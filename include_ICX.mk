CC  = icx
LINKER = $(CC)

OPENMP  = #-qopenmp
PROFILE  = #-profile-functions -g  -pg
#OPTS      = -Ofast -xCORE-AVX512 -qopt-zmm-usage=high $(PROFILE)
#OPTS     = -Ofast -xCORE-AVX2  $(PROFILE)
#OPTS     = -Ofast -xAVX  $(PROFILE)
#OPTS     = -Ofast -xAVX2  $(PROFILE)
#OPTS     = -Ofast -xSSE4.2 $(PROFILE)
#OPTS     = -Ofast -no-vec $(PROFILE)
OPTS     = -Ofast -xHost $(PROFILE)
CFLAGS   = $(PROFILE) $(OPENMP) $(OPTS)
ASFLAGS  = #-masm=intel
LFLAGS   = $(PROFILE) $(OPTS) $(OPENMP)
DEFINES  = -std=c11 -pedantic-errors -D_GNU_SOURCE -DNO_ZMM_INTRIN
INCLUDES =
LIBS     = -lm
