CC  = gcc
AS  = as
LINKER = $(CC)

OPENMP   = -fopenmp
CFLAGS   = -Ofast -std=c11 -mavx2 -mfma $(OPENMP)
ASFLAGS  =
LFLAGS   = $(OPENMP) -mavx2 -mfma
DEFINES  = -D_GNU_SOURCE
INCLUDES =
LIBS     =
