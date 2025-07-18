# Compiler tool chain (GCC/CLANG/ICC/ICX/ONEAPI/NVCC/HIPCC)
TOOLCHAIN ?= ICC
# ISA of instruction code (X86/ARM)
ISA ?= X86
# Instruction set for instrinsic kernels (NONE/<X86-SIMD>/<ARM-SIMD>)
# with X86-SIMD options: NONE/SSE/AVX/AVX_FMA/AVX2/AVX512
# with ARM-SIMD options: NONE/NEON/SVE/SVE2 (SVE not width-agnostic yet!)
SIMD ?= AVX512
# Optimization scheme (verletlist/clusterpair)
OPT_SCHEME ?= clusterpair
# Enable likwid (true or false)
ENABLE_LIKWID ?= false
# Enable OpenMP parallelization (true or false)
ENABLE_OPENMP ?= false
# Enable MPI parallelization
ENABLE_MPI ?= true
# SP or DP
DATA_TYPE ?= SP
# AOS or SOA
DATA_LAYOUT ?= AOS
# Debug
DEBUG ?= false

# Sort atoms when reneighboring (true or false)
SORT_ATOMS ?= false
# Simulate only for one atom type, without table lookup for parameters (true or false)
ONE_ATOM_TYPE ?= false
# Trace memory addresses for cache simulator (true or false)
MEM_TRACER ?= false
# Trace indexes and distances for gather-md (true or false)
INDEX_TRACER ?= false
# Compute statistics
COMPUTE_STATS ?= false

# Configurations for verletlist optimization scheme
# Use omp simd pragma when running with half neighbor-lists
ENABLE_OMP_SIMD ?= true

# Configurations for clusterpair optimization scheme
# Cluster pair kernel variant (auto/4xN/2xNN)
CLUSTER_PAIR_KERNEL ?= auto
# Use scalar version (and pray for the compiler to vectorize the code properly)
USE_SCALAR_KERNEL ?= false
# Use reference version (for correction and metrics purposes)
USE_REFERENCE_KERNEL ?= false
# Enable XTC output (a GROMACS file format for trajectories)
XTC_OUTPUT ?= false

# Configurations for CUDA
# Use CUDA pinned memory to optimize transfers
USE_CUDA_HOST_MEMORY ?= true

#Feature options
OPTIONS =  -DALIGNMENT=64
#OPTIONS +=  More options

################################################################
# DO NOT EDIT BELOW !!!
################################################################
DEFINES =

ifeq ($(strip $(TOOLCHAIN)), HIPCC)
	VECTOR_WIDTH=1
	SIMD = NONE
	USE_REFERENCE_KERNEL = true
endif
ifeq ($(strip $(TOOLCHAIN)), NVCC)
	VECTOR_WIDTH=1
	SIMD = NONE
	USE_REFERENCE_KERNEL = true
endif
ifeq ($(strip $(SIMD)), NONE)
	VECTOR_WIDTH=1
	USE_REFERENCE_KERNEL = true
else
ifeq ($(strip $(ISA)),ARM)
    ifeq ($(strip $(SIMD)), NEON)
        __ISA_NEON__=true
        __SIMD_WIDTH_DBL__=2
    else ifeq ($(strip $(SIMD)), SVE)
        __ISA_SVE__=true
		# needs further specification
        __SIMD_WIDTH_DBL__=2
    else ifeq ($(strip $(SIMD)), SVE2)
        __ISA_SVE__=true
        __ISA_SVE2__=true
        # needs further specification
        __SIMD_WIDTH_DBL__=2
    endif
else
# X86
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
endif

# SIMD width is specified in double-precision, hence it may
# need to be adjusted for single-precision
ifeq ($(strip $(DATA_TYPE)), SP)
    VECTOR_WIDTH=$(shell echo $$(( $(__SIMD_WIDTH_DBL__) * 2 )))
else
    VECTOR_WIDTH=$(__SIMD_WIDTH_DBL__)
endif
endif
ifeq ($(strip $(DATA_LAYOUT)),AOS)
    DEFINES +=  -DAOS
endif
ifeq ($(strip $(DATA_TYPE)),SP)
    DEFINES +=  -DPRECISION=1
else
    DEFINES +=  -DPRECISION=2
endif

ifeq ($(strip $(SORT_ATOMS)),true)
    DEFINES += -DSORT_ATOMS
endif

ifeq ($(strip $(ONE_ATOM_TYPE)),true)
    DEFINES += -DONE_ATOM_TYPE
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

ifeq ($(strip $(USE_SCALAR_KERNEL)),true)
    DEFINES += -DUSE_SCALAR_KERNEL
endif

ifeq ($(strip $(USE_REFERENCE_KERNEL)),true)
    DEFINES += -DUSE_REFERENCE_KERNEL
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

ifeq ($(strip $(__ISA_NEON__)),true)
    DEFINES += -D__ISA_NEON__
endif

ifeq ($(strip $(__ISA_SVE__)),true)
    DEFINES += -D__ISA_SVE__
endif

ifeq ($(strip $(__ISA_SVE2__)),true)
    DEFINES += -D__ISA_SVE2__
endif

ifeq ($(strip $(ENABLE_OMP_SIMD)),true)
    DEFINES += -DENABLE_OMP_SIMD
endif

ifeq ($(strip $(OPT_SCHEME)),clusterpair)
    DEFINES += -DCLUSTER_PAIR
endif

ifeq ($(strip $(OPT_SCHEME)),verletlist)
		OPT_TAG = VL
else ifeq ($(strip $(OPT_SCHEME)),clusterpair)
		OPT_TAG = CP
endif

ifeq ($(strip $(SIMD)),NONE)
		TOOL_TAG = $(TOOLCHAIN)-$(ISA)
else
		TOOL_TAG = $(TOOLCHAIN)-$(ISA)-$(SIMD)
endif

ifeq ($(strip $(OPT_SCHEME)),clusterpair)
    ifeq ($(strip $(CLUSTER_PAIR_KERNEL)),auto)
        DEFINES += -DCLUSTER_PAIR_KERNEL_AUTO
    else ifeq ($(strip $(CLUSTER_PAIR_KERNEL)),4xN)
        DEFINES += -DCLUSTERPAIR_KERNEL_4XN
    else ifeq ($(strip $(CLUSTER_PAIR_KERNEL)),2xNN)
        DEFINES += -DCLUSTERPAIR_KERNEL_2XNN
    else
        $(error Invalid CLUSTER_PAIR_KERNEL, must be one of: auto, 4xN, 2xNN)
    endif
endif
