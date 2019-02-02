#!/bin/sh -e
[ "$ANDROID_HOME" ] || { echo "FATAL: ANDROID_HOME not set"; exit 1; }
[ $# -eq 1 ] || { echo "Usage: $0 <arch>"; exit 1; }
set -x
arch=$1
$ANDROID_HOME/platform-tools/adb root
$ANDROID_HOME/platform-tools/adb push ./dist/$arch/bin/measurement_kit /data
$ANDROID_HOME/platform-tools/adb push ./testdata/ca-bundle.pem /data
for cmd in ndt 'web_connectivity -u http://www.google.com'; do
  $ANDROID_HOME/platform-tools/adb shell                                       \
    "cd /data && ./measurement_kit --ca-bundle-path=ca-bundle.pem $cmd"
done
$ANDROID_HOME/platform-tools/adb shell rm /data/measurement_kit
$ANDROID_HOME/platform-tools/adb shell rm /data/ca-bundle.pem
