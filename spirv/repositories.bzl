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

def spirv_repositories(omit_com_github_renatoutsch_rules_system=False,
                       omit_glslang=False,
                       omit_shaderc=False,
                       omit_spirv_headers=False,
                       omit_spirv_tools=False):
    """Imports dependencies for SPIR-V Rules."""
    if not omit_com_github_renatoutsch_rules_system:
        com_github_renatoutsch_rules_system()
    if not omit_glslang:
        glslang()
    if not omit_shaderc:
        shaderc()
    if not omit_spirv_headers:
        spirv_headers()
    if not omit_spirv_tools:
        spirv_tools()

def com_github_renatoutsch_rules_system():
    # TODO(renatoutsch): use a tag or commit once there's a release
    native.http_archive(
        name = "com_github_renatoutsch_rules_system",
        #sha256 = "",  # TODO(renatoutsch): add once there's a release
        strip_prefix = "rules_system-master",
        urls = ["https://github.com/RenatoUtsch/rules_system/archive/master.zip"],
    )

def glslang():
    native.new_http_archive(
        name = "glslang",
        build_file = str(Label("//third_party:glslang.BUILD")),
        sha256 = "02ab032b3915bf386399d088cb108e330e45ed40709d25456c9ca48cb033166e",
        strip_prefix = "glslang-eb5f12d1ca7b2bf16c804fc930a960ba4d0f5628",
        urls = ["https://github.com/KhronosGroup/glslang/archive/eb5f12d1ca7b2bf16c804fc930a960ba4d0f5628.zip"],
    )

def shaderc():
    native.new_http_archive(
        name = "shaderc",
        build_file = str(Label("//third_party:shaderc.BUILD")),
        sha256 = "1c1e32cbd29ccf14935584314f10aa3ffbeb9dd02a2ab5f1deef3f25be1f7b98",
        strip_prefix = "shaderc-41ce8e69e12b3fe8370e9d49e1760ea711d5e61b",
        urls = ["https://github.com/google/shaderc/archive/41ce8e69e12b3fe8370e9d49e1760ea711d5e61b.zip"],
    )

def spirv_headers():
    native.new_http_archive(
        name = "spirv_headers",
        build_file = str(Label("//third_party:spirv_headers.BUILD")),
        sha256 = "13c87d8c891851bb439a58f34bbcf19abecd232a82c8977447419ed64d0186d2",
        strip_prefix = "SPIRV-Headers-661ad91124e6af2272afd00f804d8aa276e17107",
        urls = ["https://github.com/KhronosGroup/SPIRV-Headers/archive/661ad91124e6af2272afd00f804d8aa276e17107.zip"],
    )

def spirv_tools():
    native.new_http_archive(
        name = "spirv_tools",
        build_file = str(Label("//third_party/spirv_tools:spirv_tools.BUILD")),
        sha256 = "a6e5e07e7c16827556ef1a3c2ca80f19e4e57e8a4874c912c7f398a1daa7623f",
        strip_prefix = "SPIRV-Tools-abc6f5a67288b50846b9ef5f21a8100edd36d7c8",
        urls = ["https://github.com/KhronosGroup/SPIRV-Tools/archive/abc6f5a67288b50846b9ef5f21a8100edd36d7c8.zip"],
    )
