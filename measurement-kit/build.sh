#!/bin/sh -e
name=measurement-kit
tarball=./pkg/$name/tarball.tar.gz
builddir=./build/$MKARCH/$name
rm -rf $builddir
install -d $builddir
tar -C $builddir -xzf $tarball
srcdir=$builddir/$name-0.9.2
destdir=`pwd`/dist/$MKARCH
(
  set -ex
  cd $srcdir
  ./autogen.sh -n
  # TODO(bassosimone): the way in which MK's configure works is such
  # that moved libtool libraries completely confuse it.\
  find $destdir -type f -name \*.la -exec rm {} \;
  # TODO(bassosimone): MK's configure is not able to handle the
  # presence of `-lz` yet, so we use this hack.
  export LIBS="-lz"
  ./configure --prefix=/ --disable-dependency-tracking         \
    --with-libevent=$destdir --with-openssl=$destdir           \
    --with-libcurl=$destdir --with-libmaxminddb=$destdir       \
    --disable-shared $CONFIGUREFLAGS
  make V=0
  make install DESTDIR=$destdir
)
