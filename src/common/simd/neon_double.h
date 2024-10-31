// #include <arm_acle.h>
// #include <arm_neon.h>
// #include <stdlib.h>
// #include <stdio.h>
#warning neon_double
// Typedefs for MD_SIMD_FLOAT and MD_SIMD_MASK for double precision
typedef float64x2x2_t MD_SIMD_FLOAT;
typedef float64x2x2_t MD_SIMD_MASK;
typedef float64x2_t   MD_SIMD_HALF;

static inline MD_SIMD_FLOAT simd_broadcast(double value)
{
    // Create a vector with the broadcasted value
    MD_SIMD_HALF v = vdupq_n_f64(value);
    MD_SIMD_FLOAT result;
    result.val[0] = v;
    result.val[1] = v;
    // Return the value replicated across both parts of the MD_SIMD_FLOAT structure
    return result;
}

static inline MD_SIMD_FLOAT simd_zero(void)
{
    // Create a vector with the broadcasted value
    MD_SIMD_HALF v = vdupq_n_f64(0.0);
    MD_SIMD_FLOAT result;
    result.val[0] = v;
    result.val[1] = v;
    // Return the value replicated across both parts of the MD_SIMD_FLOAT structure
    return result;
}

// Helper function to subtract two MD_SIMD_FLOAT vectors
static inline MD_SIMD_FLOAT simd_sub(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b)
{
    MD_SIMD_FLOAT result;
    result.val[0] = vsubq_f64(a.val[0], b.val[0]);
    result.val[1] = vsubq_f64(a.val[1], b.val[1]);
    return result;
}

static inline MD_SIMD_FLOAT simd_load(const double* ptr)
{
    // Load two 128-bit vectors in one instruction
    return vld1q_f64_x2(ptr);
}

static inline void simd_store(double* ptr, MD_SIMD_FLOAT vec)
{
    // Store the first 128-bit vector (first two doubles)
    vst1q_f64_x2(ptr, vec);
}

static inline MD_SIMD_FLOAT simd_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b)
{
    MD_SIMD_FLOAT result;
    result.val[0] = vaddq_f64(a.val[0], b.val[0]);
    result.val[1] = vaddq_f64(a.val[1], b.val[1]);
    return result;
}
static inline MD_SIMD_FLOAT simd_padd(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b)
{
    MD_SIMD_FLOAT result;
    result.val[0] = vpaddq_f64(a.val[0], a.val[1]);
    result.val[1] = vpaddq_f64(b.val[0], b.val[1]);
    return result;
}

static inline MD_SIMD_FLOAT simd_mul(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b)
{
    MD_SIMD_FLOAT result;
    result.val[0] = vmulq_f64(a.val[0], b.val[0]);
    result.val[1] = vmulq_f64(a.val[1], b.val[1]);
    return result;
}

static inline MD_SIMD_FLOAT simd_fma(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_FLOAT c)
{
    MD_SIMD_FLOAT result;
    //@todo doublecheck this
    result.val[0] = vfmaq_f64(c.val[0], a.val[0], b.val[0]);
    result.val[1] = vfmaq_f64(c.val[1], a.val[1], b.val[1]);
    return result;
}

static inline MD_SIMD_MASK simd_mask_from_u32(uint32_t a)
{
    const uint64_t all  = 0xFFFFFFFFFFFFFFFF;
    const uint64_t none = 0x0;
    MD_SIMD_MASK result;
    // uint64x2_t mask     = vreinterpretq_u64_u32(vdupq_n_u32((a & 0x8) ? all : none));
    // mask                = vsetq_lane_u64((a & 0x4) ? 0xFFFFFFFFFFFFFFFFULL : 0x0ULL, mask, 1);
    // result = simd_broadcast(1.0);
    result.val[0] = vsetq_lane_f64(vreinterpret_f64_u64(vdup_n_u64((a&0x1) ? all: none)), result.val[0], 0);
    result.val[0] = vsetq_lane_f64(vreinterpret_f64_u64(vdup_n_u64((a&0x2) ? all: none)), result.val[0], 1);
    result.val[1] = vsetq_lane_f64(vreinterpret_f64_u64(vdup_n_u64((a&0x4) ? all: none)), result.val[1], 0);
    result.val[1] = vsetq_lane_f64(vreinterpret_f64_u64(vdup_n_u64((a&0x8) ? all: none)), result.val[1], 1);
    return result;
}


static inline MD_SIMD_MASK simd_mask_and(MD_SIMD_MASK a, MD_SIMD_MASK b)
{
    uint64x2_t result0 = vandq_u64(a.val[0], b.val[0]);
    uint64x2_t result1 = vandq_u64(a.val[1], b.val[1]);
    MD_SIMD_MASK result;
    result.val[0] = result0;
    result.val[1] = result1;
    return result;
}


