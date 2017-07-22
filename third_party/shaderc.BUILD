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

package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # Apache 2.0

cc_binary(
    name = "glslc",
    srcs = ["glslc/src/main.cc"],
    deps = [
        ":glslc",
        ":shaderc",
        ":shaderc_util",
    ],
)

cc_library(
    name = "glslc_lib",
    hdrs = [
        "glslc/src/dependency_info.h",
        "glslc/src/file.h",
        "glslc/src/file_compiler.h",
        "glslc/src/file_includer.h",
        "glslc/src/resource_parse.h",
        "glslc/src/shader_stage.h",
    ],
    srcs = [
        "glslc/src/dependency_info.cc",
        "glslc/src/file.cc",
        "glslc/src/file_compiler.cc",
        "glslc/src/file_includer.cc",
        "glslc/src/resource_parse.cc",
        "glslc/src/shader_stage.cc",
    ],
    linkopts = ["-lpthread"],  # TODO(renatoutsch): select based on OS.
    deps = [
        ":shaderc",
        ":shaderc_util",
        "@glslang//:glslang_lib",
        "@glslang//:HLSL",
        "@glslang//:OGLCompiler",
        "@glslang//:OSDependent",
        "@glslang//:SPIRV",
    ],
)

cc_library(
    name = "shaderc",
)

cc_library(
    name = "shaderc_util",
)

