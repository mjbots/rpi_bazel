# -*- python -*-
# Copyright 2018-2019 Josh Pieper, jjp@pobox.com.
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

cc_toolchain_suite(
    name = "toolchain",
    toolchains = {
        "k8|clang": "cc_toolchain_linux",
        "armeabihf|clang": "cc_toolchain_armeabihf",
    },
)

filegroup(
    name = "empty",
    srcs = [],
    visibility = ["//visibility:private"],
)

filegroup(
    name = "everything",
    srcs = [],
    visibility = ["//visibility:private"],
)

filegroup(
    name = "clang_wrappers",
    srcs = glob(["wrapper/clang-*"]) + [
        "@org_llvm_clang//:binaries",
        "@org_llvm_clang//:clang_libs",
    ],
)

filegroup(
    name = "clang_all",
    srcs = [
        ":clang_wrappers",
        "@org_llvm_clang//:includes",
        "@org_llvm_clang//:runtime_libs",
        "@org_llvm_clang//:static_libs",
    ],
)


cc_toolchain(
    name = "cc_toolchain_linux",
    toolchain_identifier = "clang-x86_64",
    all_files = ":clang_all",
    compiler_files = ":clang_wrappers",
    cpu = "k8",
    dwp_files = ":clang_wrappers",
    dynamic_runtime_libs = ["@org_llvm_clang//:runtime_libs"],
    linker_files = ":clang_wrappers",
    objcopy_files = ":clang_wrappers",
    static_runtime_libs = ["@org_llvm_clang//:static_libs"],
    strip_files = ":clang_wrappers",
    supports_param_files = True,
)

filegroup(
    name = "clang_arm_all",
    srcs = [
        ":clang_all",
        "//tools/cc_toolchain/raspberry_pi_sysroot:everything",
    ],
)

cc_toolchain(
    name = "cc_toolchain_armeabihf",
    toolchain_identifier = "clang-armeabihf",
    all_files = ":clang_arm_all",
    compiler_files = ":clang_arm_all",
    cpu = "armeabihf",
    dwp_files = ":clang_wrappers",
    dynamic_runtime_libs = [":empty"],
    linker_files = ":clang_arm_all",
    objcopy_files = ":clang_wrappers",
    static_runtime_libs = [":empty"],
    strip_files = ":clang_wrappers",
    supports_param_files = True,
)
