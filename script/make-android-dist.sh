#!/bin/sh -e
d=android-dist/d
set -x
rm -rf $d
cp -Rp dist $d
# Trim down the distribution by deleting unneeded entries
for arch in `ls $d`; do
  for entry in bin etc share include/evdns.h include/event.h      \
               include/evhttp.h include/evrpc.h include/evutil.h  \
               include/tls.h lib/libevent.a lib/libtls.a          \
               lib/pkgconfig; do
    rm -r $d/$arch/$entry
  done
done
# Really make sure that only what we care about survives
find $d -type f -not -name \*.a -and -not -name \*.h -and -not \
                    -name \*.hpp -exec rm -f {} \;
find $d -type l -exec rm -f {} \;
find $d -depth -type d -empty -exec rmdir {} \;
# Finally, make a tarball and record its SHA256SUM
v=`cat VERSION`
tarball=measurement-kit-android-$v.tar.gz
(cd $d && tar -czf ../../$tarball .)
shasum -a 256 $tarball | awk '{print $1}' > SHA256SUM
