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
    "//glsl:defs.bzl",
    "glsl_library",
    "glsl_binary",
    "glsl_preprocessed_binary",
)

package(default_visibility = ["//visibility:private"])

glsl_library(
    name = "a",
    srcs = ["a.glsl"],
)

glsl_library(
    name = "b",
    srcs = [
        "b.glsl",
        "b2.glsl",
    ],
)

glsl_library(
    name = "c",
    srcs = ["c.glsl"],
    deps = [
        ":a",
        ":b",
    ],
)

glsl_preprocessed_binary(
    name = "main",
    srcs = ["main.comp"],
    deps = [
        ":c",
    ],
)
