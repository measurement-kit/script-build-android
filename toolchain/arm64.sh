#!/bin/sh -e
toolchain=aarch64-linux-android
sysname="`uname -s|tr [A-Z] [a-z]`-`uname -m`"

export AR="$toolchain-ar"
export AS="$toolchain-as"
export CC="${toolchain}21-clang"
export CFLAGS="-O2 -fPIC"
export CONFIGUREFLAGS="--host=$toolchain"
export CPP="${toolchain}21-clang -E"
export CXX="${toolchain}21-clang++"
export CXXFLAGS="-O2 -fPIC"
export LD="$toolchain-ld"
export MKARCH="arm64-v8a"
export NM="$toolchain-nm"
export PATH="$NDK/toolchains/llvm/prebuilt/$sysname/bin/:$PATH"
export RANLIB="$toolchain-ranlib"
export STRIP="$toolchain-strip"

"$@"
