#!/bin/sh -e
name=libmaxminddb
tarball=./pkg/$name/tarball.tar.gz
builddir=./build/$MKARCH/$name
rm -rf $builddir
install -d $builddir
tar -C $builddir -xzf $tarball
srcdir=$builddir/libmaxminddb-1.3.2
destdir=`pwd`/dist/$MKARCH
(
  set -ex
  cd $srcdir
  ./bootstrap
  ./configure --prefix=/ --disable-shared --disable-tests $CONFIGUREFLAGS
  make V=0
  make install DESTDIR=$destdir
  # Remove everything we don't need and that may confuse subsequent builds
  rm -rf $destdir/lib/pkgconfig
  rm -rf $destdir/lib/libmaxminddb.la
  rm -rf $destdir/share
)
