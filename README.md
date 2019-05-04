# Android build scripts

This repository contains MK Android build scripts. The rest of this
document describes the vanilla build procedure and other less common
use cases of these scripts, along with details.

## Tell the scripts about the NDK

Make sure that you have the NDK installed. Make sure that you are using
the latest version using the proper channel. Then, let us know the location
in which it is installed by using

```sh
export ANDROID_NDK_ROOT=/path/to/NDK  # $HOME/Library/Android/sdk/ndk-bundle on macOS
```

## Check dependencies versions

In general we would like to build the latest version of a dependency. You can
check that by looking into all the download scripts with:

```sh
vi `find . -type f -name download.sh | grep -v ./script`
```

If any dependency has been updated, fix the URL and the SHA256. Then also
make sure that the corresponding build script is updated.

## Check the output version

The output version is the version of the tarball produced by these
scripts. It's located in the `VERSION` file. Make sure this is
exactly the version that you would like to build.

## Start over

To minimize the impact of human errors, we want all builds to be
fully automated using these scripts. For this reason, you MUST
start over before making a release build. First, make sure that
you do not have any precious uncommitted files, then:

```sh
git clean -dffx
```

## Downloading tarballs

Then download the tarballs with

```sh
./script/download.sh all
```

This will download packages tarballs in `./pkg`.

## Building libs

Then rebuild everything with

```sh
./script/build.sh all 2>&1 | tee BUILD.txt
```

This will compile in `./build` and install in `./dist`.

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

Double check that you updated the `VERSION` file.

Then, run this script

```sh
./script/make-android-dist.sh
```

It will create a tarball in the toplevel directory and update `SHA256SUMS`.

Then:

- [ ] commit
- [ ] tag and sign the tag
- [ ] push
- [ ] make a GitHub release
- [ ] upload the tarball
- [ ] upload the build logs
- [ ] upload the test logs

## Less common usage

### Only rebuild a specific library

Instead of `all` you can also pass the name of a specific library. For example

```sh
./script/build.sh curl
```

In that case, make sure you also recompile all libs that depend on
the library that you are currently recompiling.

This procedure MUST NOT be followed when making a stable release but it's
of course acceptable when smoke testing.

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

This procedure MUST NOT be followed when making a stable release but it's
of course acceptable when smoke testing.

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

This procedure MUST NOT be followed when making a stable release but it's
of course acceptable when smoke testing.
