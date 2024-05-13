# Compiler tag (GCC/CLANG/ICC/ICX/ONEAPI/NVCC)
TAG ?= CLANG
# Instruction set (SSE/AVX/AVX_FMA/AVX2/AVX512)
ISA ?= SSE
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
# Use kernel with explicit SIMD intrinsics
USE_SIMD_KERNEL ?= false

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
