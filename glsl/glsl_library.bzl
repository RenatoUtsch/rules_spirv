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

def _impl(ctx):
    return [GLSLInfo(
        srcs=get_transitive_srcs(ctx.files.srcs, ctx.attr.deps),
        defines=get_transitive_defines(ctx.attr.defines, ctx.attr.deps),
        includes=get_transitive_includes(ctx.attr.includes, ctx.attr.deps),
        version=get_transitive_version(ctx.attr.version, ctx.attr.deps),
    )]

glsl_library = rule(
    attrs = {
        "deps": attr.label_list(providers = [GLSLInfo]),
        "srcs": attr.label_list(allow_files = True),
        "defines": attr.string_list(),
        "includes": attr.string_list(),
        "version": attr.string(default = GLSL_VERSION_DEFAULT),
    },
    implementation = _impl,
)
