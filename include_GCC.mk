CC  = gcc
CXX = g++
FC  = gfortran
LINKER = $(CXX)

ANSI_CFLAGS  = -ansi
ANSI_CFLAGS += -std=c99
ANSI_CFLAGS += -pedantic
ANSI_CFLAGS += -Wextra

# CFLAGS   = -O0 -g  -std=c99 -fargument-noalias
CFLAGS   = -O3 -march=znver1  -ffast-math -funroll-loops -fopenmp
CXXFLAGS = $(CFLAGS)
ASFLAGS  =  -masm=intel
FCFLAGS  =
LFLAGS   =
DEFINES  = -D_GNU_SOURCE
INCLUDES =
LIBS     =


