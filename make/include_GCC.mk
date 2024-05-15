CC  = gcc
LINKER = $(CC)

ANSI_CFLAGS  = -ansi
ANSI_CFLAGS += -std=c99
ANSI_CFLAGS += -pedantic
ANSI_CFLAGS += -Wextra

ifeq ($(ISA),AVX512)
CFLAGS   = -Ofast -mavx512f -mavx512vl -mavx512bw -mavx512dq -mavx512cd -ffast-math -funroll-loops # -fopenmp
#CFLAGS   = -O3 -march=cascadelake  -ffast-math -funroll-loops # -fopenmp
endif

ifeq ($(ISA),AVX2)
#CFLAGS   = -Ofast -march=native -mavx2  -ffast-math -funroll-loops # -fopenmp
#CFLAGS   = -O3 -march=znver1  -ffast-math -funroll-loops # -fopenmp
#CFLAGS   = -Ofast -mavx2 -ffast-math -funroll-loops # -fopenmp
CFLAGS   = -Ofast -mavx2 -mfma -ffast-math -funroll-loops # -fopenmp
endif

ifeq ($(ISA),AVX)
CFLAGS   = -Ofast -mavx -ffast-math -funroll-loops # -fopenmp
endif

ifeq ($(ISA),SSE)
CFLAGS   = -Ofast -msse4.2 -ffast-math -funroll-loops # -fopenmp
endif

#CFLAGS   = -O0 -g -std=c99 -fargument-noalias
#CFLAGS   = -Ofast -march=native -ffast-math -funroll-loops # -fopenmp
#CFLAGS   = -O3 -march=native  -ffast-math -funroll-loops # -fopenmp
ASFLAGS  =  #-masm=intel
LFLAGS   =
DEFINES  = -D_GNU_SOURCE -DNO_ZMM_INTRIN
INCLUDES = $(LIKWID_INC)
LIBS     = -lm
