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

licenses(["notice"])  # MIT-like

cc_library(
    name = "spirv_headers",
    hdrs = [
        "include/spirv/1.0/GLSL.std.450.h",
        "include/spirv/1.0/OpenCL.std.h",
        "include/spirv/1.0/spirv.h",
        "include/spirv/1.0/spirv.hpp",
        "include/spirv/1.0/spirv.hpp11",
        "include/spirv/1.1/GLSL.std.450.h",
        "include/spirv/1.1/OpenCL.std.h",
        "include/spirv/1.1/spirv.h",
        "include/spirv/1.1/spirv.hpp",
        "include/spirv/1.1/spirv.hpp11",
        "include/spirv/1.2/GLSL.std.450.h",
        "include/spirv/1.2/OpenCL.std.h",
        "include/spirv/1.2/spirv.h",
        "include/spirv/1.2/spirv.hpp",
        "include/spirv/1.2/spirv.hpp11",
    ],
    includes = ["include"],
)

filegroup(
    name = "spirv_xml_registry",
    srcs = ["include/spirv/spir-v.xml"],
)

filegroup(
    name = "spirv_core_grammar_1.0",
    srcs = ["include/spirv/1.0/spirv.core.grammar.json"],
)

filegroup(
    name = "spirv_core_grammar_1.1",
    srcs = ["include/spirv/1.1/spirv.core.grammar.json"],
)

filegroup(
    name = "spirv_core_grammar_1.2",
    srcs = ["include/spirv/1.2/spirv.core.grammar.json"],
)

filegroup(
    name = "extinst_opencl_grammar_1.0",
    srcs = ["include/spirv/1.0/extinst.opencl.std.100.grammar.json"],
)

filegroup(
    name = "extinst_opencl_grammar_1.1",
    srcs = ["include/spirv/1.1/extinst.opencl.std.100.grammar.json"],
)

filegroup(
    name = "extinst_opencl_grammar_1.2",
    srcs = ["include/spirv/1.2/extinst.opencl.std.100.grammar.json"],
)

filegroup(
    name = "extinst_glsl_grammar_1.0",
    srcs = ["include/spirv/1.0/extinst.glsl.std.450.grammar.json"],
)

filegroup(
    name = "extinst_glsl_grammar_1.1",
    srcs = ["include/spirv/1.1/extinst.glsl.std.450.grammar.json"],
)

filegroup(
    name = "extinst_glsl_grammar_1.2",
    srcs = ["include/spirv/1.2/extinst.glsl.std.450.grammar.json"],
)
