#!/bin/sh -e
name=measurement-kit
tarball=./pkg/$name/tarball.tar.gz
builddir=./build/$MKARCH/$name
rm -rf $builddir
install -d $builddir
tar -C $builddir -xzf $tarball
patch000=`pwd`/$name/000.patch
srcdir=$builddir/$name-0.9.2
destdir=`pwd`/dist/$MKARCH
(
  set -ex
  cd $srcdir
  patch -Np1 -i $patch000
  # Note: the `-n` prevents MK from downloading assets. We do not want the
  # build to download any asset, so that, once it is started, we can rest
  # assured that it will not complete because of bad connectivity.
  ./autogen.sh -n
  # TODO(bassosimone): the way in which MK's configure works is such
  # that moved libtool libraries completely confuse it.
  find $destdir -type f -name \*.la -exec rm {} \;
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
)
