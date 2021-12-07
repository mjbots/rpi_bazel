# -*- python -*-

# Copyright 2018-2020 Josh Pieper, jjp@pobox.com.
# Copyright 2021 Diego Dagum, email@diegodagum.com.
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

CLANG_VERSION = '10.0.0'
SHARED_LIB_EXTENSION = '1.dylib'
HOST_OS = 'darwin'

package(default_visibility = ["//visibility:public"])

filegroup(
    name = "binaries",
    srcs = [
        "bin/clang",
        "bin/clang++",
        "bin/llvm-dwp",
        "bin/llvm-objcopy",
        "bin/llvm-objdump",
        "bin/llvm-strip",
        "bin/ld.lld",
        "bin/llvm-ar",
        "bin/llvm-nm",
        "bin/llvm-cov",
    ],
)

filegroup(
    name = "clang_libs",
    srcs = glob(["lib/clang/{}/lib/{}/*.a".format(CLANG_VERSION, HOST_OS)]),
)

filegroup(
    name = "includes",
    srcs = glob([
        "include/c++/**",
        "lib/clang/{}/include/**".format(CLANG_VERSION),
    ]),
)

filegroup(
    name = "runtime_libs",
    srcs = [
        "lib/libc++.{}".format(SHARED_LIB_EXTENSION),
        "lib/libc++abi.{}".format(SHARED_LIB_EXTENSION),
        "lib/libunwind.{}".format(SHARED_LIB_EXTENSION),
    ],
)

filegroup(
    name = "static_libs",
    srcs = [
        "lib/libc++.a",
        "lib/libc++abi.a",
        "lib/libunwind.a",
    ],
)
