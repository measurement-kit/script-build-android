# Android build scripts

Make sure that you have the NDK installed. Let us know the location
in which it is installed by using

```sh
export NDK_ROOT=/path/to/NDK  # $HOME/Library/Android/sdk/ndk-bundle on macOS
```

## Downloading tarballs

Then download the tarballs with

```sh
./script/download.sh
```

This will download packages tarballs in `./pkg`.

## Building libs

Then rebuild everything with

```sh
./script/build.sh
```

This will compile in `./build` and install in `./dist`.

## Smoke testing

It is possible (and advisable) to start an emulated device and push
the freshly build MK binary (along with the correct `libc++_shared.so`
and `ca-bundle.pem`) to make sure _immediately_ that it works on a
device. The process for now is quite clumsy, so I will not embarrass
myself by publishing it at this time. The basic procedure is to use
Android Studio to start an emulator, then `adb push` in `/data`,
and finally using `LD_LIBRARY_PATH` to let MK find `libc++_shared.so`.
