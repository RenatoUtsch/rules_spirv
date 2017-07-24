# Copyright 2017 Renato Utsch
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load(
    ":glsl_common.bzl",
    "GLSLInfo",
    "GLSL_VERSION_DEFAULT",
    "get_transitive_srcs",
    "get_transitive_defines",
    "get_transitive_includes",
    "get_transitive_version",
)

def _get_define_string(defines):
    """Converts from defines depset to a cmd string."""
    # TODO(renatoutsch): inspect possible injection security holes here.
    define_strings = ["-D{}".format(define) for define in defines.to_list()]
    return " ".join(define_strings)

def _get_include_string(includes):
    """Converts from includes depset to a cmd string."""
    # TODO(renatoutsch): inspect possible injection security holes here.
    include_strings = ["-I{}".format(include) for include in includes.to_list()]
    return " ".join(include_strings)

def _get_src_string(srcs):
    """Converts from srcs attr to a string. Must have only one element."""
    if len(srcs) != 1:
        fail("glsl_binary srcs must have exactly one source file.")

    return srcs[0].path

def _get_optimization_string(optimization_level):
    """Returns the optimization string from the optimization level."""
    if optimization_level == 0:
        return "0"
    if optimization_level == 1:
        return "s"
    fail("Invalid optimization_level attribute. Expected 0 or 1.")

def _get_shader_stage_string(shader_stage):
    """Returns the shader stage string from the given shader stage."""
    if (shader_stage == "vertex" or shader_stage == "fragment" or
            shader_stage == "tesscontrol" or shader_stage == "tesseval" or
            shader_stage == "geometry" or shader_stage == "compute"):
        return "-fshader-stage={}".format(shader_stage)
    return ""

def _get_target_env_string(target_env):
    """Returns the target env string if it is valid."""
    if (target_env == "vulkan" or target_env == "opengl" or
            target_env == "opengl_compat"):
        return target_env
    fail("glsl_binary: Invalid target_env: {}".format(target_env))

def _impl(ctx):
    glslc = ctx.executable._glslc
    binary = ctx.outputs.binary

    srcs = get_transitive_srcs(ctx.files.srcs, ctx.attr.deps)
    defines = get_transitive_defines(ctx.attr.defines, ctx.attr.deps)
    includes = get_transitive_includes(ctx.attr.includes, ctx.attr.deps)
    version = get_transitive_version(ctx.attr.version, ctx.attr.deps)

    define_string = _get_define_string(defines)
    include_string = _get_include_string(includes)
    src_string = _get_src_string(ctx.files.srcs)
    shader_stage_string = _get_shader_stage_string(ctx.attr.shader_stage)
    optimization_string = _get_optimization_string(ctx.attr.optimization_level)
    target_env_string = _get_target_env_string(ctx.attr.target_env)

    cmd = ("{} -std={} -O{} ".format(glslc.path, version, optimization_string) +
           "--target-env={} ".format(target_env_string) +
           "{} ".format(shader_stage_string) +
           "{} {} {} ".format(define_string, include_string, src_string) +
           "-o {}".format(binary.path))
    ctx.action(
        inputs = srcs.to_list() + [glslc],
        outputs = [binary],
        command=cmd,
        mnemonic = "glslc",
        progress_message = "Compiling SPIR-V binary {}".format(
            binary.short_path))

glsl_binary = rule(
    attrs = {
        "deps": attr.label_list(providers = [GLSLInfo]),
        "srcs": attr.label_list(
            allow_files = True,
            mandatory = True,
        ),
        "defines": attr.string_list(),
        "includes": attr.string_list(),
        "shader_stage": attr.string(),
        "version": attr.string(default = GLSL_VERSION_DEFAULT),
        "optimization_level": attr.int(default = 1),
        "target_env": attr.string(default = "vulkan"),
        "_glslc": attr.label(
            allow_files = True,
            cfg = "host",
            executable = True,
            default = Label("@shaderc//:glslc"),
        ),
    },
    outputs = {
        "binary": "%{name}.spv",
    },
    implementation = _impl,
)

"""

Args:
    shader_stage: the shader stage of the generated binary. Must be one of
        "vertex", "fragment", "tesscontrol", "tesseval", "geometry", "compute".
        If not specified, the compiler will try to guess from the source file's
        extension (".vert", ".frag", ".tesc", ".tese", ".geom", ".comp",
        respectively). If you use ".glsl" in the binary's srcs attribute, you
        *must* specify a shader stage here.
    version: version the shader was developed in. Defaults to "450".
    optimization_level: how the shader should be optimized. It's value is one of
        the following:
        - 0: disables optimizations.
        - 1: optimize for size.
        The default is 1.
    target_env: target environment of the generated SPIR-V binary. Can be one of
        "vulkan", "opengl" and "opengl_compat". Default is "vulkan".
"""
