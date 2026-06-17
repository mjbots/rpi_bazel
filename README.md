# Raspberry Pi bazel cross compilation rules #

This contains a set of rules to use for cross compiling C++ to a
Raspberry Pi using clang.  It includes a minimal sysroot, and only
needs a functioning clang compiler.

 * travis-ci [![Build Status](https://travis-ci.org/mjbots/rpi_bazel.svg?branch=master)](https://travis-ci.org/mjbots/rpi_bazel)

## Example Usage ##

In `tools/workspace/rpi_bazel/repository.bzl`

```
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")


def rpi_bazel_repository(name):
    commit = "XXX"
    http_archive(
        name = name,
        url = "https://github.com/mjbots/rpi_bazel/archive/{}.zip".format(commit),
        sha256 = "XXX",
        strip_prefix = "rpi_bazel-{}".format(commit),
    )

```

At least an empty `tools/workspace/rpi_bazel/BUILD` is required.

In `tools/workspace/default.bzl`:

```
load("//tools/workspace/rpi_bazel:repository.bzl", "rpi_bazel_repository")

def add_default_repositories(excludes = []):
    if "rpi_bazel" not in excludes:
        rpi_bazel_repository(name = "rpi_bazel")
```

At least an empty `tools/workspace/BUILD` is required.

In WORKSPACE:

```
load("//tools/workspace:default.bzl", "add_default_repositories")

add_default_repositories()

load("@rpi_bazel//tools/workspace:default.bzl",
     rpi_bazel_add = "add_default_repositories",
     rpi_bazel_register = "add_default_toolchains")
rpi_bazel_add()

# Register the Raspberry Pi cross-compilation toolchains for Bazel's
# platform-based toolchain resolution.
rpi_bazel_register()
```


In `tools/bazel.rc`

```
build --incompatible_enable_cc_toolchain_resolution

# Name bazel-out directories by platform so host and Pi outputs coexist.
# NOTE: Bazel 9 renames --experimental_override_name_platform_in_output_dir to --experimental_override_platform_cpu_name (bazelbuild/bazel#27575).
build --experimental_platform_in_output_dir
build --experimental_override_name_platform_in_output_dir=@rpi_bazel//:armeabihf=armeabihf
build --experimental_override_name_platform_in_output_dir=@rpi_bazel//:aarch64=aarch64

build:pi --platforms=@rpi_bazel//:armeabihf
test:pi --platforms=@rpi_bazel//:armeabihf

build:pi64 --platforms=@rpi_bazel//:aarch64
test:pi64 --platforms=@rpi_bazel//:aarch64
```

Then you can build for 32-bit (armv7 hard-float) or 64-bit (aarch64)
Raspberry Pi OS with:

```
bazel build --config=pi //...
bazel build --config=pi64 //...
```

Because toolchains are now selected by `--platforms`, the Raspberry Pi
toolchain coexists with other platform-based toolchains (e.g. the host
toolchain, or `rules_rust` for cross-compiling Rust to the Pi) in a
single build, rather than requiring a global `--crosstool_top`/`--cpu`.

### Legacy `--crosstool_top` selection ###

The previous `cc_toolchain_suite` is still present for backwards
compatibility, so the older selection mechanism continues to work:

```
build:pi --crosstool_top=@rpi_bazel//tools/cc_toolchain:toolchain
build:pi --cpu=armeabihf
build:pi --compiler=clang
build:pi --noincompatible_enable_cc_toolchain_resolution
```
