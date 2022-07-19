CC  = gcc
LINKER = $(CC)

ANSI_CFLAGS  = -ansi
ANSI_CFLAGS += -std=c99
ANSI_CFLAGS += -pedantic
ANSI_CFLAGS += -Wextra

# CFLAGS   = -O0 -g  -std=c99 -fargument-noalias
#CFLAGS   = -O3 -march=cascadelake  -ffast-math -funroll-loops # -fopenmp
CFLAGS   = -O3 -march=native  -ffast-math -funroll-loops # -fopenmp
#CFLAGS   = -O3 -march=znver1  -ffast-math -funroll-loops # -fopenmp
ASFLAGS  =  -masm=intel
LFLAGS   =
DEFINES  = -D_GNU_SOURCE -DNO_ZMM_INTRIN
INCLUDES = $(LIKWID_INC)
LIBS     = -lm
