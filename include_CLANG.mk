CC  = cc
LINKER = $(CC)

ANSI_CFLAGS  = -ansi
ANSI_CFLAGS += -std=c99
ANSI_CFLAGS += -pedantic
ANSI_CFLAGS += -Wextra

CFLAGS   = -Ofast $(ANSI_CFLAGS) -g #-Xpreprocessor -fopenmp -g
ASFLAGS  = -masm=intel
LFLAGS   =
DEFINES  = -D_GNU_SOURCE
INCLUDES =
LIBS     = -lm #-lomp
