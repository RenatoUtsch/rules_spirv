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

# Selects the right thread lib depending on the OS.
# TODO(renatoutsch): use platform_select once it's working
THREAD_LIBS = select({
    "@rules_platform//platform:freebsd": ["-lpthread"],
    "@rules_platform//platform:linux_k8": ["-lpthread"],
    "@rules_platform//platform:linux_arm": ["-lpthread"],
    "@rules_platform//platform:linux_piii": ["-lpthread"],
    "@rules_platform//platform:linux_ppc": ["-lpthread"],
    "@rules_platform//platform:linux_ppc64": ["-lpthread"],
    "@rules_platform//platform:linux_s390x": ["-lpthread"],
    "@rules_platform//platform:windows_x64": ["-lpsapi"],
    "@rules_platform//platform:windows_x64_msvc": ["-lpsapi"],
    "@rules_platform//platform:windows_x64_msys": ["-lpsapi"],
    "//conditions:default": [],
})
