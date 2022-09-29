# MD-Bench

A generic proxy-app toolbox for state-of-the-art molecular dynamics algorithms

## Build instructions for the lammps variant

Properly configure your building by changing `config.mk` file. The following options are available:

- **TAG:** Compiler tag (available options: GCC, CLANG, ICC, ONEAPI, NVCC).
- **ISA:** Instruction set (available options: SSE, AVX, AVX2, AVX512).
- **MASK\_REGISTERS:** Use AVX512 mask registers (always true when ISA is set to AVX512).
- **OPT\_SCHEME:** Optimization algorithm (available options: lammps, gromacs).
- **ENABLE\_LIKWID:** Enable likwid to make use of HPM counters.
- **DATA\_TYPE:** Floating-point precision (available options: SP, DP).
- **DATA\_LAYOUT:** Data layout for atom vector properties (available options: AOS, SOA).
- **ASM\_SYNTAX:** Assembly syntax to use when generating assembly files (available options: ATT, INTEL).
- **DEBUG:** Toggle debug mode.
- **EXPLICIT\_TYPES:** Explicitly store and load atom types.
- **MEM\_TRACER:** Trace memory addresses for cache simulator.
- **INDEX\_TRACER:** Trace indexes and distances for gather-md.
- **COMPUTE\_STATS:** Compute statistics.

Configurations for LAMMPS Verlet Lists optimization scheme:
- **ENABLE\_OMP\_SIMD:** Use omp simd pragma on half neighbor-lists kernels.
- **USE\_SIMD\_KERNEL:** Compile kernel with explicit SIMD intrinsics.

Configurations for GROMACS MxN optimization scheme:
- **USE\_REFERENCE\_VERSION:** Use reference version (only for correction purposes).
- **XTC\_OUTPUT:** Enable XTC output.
- **HALF\_NEIGHBOR\_LISTS\_CHECK\_CJ:** Check if j-clusters are local when decreasing the reaction force.

Configurations for CUDA:
- **USE\_CUDA\_HOST\_MEMORY:** Use CUDA host memory to optimize host-device transfers.

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
