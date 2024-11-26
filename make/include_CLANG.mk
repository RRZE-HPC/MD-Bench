CC = clang
LINKER = $(CC)

OS := $(shell uname -s)

ifeq ($(strip $(ENABLE_OPENMP)),true)
ifeq ($(strip $(OS)),Darwin)
OPENMP = -Xpreprocessor -fopenmp
else
OPENMP = -fopenmp
endif
endif

PROFILE = #-fdiagnostics-show-hotness -fprofile-generate -fdebug-info-for-profiling -funique-internal-linkage-names -g
ANSI_CFLAGS = #-ansi -pedantic -Wextra

# ARM SIMD options
ifeq ($(strip $(ISA)),ARM)
OPTS = -Ofast
ifeq ($(strip $(SIMD)),SVE2)
OPTS += -mcpu=native+sve2
endif
ifeq ($(strip $(SIMD)),SVE)
OPTS += -mcpu=native+sve+nosve2
endif
ifeq ($(strip $(SIMD)),NEON)
OPTS += -mcpu=native+simd+nosve
endif
ifeq ($(strip $(SIMD)),NONE)
OPTS += -mcpu=native+nosimd+nosve
endif
ASFLAGS =
endif

# X86 SIMD options
ifeq ($(strip $(ISA)),X86)
OPTS = -Ofast
ifeq ($(strip $(SIMD)),AVX512)
OPTS += -march=x86-64 -mavx512f -mavx512vl -mavx512dq
else
DEFINES += -DNO_ZMM_INTRIN
endif
ifeq ($(strip $(SIMD)),AVX2)
OPTS += -march=x86-64 -mavx2 -mfma
endif
ifeq ($(strip $(SIMD)),AVX)
OPTS += -march=x86-64 -mavx -mno-avx2 -mno-bmi -mno-bmi2 -mno-fma4
endif
ifeq ($(strip $(SIMD)),AVX_FMA)
OPTS += -march=x86-64 -mavx -mno-avx2 -mno-bmi -mno-bmi2 -mfma
endif
ifeq ($(strip $(SIMD)),SSE)
OPTS += -march=x86-64
endif
ifeq ($(strip $(SIMD)),NONE)
OPTS += -fno-vectorize -fno-slp-vectorize -fno-tree-vectorize
endif
ASFLAGS = -masm=intel
endif

CFLAGS = $(PROFILE) $(OPENMP) $(OPTS) -std=c99 $(ANSI_CFLAGS)
LFLAGS = $(PROFILE) $(OPENMP) $(OPTS)
DEFINES += -D_GNU_SOURCE -DNO_ZMM_INTRIN
INCLUDES =
LIBS = -lm

# MacOSX with Apple Silicon and homebrew
ifeq ($(strip $(OS)),Darwin)
INCLUDES += -I/opt/homebrew/Cellar/libomp/18.1.7/include/
LIBS +=  -L/opt/homebrew/Cellar/libomp/18.1.7/lib/ -lomp
endif
