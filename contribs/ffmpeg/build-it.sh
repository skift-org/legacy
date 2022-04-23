#!/bin/sh

cd sources
sysroot="$PWD/../../build/sysroot"
export CPPFLAGS="-I$sysroot/system/includes"
export LDFLAGS="-L$sysroot/system/libraries -static -lc"
./configure \
 --enable-cross-compile --target-os=minix \
 --cross_prefix=i686-pc-skift- --arch=i686 --prefix=./install && make -j $(nproc)
cd ..
