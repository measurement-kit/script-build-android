#!/bin/sh -e
name=libevent
tarball=./pkg/$name/tarball.tar.gz
builddir=./build/$MKARCH/$name
rm -rf $builddir
install -d $builddir
tar -C $builddir -xzf $tarball
patch000=`pwd`/$name/000.patch
patch001=`pwd`/$name/001.patch
srcdir=$builddir/$name-release-2.1.8-stable
destdir=`pwd`/dist/$MKARCH
(
  set -ex
  cd $srcdir
  patch -Np1 -i $patch000
  patch -Np1 -i $patch001
  ./autogen.sh
  export CPPFLAGS="${CPPFLAGS} -I${destdir}/include"
  export LDFLAGS="${LDFLAGS} -L${destdir}/lib"
  ./configure --prefix=/ --disable-shared --disable-samples                    \
    --disable-libevent-regress --disable-clock-gettime $CONFIGUREFLAGS
  make V=0
  make install DESTDIR=$destdir
  # Remove everything we don't need and may confuse subsequent builds
  rm -rf $destdir/bin
  rm -rf $destdir/lib/pkgconfig
  rm -rf $destdir/lib/libevent_openssl.la
  rm -rf $destdir/lib/libevent_extra.la
  rm -rf $destdir/lib/libevent.la
  rm -rf $destdir/lib/libevent.a
  rm -rf $destdir/lib/libevent_core.la
  rm -rf $destdir/lib/libevent_pthreads.la
)
