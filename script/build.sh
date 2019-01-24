#!/bin/sh -e
if [ "$NDK_ROOT" = "" ]; then
  echo "FATAL: NDK_ROOT is not set" 1>&2
  exit 1
fi
allpkgs="libmaxminddb libressl libevent curl measurement-kit"
for pkg in $allpkgs; do
  for toolchain in `ls ./toolchain`; do
    ./toolchain/$toolchain ./$pkg/build.sh
  done
done
