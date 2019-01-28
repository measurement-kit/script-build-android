#!/bin/sh -e
if [ "$NDK_ROOT" = "" ]; then
  echo "FATAL: NDK_ROOT is not set" 1>&2
  exit 1
fi
if [ $# -eq 0 ]; then
  echo "Usage: $0 [package...]" 1>&2
  exit 1
else
  allpkgs="$@"
  if [ $allpkgs = "all" ]; then
    allpkgs="libmaxminddb libressl libevent curl measurement-kit"
  fi
fi
for pkg in $allpkgs; do
  for toolchain in `ls ./toolchain`; do
    ./toolchain/$toolchain ./$pkg/build.sh
  done
done
