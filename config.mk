# Compiler tag (GCC/CLANG/ICC/ONEAPI)
TAG ?= ICC
# Instruction set (SSE/AVX/AVX2/AVX512)
ISA ?= AVX512
# Optimization scheme (lammps/gromacs/clusters_per_bin)
OPT_SCHEME ?= lammps
# Enable likwid (true or false)
ENABLE_LIKWID ?= true
# SP or DP
DATA_TYPE ?= DP
# AOS or SOA
DATA_LAYOUT ?= AOS
# Assembly syntax to generate (ATT/INTEL)
ASM_SYNTAX ?= ATT
# Debug
DEBUG ?= false

# Explicitly store and load atom types (true or false)
EXPLICIT_TYPES ?= false
# Trace memory addresses for cache simulator (true or false)
MEM_TRACER ?= false
# Trace indexes and distances for gather-md (true or false)
INDEX_TRACER ?= false
# Compute statistics
COMPUTE_STATS ?= false

# Configurations for lammps optimization scheme
# Use omp simd pragma when running with half neighbor-lists
ENABLE_OMP_SIMD ?= true
# Use kernel with explicit SIMD intrinsics
USE_SIMD_KERNEL ?= false

# Configurations for gromacs optimization scheme
# Use reference version
USE_REFERENCE_VERSION ?= false
# Enable XTC output
XTC_OUTPUT ?= false
# Check if cj is local when decreasing reaction force
HALF_NEIGHBOR_LISTS_CHECK_CJ ?= false

#Feature options
OPTIONS =  -DALIGNMENT=64
#OPTIONS +=  More options
