ifeq ($(strip $(ISA)), SSE)
    __ISA_SSE__=true
    __SIMD_WIDTH_DBL__=2
else ifeq ($(strip $(ISA)), AVX)
    __ISA_AVX__=true
    __SIMD_WIDTH_DBL__=4
else ifeq ($(strip $(ISA)), AVX_FMA)
    __ISA_AVX__=true
    __ISA_AVX_FMA__=true
    __SIMD_WIDTH_DBL__=4
else ifeq ($(strip $(ISA)), AVX2)
    __ISA_AVX2__=true
    #__SIMD_KERNEL__=true
    __SIMD_WIDTH_DBL__=4
else ifeq ($(strip $(ISA)), AVX512)
    __ISA_AVX512__=true
    __SIMD_KERNEL__=true
    __SIMD_WIDTH_DBL__=8
endif

# SIMD width is specified in double-precision, hence it may
# need to be adjusted for single-precision
ifeq ($(strip $(DATA_TYPE)), SP)
    VECTOR_WIDTH=$(shell echo $$(( $(__SIMD_WIDTH_DBL__) * 2 )))
else
    VECTOR_WIDTH=$(__SIMD_WIDTH_DBL__)
endif
