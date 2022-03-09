ifeq ($(strip $(ISA)), SSE)
VECTOR_WIDTH=2
else ifeq ($(strip $(ISA)), AVX)
# Vector width is 4 but AVX2 instruction set is not supported
NO_AVX2=true
VECTOR_WIDTH=4
else ifeq ($(strip $(ISA)), AVX2)
VECTOR_WIDTH=4
else ifeq ($(strip $(ISA)), AVX512)
VECTOR_WIDTH=8
endif

ifeq ($(strip $(DATA_TYPE)), SP)
VECTOR_WIDTH=$((VECTOR_WIDTH * 2))
endif
