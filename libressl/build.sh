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
  # Remove everything we don't need and that may confuse subsequent builds
  rm -rf $destdir/etc
  rm -rf $destdir/lib/pkgconfig
  rm -rf $destdir/lib/libcrypto.la
  rm -rf $destdir/lib/libssl.la
  rm -rf $destdir/lib/libtls.la
  rm -rf $destdir/share
)
