CC  = nvcc
LINKER = $(CC)

ANSI_CFLAGS  = -ansi
ANSI_CFLAGS += -std=c99
ANSI_CFLAGS += -pedantic
ANSI_CFLAGS += -Wextra

# CFLAGS   = -O0 -g  -std=c99 -fargument-noalias
CFLAGS   = -O3 -arch=sm_61 # -fopenmp
ASFLAGS  =  -masm=intel
LFLAGS   =
DEFINES  = -D_GNU_SOURCE -DLIKWID_PERFMON
INCLUDES = $(LIKWID_INC)
LIBS     = -lm $(LIKWID_LIB) -llikwid
