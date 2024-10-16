CC = aocc
LINKER = $(CC)

ifeq ($(strip $(ENABLE_MPI)),true)
    CC = mpicc
    DEFINES += -D_MPI
endif

ifeq ($(strip $(ENABLE_OPENMP)),true)
    OPENMP = -fopenmp
endif

PROFILE = #-fprofile-generate -fauto-profile -g
ANSI_CFLAGS = #-ansi -pedantic -Wextra

# X86 SIMD options
ifeq ($(strip $(ISA)),X86)
    OPTS = -Ofast
ifeq ($(strip $(SIMD)),AVX512)
    OPTS += -march=znver3 -mavx512f -mavx512vl -mavx512dq -mavx512bw
else
    DEFINES += -DNO_ZMM_INTRIN
endif
ifeq ($(strip $(SIMD)),AVX2)
    OPTS += -march=znver2 -mavx2
endif
ifeq ($(strip $(SIMD)),AVX)
    OPTS += -march=znver1 -mno-avx2 -mno-bmi1 -mno-bmi2 -mno-fma4
endif
ifeq ($(strip $(SIMD)),SSE)
    OPTS += -march=znver1
endif
ifeq ($(strip $(SIMD)),NONE)
    OPTS += -fno-vectorize -fno-slp-vectorize -fno-tree-vectorize
endif
ASFLAGS = -masm=intel
endif

CFLAGS = $(PROFILE) $(OPENMP) $(OPTS) -std=c11 $(ANSI_CFLAGS)
LFLAGS = $(PROFILE) $(OPENMP) $(OPTS)
DEFINES += -D_GNU_SOURCE
INCLUDES =
LIBS = -lm
