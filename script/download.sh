#!/bin/sh -ex
for dir in `ls src`; do
  source src/$dir/download.sh
  rm -rf pkg/$dir
  mkdir pkg/$dir
  curl -fsSL -o pkg/$dir/tarball.tar.gz $url
  [ "$sha256" = "`shasum -a 256 pkg/$dir/tarball.tar.gz | awk '{print $1}'`" ]
done
