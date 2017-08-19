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

load("@com_github_renatoutsch_rules_spirv//third_party:threads.bzl", "THREAD_LIBS")

package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # Apache 2.0

cc_binary(
    name = "glslc",
    srcs = [
        "glslc/src/main.cc",
        ":build_version",
    ],
    deps = [
        ":glslc_lib",
        ":shaderc",
        ":shaderc_util",
    ],
)

cc_library(
    name = "glslc_lib",
    srcs = [
        "glslc/src/dependency_info.h",
        "glslc/src/file.h",
        "glslc/src/file_compiler.h",
        "glslc/src/file_includer.h",
        "glslc/src/resource_parse.h",
        "glslc/src/shader_stage.h",
        "glslc/src/dependency_info.cc",
        "glslc/src/file.cc",
        "glslc/src/file_compiler.cc",
        "glslc/src/file_includer.cc",
        "glslc/src/resource_parse.cc",
        "glslc/src/shader_stage.cc",
    ],
    linkopts = THREAD_LIBS,
    deps = [
        ":shaderc",
        ":shaderc_util",
        "@glslang",
        "@glslang//:SPIRV",
    ],
)

cc_library(
    name = "shaderc",
    hdrs = [
        "libshaderc/include/shaderc/shaderc.h",
        "libshaderc/include/shaderc/shaderc.hpp",
    ],
    srcs = [
        "libshaderc/src/shaderc.cc",
        "libshaderc/src/shaderc_private.h",
    ],
    includes = ["libshaderc/include"],
    linkopts = THREAD_LIBS,
    deps = [
        "@glslang",
        "@glslang//:SPIRV",
        "@spirv_tools",
        ":shaderc_util",
    ],
)

cc_library(
    name = "shaderc_util",
    hdrs = [
        "libshaderc_util/include/libshaderc_util/compiler.h",
        "libshaderc_util/include/libshaderc_util/counting_includer.h",
        "libshaderc_util/include/libshaderc_util/file_finder.h",
        "libshaderc_util/include/libshaderc_util/format.h",
        "libshaderc_util/include/libshaderc_util/io.h",
        "libshaderc_util/include/libshaderc_util/mutex.h",
        "libshaderc_util/include/libshaderc_util/message.h",
        "libshaderc_util/include/libshaderc_util/resources.h",
        "libshaderc_util/include/libshaderc_util/resources.inc",
        "libshaderc_util/include/libshaderc_util/spirv_tools_wrapper.h",
        "libshaderc_util/include/libshaderc_util/shader_stage.h",
        "libshaderc_util/include/libshaderc_util/string_piece.h",
        "libshaderc_util/include/libshaderc_util/universal_unistd.h",
        "libshaderc_util/include/libshaderc_util/version_profile.h",
    ],
    srcs = [
        "libshaderc_util/src/compiler.cc",
        "libshaderc_util/src/file_finder.cc",
        "libshaderc_util/src/io.cc",
        "libshaderc_util/src/message.cc",
        "libshaderc_util/src/resources.cc",
        "libshaderc_util/src/shader_stage.cc",
        "libshaderc_util/src/spirv_tools_wrapper.cc",
        "libshaderc_util/src/version_profile.cc",
    ],
    includes = ["libshaderc_util/include"],
    linkopts = THREAD_LIBS,
    deps = [
        "@glslang",
        "@glslang//:SPIRV",
        "@spirv_tools//:spirv_tools_opt",
    ],
)

filegroup(
    name = "changes",
    srcs = ["CHANGES"],
)

py_binary(
    name = "update_build_version",
    srcs = ["utils/update_build_version.py"],
    visibility = ["//visibility:private"],
)

genrule(
    name = "build_version",
    srcs = [
        ":changes",
        "@spirv_tools//:changes",
        "@glslang//:readme",
    ],
    outs = ["build-version.inc"],
    tools = [":update_build_version"],
    cmd = "BASE=$$PWD && cd $(@D) && " +
          "$$BASE/$(location :update_build_version) " +
          "$$BASE/$$(dirname $(location :changes)) " +
          "$$BASE/$$(dirname $(location @spirv_tools//:changes)) " +
          "$$BASE/$$(dirname $(location @glslang//:readme))",
    visibility = ["//visibility:private"],
)
