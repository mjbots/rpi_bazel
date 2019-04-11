# -*- python -*-

# Copyright 2019 Josh Pieper, jjp@pobox.com.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

package(default_visibility = ["//visibility:public"])

filegroup(
    name = "raw_headers",
    srcs = glob(["include/**"]),
)

cc_library(
    name = "libcxxabi",
    hdrs = [":raw_headers"],
    srcs = glob([
        "src/*.cpp",
        "src/*.hpp",
        "src/*.h",
        "src/include/*.h",
        "src/demangle/*.h",
    ], exclude = [
        "src/stdlib_new_delete.cpp",
        "src/cxa_noexception.cpp",
    ]),
    copts = [
        "-Iexternal/org_llvm_libcxx/include",
        "-D_LIBCPP_BUILDING_LIBRARY",
        "-DNDEBUG",
        "-fvisibility-inlines-hidden",
    ],
    includes = ["include"],
    deps = ["@org_llvm_libcxx//:headers"],
)
