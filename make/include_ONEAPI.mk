CC  = icx
LINKER = $(CC)

OPENMP  = -qopenmp-simd
PROFILE  = #-g  -pg
#OPTS     = -Ofast -no-vec
#OPTS     = -Ofast -xSSE4.2
#OPTS     = -Ofast -xAVX
#OPTS     = -Ofast -xCORE-AVX2
OPTS     = -Ofast -xCORE-AVX512 -qopt-zmm-usage=high
#OPTS     = -Ofast -xHost
CFLAGS   = $(PROFILE) $(OPTS) $(OPENMP)
ASFLAGS  = -masm=intel
LFLAGS   = $(PROFILE) $(OPTS)
DEFINES  += -D_GNU_SOURCE  -DNOCHUNK
INCLUDES = 
LIBS     = -lm 
