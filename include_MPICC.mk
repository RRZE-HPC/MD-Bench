CC  = mpicc
LINKER = $(CC)

ANSI_CFLAGS  = -ansi
ANSI_CFLAGS += -std=c99
ANSI_CFLAGS += -pedantic
ANSI_CFLAGS += -Wall -Wextra

#CFLAGS   =   -g -ggdb $(ANSI_CFLAGS) #-Xpreprocessor -fopenmp -g
CFLAGS   = -Ofast -march=native $(ANSI_CFLAGS) #-Xpreprocessor -fopenmp -g
#CFLAGS   = -Ofast -march=core-avx2 $(ANSI_CFLAGS) #-Xpreprocessor -fopenmp -g
#CFLAGS   = -O3 -march=cascadelake $(ANSI_CFLAGS) #-Xpreprocessor -fopenmp -g
#CFLAGS   = -Ofast $(ANSI_CFLAGS) -g #-Xpreprocessor -fopenmp -g
ASFLAGS  = -masm=intel
LFLAGS   =
DEFINES  = -D_GNU_SOURCE
INCLUDES =
LIBS     = -lm #-lomp
