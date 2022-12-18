CC  = nvcc
LINKER = $(CC)

ANSI_CFLAGS  = -ansi
ANSI_CFLAGS += -std=c99
ANSI_CFLAGS += -pedantic
ANSI_CFLAGS += -Wextra

#
# A100 + Native
#CFLAGS   = -O3 -arch=sm_80 -march=native -ffast-math -funroll-loops --forward-unknown-to-host-compiler # -fopenmp
CFLAGS   = -O3 -arch=compute_61 -code=sm_61,sm_80,sm_86 -march=native -ffast-math -funroll-loops --forward-unknown-to-host-compiler # -fopenmp
# A40 + Native
#CFLAGS   = -O3 -arch=sm_86 -march=native -ffast-math -funroll-loops --forward-unknown-to-host-compiler # -fopenmp
# Cascade Lake
#CFLAGS   = -O3 -march=cascadelake  -ffast-math -funroll-loops --forward-unknown-to-host-compiler # -fopenmp
# For GROMACS kernels, we need at least sm_61 due to atomicAdd with doubles
# TODO: Check if this is required for full neighbor-lists and just compile kernel for that case if not
#CFLAGS   = -O3 -g -arch=sm_61 # -fopenmp
ASFLAGS  =  -masm=intel
LFLAGS   =
DEFINES  = -D_GNU_SOURCE -DCUDA_TARGET -DNO_ZMM_INTRIN #-DLIKWID_PERFMON
INCLUDES = $(LIKWID_INC)
LIBS     = -lm $(LIKWID_LIB) -lcuda -lcudart #-llikwid
