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
    name = "libcxxabi",
    hdrs = [":raw_headers"],
    srcs = glob([
        "src/*.cpp",
        "src/*.hpp",
        "src/*.h",
        "src/demangle/*.h",
    ], exclude = [
        "src/cxa_noexception.cpp",
    ]),
    textual_hdrs = glob(["src/demangle/*.def"]),
    copts = [
        "-std=c++23",
        "-Iexternal/org_llvm_libcxx/src",
        "-D_LIBCXXABI_BUILDING_LIBRARY",
        "-D_LIBCPP_BUILDING_LIBRARY",
        "-D_LIBCXXABI_LINK_PTHREAD_LIB",
        "-DHAVE___CXA_THREAD_ATEXIT_IMPL",
        "-DNDEBUG",
        "-fstrict-aliasing",
        "-fvisibility-inlines-hidden",
        "-fsized-deallocation",
    ],
    includes = ["include"],
    deps = [
        "@org_llvm_libcxx//:headers",
        "@org_llvm_libcxx//:src_headers",
    ],
)
