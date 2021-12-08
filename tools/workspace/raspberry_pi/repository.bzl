# -*- python -*-

# Copyright 2018 Josh Pieper, jjp@pobox.com.
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

def _raspberry_pi_impl(ctx):
    result = ctx.execute([
        "bash",
        "-c",
        "mkdir -p sysroot && tar xvf {} -C sysroot".format(ctx.path(ctx.attr.sysroot)),
    ])

    if result.return_code != 0:
        fail(result.stdout + result.stderr)

    ctx.file("WORKSPACE", "workspace(name = \"{}\")\n".format(ctx.name))

    ctx.file("BUILD", "")
    ctx.file(
        "sysroot/BUILD",
        """
filegroup(
    name="everything",
    srcs=glob(["**"]),
    visibility = ["//visibility:public"],
)
        """)

_raspberry_pi_attrs = {
    "sysroot": attr.label(
        allow_files=True,
        default="@rpi_bazel//tools/workspace/raspberry_pi:2021-12-07-sysroot.tar.xz"),
}

raspberry_pi_repository = repository_rule(
    implementation = _raspberry_pi_impl,
    attrs = _raspberry_pi_attrs,
)
