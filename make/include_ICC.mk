CC  = icc
LINKER = $(CC)

OPENMP  = -qopenmp
PROFILE  = #-profile-functions -g  -pg

ifeq ($(SIMD),AVX512)
OPTS      = -Ofast -xCORE-AVX512 -qopt-zmm-usage=high $(PROFILE)
endif

ifeq ($(SIMD),AVX2)
OPTS     = -Ofast -xCORE-AVX2  $(PROFILE)
#OPTS     = -Ofast -xAVX2  $(PROFILE)
#OPTS     = -Ofast -march=core-avx2 $(PROFILE)
endif

ifeq ($(SIMD),AVX)
OPTS     = -Ofast -xAVX  $(PROFILE)
endif

ifeq ($(SIMD),SSE)
OPTS     = -Ofast -xSSE4.2 $(PROFILE)
endif

#OPTS     = -Ofast -no-vec $(PROFILE)
#OPTS     = -Ofast -xHost $(PROFILE)
CFLAGS   = $(PROFILE) $(OPENMP) $(OPTS) -std=c11 -restrict -diag-disable=10441 #-pedantic-errors 
ASFLAGS  = #-masm=intel
LFLAGS   = $(PROFILE) $(OPTS) $(OPENMP)
DEFINES  += -D_GNU_SOURCE
INCLUDES =
LIBS     = -lm
