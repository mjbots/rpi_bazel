# Raspberry Pi bazel cross compilation rules #

This contains a set of rules to use for cross compiling C++ to a
Raspberry Pi using clang.  It includes a minimal sysroot, and only
needs a functioning clang compiler.

## Example Usage ##

```
sudo apt install clang-6.0 lld-6.0
```

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
     rpi_bazel_add = "add_default_repositories")
rpi_bazel_add()
```


In `tools/bazel.rc`

```
build --crosstool_top=@rpi_bazel//tools/cc_toolchain:toolchain
test --crosstool_top=@rpi_bazel//tools/cc_toolchain:toolchain

build:pi --cpu=armeabihf
build:pi --cpu=armeabihf
```

Then you can build and run tests with:

```
bazel test --config=pi //...
```
