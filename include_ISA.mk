ifeq ($(strip $(ISA)), SSE)
_VECTOR_WIDTH=2
else ifeq ($(strip $(ISA)), AVX)
# Vector width is 4 but AVX2 instruction set is not supported
NO_AVX2=true
_VECTOR_WIDTH=4
else ifeq ($(strip $(ISA)), AVX2)
#SIMD_KERNEL_AVAILABLE=true
_VECTOR_WIDTH=4
else ifeq ($(strip $(ISA)), AVX512)
AVX512=true
SIMD_KERNEL_AVAILABLE=true
_VECTOR_WIDTH=8
endif

ifeq ($(strip $(DATA_TYPE)), SP)
VECTOR_WIDTH=$(shell echo $$(( $(_VECTOR_WIDTH) * 2 )))
else
VECTOR_WIDTH=$(_VECTOR_WIDTH)
endif
