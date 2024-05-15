CC  = /opt/homebrew/Cellar/llvm/18.1.5/bin/clang
LINKER = $(CC)

ANSI_CFLAGS  = -ansi
ANSI_CFLAGS += -std=c99
ANSI_CFLAGS += -pedantic
# ANSI_CFLAGS += -Wextra

CFLAGS   = -Ofast -march=native $(ANSI_CFLAGS) -Xpreprocessor -fopenmp #-g
#CFLAGS   = -Ofast -march=core-avx2 $(ANSI_CFLAGS) #-Xpreprocessor -fopenmp -g
#CFLAGS   = -O3 -march=cascadelake $(ANSI_CFLAGS) #-Xpreprocessor -fopenmp -g
#CFLAGS   = -Ofast $(ANSI_CFLAGS) -g #-Xpreprocessor -fopenmp -g
ASFLAGS  = #-masm=intel
LFLAGS   =
DEFINES  = -D_GNU_SOURCE
# MacOSX with Apple Silicon and homebrew
INCLUDES = -I/opt/homebrew/Cellar/libomp/18.1.5/include/
LIBS     = -lm  -L/opt/homebrew/Cellar/libomp/18.1.5/lib/ -lomp
