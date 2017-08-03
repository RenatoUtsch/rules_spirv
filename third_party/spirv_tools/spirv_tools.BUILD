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

load("@com_github_renatoutsch_rules_system//platform:defs.bzl", "platform_select")
load("@rules_spirv//third_party/spirv_tools:generators.bzl",
      "generate_build_version",
      "generate_core_tables",
      "generate_enum_string_mapping",
      "generate_glsl_tables",
      "generate_opencl_tables",
      "generate_vendor_tables",
      "generate_xml_registry_tables")

package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # Apache 2.0

# TODO(renatoutsch): investigate why this gives a
# no such package '@spirv_tools//platform' error.
OS_DEFINITIONS = platform_select({
    "linux": ["-DSPIRV_LINUX"],
    "macos": ["-DSPIRV_MAC"],
    "windows": ["-DSPIRV_WINDOWS"],
    "freebsd": ["-DSPIRV_FREEBSD"],
    #"android": ["-DSPIRV_ANDROID"],  # Not supported yet
})

cc_library(
    name = "spirv_tools",
    hdrs = [
        "include/spirv-tools/libspirv.h",
        "include/spirv-tools/libspirv.hpp",
    ],
    srcs = [
        "source/util/bitutils.h",
        "source/util/bit_stream.h",
        "source/util/hex_float.h",
        "source/util/parse_number.h",
        "source/util/string_utils.h",
        "source/assembly_grammar.h",
        "source/binary.h",
        "source/cfa.h",
        "source/diagnostic.h",
        "source/enum_set.h",
        "source/enum_string_mapping.h",
        "source/ext_inst.h",
        "source/extensions.h",
        "source/instruction.h",
        "source/macro.h",
        "source/message.h",
        "source/name_mapper.h",
        "source/opcode.h",
        "source/operand.h",
        "source/parsed_operand.h",
        "source/print.h",
        "source/spirv_constant.h",
        "source/spirv_definition.h",
        "source/spirv_endian.h",
        "source/spirv_stats.h",
        "source/spirv_target_env.h",
        "source/spirv_validator_options.h",
        "source/table.h",
        "source/text.h",
        "source/text_handler.h",
        "source/validate.h",
        "source/val/basic_block.h",
        "source/val/construct.h",
        "source/val/decoration.h",
        "source/val/function.h",
        "source/val/instruction.h",
        "source/val/validation_state.h",
        "source/util/bit_stream.cpp",
        "source/util/parse_number.cpp",
        "source/util/string_utils.cpp",
        "source/assembly_grammar.cpp",
        "source/binary.cpp",
        "source/diagnostic.cpp",
        "source/disassemble.cpp",
        "source/enum_string_mapping.cpp",
        "source/ext_inst.cpp",
        "source/extensions.cpp",
        "source/libspirv.cpp",
        "source/message.cpp",
        "source/name_mapper.cpp",
        "source/opcode.cpp",
        "source/operand.cpp",
        "source/parsed_operand.cpp",
        "source/print.cpp",
        "source/software_version.cpp",
        "source/spirv_endian.cpp",
        "source/spirv_stats.cpp",
        "source/spirv_target_env.cpp",
        "source/spirv_validator_options.cpp",
        "source/table.cpp",
        "source/text.cpp",
        "source/text_handler.cpp",
        "source/validate.cpp",
        "source/validate_cfg.cpp",
        "source/validate_capability.cpp",
        "source/validate_id.cpp",
        "source/validate_instruction.cpp",
        "source/validate_datarules.cpp",
        "source/validate_decorations.cpp",
        "source/validate_layout.cpp",
        "source/validate_type_unique.cpp",
        "source/val/basic_block.cpp",
        "source/val/construct.cpp",
        "source/val/function.cpp",
        "source/val/instruction.cpp",
        "source/val/validation_state.cpp",
        ":build_version",
        ":core_tables",
        ":enum_string_mapping",
        ":glsl_tables",
        ":opencl_tables",
        ":vendor_tables",
        ":xml_registry_tables",
    ],
    #copts = OS_DEFINITIONS,
    includes = [
        "include",
        "source",
    ],
    deps = [
        "@spirv_headers",
    ],
)

