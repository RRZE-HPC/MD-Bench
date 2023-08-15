CC  = clang
LINKER = $(CC)

OPENMP   =# -fopenmp
CFLAGS   = -Ofast -std=c11 -march=core-avx2 -mavx -mfma  $(OPENMP)
LFLAGS   = $(OPENMP) -march=core-avx2 -mavx -mfma
DEFINES  = -D_GNU_SOURCE
INCLUDES =
LIBS     =
