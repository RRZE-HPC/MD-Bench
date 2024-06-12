CC  = clang
LINKER = $(CC)

ANSI_CFLAGS  = -ansi
ANSI_CFLAGS += -std=c99
ANSI_CFLAGS += -pedantic
# ANSI_CFLAGS += -Wextra

ifeq ($(strip $(ISA)),ARM)
CFLAGS  = -Ofast $(ANSI_CFLAGS)
ifeq ($(strip $(SIMD)),NONE)
CFLAGS += -mcpu=native+nosimd+nosve
endif
ifeq ($(strip $(SIMD)),NEON)
CFLAGS += -mcpu=native+simd+nosve
endif
ifeq ($(strip $(SIMD)),SVE)
CFLAGS += -mcpu=native+sve2
endif
endif
ifeq ($(strip $(ISA)),X86)
CFLAGS   = -Ofast -march=native -mavx2 -mfma $(ANSI_CFLAGS) #-fopenmp -Xpreprocessor -fopenmp -g
#CFLAGS   = -Ofast -march=core-avx2 $(ANSI_CFLAGS) #-Xpreprocessor -fopenmp -g
#CFLAGS   = -O3 -march=cascadelake $(ANSI_CFLAGS) #-Xpreprocessor -fopenmp -g
#CFLAGS   = -Ofast $(ANSI_CFLAGS) -g #-Xpreprocessor -fopenmp -g
ASFLAGS  = -masm=intel
DEFINES  += -DNO_ZMM_INTRIN
endif
# MacOSX with Apple Silicon and homebrew
# INCLUDES = -I/opt/homebrew/Cellar/libomp/18.1.5/include/
# LIBS     = -lm  -L/opt/homebrew/Cellar/libomp/18.1.5/lib/ -lomp
LFLAGS   = -lm
DEFINES  += -D_GNU_SOURCE
