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

# glsl_library provider.
GLSLInfo = provider()

# Default GLSL version for glsl_library and glsl_binary.
GLSL_VERSION_DEFAULT = "450"

def _get_transitive_values(values, deps, deps_accessor):
    """Returns the transitive values from "values" added to values from deps.

    Args:
        values: the values of to be added to the transitive values from deps.
        deps: list of dependencies with GLSLInfo providers to add to the
            transitive values.
        deps_accessor: returns the dependency from a GLSLInfo provider. Receives
            one parameter: the GLSLInfo provider to return the dependency from.
    Returns:
        A depset with the values in the correct order from dependency to the new
            values.
    """
    transitive_values = depset()
    for dep in deps:
        transitive_values += deps_accessor(dep[GLSLInfo])
    transitive_values += values
    return transitive_values

def _transitive_srcs_accessor(glsl_info):
    return glsl_info.srcs

def get_transitive_srcs(srcs, deps):
    return _get_transitive_values(srcs, deps, _transitive_srcs_accessor)

def _transitive_defines_accessor(glsl_info):
    return glsl_info.defines

def get_transitive_defines(defines, deps):
    return _get_transitive_values(defines, deps, _transitive_defines_accessor)

def _transitive_includes_accessor(glsl_info):
    return glsl_info.includes

def get_transitive_includes(includes, deps):
    return _get_transitive_values(includes, deps, _transitive_includes_accessor)

def get_transitive_version(version, deps):
    transitive_version = ""
    for dep in deps:
        if transitive_version < dep[GLSLInfo].version:
            transitive_version = dep[GLSLInfo].version

    if transitive_version < version:
        transitive_version = version
    elif transitive_version > version:
      fail("GLSL version {} is lower than ".format(version) +
           "required version {} from dependencies".format(transitive_version))

    return transitive_version
