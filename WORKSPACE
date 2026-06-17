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

workspace(name = "rpi_bazel")

BAZEL_VERSION = "7.4.1"
BAZEL_VERSION_SHA = "c97f02133adce63f0c28678ac1f21d65fa8255c80429b588aeeba8a1fac6202b"

load("//tools/workspace:default.bzl",
     "add_default_repositories",
     "add_default_toolchains")

add_default_repositories()

# Register the Raspberry Pi cross toolchains plus the host (k8)
# clang+libc++ toolchain, so this repository's own example builds for
# the host with clang.  (Consumers get only the cross toolchains unless
# they too pass register_host = True.)
add_default_toolchains(register_host = True)
