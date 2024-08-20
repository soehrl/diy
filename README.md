# DIY Package Management
Building packages in non-root environments.

## Goals
Installing packages in enviroments where you don't have root access can be very cumbersome as almost any pacakge manager I could find requires elevated permissions ([however you might have some luck using Homebrew](https://github.com/orgs/Homebrew/discussions/3386)).
This requires you to mostly build and install packages yourself which can get quite involved, too.
This repository provides a set of build scripts for commonly used packages.
In contrast to other package managers `diy` only provides a single version for each package which is guaranteed to work with all other packages it provides.
This can be quite limiting but reduces the complexity drastically.
Currently, there is no automatic dependency resolution, i.e., you have to install all dependencies manually, however, the dependencies are guaranteed to be available in the registry and if installed via `diy` the build scripts ensure they are found.
Generally, it is a more *hands-on* appraoch to managing packages.

## Installation
Generally, you can just clone this repository and you are good to go.
However, you might want to create a symlink to `diy.sh` to simply its usage.
In order to access installed binaries and libraries, you should prefix your `$PATH` variable with `$HOME/.local/bin` and your `$LD_LIBRARY_PATH` varaible with `$HOME/.local/lib`.

<!-- You can use the following command to install `diy`: -->
<!-- ``` -->
<!-- ``` -->

## Usage
Building a package: `diy build PACKAGE_NAME`.

Removing a package: `diy remove PACKAGE_NAME`.

## How it works
When building a package, `diy` will create a temporary folder in `$HOME/.diy/workbench/PACKAGE_NAME` where it builds the package.
Afterwards it will install the build package into the shelf at `$HOME/.diy/shelf/PACKAGE_NAME` and link its content to `$HOME/.local`.
Using symbolic links instead of copying the files makes removing the package easier.
Afterwards the build directory is deleted.

When removing a package `diy` will remove all symbolic links from the `$HOME/.local` directory that point into the shelf before removing the shelf directory at `$HOME/.diy/shelf/PACKAGE_NAME`.

The linking and unlinking procedures can be manually triggered using `diy link PACKAGE_NAME` and `diy unlink PACKAGE_NAME`.

## Known Limitations
- `diy` by design only provides one version per package. 
  If you need a specifc version, you need to build and install it yourself.
  In that case you can look at the build script for help.

- Merging installed folders fails: Currently `diy` also symlinks folders within the top-level directories of `$HOME/.local`.
  So, if two packages create the same folder within, e.g., `$HOME/.local/share` they will not get merged during the installation process.
  If this becomes an issue I will solve this in the future.
