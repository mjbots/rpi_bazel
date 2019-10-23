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

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")


def clang_repository():
    http_archive(
        name = "org_llvm_clang",
        urls = [
            "http://releases.llvm.org/9.0.0/clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz",
        ],
        sha256 = "5c1473c2611e1eac4ed1aeea5544eac5e9d266f40c5623bbaeb1c6555815a27d",
        strip_prefix = "clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-16.04",
        build_file = Label("//tools/workspace/clang:package.BUILD"),
    )
    http_archive(
        name = "org_llvm_libcxx",
        urls = [
            "http://releases.llvm.org/9.0.0/libcxx-9.0.0.src.tar.xz",
        ],
        sha256 = "3c4162972b5d3204ba47ac384aa456855a17b5e97422723d4758251acf1ed28c",
        strip_prefix = "libcxx-9.0.0.src",
        build_file = Label("//tools/workspace/clang:libcxx.BUILD"),
    )
    http_archive(
        name = "org_llvm_libcxxabi",
        urls = [
            "http://releases.llvm.org/9.0.0/libcxxabi-9.0.0.src.tar.xz",
        ],
        sha256 = "675041783565c906ac2f7f8b2bc5c40f14d871ecfa8ade34855aa18de95530e9",
        strip_prefix = "libcxxabi-9.0.0.src",
        build_file = Label("//tools/workspace/clang:libcxxabi.BUILD"),
    )
