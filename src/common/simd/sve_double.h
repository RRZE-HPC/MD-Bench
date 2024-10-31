

#warning SVE_DOUBLE
typedef svfloat64x2_t MD_SIMD_FLOAT;
typedef svfloat64x2_t  MD_SIMD_MASK;
typedef svfloat64_t   MD_SIMD_HALF;

// static inline MD_SIMD_FLOAT simd_padd(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) {
//     // Extract vectors from the tuples
//     svfloat64_t a0 = svget2_f64(a, 0);
//     svfloat64_t a1 = svget2_f64(a, 1);
//     svfloat64_t b0 = svget2_f64(b, 0);
//     svfloat64_t b1 = svget2_f64(b, 1);

//     // Perform pairwise addition
//     svfloat64_t result0 = svpadd_f64(a0, a1);
//     svfloat64_t result1 = svpadd_f64(b0, b1);

//     // Construct the result tuple
//     MD_SIMD_FLOAT result = svcreate2_f64(result0, result1);

//     return result;
// }


// Broadcasting a scalar double value to a SIMD vector tuple
static inline MD_SIMD_FLOAT simd_broadcast(double value) {
    MD_SIMD_FLOAT result;
    result = svcreate2_f64(svdup_f64(value), svdup_f64(value));
    return result;
}

static inline MD_SIMD_FLOAT simd_zero() {
    MD_SIMD_FLOAT result;
    result = svcreate2_f64(svdup_f64(0), svdup_f64(0));
    return result;
}

static inline MD_SIMD_FLOAT simd_sub(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b)
{
    MD_SIMD_FLOAT result;
    result = svcreate2_f64(svsub_f64_z(svptrue_b64(), svget2_f64(a, 0), svget2_f64(b, 0)), svsub_f64_z(svptrue_b64(), svget2_f64(a, 1), svget2_f64(b, 1)));
    return result;
}

// Function to load a vector tuple from memory
static inline MD_SIMD_FLOAT simd_load(const double *ptr) {
    svfloat64_t v0 = svld1_f64(svptrue_b64(), ptr);
    svfloat64_t v1 = svld1_f64(svptrue_b64(), ptr + svcntd());
    MD_SIMD_FLOAT result = svcreate2_f64(v0, v1);
    return result;
}

// Function to store a vector tuple to memory
static inline void simd_store(double* ptr, MD_SIMD_FLOAT vec) {
    svst1_f64(svptrue_b64(), ptr, svget2_f64(vec, 0));
    svst1_f64(svptrue_b64(), ptr + svcntd(), svget2_f64(vec, 1));
}

static inline MD_SIMD_FLOAT simd_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b)
{
    MD_SIMD_FLOAT result;
    result = svcreate2_f64(svadd_f64_z(svptrue_b64(), svget2_f64(a, 0), svget2_f64(b, 0)), svadd_f64_z(svptrue_b64(), svget2_f64(a, 1), svget2_f64(b, 1)));
    return result;
}

static inline MD_SIMD_FLOAT simd_mul(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b)
{
    MD_SIMD_FLOAT result;
    result = svcreate2_f64(svmul_f64_z(svptrue_b64(), svget2_f64(a, 0), svget2_f64(b, 0)), svmul_f64_z(svptrue_b64(), svget2_f64(a, 1), svget2_f64(b, 1)));
    return result;
}

static inline MD_SIMD_FLOAT simd_fma(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_FLOAT c)
{
    MD_SIMD_FLOAT result;
    result = svcreate2_f64(svmad_f64_z(svptrue_b64(), svget2_f64(a, 0), svget2_f64(b, 0), svget2_f64(c, 0)), svmad_f64_z(svptrue_b64(), svget2_f64(a, 1), svget2_f64(b, 1), svget2_f64(c, 1)));
    return result;
}

static inline MD_SIMD_FLOAT simd_reciprocal(MD_SIMD_FLOAT a)
{
    // Estimate the reciprocal
    MD_SIMD_FLOAT reciprocal_estimate;
    reciprocal_estimate = svcreate2_f64(svrecpe_f64(svget2_f64(a, 0)), svrecpe_f64(svget2_f64(a, 1)));

    // Compute the reciprocal correction
    MD_SIMD_FLOAT reciprocal_correction;
    reciprocal_correction = svcreate2_f64(svrecps_f64(svget2_f64(reciprocal_estimate, 0), svget2_f64(a, 0)), 
                                          svrecps_f64(svget2_f64(reciprocal_estimate, 1), svget2_f64(a, 1)));

    // Multiply the estimate by the correction to improve accuracy
    MD_SIMD_FLOAT reciprocal_result;
    reciprocal_result = svcreate2_f64(svmul_f64_z(svptrue_b64(), svget2_f64(reciprocal_estimate, 0), svget2_f64(reciprocal_correction, 0)), 
                                      svmul_f64_z(svptrue_b64(), svget2_f64(reciprocal_estimate, 1), svget2_f64(reciprocal_correction, 1)));

    return reciprocal_result;
}

