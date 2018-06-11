#!/usr/bin/python3 -B

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

"""Extract a sysroot suitable for cross compilation from a live
raspberry pi.
"""

import argparse
import datetime
import subprocess
import tempfile


def call(cmd, *args, **kwargs):
    print("Running:", cmd)
    subprocess.check_call(cmd, *args, **kwargs)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--user', '-u', help='username', default='pi')
    parser.add_argument('--target', default='arm-linux-gnueabihf')
    parser.add_argument('host', help='IP to use')
    args = parser.parse_args()

    temp_dir = tempfile.mkdtemp(prefix='make-sysroot-')

    # These are the directories we want whole.
    recursive_sources = [
        '/usr/lib/gcc/{}'.format(args.target),
        '/usr/include/{}/asm'.format(args.target),
        '/usr/include/{}/bits'.format(args.target),
        '/usr/include/{}/c++'.format(args.target),
        '/usr/include/{}/gnu'.format(args.target),
        '/usr/include/{}/sys'.format(args.target),
        '/usr/include/arpa'.format(args.target),
        '/usr/include/asm-generic',
        '/usr/include/c++',
        '/usr/include/linux',
        '/usr/include/net',
        '/usr/include/netinet',
        '/usr/include/rpc',
        '/usr/include/X11',
    ]

    # And these individual files.
    lib_file_sources = ['/lib/{}/{}'.format(args.target, x) for x in [
        'libnss*',
        'ld-*.so*',
        'libc.so*',
        'libdl*',
        'libgcc_s.so*',
        'libm-2*.so',
        'libm.so*',
        'libpthread-2*.so',
        'libpthread.so*',
        'librt-2*.so',
        'librt.so*',
        'libutil-2*',
        'libutil.so*',
        'libresolv*',
    ]]

    usr_lib_file_sources = ['/usr/lib/{}/{}'.format(args.target, x) for x in [
        '*.o',
        'libc.a',
        'libc_nonshared.a',
        'libc.so',
        'libdl.a',
        'libdl.so',
        'libm.a',
        'libm.so',
        'libpthread.a',
        'libpthread_nonshared.a',
        'libpthread.so',
        'librt.so',
        'librt.a',
        'libutil.so',
        'libutil.a',
        'libresolv.a',
        'libresolv.so',
    ]]

    usr_include_file_sources = ['/usr/include/{}'.format(x) for x in [
        '*.h',
    ]]

    # Prepare our 'rsync' compatible formats for all filters.
    include_patterns = (
        ['{}/***'.format(x) for x in recursive_sources] +
        lib_file_sources +
        usr_lib_file_sources +
        usr_include_file_sources
    )

    # Excluding these directories is necessary for (a) time, and (b)
    # they contain some files with either recursive symlinks or
    # inaccessible files.
    exclude_dirs = [
        'bin',
        'boot',
        'dev',
        'etc',
        'home',
        'lost+found',
        'media',
        'opt',
        'proc',
        'root',
        'run',
        'sbin',
        'srv',
        'sys',
        'tmp',
        'usr/share',
        'usr/lib/ssl',
        'var',
    ]

    print(temp_dir)

    call([
        'rsync',
        '-vrzLR',
        '--prune-empty-dirs',
        '--safe-links',
        '--exclude=cc1',
        '--exclude=cc1plus',
        '--exclude=lto-wrapper',
        '--exclude=lto1', ] + [
            '--exclude=/{}'.format(x) for x in exclude_dirs ] +
    ['--include={}'.format(x) for x in include_patterns] + [
        '--include=*/',
        '--exclude=/***',
        '{}@{}:/'.format(args.user, args.host),
        temp_dir,
    ])

    call("tar -c -C {} . | xz -9 > {}-sysroot.tar.xz".format(
        temp_dir, datetime.date.today().isoformat()),
         shell=True)


if __name__ == '__main__':
    main()
