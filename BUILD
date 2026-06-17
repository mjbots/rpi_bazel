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

package(default_visibility = ["//visibility:public"])

# Platforms describing the Raspberry Pi targets this toolchain can
# build for.  Select one with `--platforms=@rpi_bazel//:armeabihf` (or
# `:aarch64`) and Bazel's platform-based toolchain resolution will pick
# the matching cc_toolchain registered by add_default_toolchains().
#
# These use the upstream @platforms constraints so they interoperate
# with other rule sets (e.g. rules_rust, which maps the
# armv7-unknown-linux-gnueabihf / aarch64-unknown-linux-gnu triples to
# these same constraint values).

# 32-bit Raspberry Pi OS (armv7 hard-float, arm-linux-gnueabihf).
platform(
    name = "armeabihf",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:armv7",
    ],
)

# 64-bit Raspberry Pi OS (aarch64-linux-gnu).
platform(
    name = "aarch64",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
    ],
)
