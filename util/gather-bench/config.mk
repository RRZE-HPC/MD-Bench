# Supported: GCC, CLANG, ICC
TAG ?= ICC
# Supported: avx2, avx512
ISA ?= avx512
# Use likwid?
ENABLE_LIKWID ?= false

# SP or DP
DATA_TYPE ?= DP
# AOS or SOA
DATA_LAYOUT ?= AOS
# Padding byte for AoS
PADDING ?= false
# Measure cycles for each gather separately
MEASURE_GATHER_CYCLES ?= false
# Gather data only for first dimension (one gather per iteration)
ONLY_FIRST_DIMENSION ?= false

# Trace memory addresses for cache simulator
MEM_TRACER ?= false
# Test correctness of gather kernels
TEST ?= false
