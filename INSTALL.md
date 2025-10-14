This doc details the steps necessary to build a copy of Sonic Rush Adventure from the sources contained in this repository.

### 0. Clone the repository

Using a terminal or git client, clone this repository to your local device. All the steps that followed should be performed in the directory to which you cloned this repository.

### 1. Install MWCC compiler

The build system requires the use of the Metrowerks C Compiler versions 2.0/sp1p5 to compile matching files. We cannot distribute the correct compiler here so join the PRET discord and download the pinned mwccarm.zip zip in #pokediamond and extract it to tools/. At the end of this operation, you should have i.e. the file `tools/mwccarm/2.0/sp1p5/mwccarm.exe`. Run each of the executables so they ask for a license.dat and provide the one in the rar (it may also ask for it when compiling). This only needs to be done once.

In the future, a GCC option will be available so MWCC is not required to build, however it is required for a matching ROM.

### 2. Install Nitro SDK

As with the compiler, the Nitro SDK is proprietary and cannot be distributed here. Download the "NitroSDK-3_2-060901.7z" file pinned in the PRET discord. Extract and copy the folder `tools/bin` from the Nitro SDK into the folder `tools` in your rush2 clone. At the end of this operation, you should have i.e. the file `tools/bin/makelcf.exe` inside your rush2 clone. Finally, copy `include/nitro/specfiles/ARM7-TS.lcf.template` into the subdirectory `sub`, and `include/nitro/specfiles/ARM9-TS.lcf.template` and `include/nitro/specfiles/mwldarm.response.template` into the project root.

To properly compile the sub binary, the `sub/ARM7-TS.lcf.template` file will have to be slightly modified: add the line `crt0.o (.rodata)` below the line containing `crt0.o (.text)` on line 127

### 3. Dependencies

#### Linux

Building the ROM requires the following packages. If you cannot find one or more of these using your package distribution, it may be under a different name.

* make
* git
* build-essentials (build-essential on Ubuntu)
* binutils-arm-none-eabi
* wine (to run the mwcc executables)
* python3 (for asm preprocessor)
* libpng-devel (libpng-dev on Ubuntu)
* pkg-config
* pugixml (libpugixml-dev on Ubuntu)

NOTE: If you are using Arch/Manjaro or Void you will only need base-devel instead of build-essentials or make or git. You will still need wine.

Currently WSL2 has an issue with mwldarm not being able to locate it's executable. Please use WSL1 or another build environment to mitigate this issue until a solution is found.

#### Windows

##### MSYS2 (MSYS environment)

Install it from here: [MSYS2 home](https://www.msys2.org/), and run msys2.exe.

Make sure the following packages are installed, using ```pacman -S package-name```:
* gcc
* make
* git
* zlib-devel
* cmake

libpng on the other hand must be compiled from source (make sure zlib-devel was installed beforehand). Follow these instructions:
```console
cd ~
wget http://prdownloads.sourceforge.net/libpng/libpng-1.6.50.tar.gz
tar -xvf libpng-1.6.50.tar.gz
cd libpng-1.6.50/
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/usr -DPNG_SHARED=OFF -S .. -B .
cmake --build .
cmake --install .
```

##### Cygwin

**WARNING**: as of the time of writing, Cygwin is not well supported, the archivepackex.exe part of the build will fail.

Install these packages using Cygwin's package manager.

* gcc-core
* gcc-g++
* libgcc1
* libpng-devel
* git
* make

#### macOS

macOS 10.15 Catalina and later is supported on Intel and ARM64 hardware configurations. On ARM64, Rosetta 2 must be installed, as well as the following dependencies:

* GNU coreutils
* GNU make
* GNU sed
* LLVM clang compiler
* arm-gcc-bin
* git
* libpng
* pkg-config
* pugixml
* wine-crossover (includes wine32on64, required on Catalina and later to run 32-bit x86 EXEs)

They can be installed with the following commands:

```console
$ brew tap osx-cross/homebrew-arm
$ brew tap gcenx/wine
$ brew install coreutils make gnu-sed llvm arm-gcc-bin libpng git pkg-config
$ brew install wine-crossover
```

### 4. Build ROM

Run `make` to build the ROM. The ROM will be output as `build/rush2.eu/rush2.eu.nds`

There are targets for building and testing changes to individual components without repackaging the ROM. For the ARM9 modules, run `make arm9`. For the ARM7 module, run `make arm7`. For the filesystem, run `make filesystem`

At the end of building each of these, there is a checksum verification step. This makes sure that the final product is byte-for-byte equivalent to the retail ROM. To disable this, append `COMPARE=0` to your command.

To build the rom in debug mode, append `DEBUG=1` to your command.

#### Windows

If you get an error in saving configuration settings when specifying the license file, you need to add a system environment variable called LM_LICENSE_FILE and point it to the license.dat file. Alternatively, run mwccarm.exe from an Administrator command prompt, PowerShell, or WSL session.

#### Docker

If you find issues building the ROMs with the above methods, you can try the Docker-specific build script. It will build an Alpine-based Docker image with the system requirements above, and run the `make` scripts (any specified parameter will be passed to the `make` command):

```console
$ make clean
$ ./contrib/docker/build_docker.sh # build rush2
```

Note: Docker may not run at a full performance if its underlying Linux kernel is being virtualized (mainly Windows and macOS hosts).

#### After updating from upstream

This repository is still in a volatile state, and several files may be moved around or renamed. If you pull from upstream and experience errors rebuilding, try the following troubleshooting steps, **one line at a time** until you get the message `build/rush2.eu/rush2.eu.nds: OK`:

```shell
make tidy && make compare
make clean && make compare
git clean -fdx && make compare
```
