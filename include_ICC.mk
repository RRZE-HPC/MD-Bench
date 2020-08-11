CC  = icc
CXX = mpiicpc
FC  = ifort
LINKER = $(CXX)

PROFILE  = #-g  -pg
# OPTS     = -O3 -xCORE-AVX512 -qopt-zmm-usage=high $(PROFILE)
# OPTS     =  -O3 -xCORE-AVX2  $(PROFILE)
# OPTS     =  -O3 -xAVX  $(PROFILE)
# OPTS     =  -O3 -xSSE4.2 $(PROFILE)
OPTS     =  -O3 -no-vec $(PROFILE)
# OPTS     =  -O3 -xHost $(PROFILE)
CFLAGS   = $(PROFILE) -restrict $(OPTS)
CXXFLAGS = $(CFLAGS)
ASFLAGS  = -masm=intel
FCFLAGS  =
LFLAGS   = $(PROFILE) $(OPTS)
DEFINES  = -D_GNU_SOURCE  -DNOCHUNK -DUSE_SIMD# -DLIKWID_PERFMON   -DPRECISION=1
INCLUDES = $(MPIINC) $(LIKWID_INC)
LIBS     = $(LIKWID_LIB) -llikwid
