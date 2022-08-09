#include <cuda_runtime.h>
//---
#include <atom.h>
#include <neighbor.h>

#ifndef __CUDA_ATOM_H_
#define __CUDA_ATOM_H_
extern void initCuda(Atom*, Neighbor*, Atom*, Neighbor*);
extern void checkCUDAError(const char *msg, cudaError_t err);
#endif
