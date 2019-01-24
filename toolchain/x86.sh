#!/bin/sh -e
toolchain=i686-linux-android
sysname="`uname -s|tr [A-Z] [a-z]`-`uname -m`"

export AR="$toolchain-ar"
export AS="$toolchain-as"
export CC="${toolchain}16-clang"
export CFLAGS="-O2 -fPIC"
export CONFIGUREFLAGS="--host=$toolchain"
export CPP="${toolchain}16-clang -E"
export CXX="${toolchain}16-clang++"
export CXXFLAGS="-O2 -fPIC"
export LD="$toolchain-ld"
export MKARCH="x86"
export NM="$toolchain-nm"
export PATH="$NDK_ROOT/toolchains/llvm/prebuilt/$sysname/bin/:$PATH"
export RANLIB="$toolchain-ranlib"
export STRIP="$toolchain-strip"

"$@"
