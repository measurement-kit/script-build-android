#!/bin/sh -e
allpkgs="libmaxminddb libressl libevent curl measurement-kit"
for pkg in $allpkgs; do
  echo ./$pkg/download.sh
done
for pkg in $allpkgs; do
  for toolchain in `ls ./toolchain`; do
    echo ./toolchain/$toolchain ./$pkg/build.sh
  done
done
