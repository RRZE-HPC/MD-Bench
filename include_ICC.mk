CC  = icc
LINKER = $(CC)

OPENMP  = #-qopenmp
PROFILE  = #-profile-functions -g  -pg
# OPTS     = -fast -xCORE-AVX512 -qopt-zmm-usage=high $(PROFILE)
#OPTS     = -fast -xCORE-AVX2  $(PROFILE)
#OPTS     = -fast -xAVX  $(PROFILE)
#OPTS     = -fast -xSSE4.2 $(PROFILE)
#OPTS     = -fast -no-vec $(PROFILE)
OPTS     = -fast -xHost $(PROFILE)
CFLAGS   = $(PROFILE) -restrict $(OPENMP) $(OPTS)
ASFLAGS  = -masm=intel
LFLAGS   = $(PROFILE) $(OPTS) $(OPENMP)
DEFINES  = -D_GNU_SOURCE # -DALIGNMENT=64  -DLIKWID_PERFMON   -DPRECISION=1
INCLUDES = #$(LIKWID_INC)
LIBS     = -lm #$(LIKWID_LIB) -llikwid
