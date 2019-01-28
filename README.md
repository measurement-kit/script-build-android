# Android build scripts

Make sure that you have the NDK installed. Let us know the location
in which it is installed by using

```sh
export ANDROID_NDK_ROOT=/path/to/NDK  # $HOME/Library/Android/sdk/ndk-bundle on macOS
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
./script/build.sh all
```

This will compile in `./build` and install in `./dist`. Instead of `all`
you can also pass the name of a specific library. For example

```sh
./script/build.sh curl
```

In that case, make sure you also recompile all libs that depend on
the library that you are currently recompiling.

### Rebuilding a single lib for a specific arch

You may want to rebuild a single library for a specific arch with

```sh
./toolchain/$arch.sh ./$lib/build.sh
```

For example

```sh
./toolchain/arm64.sh ./measurement-kit/build.sh
```

If this step fail, make sure first that `ANDROID_NDK_ROOT` is exported. While
outer level scripts check that, `./toolchain` scripts do not. Hence
the build _may_ just be failing because the compiler couldn't be found.

### Restarting or tweaking a specific build

Enter into the build directory

```sh
cd ./build/$arch/$lib/$tarball_dir
$do_something_here
../../../../toolchain/$arch.sh $build_command
```

For example

```sh
cd build/arm64-v8a/measurement-kit/measurement-kit-0.9.2/
vi src/measurement_kit/utils.cpp
../../../../toolchain/arm64.sh make
```

Again, this will fail weirdly if `ANDROID_NDK_ROOT` is not set.

## Smoke testing

Start a simulator from Android studio. It must be using an Android
image not containing Google Play services because, apparently, in
such images we cannot become root. Note the architecture used in the
running simulator. Possibly use an old version of Android to have
more confidence that there will be no undefined symbols etc.

Then run

```sh
./script/smoke-test.sh $arch
```

The objective of this step is to make sure that the newly compiled
code is not going to cause issues on old Android and possibly on
a variety of architectures, _before_ publishing the binaries.

Hence we can spot problems or be more confident _earlier_.

## Package for distribution

Make sure you update the `VERSION` file.

Then, run this script

```sh
./script/make-android-dist.sh
```

It will create a tarball in the toplevel directory and update `SHA256SUMS`.

Then, commit, tag, push, make a GitHub release, and upload the tarball.
