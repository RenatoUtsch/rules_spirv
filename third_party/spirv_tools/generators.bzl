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
"""Scripts to be used to generate .inc files for @spirv_tools."""

def _filegroup_genrules(name, genrule_list, visibility, genrule_function):
    """Runs function for each elem in genrule_list and groups in a filegroup.

    Args:
        name: the name of the generated filegroup containing all outputs from
            the genrules.
        genrule_list: list with all genrule variables. For each element in this
            list, genrule_function will be executed and it's output will be
            added to the filegroup.
        visibility: the visibility the genrules and the filegroup should have.
        genrule_function: function that receives three parameters -- the name
            the genrule should have, the element in the genrule_list that it
            should generate and the genrule's visibility -- and generates a
            genrule with the given name that outputs files to be added to the
            filegroup.
    """
    targets = []
    for elem in genrule_list:
        target_name = "{}_{}".format(name, elem)
        targets.append(":{}".format(target_name))
        genrule_function(target_name, elem, visibility)

    native.filegroup(
        name = name,
        srcs = targets,
        visibility = visibility,
    )

def generate_build_version(name, visibility=None):
    """Generates a genrule with build version."""
    native.genrule(
        name = name,
        srcs = [":changes"],
        outs = ["build-version.inc"],
        tools = [":update_build_version"],
        cmd = "$(location :update_build_version) " +
              "$$(dirname $<) $(@D)/build-version.inc",
        visibility = visibility,
    )

def generate_core_tables(name, versions, visibility=None):
    """Generates a filegroup with the core tables of the given versions."""
    _filegroup_genrules(name, versions, visibility,
                        _generate_core_tables_genrule)

def _generate_core_tables_genrule(name, version, visibility):
    """Genrule generator for the core tables."""
    insts_out = "core.insts-{}.inc".format(version)
    kinds_out = "operand.kinds-{}.inc".format(version)

    native.genrule(
        name = name,
        srcs = ["@spirv_headers//:spirv_core_grammar_{}".format(version)],
        outs = [
            insts_out,
            kinds_out,
        ],
        tools = [":generate_grammar_tables"],
        cmd = "$(location :generate_grammar_tables) " +
            "--spirv-core-grammar=$< " +
            "--core-insts-output=$(@D)/{} ".format(insts_out) +
            "--operand-kinds-output=$(@D)/{}".format(kinds_out),
        visibility = visibility,
    )

def generate_enum_string_mapping(name, version, visibility=None):
    """Generates a genrule with the enum string mapping of the given version."""
    extension_out = "extension_enum.inc"
    string_mapping_out = "enum_string_mapping.inc"

    native.genrule(
        name = name,
        srcs = ["@spirv_headers//:spirv_core_grammar_{}".format(version)],
        outs = [
            extension_out,
            string_mapping_out,
        ],
        tools = [":generate_grammar_tables"],
        cmd = "$(location :generate_grammar_tables) " +
            "--spirv-core-grammar=$< " +
            "--extension-enum-output=$(@D)/{} ".format(extension_out) +
            "--enum-string-mapping-output=$(@D)/{}".format(string_mapping_out),
        visibility = visibility,
    )

def generate_glsl_tables(name, versions, visibility=None):
    """Generates a filegroup with the GLSL tables of the given versions."""
    _filegroup_genrules(name, versions, visibility,
                        _generate_glsl_tables_genrule)

def _generate_glsl_tables_genrule(name, version, visibility):
    """Genrule generator for the GLSL tables."""
    core_grammar = "@spirv_headers//:spirv_core_grammar_{}".format(version)
    glsl_grammar = "@spirv_headers//:extinst_glsl_grammar_{}".format(version)

    native.genrule(
        name = name,
        srcs = [
            core_grammar,
            glsl_grammar,
        ],
        outs = ["glsl.std.450.insts-{}.inc".format(version)],
        tools = [":generate_grammar_tables"],
        cmd = "$(location :generate_grammar_tables) " +
            "--spirv-core-grammar=$(location {}) ".format(core_grammar) +
            "--extinst-glsl-grammar=$(location {}) ".format(glsl_grammar) +
            "--glsl-insts-output=$@",
        visibility = visibility,
    )

def generate_opencl_tables(name, versions, visibility=None):
    """Generates a filegroup with the OpenCL tables of the given versions."""
    _filegroup_genrules(name, versions, visibility,
                        _generate_opencl_tables_genrule)

def _generate_opencl_tables_genrule(name, version, visibility):
    """Genrule generator for the OpenCL tables."""
    core_grammar = "@spirv_headers//:spirv_core_grammar_{}".format(version)
    opencl_grammar = (
        "@spirv_headers//:extinst_opencl_grammar_{}".format(version))

    native.genrule(
        name = name,
        srcs = [
            core_grammar,
            opencl_grammar,
        ],
        outs = ["opencl.std.insts-{}.inc".format(version)],
        tools = [":generate_grammar_tables"],
        cmd = "$(location :generate_grammar_tables) " +
            "--spirv-core-grammar=$(location {}) ".format(core_grammar) +
            "--extinst-opencl-grammar=$(location {}) ".format(opencl_grammar) +
            "--opencl-insts-output=$@",
        visibility = visibility,
    )

def generate_vendor_tables(name, vendor_tables, visibility=None):
    """Generates a filegroup with the given vendor table names."""
    _filegroup_genrules(name, vendor_tables, visibility,
                        _generate_vendor_tables_genrule)

def _generate_vendor_tables_genrule(name, vendor_table, visibility):
    """Genrule generator for the vendor tables."""
    native.genrule(
        name = name,
        srcs = ["source/extinst.{}.grammar.json".format(vendor_table)],
        outs = ["{}.insts.inc".format(vendor_table)],
        tools = [":generate_grammar_tables"],
        cmd = "$(location :generate_grammar_tables) " +
              "  --extinst-vendor-grammar=$< --vendor-insts-output=$@",
        visibility = visibility,
    )

def generate_xml_registry_tables(name, visibility = None):
    """Generates a genrule with tables based on the the XML registry."""
    native.genrule(
        name = name,
        srcs = ["@spirv_headers//:spirv_xml_registry"],
        outs = ["generators.inc"],
        tools = [":generate_registry_tables"],
        cmd = "$(location :generate_registry_tables) " +
              "--xml=$< --generator-output=$@",
        visibility = visibility,
    )
