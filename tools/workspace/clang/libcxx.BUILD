# -*- python -*-

# Copyright 2023 mjbots Robotic Systems, LLC.  info@mjbots.com
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
    name = "headers",
    hdrs = [":raw_headers"],
)

# Internal headers that libc++abi also needs.
cc_library(
    name = "src_headers",
    hdrs = glob(["src/include/**/*.h"]),
)

cc_library(
    name = "libcxx",
    hdrs = glob(["include/**"]),
    srcs = glob([
        "src/*.cpp",
        "src/*.h",
        "src/include/**/*.h",
        "src/filesystem/*.cpp",
        "src/filesystem/*.h",
        "src/ryu/*.cpp",
    ], exclude = [
        # libc++abi provides these.
        "src/new.cpp",
    ]),
    textual_hdrs = glob([
        "src/support/runtime/**",
    ]),
    copts = [
        "-std=c++23",
        "-Iexternal/org_llvm_libcxx/src",
        "-D_LIBCPP_BUILDING_LIBRARY",
        "-D_LIBCPP_LINK_PTHREAD_LIB",
        "-D_LIBCPP_LINK_RT_LIB",
        "-DLIBCXX_BUILDING_LIBCXXABI",
        "-DNDEBUG",
        "-fvisibility-inlines-hidden",
        "-fsized-deallocation",
    ],
    includes = ["include"],
    deps = [
        ":headers",
        "@org_llvm_libc//:common_utils",
        "@org_llvm_libcxxabi//:libcxxabi",
    ],
)
