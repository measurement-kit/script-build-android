#!/bin/sh -e
# There is some inconsistency in tool names
tool=arm-linux-androideabi
compiler=armv7a-linux-androideabi16
sysname="`uname -s|tr [A-Z] [a-z]`-`uname -m`"
extraflags="-mfloat-abi=softfp -mfpu=vfpv3-d16 -mthumb"

export AR="$tool-ar"
export AS="$tool-as"
export CC="${compiler}-clang"
export CFLAGS="-O2 -fPIC $extraflags"
export CONFIGUREFLAGS="--host=$compiler"
export CPP="${compiler}-clang -E"
export CXX="${compiler}-clang++"
export CXXFLAGS="-O2 -fPIC $extraflags"
export LD="$tool-ld"
export MKARCH="armeabi-v7a"
export NM="$tool-nm"
export PATH="$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/$sysname/bin/:$PATH"
export RANLIB="$tool-ranlib"
export STRIP="$tool-strip"

"$@"
