CC  = nvcc
LINKER = $(CC)

ANSI_CFLAGS  = -ansi
ANSI_CFLAGS += -std=c99
ANSI_CFLAGS += -pedantic
ANSI_CFLAGS += -Wextra

CFLAGS   = -O3 -march=native  -ffast-math -funroll-loops --forward-unknown-to-host-compiler # -fopenmp
#CFLAGS   = -O3 -march=cascadelake  -ffast-math -funroll-loops --forward-unknown-to-host-compiler # -fopenmp
#CFLAGS   = -O3 -g # -fopenmp
#CFLAGS   = -O0 -g  -std=c99 -fargument-noalias
#CFLAGS   = -O3 -g -arch=sm_61 # -fopenmp
ASFLAGS  =  -masm=intel
LFLAGS   =
DEFINES  = -D_GNU_SOURCE -DCUDA_TARGET -DNO_ZMM_INTRIN #-DLIKWID_PERFMON
INCLUDES = $(LIKWID_INC)
LIBS     = -lm $(LIKWID_LIB) -lcuda -lcudart #-llikwid
