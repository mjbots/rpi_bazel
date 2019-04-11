# -*- python -*-

# Copyright 2018 Josh Pieper, jjp@pobox.com.
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
            "http://releases.llvm.org/7.0.0/clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz",
        ],
        sha256 = "69b85c833cd28ea04ce34002464f10a6ad9656dd2bba0f7133536a9927c660d2",
        strip_prefix = "clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-16.04",
        build_file = Label("//tools/workspace/clang:package.BUILD"),
    )
    http_archive(
        name = "org_llvm_libcxx",
        urls = [
            "http://releases.llvm.org/7.0.0/libcxx-7.0.0.src.tar.xz",
        ],
        sha256 = "9b342625ba2f4e65b52764ab2061e116c0337db2179c6bce7f9a0d70c52134f0",
        strip_prefix = "libcxx-7.0.0.src",
        build_file = Label("//tools/workspace/clang:libcxx.BUILD"),
    )
    http_archive(
        name = "org_llvm_libcxxabi",
        urls = [
            "http://releases.llvm.org/7.0.0/libcxxabi-7.0.0.src.tar.xz",
        ],
        sha256 = "9b45c759ff397512eae4d938ff82827b1bd7ccba49920777e5b5e460baeb245f",
        strip_prefix = "libcxxabi-7.0.0.src",
        build_file = Label("//tools/workspace/clang:libcxxabi.BUILD"),
    )
