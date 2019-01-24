#!/bin/sh -e
toolchain=i686-linux-android

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
export PATH="$NDK/toolchains/llvm/prebuilt/darwin-x86_64/bin/:$PATH"
export RANLIB="$toolchain-ranlib"
export STRIP="$toolchain-strip"

"$@"