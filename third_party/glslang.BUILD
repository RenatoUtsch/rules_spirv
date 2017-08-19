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

load("@com_github_renatoutsch_rules_system//system:defs.bzl", "system_select")
load("@com_github_renatoutsch_rules_spirv//third_party:threads.bzl", "THREAD_LIBS")

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

# TODO(renatoutsch): use system_select once it's working
OS_COPTS = select({
    "@com_github_renatoutsch_rules_system//system:windows_x64": ["-DGLSLANG_OSINCLUDE_WIN32"],
    "@com_github_renatoutsch_rules_system//system:windows_x64_msvc": ["-DGLSLANG_OSINCLUDE_WIN32"],
    "@com_github_renatoutsch_rules_system//system:windows_x64_msys": ["-DGLSLANG_OSINCLUDE_WIN32"],
    "//conditions:default": ["-DGLSLANG_OSINCLUDE_UNIX"],
})

COPTS = OS_COPTS + [
    "-DAMD_EXTENSIONS",
    "-DNV_EXTENSIONS",
    "-DENABLE_HLSL",
]

# glslang has a very weird folder structure, and it's libraries have lots of
# dependency loops. Because of this, I've condensed the "glslang",
# "OGLCompiler", "OSDependent" and "HLSL" libraries into just glslang. Use
# it if you want to use any of the other ones.
cc_library(
    name = "glslang",
    hdrs = [
        "glslang/Include/arrays.h",
        "glslang/Include/BaseTypes.h",
        "glslang/Include/Common.h",
        "glslang/Include/ConstantUnion.h",
        "glslang/Include/InfoSink.h",
        "glslang/Include/InitializeGlobals.h",
        "glslang/Include/intermediate.h",
        "glslang/Include/PoolAlloc.h",
        "glslang/Include/ResourceLimits.h",
        "glslang/Include/revision.h",
        "glslang/Include/ShHandle.h",
        "glslang/Include/Types.h",
    ],
    srcs = [
        # glslang
        "glslang/Public/ShaderLang.h",
        "glslang/MachineIndependent/glslang_tab.cpp.h",
        "glslang/MachineIndependent/gl_types.h",
        "glslang/MachineIndependent/Initialize.h",
        "glslang/MachineIndependent/iomapper.h",
        "glslang/MachineIndependent/LiveTraverser.h",
        "glslang/MachineIndependent/localintermediate.h",
        "glslang/MachineIndependent/ParseHelper.h",
        "glslang/MachineIndependent/reflection.h",
        "glslang/MachineIndependent/RemoveTree.h",
        "glslang/MachineIndependent/Scan.h",
        "glslang/MachineIndependent/ScanContext.h",
        "glslang/MachineIndependent/SymbolTable.h",
        "glslang/MachineIndependent/Versions.h",
        "glslang/MachineIndependent/parseVersions.h",
        "glslang/MachineIndependent/propagateNoContraction.h",
        "glslang/MachineIndependent/preprocessor/PpContext.h",
        "glslang/MachineIndependent/preprocessor/PpTokens.h",
        "glslang/MachineIndependent/glslang_tab.cpp",
        "glslang/MachineIndependent/Constant.cpp",
        "glslang/MachineIndependent/iomapper.cpp",
        "glslang/MachineIndependent/InfoSink.cpp",
        "glslang/MachineIndependent/Initialize.cpp",
        "glslang/MachineIndependent/IntermTraverse.cpp",
        "glslang/MachineIndependent/Intermediate.cpp",
        "glslang/MachineIndependent/ParseContextBase.cpp",
        "glslang/MachineIndependent/ParseHelper.cpp",
        "glslang/MachineIndependent/PoolAlloc.cpp",
        "glslang/MachineIndependent/RemoveTree.cpp",
        "glslang/MachineIndependent/Scan.cpp",
        "glslang/MachineIndependent/ShaderLang.cpp",
        "glslang/MachineIndependent/SymbolTable.cpp",
        "glslang/MachineIndependent/Versions.cpp",
        "glslang/MachineIndependent/intermOut.cpp",
        "glslang/MachineIndependent/limits.cpp",
        "glslang/MachineIndependent/linkValidate.cpp",
        "glslang/MachineIndependent/parseConst.cpp",
        "glslang/MachineIndependent/reflection.cpp",
        "glslang/MachineIndependent/preprocessor/Pp.cpp",
        "glslang/MachineIndependent/preprocessor/PpAtom.cpp",
        "glslang/MachineIndependent/preprocessor/PpContext.cpp",
        "glslang/MachineIndependent/preprocessor/PpScanner.cpp",
        "glslang/MachineIndependent/preprocessor/PpTokens.cpp",
        "glslang/MachineIndependent/propagateNoContraction.cpp",
        "glslang/GenericCodeGen/CodeGen.cpp",
        "glslang/GenericCodeGen/Link.cpp",

        # HLSL
        "hlsl/hlslAttributes.h",
        "hlsl/hlslParseHelper.h",
        "hlsl/hlslTokens.h",
        "hlsl/hlslScanContext.h",
        "hlsl/hlslOpMap.h",
        "hlsl/hlslTokenStream.h",
        "hlsl/hlslGrammar.h",
        "hlsl/hlslParseables.h",
        "hlsl/hlslAttributes.cpp",
        "hlsl/hlslParseHelper.cpp",
        "hlsl/hlslScanContext.cpp",
        "hlsl/hlslOpMap.cpp",
        "hlsl/hlslTokenStream.cpp",
        "hlsl/hlslGrammar.cpp",
        "hlsl/hlslParseables.cpp",

        # OGLCompiler
        "OGLCompilersDLL/InitializeDll.h",
        "OGLCompilersDLL/InitializeDll.cpp",

        # OSDependent
        "glslang/OSDependent/osinclude.h",
    ] + select({  # TODO(renatoutsch): replace with system_select once it's fixed.
        "@com_github_renatoutsch_rules_system//system:windows_x64": ["glslang/OSDependent/Windows/ossource.cpp"],
        "@com_github_renatoutsch_rules_system//system:windows_x64_msvc": ["glslang/OSDependent/Windows/ossource.cpp"],
        "@com_github_renatoutsch_rules_system//system:windows_x64_msys": ["glslang/OSDependent/Windows/ossource.cpp"],
        "//conditions:default": ["glslang/OSDependent/Unix/ossource.cpp"],
    }),
    # system_select({
    #     "windows": ["glslang/OSDependent/Windows/ossource.cpp"],
    #     "default": ["glslang/OSDependent/Unix/ossource.cpp"],
    # })
    copts = COPTS,
)

