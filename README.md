# Zewo APT builder

This repository contains scripts and debian packages for a proper zewo
installation on a debian-enabled system like Ubuntu.

# Building Debian Packages

To build debian packages all you need to do is to call the main target of the enclosed Makefile:

```sh
make
```

Even being unecessary, you can achieve the same result by using the _all_ target:

```sh
make all
```

## Cleaning up

If you want to clean up your build, there are two targets for that:

- _clean_: will clean up the build directory, but will left the generated
  packages
- _purge_: will clean up everything, returning your source tree to the initial
  state.

### Examples:

```sh
make clean
```

```sh
make purge
```

# Upgrading the build system

This build system was thought to be as simple as possible. by using Makefiles,
it is possible to build it in virtually any system that have a GNU-make
compatible version.

The build system contains the following:

- _include_ directory: contains include make files, each one created for a given
dependency of Zewo's run-time.
- _Makefile_: the central makefile, which coordinates everything.

If you need to upgrade any dependency version, you must edit one of the _.mk_
files on _include_ directory. All files looks the same. The only one that is not
of interest is _functions.mk_. This file contains Make functions used by the
central makefile and should not be edited. Edit it if you want to add a new
function to be used no the build system.

If you just need to upgrade versions, all files declares a variable like
_<MODULE>\_VERSION_. All you have to do is to change the version tag in
there. For instance, if you need to update BTLS version:

```makefile
BTLS_VERSION=0.1.0
```

This is the variable you need to update. After updating it, just save the file,
move to upper directory and build it.

# After your upgrade

After your upgrade, you need to build everything. At the end of the build,
commit everything and push to the remote repository. This step is necessary to
upgrade the published debian packages available for download.

# Adding Debian packages to your system

Follow this recipe:

```sh
echo "deb [trusted=yes] http://apt.zewo.io ./" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install zewo
```

This will update your _apt_ package system with Zewo's sources. Also, it will
download and install the binary packages on your system.
