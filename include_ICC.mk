CC  = icc
LINKER = $(CC)

OPENMP  = #-qopenmp
PROFILE  = #-profile-functions -g  -pg
OPTS      = -Ofast -xCORE-AVX512 -qopt-zmm-usage=high $(PROFILE)
#OPTS     = -Ofast -xCORE-AVX2  $(PROFILE)
#OPTS     = -fast -xAVX  $(PROFILE)
#OPTS     = -fast -xSSE4.2 $(PROFILE)
#OPTS     = -fast -no-vec $(PROFILE)
#OPTS     = -fast -xHost $(PROFILE)
CFLAGS   = $(PROFILE) -restrict $(OPENMP) $(OPTS)
ASFLAGS  = #-masm=intel
LFLAGS   = $(PROFILE) $(OPTS) $(OPENMP)
DEFINES  = -std=c11 -pedantic-errors -D_GNU_SOURCE #-DLIKWID_PERFMON
INCLUDES = #$(LIKWID_INC)
LIBS     = -lm #$(LIKWID_LIB) -llikwid
