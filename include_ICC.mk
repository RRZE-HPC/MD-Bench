CC  = icc
LINKER = $(CC)

OPENMP  = #-qopenmp
PROFILE  = #-profile-functions -g  -pg

ifeq ($(ISA),AVX512)
OPTS      = -Ofast -xCORE-AVX512 -qopt-zmm-usage=high $(PROFILE)
endif

ifeq ($(ISA),AVX2)
OPTS     = -Ofast -xCORE-AVX2  $(PROFILE)
#OPTS     = -Ofast -xAVX2  $(PROFILE)
#OPTS     = -Ofast -march=core-avx2 $(PROFILE)
endif

ifeq ($(ISA),AVX)
OPTS     = -Ofast -xAVX  $(PROFILE)
endif

ifeq ($(ISA),SSE)
OPTS     = -Ofast -xSSE4.2 $(PROFILE)
endif

#OPTS     = -Ofast -no-vec $(PROFILE)
#OPTS     = -Ofast -xHost $(PROFILE)
CFLAGS   = $(PROFILE) -restrict $(OPENMP) $(OPTS)
ASFLAGS  = #-masm=intel
LFLAGS   = $(PROFILE) $(OPTS) $(OPENMP)
DEFINES  = -std=c11 -pedantic-errors -D_GNU_SOURCE
INCLUDES =
LIBS     = -lm
