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

load("//tools/workspace/clang:repository.bzl", "clang_repository")
load("//tools/workspace/raspberry_pi:repository.bzl", "raspberry_pi_repository")

def add_default_repositories(excludes = []):
    if "clang" not in excludes:
        clang_repository()
    if "raspberry_pi" not in excludes:
        raspberry_pi_repository()

def add_default_toolchains(register_host = False):
    """Register the Raspberry Pi cross-compilation toolchains.

    Call this from a consumer's WORKSPACE (after add_default_repositories)
    to make rpi_bazel's toolchains available to Bazel's platform-based
    toolchain resolution.  Then build with
    --platforms=@rpi_bazel//:armeabihf (or :aarch64).

    By default only the cross toolchains are registered, so a consumer's
    host builds keep using their own autodetected host toolchain.  Pass
    register_host = True to also register the host (k8) clang+libc++
    toolchain -- use this if you want host builds to use rpi_bazel's
    clang+libc++ toolchain (as the quad / com_github_mjbots_mech project
    does) rather than the autodetected one.
    """
    if register_host:
        native.register_toolchains(
            "@rpi_bazel//tools/cc_toolchain:k8_toolchain",
        )
    native.register_toolchains(
        "@rpi_bazel//tools/cc_toolchain:armeabihf_toolchain",
        "@rpi_bazel//tools/cc_toolchain:aarch64_toolchain",
    )
