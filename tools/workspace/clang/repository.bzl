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
            "http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz",
        ],
        sha256 = "87b88d620284d1f0573923e6f7cc89edccf11d19ebaec1cfb83b4f09ac5db09c",
        strip_prefix = "clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-16.04",
        build_file = Label("//tools/workspace/clang:package.BUILD"),
    )
    http_archive(
        name = "org_llvm_libcxx",
        urls = [
            "http://releases.llvm.org/8.0.0/libcxx-8.0.0.src.tar.xz",
        ],
        sha256 = "c2902675e7c84324fb2c1e45489220f250ede016cc3117186785d9dc291f9de2",
        strip_prefix = "libcxx-8.0.0.src",
        build_file = Label("//tools/workspace/clang:libcxx.BUILD"),
    )
    http_archive(
        name = "org_llvm_libcxxabi",
        urls = [
            "http://releases.llvm.org/8.0.0/libcxxabi-8.0.0.src.tar.xz",
        ],
        sha256 = "c2d6de9629f7c072ac20ada776374e9e3168142f20a46cdb9d6df973922b07cd",
        strip_prefix = "libcxxabi-8.0.0.src",
        build_file = Label("//tools/workspace/clang:libcxxabi.BUILD"),
    )
