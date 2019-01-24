#!/bin/sh -e
USAGE="$0 arm64|armeabi-v7a|x86|x86_64 command [args...]"
[ "$NDK" != "" ] || { echo "FATAL: NDK variable not set"; exit 1; }
[ "$#" -ge 2 ] || { echo "$USAGE"; exit 1; }
toolchain=$1
shift
./toolchain/$toolchain.sh "$@"
