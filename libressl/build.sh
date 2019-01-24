#!/bin/sh -e
name=libressl
tarball=./pkg/$name/tarball.tar.gz
builddir=./build/$MKARCH/$name
rm -rf $builddir
install -d $builddir
tar -C $builddir -xzf $tarball
patch000=`pwd`/$name/000.patch
srcdir=$builddir/$name-2.8.3
destdir=`pwd`/dist/$MKARCH
(
  set -ex
  cd $srcdir
  patch -Np1 -i $patch000
  autoreconf -i
  ./configure --prefix=/ --disable-shared $CONFIGUREFLAGS
  make V=0
  make install DESTDIR=$destdir
)