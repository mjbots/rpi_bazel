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
    name = "binaries",
    srcs = [
        "bin/clang",
        "bin/clang++",
        "bin/clang-20",
        "bin/lld",
        "bin/llvm-dwp",
        "bin/llvm-objcopy",
        "bin/llvm-objdump",
        "bin/llvm-strip",
        "bin/ld.lld",
        "bin/llvm-ar",
        "bin/llvm-nm",
        "bin/llvm-cov",
    ] + glob(
        # Only present when the host has no libxml2.so.2 of its own.
        ["lib/libxml2.so.2"],
        allow_empty = True,
    ),
)

filegroup(
    name = "clang_libs",
    srcs = glob(["lib/clang/20/lib/*/*.a"]),
)

filegroup(
    name = "includes",
    srcs = glob([
        "lib/clang/20/include/**",
    ]),
)

filegroup(
    name = "runtime_libs",
    srcs = [
        "lib/x86_64-unknown-linux-gnu/libc++.so.1",
        "lib/x86_64-unknown-linux-gnu/libc++abi.so.1",
        "lib/x86_64-unknown-linux-gnu/libunwind.so.1",
    ],
)

filegroup(
    name = "static_libs",
    srcs = [
        "lib/x86_64-unknown-linux-gnu/libc++.a",
        "lib/x86_64-unknown-linux-gnu/libc++abi.a",
        "lib/x86_64-unknown-linux-gnu/libunwind.a",
    ],
)
