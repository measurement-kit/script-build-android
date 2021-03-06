#!/bin/sh -e
name=curl
tarball=./pkg/$name/tarball.tar.gz
builddir=./build/$MKARCH/$name
rm -rf $builddir
install -d $builddir
tar -C $builddir -xzf $tarball
srcdir=$builddir/curl-curl-7_64_1
destdir=`pwd`/dist/$MKARCH
(
  set -ex
  cd $srcdir
  ./buildconf
  ./configure \
    --disable-ftp \
     --disable-file \
     --disable-ldap \
     --disable-ldaps \
     --disable-rtsp \
     --disable-dict \
     --disable-telnet \
     --disable-tftp \
     --disable-pop3 \
     --disable-imap \
     --disable-smb \
     --disable-smtp \
     --disable-gopher \
     --disable-manual \
     --enable-ipv6 \
     --disable-sspi \
     --disable-ntlm-wb \
     --disable-tls-srp \
     --with-pic=yes \
     --without-ca-bundle \
     --without-libidn2 \
     --with-ssl=$destdir \
     --prefix=/ \
     --disable-shared \
     $CONFIGUREFLAGS
  make V=0
  make install DESTDIR=$destdir
  # Remove everything we don't need and that may confuse subsequent builds
  rm -rf $destdir/lib/libcurl.la
  rm -rf $destdir/lib/pkgconfig
  rm -rf $destdir/share
)
