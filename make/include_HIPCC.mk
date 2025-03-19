CC  = hipcc
LINKER = $(CC)

ifeq ($(strip $(ENABLE_MPI)),true)
DEFINES += -D_MPI
MPI_LIB  = -L/apps/SPACK/0.19.1/opt/linux-almalinux8-zen/nvhpc-23.7/openmpi-4.1.6-ojusv6lrh7e5o7ktibh2qaj2yuzxyzeg/lib \
           -L/apps/SPACK/0.19.1/opt/linux-almalinux8-zen/gcc-8.5.0/hwloc-2.8.0-bneg6wh22jt37qyr2hghz5vmrdk6txyt/lib \
           -L/apps/SPACK/0.19.1/opt/linux-almalinux8-zen/gcc-8.5.0/ucx-1.13.1-woaymodwh7p66njpgt76d7fyqyv7srl3/lib \
           -L/apps/SPACK/0.19.1/opt/linux-almalinux8-zen/gcc-8.5.0/libevent-2.1.12-rzghn5u3lsuysqbbf7xqwq4kg4gkr7mf/lib \
           -L/apps/SPACK/0.19.1/opt/linux-almalinux8-zen/gcc-8.5.0/pmix-4.1.3-lksytzxfs4yylwzgc7dlcihvkqnc7e4d/lib \
           -L/usr/lib64 \
           -Xlinker -rpath -Xlinker /apps/SPACK/0.19.1/opt/linux-almalinux8-zen/gcc-8.5.0/nvhpc-23.7-bzxcokzjvx4stynglo4u2ffpljajzlam/Linux_x86_64/23.7/compilers/lib \
           -Xlinker -rpath -Xlinker /apps/SPACK/0.19.1/opt/linux-almalinux8-zen/nvhpc-23.7/openmpi-4.1.6-ojusv6lrh7e5o7ktibh2qaj2yuzxyzeg/lib \
           -Xlinker -rpath -Xlinker /apps/SPACK/0.19.1/opt/linux-almalinux8-zen/gcc-8.5.0/hwloc-2.8.0-bneg6wh22jt37qyr2hghz5vmrdk6txyt/lib \
           -Xlinker -rpath -Xlinker /apps/SPACK/0.19.1/opt/linux-almalinux8-zen/gcc-8.5.0/ucx-1.13.1-woaymodwh7p66njpgt76d7fyqyv7srl3/lib \
           -Xlinker -rpath -Xlinker /apps/SPACK/0.19.1/opt/linux-almalinux8-zen/gcc-8.5.0/libevent-2.1.12-rzghn5u3lsuysqbbf7xqwq4kg4gkr7mf/lib \
           -Xlinker -rpath -Xlinker /apps/SPACK/0.19.1/opt/linux-almalinux8-zen/gcc-8.5.0/pmix-4.1.3-lksytzxfs4yylwzgc7dlcihvkqnc7e4d/lib \
           -lmpi
MPI_HOME = -I/apps/SPACK/0.19.1/opt/linux-almalinux8-zen/nvhpc-23.7/openmpi-4.1.6-ojusv6lrh7e5o7ktibh2qaj2yuzxyzeg/include
endif

ANSI_CFLAGS  = -ansi
ANSI_CFLAGS += -std=c99
ANSI_CFLAGS += -pedantic
ANSI_CFLAGS += -Wextra

#
# Mi2XXX + Native
#CFLAGS   = -O3 --offload-arch=gfx90a -march=native -ffast-math -funroll-loops # -fopenmp
# Mi300A + Native
CFLAGS   = -O3 -march=native -ffast-math -funroll-loops # -fopenmp
#
ASFLAGS  =  -masm=intel
LFLAGS   =
DEFINES  += -D_GNU_SOURCE -DCUDA_TARGET=1 -DNO_ZMM_INTRIN #-DLIKWID_PERFMON
INCLUDES = $(LIKWID_INC) $(MPI_HOME) -I/opt/rocm/include
LIBS     = -lm $(LIKWID_LIB) $(MPI_LIB) -lamdhip64 #-llikwid
