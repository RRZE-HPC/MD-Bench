#include <cuda_runtime.h>
//---
#include <atom.h>
#include <neighbor.h>

#ifndef __CUDA_ATOM_H_
#define __CUDA_ATOM_H_
extern void initCuda(Atom*, Neighbor*);
extern void cuda_assert(const char *msg, cudaError_t err);
extern void *allocateGPU(size_t bytesize);
extern void *reallocateGPU(void *ptr, size_t new_bytesize);
extern void memcpyToGPU(void *d_ptr, void *h_ptr, size_t bytesize);
extern void memcpyFromGPU(void *h_ptr, void *d_ptr, size_t bytesize);
extern void memsetGPU(void *d_ptr, int value, size_t bytesize);
#endif
