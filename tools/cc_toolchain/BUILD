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

load(":cc_toolchain_config.bzl", "cc_toolchain_config")

# Legacy cc_toolchain_suite.  Bazel now uses platform-based toolchain
# resolution (the toolchain() rules below), but this suite is kept so
# that consumers which still pass --crosstool_top=@rpi_bazel//tools/cc_toolchain:toolchain
# (along with a matching --cpu) continue to work, and so it can be used
# to work around https://github.com/bazelbuild/bazel/issues/12036 if
# needed.  Prefer --platforms=@rpi_bazel//:armeabihf (or :aarch64).
cc_toolchain_suite(
    name = "toolchain",
    toolchains = {
        "k8|clang": "cc_toolchain_linux",
        "armeabihf|clang": "cc_toolchain_armeabihf",
        "aarch64|clang": "cc_toolchain_aarch64",
    },
    # Excluded from wildcard builds (//...): analyzing the suite requires
    # the legacy --cpu/--compiler flags, which are no longer set by
    # default now that toolchains are selected via --platforms.
    tags = ["manual"],
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
    ar_files = ":clang_wrappers",
    as_files = ":clang_wrappers",
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
        "external/raspberry_pi_armeabihf/sysroot/usr/include/arm-linux-gnueabihf",
        "external/raspberry_pi_armeabihf/sysroot/usr/include",
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
    ar_files = ":clang_arm_all",
    as_files = ":clang_arm_all",
    objcopy_files = ":clang_wrappers",
    strip_files = ":clang_wrappers",
    supports_param_files = True,
    toolchain_config = ":clang-armeabihf",
)

cc_toolchain_config(
    name = "clang-aarch64",
    toolchain_identifier = "clang-aarch64",
    cpu = "k8",
    target_cpu = "aarch64",
    target_system_name = "aarch64",
    builtin_include_directories = [
        "external/raspberry_pi_aarch64/sysroot/usr/include/arm-linux-aarch64",
        "external/raspberry_pi_aarch64/sysroot/usr/include",
        "external/org_llvm_clang/include/",
        "external/org_llvm_clang/lib/clang/7.0.0/include/",
        "/usr/include/",
    ],
    host_compiler_prefix = "wrapper",
    host_compiler_path = "wrapper/clang-clang",
    extra_features = [
        "aarch64",
    ],
    linker_bin_path = "external/org_llvm_clang/bin",
)

cc_toolchain(
    name = "cc_toolchain_aarch64",
    toolchain_identifier = "clang-aarch64",
    all_files = ":clang_arm_all",
    compiler_files = ":clang_arm_all",
    dwp_files = ":clang_wrappers",
    linker_files = ":clang_arm_all",
    ar_files = ":clang_arm_all",
    as_files = ":clang_arm_all",
    objcopy_files = ":clang_wrappers",
    strip_files = ":clang_wrappers",
    supports_param_files = True,
    toolchain_config = ":clang-aarch64",
)


# Platform-based toolchain resolution.  Each toolchain() advertises a
# cc_toolchain for a particular target platform; Bazel selects the one
# whose target_compatible_with matches --platforms.  These are
# registered for consumers by add_default_toolchains() in
# //tools/workspace:default.bzl (the cross toolchains) and for this
# repository's own builds in the WORKSPACE (which also registers the
# host k8 toolchain).

# Host (x86_64 linux) clang+libc++ toolchain.  Registered only for
# rpi_bazel's own builds, not exposed to consumers, so that downstream
# host builds keep using their autodetected host toolchain.
toolchain(
    name = "k8_toolchain",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    toolchain = ":cc_toolchain_linux",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

# 32-bit Raspberry Pi (armv7 hard-float).
toolchain(
    name = "armeabihf_toolchain",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:armv7",
        "@platforms//os:linux",
    ],
    toolchain = ":cc_toolchain_armeabihf",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

# 64-bit Raspberry Pi (aarch64).
toolchain(
    name = "aarch64_toolchain",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:aarch64",
        "@platforms//os:linux",
    ],
    toolchain = ":cc_toolchain_aarch64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
