# -*- python -*-

package(default_visibility = ["//visibility:public"])

cc_toolchain_suite(
    name = "toolchain",
    toolchains = {
        "k8|clang-5.0": "cc_toolchain_linux",
        "armeabihf|clang-5.0": "cc_toolchain_armeabihf",
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

cc_toolchain(
    name = "cc_toolchain_linux",
    all_files = ":empty",
    compiler_files = ":empty",
    cpu = "k8",
    dwp_files = ":empty",
    dynamic_runtime_libs = [":empty"],
    linker_files = ":empty",
    objcopy_files = ":empty",
    static_runtime_libs = [":empty"],
    strip_files = ":empty",
    supports_param_files = 0,
)

cc_toolchain(
    name = "cc_toolchain_armeabihf",
    all_files = "//tools/cc_toolchain/raspberry_pi_sysroot:everything",
    compiler_files = "//tools/cc_toolchain/raspberry_pi_sysroot:everything",
    cpu = "armeabihf",
    dwp_files = ":empty",
    dynamic_runtime_libs = [":empty"],
    linker_files = "//tools/cc_toolchain/raspberry_pi_sysroot:everything",
    objcopy_files = ":empty",
    static_runtime_libs = [":empty"],
    strip_files = ":empty",
    supports_param_files = 0,
)
