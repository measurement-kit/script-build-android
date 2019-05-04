#!/bin/sh -e
name=measurement-kit
tarball=./pkg/$name/tarball.tar.gz
builddir=./build/$MKARCH/$name
rm -rf $builddir
install -d $builddir
tar -C $builddir -xzf $tarball
srcdir=$builddir/$name-0.10.3
destdir=`pwd`/dist/$MKARCH
(
  set -ex
  cd $srcdir
  # Note: the `-n` prevents MK from downloading assets. We do not want the
  # build to download any asset, so that, once it is started, we can rest
  # assured that it will not complete because of bad connectivity.
  ./autogen.sh -n
  # TODO(bassosimone): MK's configure is not able to handle the
  # presence of `-lz` yet, so we use this hack.
  export LIBS="-lz"
  # We want to smoke test the MK executable on device. So, let's force
  # static linking so we don't need to copy over libc++_shared.so.
  export LDFLAGS="-static-libstdc++"
  ./configure --prefix=/                                       \
    --with-libevent=$destdir --with-openssl=$destdir           \
    --with-libcurl=$destdir --with-libmaxminddb=$destdir       \
    --disable-shared $CONFIGUREFLAGS
  make V=0
  make install DESTDIR=$destdir
  # Remove everything we don't need
  rm -rf $destdir/lib/libmeasurement_kit.la
  rm -rf $destdir/include/measurement_kit/README.md
)
