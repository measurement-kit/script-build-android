# Android build scripts

Make sure that you have the NDK installed. Let us know the location
in which it is installed by using

```sh
export NDK_ROOT=/path/to/NDK  # $HOME/Library/Android/sdk/ndk-bundle on macOS
```

Then download the tarballs with

```sh
./script/download.sh
```

This will download packages tarballs in `./pkg`.

Then rebuild everything with

```sh
./script/build.sh
```

This will compile in `./build` and install in `./dist`.