cc_library(
    name = "spirv_tools_opt",
    hdrs = ["include/spirv-tools/optimizer.hpp"],
    srcs = [
        "source/opt/basic_block.h",
        "source/opt/block_merge_pass.h",
        "source/opt/build_module.h",
        "source/opt/compact_ids_pass.h",
        "source/opt/constants.h",
        "source/opt/def_use_manager.h",
        "source/opt/eliminate_dead_constant_pass.h",
        "source/opt/flatten_decoration_pass.h",
        "source/opt/function.h",
        "source/opt/fold_spec_constant_op_and_composite_pass.h",
        "source/opt/freeze_spec_constant_value_pass.h",
        "source/opt/inline_pass.h",
        "source/opt/insert_extract_elim.h",
        "source/opt/instruction.h",
        "source/opt/ir_loader.h",
        "source/opt/iterator.h",
        "source/opt/local_access_chain_convert_pass.h",
        "source/opt/local_single_block_elim_pass.h",
        "source/opt/local_single_store_elim_pass.h",
        "source/opt/log.h",
        "source/opt/make_unique.h",
        "source/opt/module.h",
        "source/opt/null_pass.h",
        "source/opt/reflect.h",
        "source/opt/pass.h",
        "source/opt/passes.h",
        "source/opt/pass_manager.h",
        "source/opt/set_spec_constant_default_value_pass.h",
        "source/opt/strip_debug_info_pass.h",
        "source/opt/types.h",
        "source/opt/type_manager.h",
        "source/opt/unify_const_pass.h",
        "source/opt/basic_block.cpp",
        "source/opt/block_merge_pass.cpp",
        "source/opt/build_module.cpp",
        "source/opt/compact_ids_pass.cpp",
        "source/opt/def_use_manager.cpp",
        "source/opt/eliminate_dead_constant_pass.cpp",
        "source/opt/flatten_decoration_pass.cpp",
        "source/opt/function.cpp",
        "source/opt/fold_spec_constant_op_and_composite_pass.cpp",
        "source/opt/freeze_spec_constant_value_pass.cpp",
        "source/opt/inline_pass.cpp",
        "source/opt/insert_extract_elim.cpp",
        "source/opt/instruction.cpp",
        "source/opt/ir_loader.cpp",
        "source/opt/local_access_chain_convert_pass.cpp",
        "source/opt/local_single_block_elim_pass.cpp",
        "source/opt/local_single_store_elim_pass.cpp",
        "source/opt/module.cpp",
        "source/opt/set_spec_constant_default_value_pass.cpp",
        "source/opt/optimizer.cpp",
        "source/opt/pass_manager.cpp",
        "source/opt/strip_debug_info_pass.cpp",
        "source/opt/types.cpp",
        "source/opt/type_manager.cpp",
        "source/opt/unify_const_pass.cpp",
    ],
    includes = ["include"],
    deps = [
        ":spirv_tools",
    ],
)

cc_library(
    name = "spirv_tools_comp",
    hdrs = ["include/spirv-tools/markv.h"],
    srcs = ["source/comp/markv_codec.cpp"],
    includes = ["include"],
    deps = [
        ":spirv_tools",
    ],
)

cc_binary(
    name = "spirv-as",
    srcs = [
        "tools/as/as.cpp",
    ],
    deps = [
        ":spirv_tools",
        ":tools_io",
    ],
)

cc_binary(
    name = "spirv-dis",
    srcs = [
        "tools/dis/dis.cpp",
    ],
    deps = [
        ":spirv_tools",
        ":tools_io",
    ],
)

cc_binary(
    name = "spirv-val",
    srcs = [
        "tools/val/val.cpp",
    ],
    deps = [
        ":spirv_tools",
        ":tools_io",
    ],
)

cc_binary(
    name = "spirv-opt",
    srcs = ["tools/opt/opt.cpp"],
    deps = [
        ":spirv_tools",
        ":spirv_tools_opt",
        ":tools_io",
    ],
)

cc_binary(
    name = "spirv-markv",
    srcs = ["tools/comp/markv.cpp"],
    deps = [
        ":spirv_tools",
        ":spirv_tools_comp",
        ":tools_io",
    ],
)

cc_binary(
    name = "spirv-stats",
    srcs = [
        "tools/stats/stats.cpp",
        "tools/stats/stats_analyzer.cpp",
        "tools/stats/stats_analyzer.h",
    ],
    deps = [
        ":spirv_tools",
        ":tools_io",
    ],
)

cc_binary(
    name = "spirv-cfg",
    srcs = [
        "tools/cfg/cfg.cpp",
        "tools/cfg/bin_to_dot.cpp",
        "tools/cfg/bin_to_dot.h",
    ],
    deps = [
        ":spirv_tools",
        ":tools_io",
    ],
)

filegroup(
    name = "changes",
    srcs = ["CHANGES"],
)

cc_library(
    name = "tools_io",
    hdrs = ["tools/io.h"],
    includes = ["."],
    visibility = ["//visibility:private"],
)

generate_build_version(
    name = "build_version",
    visibility = ["//visibility:private"],
)

generate_core_tables(
    name = "core_tables",
    versions = ["1.0", "1.1", "1.2"],
    visibility = ["//visibility:private"],
)

generate_enum_string_mapping(
    name = "enum_string_mapping",
    version = "1.2",
    visibility = ["//visibility:private"],
)

generate_glsl_tables(
    name = "glsl_tables",
    versions = ["1.0"],
    visibility = ["//visibility:private"],
)

generate_opencl_tables(
    name = "opencl_tables",
    versions = ["1.0"],
    visibility = ["//visibility:private"],
)

generate_vendor_tables(
    name = "vendor_tables",
    vendor_tables = [
        "spv-amd-shader-explicit-vertex-parameter",
        "spv-amd-shader-trinary-minmax",
        "spv-amd-gcn-shader",
        "spv-amd-shader-ballot",
    ],
    visibility = ["//visibility:private"],
)

generate_xml_registry_tables(
    name = "xml_registry_tables",
    visibility = ["//visibility:private"],
)

py_binary(
    name = "generate_grammar_tables",
    srcs = ["utils/generate_grammar_tables.py"],
    visibility = ["//visibility:private"],
)

py_binary(
    name = "generate_registry_tables",
    srcs = ["utils/generate_registry_tables.py"],
    visibility = ["//visibility:private"],
)

py_binary(
    name = "update_build_version",
    srcs = ["utils/update_build_version.py"],
    visibility = ["//visibility:private"],
)
