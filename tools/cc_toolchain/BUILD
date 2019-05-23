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

load(":cc_toolchain_config.bzl", "cc_toolchain_config")

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
        "@org_llvm_libcxx//:raw_headers",
        "@org_llvm_libcxxabi//:raw_headers",
    ],
)


cc_toolchain_config(
    name = "clang-k8",
    toolchain_identifier = "clang-k8",
    cpu = "k8",
    target_cpu = "k8",
    target_system_name = "k8",
    builtin_include_directories = [
        "external/org_llvm_clang/include/",
        "external/org_llvm_clang/lib/clang/7.0.0/include/",
        "/usr/include/",
    ],
    host_compiler_prefix = "wrapper",
    host_compiler_path = "wrapper/clang-clang",
)


cc_toolchain(
    name = "cc_toolchain_linux",
    toolchain_identifier = "clang-x86_64",
    all_files = ":clang_all",
    compiler_files = ":clang_all",
    dwp_files = ":clang_wrappers",
    linker_files = ":clang_wrappers",
    objcopy_files = ":clang_wrappers",
    strip_files = ":clang_wrappers",
    supports_param_files = True,
    toolchain_config = ":clang-k8",
)

filegroup(
    name = "clang_arm_all",
    srcs = [
        ":clang_all",
        "//tools/cc_toolchain/raspberry_pi_sysroot:everything",
    ],
)

cc_toolchain_config(
    name = "clang-armeabihf",
    toolchain_identifier = "clang-armeabihf",
    cpu = "k8",
    target_cpu = "armeabihf",
    target_system_name = "armeabihf",
    builtin_include_directories = [
        "external/raspberry_pi/sysroot/usr/include/arm-linux-gnueabihf",
        "external/raspberry_pi/sysroot/usr/include",
        "external/org_llvm_clang/include/",
        "external/org_llvm_clang/lib/clang/7.0.0/include/",
        "/usr/include/",
    ],
    host_compiler_prefix = "wrapper",
    host_compiler_path = "wrapper/clang-clang",
    extra_features = [
        "armeabihf",
    ],
    linker_bin_path = "external/org_llvm_clang/bin",
)

cc_toolchain(
    name = "cc_toolchain_armeabihf",
    toolchain_identifier = "clang-armeabihf",
    all_files = ":clang_arm_all",
    compiler_files = ":clang_arm_all",
    dwp_files = ":clang_wrappers",
    linker_files = ":clang_arm_all",
    objcopy_files = ":clang_wrappers",
    strip_files = ":clang_wrappers",
    supports_param_files = True,
    toolchain_config = ":clang-armeabihf",
)
