# MD-Bench

A simple, sequential  C implementation of the [Mantevo miniMD](https://github.com/Mantevo/miniMD) benchmark in less than 1000 LOC.

A $x^2$ test.

## Build

1. Open `config.mk` and edit the `TAG` value according to the tool chain used. Currently supported is GCC, CLANG (LLVM), and ICC (Intel).
2. Change `DATA_LAYOUT` and `DATA_TYPE` if desired in config.mk.
3. Open and adapt the compiler flags in `<include_<TOOLCHAIN>.mk`, e.g. in `include_ICC.mk` for the Intel tool chain.
4. Build the binary calling `make`.

You can clean intermediate build results with `make clean`, and all build results with `make distclean`.
You have to call `make clean` before `make` if you changed the build settings.

## Configuration

Currently all settings apart from the options described below are hard-coded in `main.c`.

## Run the benchmark

Without any options 200 steps with system size 32x32x32 is used.

The default can be changed using the following options:
```
-n / --nsteps <int>:  set number of timesteps for simulation
-nx/-ny/-nz <int>:    set linear dimension of systembox in x/y/z direction
```