static inline MD_SIMD_MASK simd_mask_from_u32(uint32_t a)
{
    const uint64_t all = 0xFFFFFFFFFFFFFFFF;
    const uint64_t none = 0x0;
    MD_SIMD_HALF zero_mask = svdupq_n_f64(0, 0);
    MD_SIMD_HALF result1,result2;
    result1 = svreinterpret_f64_u64(svdup_u64(0xFFFFFFFFFFFFFFFF));
    result2 = svreinterpret_f64_u64(svdup_u64(0xFFFFFFFFFFFFFFFF));
    svbool_t predicate1 = svdupq_n_b64 (a & 0x1 ? 1 :0, a & 0x2 ? 1 :0);
    svbool_t predicate2 = svdupq_n_b64 (a & 0x4 ? 1 :0,a & 0x8 ? 1 :0);
    
    result1 = svmul_f64_z(predicate1, result1, zero_mask);
    result2 = svmul_f64_z(predicate2, result2, zero_mask);

    return svcreate2_f64(result1, result2);
}


static inline MD_SIMD_MASK simd_mask_and(MD_SIMD_MASK a, MD_SIMD_MASK b)
{
    MD_SIMD_MASK result;
    svuint64_t a1i = svreinterpret_u64_f64(svget2_f64(a, 0));
    svuint64_t b1i = svreinterpret_u64_f64(svget2_f64(b, 0));
    svuint64_t a2i = svreinterpret_u64_f64(svget2_f64(a, 1));
    svuint64_t b2i = svreinterpret_u64_f64(svget2_f64(b, 1));
    

    result = svcreate2_f64(svreinterpret_f64_u64(svand_u64_z(svptrue_b64(), a1i, b1i)), 
                           svreinterpret_f64_u64(svand_u64_z(svptrue_b64(), a2i, b2i)));
    return result;
}

static inline MD_SIMD_MASK simd_mask_cond_lt(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b)
{
    // Use an active predicate for all lanes
    svbool_t pg = svptrue_b32();
    
    // Compare elements of a and b, resulting in a predicate
    svbool_t predicate1 = svcmplt(pg, svget2_f64(a, 0), svget2_f64(b, 0));
    svbool_t predicate2 = svcmplt(pg, svget2_f64(a, 1), svget2_f64(b, 1));

    MD_SIMD_HALF zero_mask = svdupq_n_f64(0, 0);
    MD_SIMD_HALF result1 = svreinterpret_f64_u64(svdup_u64(0xFFFFFFFFFFFFFFFF));
    MD_SIMD_HALF result2 = svreinterpret_f64_u64(svdup_u64(0xFFFFFFFFFFFFFFFF));
    result1 = svmul_f64_z(predicate1, result1, zero_mask);
    result2 = svmul_f64_z(predicate2, result2, zero_mask);
    return svcreate2_f64(result1, result2);

}

// Select elements based on mask
static inline MD_SIMD_FLOAT select_by_mask(MD_SIMD_FLOAT a, MD_SIMD_MASK mask) {
    // Convert the float mask to a boolean mask
    svbool_t pg1 = svcmpne_f64(svptrue_b64(), svget2_f64(mask, 0), svdup_f64(0.0f));
    svbool_t pg2 = svcmpne_f64(svptrue_b64(), svget2_f64(mask, 1), svdup_f64(0.0f));
    
    // Select elements from a where the mask is true, otherwise select 0.0f
    return svcreate2_f64(svsel_f64(pg1, svget2_f64(a, 0), svdup_f64(0.0f)), svsel_f64(pg2, svget2_f64(a, 1), svdup_f64(0.0f)));
    // return svsel_f32(pg, a, svdup_f32(0.0f));

}

// Masked add operation
static inline MD_SIMD_FLOAT simd_masked_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_MASK m) {
    // Convert the float mask to a boolean mask
    svbool_t pg1 = svcmpne_f64(svptrue_b64(), svget2_f64(m, 0), svdup_f64(0.0f));
    svbool_t pg2 = svcmpne_f64(svptrue_b64(), svget2_f64(m, 1), svdup_f64(0.0f));
    
    // Perform the masked add operation
    return svcreate2_f64(svadd_f64_m(pg1, svget2_f64(a, 0), svget2_f64(b, 0)), svadd_f64_m(pg2, svget2_f64(a, 1), svget2_f64(b, 1)));
}

static inline double simd_incr_reduced_sum(double *m, MD_SIMD_FLOAT v0, MD_SIMD_FLOAT v1, MD_SIMD_FLOAT v2, MD_SIMD_FLOAT v3) {
    MD_SIMD_HALF sum00 = svaddp_f64_m(svptrue_b64(), svget2_f64(v0, 1), svget2_f64(v0, 0));
    MD_SIMD_HALF sum01 = svaddp_f64_m(svptrue_b64(), svget2_f64(v1, 1), svget2_f64(v1, 0));
    MD_SIMD_HALF sum10 = svaddp_f64_m(svptrue_b64(), svget2_f64(v2, 1), svget2_f64(v2, 0));
    MD_SIMD_HALF sum11 = svaddp_f64_m(svptrue_b64(), svget2_f64(v3, 1), svget2_f64(v3, 0));
    sum00 = svaddp_f64_m(svptrue_b64(),sum00,sum01);
    sum10 = svaddp_f64_m(svptrue_b64(),sum10,sum11);

    MD_SIMD_FLOAT result_vec = svcreate2_f64(sum00, sum10);
    result_vec= simd_add(result_vec,simd_load(m));
    simd_store(m,result_vec);

    double result1 = svaddv_f64(svptrue_b64(), svget2_f64(result_vec,0));
    double result2 = svaddv_f64(svptrue_b64(), svget2_f64(result_vec,1));
    return result1 + result2;
}

