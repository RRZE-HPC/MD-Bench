CC  = cc
CXX = gcc
LINKER = $(CC)

ANSI_CFLAGS  = -ansi
ANSI_CFLAGS += -std=c99
ANSI_CFLAGS += -pedantic
ANSI_CFLAGS += -Wextra

CFLAGS   = -Ofast $(ANSI_CFLAGS) -g #-Xpreprocessor -fopenmp -g
ASFLAGS  = -masm=intel
CXXFLAGS = $(CFLAGS)
FCFLAGS  =
LFLAGS   =
DEFINES  = -D_GNU_SOURCE -DALIGNMENT=64 -DPRECISION=2
INCLUDES =
LIBS     = #-lomp