static inline MD_SIMD_MASK simd_mask_cond_lt(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b)
{
    uint64x2_t mask0 = vcltq_f64(a.val[0], b.val[0]);
    uint64x2_t mask1 = vcltq_f64(a.val[1], b.val[1]);
    MD_SIMD_MASK result;
    result.val[0] = mask0;
    result.val[1] = mask1;
    return result;
}

static inline MD_SIMD_FLOAT simd_reciprocal(MD_SIMD_FLOAT a)
{
    // Estimate the reciprocal
    MD_SIMD_FLOAT reciprocal_estimate;
    reciprocal_estimate.val[0] = vrecpeq_f64(a.val[0]);
    reciprocal_estimate.val[1] = vrecpeq_f64(a.val[1]);

    // Compute the reciprocal correction
    MD_SIMD_FLOAT reciprocal_correction;
    reciprocal_correction.val[0] = vrecpsq_f64(reciprocal_estimate.val[0], a.val[0]);
    reciprocal_correction.val[1] = vrecpsq_f64(reciprocal_estimate.val[1], a.val[1]);

    // Multiply the estimate by the correction to improve accuracy
    MD_SIMD_FLOAT reciprocal_result;
    reciprocal_result.val[0] = vmulq_f64(reciprocal_estimate.val[0],
        reciprocal_correction.val[0]);
    reciprocal_result.val[1] = vmulq_f64(reciprocal_estimate.val[1],
        reciprocal_correction.val[1]);

    return reciprocal_result;
}



static inline double simd_incr_reduced_sum(
    double* m, MD_SIMD_FLOAT v0, MD_SIMD_FLOAT v1, MD_SIMD_FLOAT v2, MD_SIMD_FLOAT v3)
{

    // Load existing values from memory and add to the sum
    MD_SIMD_FLOAT sum0 = simd_padd(v0,v1);
    MD_SIMD_FLOAT sum1 = simd_padd(v2,v3);

    MD_SIMD_FLOAT sum = simd_padd(sum0,sum1);

    MD_SIMD_FLOAT mem  = vld1q_f64_x2(m);
    sum  = simd_add(sum,mem);

    // Store the result back to memory
    vst1q_f64_x2(m,sum);//? Here is a bubu??

    // Reduce the final vector to a single double
    MD_SIMD_HALF sum_parts = vpaddq_f64(sum.val [0], sum.val [1]); // Horizontal add
    double final_sum = vgetq_lane_f64(sum_parts, 0) + vgetq_lane_f64(sum_parts, 1); // Extract and sum lanes
    return final_sum;
}



static inline MD_SIMD_FLOAT select_by_mask(MD_SIMD_FLOAT a, MD_SIMD_MASK mask) {
    // Select elements from 'a' based on the mask, and set other elements to 0.0
    MD_SIMD_FLOAT result;
    result.val[0] = vandq_u64( a.val[0], mask.val[0]);
    result.val[1] = vandq_u64( a.val[1], mask.val[1]);
    return result;
}
static inline MD_SIMD_FLOAT simd_masked_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_MASK m) {
    return simd_add(a,select_by_mask(b,m));
}

static inline MD_SIMD_FLOAT simd_load_h_dual(const double* m) {
    fprintf(stderr,
        "simd_h_dual_incr_reduced_sum(): Not implemented for AVX2 with double "
        "precision!");
    return (MD_SIMD_FLOAT){vdupq_n_f64(0.0), vdupq_n_f64(0.0)};
}

static inline MD_SIMD_FLOAT simd_load_h_duplicate(const double* m) {
    double value = *m;
        fprintf(stderr,
        "simd_load_h_duplicatem(): Not implemented for AVX2 with double "
        "precision!");
    return (MD_SIMD_FLOAT){vdupq_n_f64(value), vdupq_n_f64(value)};
}

static inline void simd_h_decr3(double* m, MD_SIMD_FLOAT a0, MD_SIMD_FLOAT a1, MD_SIMD_FLOAT a2) {
    double value = *m;
    fprintf(stderr,
        "simd_h_decr3(): Not implemented for AVX2 with double "
        "precision!");
    return;
}

static inline double simd_h_dual_incr_reduced_sum(double* m, MD_SIMD_FLOAT v0, MD_SIMD_FLOAT v1) {
    fprintf(stderr,
        "simd_h_dual_incr_reduced_sum(): Not implemented for AVX2 with double "
        "precision!");

    return 0.0;
}
