#warning SVE FLOAT
// Typedefs for MD_SIMD_FLOAT and MD_SIMD_MASK
typedef svfloat32_t MD_SIMD_FLOAT;
typedef svfloat32_t MD_SIMD_MASK;  // Corrected type for mask

// Broadcasting a scalar value to a SIMD vector
static inline MD_SIMD_FLOAT simd_broadcast(float value) {
    return svdup_f32(value);
}

// Zeroing a SIMD vector
static inline MD_SIMD_FLOAT simd_zero(void) {
    return svdup_f32(0.0f);
}

// Helper function to subtract two float64x2x2_t vectors
static inline MD_SIMD_FLOAT simd_sub(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) {
    return svsub_f32_z(svptrue_b32(), a, b);
}

// Loading data into a SIMD vector
static inline MD_SIMD_FLOAT simd_load(const float* ptr) {
    return svld1_f32(svptrue_b32(), ptr);
}

// Storing data from a SIMD vector
static inline void simd_store(MD_FLOAT* ptr, MD_SIMD_FLOAT vec) {
    svst1_f32(svptrue_b32(), ptr, vec);
}

// Adding two SIMD vectors
static inline MD_SIMD_FLOAT simd_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) {
    return svadd_f32_z(svptrue_b32(), a, b);
}

// Multiplying two SIMD vectors
static inline MD_SIMD_FLOAT simd_mul(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) {
    return svmul_f32_z(svptrue_b32(), a, b);
}

// Fused multiply-add operation
static inline MD_SIMD_FLOAT simd_fma(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_FLOAT c) {
    return svmad_f32_z(svptrue_b32(), a, b, c);
}

static inline MD_SIMD_FLOAT simd_mask_from_u32(uint32_t a) {

    const uint32_t all = 0xFFFFFFFF;
    const uint32_t none = 0x0;
    MD_SIMD_MASK zero_mask = simd_zero();
    MD_SIMD_MASK result = svreinterpret_f32_u32(svdup_u32(0xFFFFFFFF));
    svbool_t predicate = svdupq_n_b32 (a & 0x1 ? 1 :0, a & 0x2 ? 1 :0,a & 0x4 ? 1 :0,a & 0x8 ? 1 :0);
    return svmul_f32_z(predicate, result, zero_mask);;
}

static inline MD_SIMD_MASK simd_mask_and(svfloat32_t a, svfloat32_t b) {
    // Reinterpret the float vectors as integer vectors
    svuint32_t ai = svreinterpret_u32_f32(a);
    svuint32_t bi = svreinterpret_u32_f32(b);
    
    // Perform bitwise AND operation
    svuint32_t result = svand_u32_z(svptrue_b32(), ai, bi);
    
    // Reinterpret the result back to float
    return svreinterpret_f32_u32(result);
}


// Conditional mask based on less than comparison
static inline MD_SIMD_MASK simd_mask_cond_lt(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) {
    // Use an active predicate for all lanes
    svbool_t pg = svptrue_b32();
    
    // Compare elements of a and b, resulting in a predicate
    svbool_t predicate = svcmplt(pg, a, b);

    MD_SIMD_MASK zero_mask = simd_zero();
    MD_SIMD_MASK result = svreinterpret_f32_u32(svdup_u32(0xFFFFFFFF));
    return svmul_f32_z(predicate, result, zero_mask);;

}

// Reciprocal approximation
static inline MD_SIMD_FLOAT simd_reciprocal(MD_SIMD_FLOAT a) {
    MD_SIMD_FLOAT reciprocal = svrecpe_f32(a);
    reciprocal = svmul_f32_z(svptrue_b32(), reciprocal, svrecps_f32(reciprocal, a));
    return reciprocal;
}

// Increment reduced sum
static inline float simd_incr_reduced_sum(float *m, MD_SIMD_FLOAT v0, MD_SIMD_FLOAT v1, MD_SIMD_FLOAT v2, MD_SIMD_FLOAT v3) {
    MD_SIMD_FLOAT sum0 = svaddp_f32_m(svptrue_b32(), v0, v1);
    MD_SIMD_FLOAT sum1 = svaddp_f32_m(svptrue_b32(), v2, v3);
    MD_SIMD_FLOAT odd  = svuzp2_f32(sum0,sum1);
    MD_SIMD_FLOAT even = svuzp1_f32(sum0,sum1);
    MD_SIMD_FLOAT sum  = svaddp_f32_m(svptrue_b32(),even,odd);

    MD_SIMD_FLOAT mem = svld1_f32(svptrue_b32(), m);
    sum = svadd_f32_m(svptrue_b32(), sum, mem);

    svst1_f32(svptrue_b32(), m, sum);

    float result = svaddv_f32(svptrue_b32(), sum);
    return result;
}

// Masked add operation
static inline MD_SIMD_FLOAT simd_masked_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_MASK m) {
    // Convert the float mask to a boolean mask
    svbool_t pg = svcmpne_f32(svptrue_b32(), m, svdup_f32(0.0f));
    
    // Perform the masked add operation
    return svadd_f32_m(pg, a, b);

}

// Select elements based on mask
static inline MD_SIMD_FLOAT select_by_mask(MD_SIMD_FLOAT a, MD_SIMD_MASK mask) {
    // Convert the float mask to a boolean mask
    svbool_t pg = svcmpne_f32(svptrue_b32(), mask, svdup_f32(0.0f));
    
    // Select elements from a where the mask is true, otherwise select 0.0f
    return svsel_f32(pg, a, svdup_f32(0.0f));

}

// Dummy load functions to match original signatures
static inline MD_SIMD_FLOAT simd_load_h_dual(const MD_FLOAT* m) {
    return svdup_f32(0.0f);
}

static inline MD_SIMD_FLOAT simd_load_h_duplicate(const MD_FLOAT* m) {
    return svdup_f32(0.0f);
}

// Dummy function for simd_h_decr3
static inline void simd_h_decr3(MD_FLOAT* m, MD_SIMD_FLOAT a0, MD_SIMD_FLOAT a1, MD_SIMD_FLOAT a2) {
    return;
}

// Dummy function for simd_h_dual_incr_reduced_sum
static inline MD_FLOAT simd_h_dual_incr_reduced_sum(MD_FLOAT* m, MD_SIMD_FLOAT v0, MD_SIMD_FLOAT v1) {
    return 0.0f;
}

// // Helper function to convert MD_SIMD_MASK to MD_SIMD_FLOAT for printing
// static inline MD_SIMD_FLOAT simd_mask_to_float(MD_SIMD_MASK mask) {
//     // Convert the float mask to a boolean mask
//     svbool_t pg = svcmpne_f32(svptrue_b32(), mask, svdup_f32(0.0f));
    
//     // Create a float vector based on the boolean mask: 1.0f for true, 0.0f for false
//     return svsel_f32(pg, svdup_f32(1.0f), svdup_f32(0.0f));
// }
