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

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

CLANG_VERSION = '10.0.0'
CLANG_SHA = '633a833396bf2276094c126b072d52b59aca6249e7ce8eae14c728016edb5e61'

LIBCXX_SHA = '270f8a3f176f1981b0f6ab8aa556720988872ec2b48ed3b605d0ced8d09156c7'
LIBCXXABI_SHA = 'e71bac75a88c9dde455ad3f2a2b449bf745eafd41d2d8432253b2964e0ca14e1'

HOST_ARCHITECTURE = 'x86_64'
HOST_OS = 'apple-darwin'


def clang_repository():
    http_archive(
        name = "org_llvm_clang",
        urls = [
            "https://github.com/llvm/llvm-project/releases/download/llvmorg-{}/clang+llvm-{}-{}-{}.tar.xz".format(
                CLANG_VERSION, CLANG_VERSION, HOST_ARCHITECTURE, HOST_OS
            ),
        ],
        sha256 = CLANG_SHA,
        strip_prefix = "clang+llvm-{}-{}-{}".format(
            CLANG_VERSION, HOST_ARCHITECTURE, HOST_OS
        ),
        build_file = Label("//tools/workspace/clang:package.BUILD"),
    )
    http_archive(
        name = "org_llvm_libcxx",
        urls = [
            "https://github.com/llvm/llvm-project/releases/download/llvmorg-{}/libcxx-{}.src.tar.xz".format(
                CLANG_VERSION, CLANG_VERSION
            ),
        ],
        sha256 = LIBCXX_SHA,
        strip_prefix = "libcxx-{}.src".format(CLANG_VERSION),
        build_file = Label("//tools/workspace/clang:libcxx.BUILD"),
    )
    http_archive(
        name = "org_llvm_libcxxabi",
        urls = [
            "https://github.com/llvm/llvm-project/releases/download/llvmorg-{}/libcxxabi-{}.src.tar.xz".format(
                CLANG_VERSION, CLANG_VERSION
            ),
        ],
        sha256 = LIBCXXABI_SHA,
        strip_prefix = "libcxxabi-{}.src".format(CLANG_VERSION),
        build_file = Label("//tools/workspace/clang:libcxxabi.BUILD"),
    )
