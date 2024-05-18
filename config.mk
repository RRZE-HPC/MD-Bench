# Compiler tool chain (GCC/CLANG/ICC/ICX/ONEAPI/NVCC)
TOOLCHAIN ?= CLANG
# Instruction set for instrinsic kernels (NONE/SSE/AVX/AVX_FMA/AVX2/AVX512)
ISA ?= X86
SIMD ?= AVX
# Optimization scheme (verletlist/clusterpair/clusters_per_bin)
OPT_SCHEME ?= verletlist
# Enable likwid (true or false)
ENABLE_LIKWID ?= false
# SP or DP
DATA_TYPE ?= DP
# AOS or SOA
DATA_LAYOUT ?= AOS
# Assembly syntax to generate (ATT/INTEL)
ASM_SYNTAX ?= INTEL
# Debug
DEBUG ?= false

# Sort atoms when reneighboring (true or false)
SORT_ATOMS ?= true
# Explicitly store and load atom types (true or false)
EXPLICIT_TYPES ?= false
# Trace memory addresses for cache simulator (true or false)
MEM_TRACER ?= false
# Trace indexes and distances for gather-md (true or false)
INDEX_TRACER ?= false
# Compute statistics
COMPUTE_STATS ?= true

# Configurations for lammps optimization scheme
# Use omp simd pragma when running with half neighbor-lists
ENABLE_OMP_SIMD ?= false

# Configurations for gromacs optimization scheme
# Use reference version
USE_REFERENCE_VERSION ?= false
# Enable XTC output
XTC_OUTPUT ?= false
# Check if cj is local when decreasing reaction force
HALF_NEIGHBOR_LISTS_CHECK_CJ ?= true

# Configurations for CUDA
# Use CUDA host memory to optimize transfers
USE_CUDA_HOST_MEMORY ?= false

#Feature options
OPTIONS =  -DALIGNMENT=64
#OPTIONS +=  More options

################################################################
# DO NOT EDIT BELOW !!!
################################################################
ifeq ($(strip $(SIMD)), SSE)
    __ISA_SSE__=true
    __SIMD_WIDTH_DBL__=2
else ifeq ($(strip $(SIMD)), AVX)
    __ISA_AVX__=true
    __SIMD_WIDTH_DBL__=4
else ifeq ($(strip $(SIMD)), AVX_FMA)
    __ISA_AVX__=true
    __ISA_AVX_FMA__=true
    __SIMD_WIDTH_DBL__=4
else ifeq ($(strip $(SIMD)), AVX2)
    #__SIMD_KERNEL__=true
    __ISA_AVX2__=true
    __SIMD_WIDTH_DBL__=4
else ifeq ($(strip $(SIMD)), AVX512)
    __ISA_AVX512__=true
    __SIMD_WIDTH_DBL__=8
    ifeq ($(strip $(DATA_TYPE)), DP)
        __SIMD_KERNEL__=true
    endif
endif

DEFINES =
# SIMD width is specified in double-precision, hence it may
# need to be adjusted for single-precision
ifeq ($(strip $(DATA_TYPE)), SP)
    VECTOR_WIDTH=$(shell echo $$(( $(__SIMD_WIDTH_DBL__) * 2 )))
else
    VECTOR_WIDTH=$(__SIMD_WIDTH_DBL__)
endif
ifeq ($(strip $(DATA_LAYOUT)),AOS)
    DEFINES +=  -DAOS
endif
ifeq ($(strip $(DATA_TYPE)),SP)
    DEFINES +=  -DPRECISION=1
else
    DEFINES +=  -DPRECISION=2
endif

ifneq ($(ASM_SYNTAX), ATT)
    ASFLAGS += -masm=intel
endif

ifeq ($(strip $(SORT_ATOMS)),true)
    DEFINES += -DSORT_ATOMS
endif

ifeq ($(strip $(EXPLICIT_TYPES)),true)
    DEFINES += -DEXPLICIT_TYPES
endif

ifeq ($(strip $(MEM_TRACER)),true)
    DEFINES += -DMEM_TRACER
endif

ifeq ($(strip $(INDEX_TRACER)),true)
    DEFINES += -DINDEX_TRACER
endif

ifeq ($(strip $(COMPUTE_STATS)),true)
    DEFINES += -DCOMPUTE_STATS
endif

ifeq ($(strip $(XTC_OUTPUT)),true)
    DEFINES += -DXTC_OUTPUT
endif

ifeq ($(strip $(USE_REFERENCE_VERSION)),true)
    DEFINES += -DUSE_REFERENCE_VERSION
endif

ifeq ($(strip $(HALF_NEIGHBOR_LISTS_CHECK_CJ)),true)
    DEFINES += -DHALF_NEIGHBOR_LISTS_CHECK_CJ
endif

ifeq ($(strip $(DEBUG)),true)
    DEFINES += -DDEBUG
endif

ifneq ($(VECTOR_WIDTH),)
    DEFINES += -DVECTOR_WIDTH=$(VECTOR_WIDTH)
endif

ifeq ($(strip $(__SIMD_KERNEL__)),true)
    DEFINES += -D__SIMD_KERNEL__
endif

ifeq ($(strip $(__SSE__)),true)
    DEFINES += -D__ISA_SSE__
endif

ifeq ($(strip $(__ISA_AVX__)),true)
    DEFINES += -D__ISA_AVX__
endif

ifeq ($(strip $(__ISA_AVX_FMA__)),true)
    DEFINES += -D__ISA_AVX_FMA__
endif

ifeq ($(strip $(__ISA_AVX2__)),true)
    DEFINES += -D__ISA_AVX2__
endif

ifeq ($(strip $(__ISA_AVX512__)),true)
    DEFINES += -D__ISA_AVX512__
endif

ifeq ($(strip $(ENABLE_OMP_SIMD)),true)
    DEFINES += -DENABLE_OMP_SIMD
endif

ifeq ($(strip $(OPT_SCHEME)),verletlist)
		OPT_TAG = VL
else ifeq ($(strip $(OPT_SCHEME)),clusterpair)
		OPT_TAG = CP
endif

ifneq ($(strip $(SIMD)),NONE)
		TOOL_TAG = $(TOOLCHAIN)-$(ISA)-$(SIMD)
endif
