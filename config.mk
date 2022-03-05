# Compiler tag (GCC/CLANG/ICC)
TAG ?= ICC
# Optimization scheme (lammps/gromacs/clusters_per_bin)
OPT_SCHEME ?= gromacs
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

# Number of times to run the atoms loop on stubbed variant
ATOMS_LOOP_RUNS ?= 1
# Number of times to run the neighbors loop on stubbed variant
NEIGHBORS_LOOP_RUNS ?= 1
# Explicitly store and load atom types (true or false)
EXPLICIT_TYPES ?= false
# Trace memory addresses for cache simulator (true or false)
MEM_TRACER ?= false
# Trace indexes and distances for gather-md (true or false)
INDEX_TRACER ?= false
# Vector width (elements) for index and distance tracer
VECTOR_WIDTH ?= 8
# When vector width is 4 but AVX2 is not supported (AVX only), set this to true
NO_AVX2 ?= false
# Compute statistics
COMPUTE_STATS ?= true

# Configurations for gromacs optimization scheme
# AOS or SOA
CLUSTER_LAYOUT ?= SOA
# Use reference version
USE_REFERENCE_VERSION ?= false
# Enable XTC output
XTC_OUTPUT ?= false

#Feature options
OPTIONS =  -DALIGNMENT=64
#OPTIONS +=  More options
