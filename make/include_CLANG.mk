CC  = clang
LINKER = $(CC)

ANSI_CFLAGS  = -ansi
ANSI_CFLAGS += -std=c99
ANSI_CFLAGS += -pedantic
# ANSI_CFLAGS += -Wextra

ifeq ($(strip $(ISA)),ARM)
CFLAGS  = -Ofast -mcpu=native $(ANSI_CFLAGS)
endif
ifeq ($(strip $(ISA)),X86)
CFLAGS   = -Ofast -march=native -mavx2 -mfma $(ANSI_CFLAGS) #-fopenmp -Xpreprocessor -fopenmp -g
#CFLAGS   = -Ofast -march=core-avx2 $(ANSI_CFLAGS) #-Xpreprocessor -fopenmp -g
#CFLAGS   = -O3 -march=cascadelake $(ANSI_CFLAGS) #-Xpreprocessor -fopenmp -g
#CFLAGS   = -Ofast $(ANSI_CFLAGS) -g #-Xpreprocessor -fopenmp -g
ASFLAGS  = #-masm=intel
DEFINES  += -DNO_ZMM_INTRIN
endif
# MacOSX with Apple Silicon and homebrew
# INCLUDES = -I/opt/homebrew/Cellar/libomp/18.1.5/include/
# LIBS     = -lm  -L/opt/homebrew/Cellar/libomp/18.1.5/lib/ -lomp
LFLAGS   = -lm
DEFINES  += -D_GNU_SOURCE