cc_library(
    name = "SPIRV",
    hdrs = [
        "SPIRV/bitutils.h",
        "SPIRV/GLSL.std.450.h",
        "SPIRV/GlslangToSpv.h",
        "SPIRV/hex_float.h",
        "SPIRV/Logger.h",
        "SPIRV/SpvBuilder.h",
        "SPIRV/disassemble.h",
    ],
    srcs = [
        "SPIRV/GlslangToSpv.cpp",
        "SPIRV/InReadableOrder.cpp",
        "SPIRV/Logger.cpp",
        "SPIRV/SpvBuilder.cpp",
        "SPIRV/disassemble.cpp",
    ],
    copts = COPTS,
    deps = [
        ":glslang",
        ":SPIRV_doc",
    ],
)

cc_library(
    name = "SPVRemapper",
    hdrs = ["SPIRV/SPVRemapper.h"],
    srcs = ["SPIRV/SPVRemapper.cpp"],
    copts = COPTS,
    deps = [
        ":glslang",
        ":SPIRV_doc",
    ],
)

cc_library(
    name = "SPIRV_doc",
    hdrs = [
        "SPIRV/doc.h",
        "SPIRV/GLSL.ext.KHR.h",
        "SPIRV/GLSL.ext.AMD.h",
        "SPIRV/GLSL.ext.NV.h",
        "SPIRV/spirv.hpp",
        "SPIRV/spvIR.h",
    ],
    srcs = ["SPIRV/doc.cpp"],
    copts = COPTS,
    visibility = ["//visibility:private"],
)

cc_library(
    name = "glslang-default-resource-limits",
    hdrs = ["StandAlone/ResourceLimits.h"],
    srcs = ["StandAlone/ResourceLimits.cpp"],
    copts = COPTS,
    visibility = ["//visibility:private"],
    deps = [
        ":glslang",
    ],
)

cc_binary(
    name = "glslangValidator",
    srcs = [
        "StandAlone/StandAlone.cpp",
        "StandAlone/DirStackFileIncluder.h",
        "StandAlone/Worklist.h",
    ],
    copts = COPTS,
    linkopts = THREAD_LIBS,
    deps = [
        ":glslang",
        ":glslang-default-resource-limits",
        ":SPIRV",
        ":SPVRemapper",
    ],
)

cc_binary(
    name = "spirv-remap",
    srcs = [
        "StandAlone/spirv-remap.cpp",
    ],
    copts = COPTS,
    linkopts = THREAD_LIBS,
    deps = [
        ":glslang",
        ":glslang-default-resource-limits",
        ":SPIRV",
        ":SPVRemapper",
    ],
)

# A file in the main folder so that it can be referenced by other rules
filegroup(
    name = "readme",
    srcs = ["README.md"],
)
