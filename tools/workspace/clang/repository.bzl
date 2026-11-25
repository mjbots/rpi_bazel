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

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

LLVM_VERSION = "20.1.8"

_LLVM_RELEASE = "https://github.com/llvm/llvm-project/releases/download/llvmorg-{}/".format(LLVM_VERSION)

# libc++ and libc++abi are built from source for each target, as the
# binary distribution only contains them for the host.
_SRC_URLS = [_LLVM_RELEASE + "llvm-project-{}.src.tar.xz".format(LLVM_VERSION)]
_SRC_SHA256 = "6898f963c8e938981e6c4a302e83ec5beb4630147c7311183cf61069af16333d"
_SRC_PREFIX = "llvm-project-{}.src/".format(LLVM_VERSION)

# The upstream build generates this with cmake.  These are the values
# from the official linux binary distribution, with the exception that
# the time zone database is disabled as it lives in the experimental
# library which we do not build.
_CONFIG_SITE = """
#ifndef _LIBCPP___CONFIG_SITE
#define _LIBCPP___CONFIG_SITE

#define _LIBCPP_ABI_VERSION 1
#define _LIBCPP_ABI_NAMESPACE __1
#define _LIBCPP_ABI_FORCE_ITANIUM 0
#define _LIBCPP_ABI_FORCE_MICROSOFT 0
#define _LIBCPP_HAS_THREADS 1
#define _LIBCPP_HAS_MONOTONIC_CLOCK 1
#define _LIBCPP_HAS_TERMINAL 1
#define _LIBCPP_HAS_MUSL_LIBC 0
#define _LIBCPP_HAS_THREAD_API_PTHREAD 0
#define _LIBCPP_HAS_THREAD_API_EXTERNAL 0
#define _LIBCPP_HAS_THREAD_API_WIN32 0
#define _LIBCPP_HAS_THREAD_API_C11 0
#define _LIBCPP_HAS_VENDOR_AVAILABILITY_ANNOTATIONS 0
#define _LIBCPP_HAS_FILESYSTEM 1
#define _LIBCPP_HAS_RANDOM_DEVICE 1
#define _LIBCPP_HAS_LOCALIZATION 1
#define _LIBCPP_HAS_UNICODE 1
#define _LIBCPP_HAS_WIDE_CHARACTERS 1
#define _LIBCPP_HAS_TIME_ZONE_DATABASE 0
#define _LIBCPP_INSTRUMENTED_WITH_ASAN 0

#define _LIBCPP_PSTL_BACKEND_STD_THREAD

#define _LIBCPP_HARDENING_MODE_DEFAULT 2

#endif // _LIBCPP___CONFIG_SITE
"""

# ld.lld is built against libxml2.so.2 with versioned symbols.
# Distributions with libxml2 2.14+ (e.g. Ubuntu 26.04) bumped the
# SONAME and no longer provide it.  lld only uses libxml2 for Windows
# manifest handling, so when the host lacks libxml2.so.2, build a stub
# library with the right SONAME and symbol versions.  ld.lld has a
# RUNPATH of $ORIGIN/../lib, so it will be found there.  This mirrors
# what mjbots/bazel-toolchain does.
_LIBXML2_STUB_SYMBOLS = [
    "xmlAddChild",
    "xmlCopyNamespace",
    "xmlDocDumpFormatMemoryEnc",
    "xmlDocGetRootElement",
    "xmlDocSetRootElement",
    "xmlFree",
    "xmlFreeDoc",
    "xmlFreeNode",
    "xmlFreeNs",
    "xmlNewDoc",
    "xmlNewNs",
    "xmlNewProp",
    "xmlSetGenericErrorFunc",
    "xmlStrdup",
    "xmlUnlinkNode",
]

_LIBXML2_STUB_C = "".join([
    "void {}(void) {{}}\n".format(x)
    for x in _LIBXML2_STUB_SYMBOLS + ["xmlReadMemory"]
])

_LIBXML2_STUB_VER = (
    "LIBXML2_2.4.30 {\n  global:\n" +
    "".join(["    {};\n".format(x) for x in _LIBXML2_STUB_SYMBOLS]) +
    "  local: *;\n};\n\n" +
    "LIBXML2_2.6.0 {\n  global:\n    xmlReadMemory;\n} LIBXML2_2.4.30;\n"
)

_LIBXML2_STUB_CMD = """
if ! ldconfig -p 2>/dev/null | grep -q 'libxml2\\.so\\.2 '; then
cat > lib/_libxml2_stub.c <<'EOF'
""" + _LIBXML2_STUB_C + """EOF
cat > lib/_libxml2_stub.ver <<'EOF'
""" + _LIBXML2_STUB_VER + """EOF
bin/clang -shared -fPIC -nostdlib \
    -Wl,-soname,libxml2.so.2 \
    -Wl,--version-script=lib/_libxml2_stub.ver \
    -o lib/libxml2.so.2 lib/_libxml2_stub.c
fi
"""

def clang_repository():
    http_archive(
        name = "org_llvm_clang",
        urls = [
            _LLVM_RELEASE + "LLVM-{}-Linux-X64.tar.xz".format(LLVM_VERSION),
        ],
        sha256 = "1ead36b3dfcb774b57be530df42bec70ab2d239fbce9889447c7a29a4ddc1ae6",
        strip_prefix = "LLVM-{}-Linux-X64".format(LLVM_VERSION),
        build_file = Label("//tools/workspace/clang:package.BUILD"),
        patch_cmds = [_LIBXML2_STUB_CMD],
    )
    http_archive(
        name = "org_llvm_libcxx",
        urls = _SRC_URLS,
        sha256 = _SRC_SHA256,
        strip_prefix = _SRC_PREFIX + "libcxx",
        build_file = Label("//tools/workspace/clang:libcxx.BUILD"),
        patch_cmds = [
            "cat > include/__config_site <<'EOF'" + _CONFIG_SITE + "EOF",
            "cp vendor/llvm/default_assertion_handler.in include/__assertion_handler",
        ],
    )
    http_archive(
        name = "org_llvm_libcxxabi",
        urls = _SRC_URLS,
        sha256 = _SRC_SHA256,
        strip_prefix = _SRC_PREFIX + "libcxxabi",
        build_file = Label("//tools/workspace/clang:libcxxabi.BUILD"),
    )

    # libc++ uses some of the internals of llvm's libc to implement
    # floating point parsing.
    http_archive(
        name = "org_llvm_libc",
        urls = _SRC_URLS,
        sha256 = _SRC_SHA256,
        strip_prefix = _SRC_PREFIX + "libc",
        build_file = Label("//tools/workspace/clang:libc.BUILD"),
    )
