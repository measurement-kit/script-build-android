#!/bin/sh -e
[ "$NDK" != "" ] || { echo "FATAL: NDK variable not set"; exit 1; }
[ "$#" -ge 2 ] || { echo "Usage: $0 <toolchain> [command <args>...]"; exit 1; }
toolchain=$1
shift
./toolchain/$toolchain.sh "$@"
