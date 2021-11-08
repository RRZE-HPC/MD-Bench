# Compiler tag (GCC/CLANG/ICC/NVCC)
TAG ?= NVCC
# Enable likwid (true or false)
ENABLE_LIKWID ?= false
# SP or DP
DATA_TYPE ?= DP
# AOS or SOA
DATA_LAYOUT ?= AOS
# Assembly syntax to generate (ATT/INTEL)
ASM_SYNTAX ?= ATT

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
# Compute statistics
COMPUTE_STATS ?= true

#Feature options
OPTIONS =  -DALIGNMENT=64
#OPTIONS +=  More options
