/*
 * =======================================================================================
 *
 *   Author:   Jan Eitzinger (je), jan.eitzinger@fau.de
 *   Copyright (c) 2021 RRZE, University Erlangen-Nuremberg
 *
 *   This file is part of MD-Bench.
 *
 *   MD-Bench is free software: you can redistribute it and/or modify it
 *   under the terms of the GNU Lesser General Public License as published
 *   by the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   MD-Bench is distributed in the hope that it will be useful, but WITHOUT ANY
 *   WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 *   PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
 *   details.
 *
 *   You should have received a copy of the GNU Lesser General Public License along
 *   with MD-Bench.  If not, see <https://www.gnu.org/licenses/>.
 * =======================================================================================
 */
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <cuda_profiler_api.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
//---

extern "C" {

#include <atom.h>
#include <cuda_atom.h>
#include <parameter.h>
#include <neighbor.h>
#include <util.h>

}

extern MD_FLOAT xprd, yprd, zprd;
extern MD_FLOAT bininvx, bininvy, bininvz;
extern int mbinxlo, mbinylo, mbinzlo;
extern int nbinx, nbiny, nbinz;
extern int mbinx, mbiny, mbinz; // n bins in x, y, z
extern int mbins; //total number of bins
extern int atoms_per_bin;  // max atoms per bin
extern MD_FLOAT cutneighsq;  // neighbor cutoff squared
extern int nmax;
extern int nstencil;      // # of bins in stencil
extern int* stencil;      // stencil list of bin offsets
static int* c_stencil = NULL;
static int* c_resize_needed = NULL;
static int* c_new_maxneighs = NULL;
static Binning c_binning {
    .bincount = NULL,
    .bins = NULL,
    .mbins = 0,
    .atoms_per_bin = 0
};

__device__ int coord2bin_device(MD_FLOAT xin, MD_FLOAT yin, MD_FLOAT zin, Neighbor_params np) {
    int ix, iy, iz;

    if(xin >= np.xprd) {
        ix = (int)((xin - np.xprd) * np.bininvx) + np.nbinx - np.mbinxlo;
    } else if(xin >= 0.0) {
        ix = (int)(xin * np.bininvx) - np.mbinxlo;
    } else {
        ix = (int)(xin * np.bininvx) - np.mbinxlo - 1;
    }

    if(yin >= np.yprd) {
        iy = (int)((yin - np.yprd) * np.bininvy) + np.nbiny - np.mbinylo;
    } else if(yin >= 0.0) {
        iy = (int)(yin * np.bininvy) - np.mbinylo;
    } else {
        iy = (int)(yin * np.bininvy) - np.mbinylo - 1;
    }

    if(zin >= np.zprd) {
        iz = (int)((zin - np.zprd) * np.bininvz) + np.nbinz - np.mbinzlo;
    } else if(zin >= 0.0) {
        iz = (int)(zin * np.bininvz) - np.mbinzlo;
    } else {
        iz = (int)(zin * np.bininvz) - np.mbinzlo - 1;
    }

    return (iz * np.mbiny * np.mbinx + iy * np.mbinx + ix + 1);
}

/* sorts the contents of a bin to make it comparable to the CPU version */
/* uses bubble sort since atoms per bin should be relatively small and can be done in situ */
__global__ void sort_bin_contents_kernel(int* bincount, int* bins, int mbins, int atoms_per_bin){
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if(i >= mbins) {
        return;
    }

    int atoms_in_bin = bincount[i];
    int *bin_ptr = &bins[i * atoms_per_bin];
    int sorted;
    do {
        sorted = 1;
        int tmp;
        for(int index = 0; index < atoms_in_bin - 1; index++){
            if (bin_ptr[index] > bin_ptr[index + 1]){
                tmp = bin_ptr[index];
                bin_ptr[index] = bin_ptr[index + 1];
                bin_ptr[index + 1] = tmp;
                sorted = 0;
            }
        }
    } while (!sorted);
}

__global__ void binatoms_kernel(Atom a, int* bincount, int* bins, int atoms_per_bin, Neighbor_params np, int *resize_needed) {
    Atom* atom = &a;
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    int nall = atom->Nlocal + atom->Nghost;
    if(i >= nall){
        return;
    }
    
    MD_FLOAT x = atom_x(i);
    MD_FLOAT y = atom_y(i);
    MD_FLOAT z = atom_z(i);
    int ibin = coord2bin_device(x, y, z, np);
    int ac = atomicAdd(&bincount[ibin], 1);
            
    if(ac < atoms_per_bin){
        bins[ibin * atoms_per_bin + ac] = i;
    } else {
        atomicMax(resize_needed, ac);
    }
}

__global__ void compute_neighborhood(Atom a, Neighbor neigh, Neighbor_params np, int nstencil, int* stencil,
                                     int* bins, int atoms_per_bin, int *bincount, int *new_maxneighs, MD_FLOAT cutneighsq) {
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    const int Nlocal = a.Nlocal;
    if( i >= Nlocal ) {
        return;
    }
    
    Atom *atom = &a;
    Neighbor *neighbor = &neigh;
    
    int* neighptr = &(neighbor->neighbors[i]);
    int n = 0;
    MD_FLOAT xtmp = atom_x(i);
    MD_FLOAT ytmp = atom_y(i);
    MD_FLOAT ztmp = atom_z(i);
    int ibin = coord2bin_device(xtmp, ytmp, ztmp, np);
#ifdef EXPLICIT_TYPES
    int type_i = atom->type[i];
#endif
    for(int k = 0; k < nstencil; k++) {
        int jbin = ibin + stencil[k];
        int* loc_bin = &bins[jbin * atoms_per_bin];

        for(int m = 0; m < bincount[jbin]; m++) {
            int j = loc_bin[m];

            if ( j == i ){
                continue;
            }

            MD_FLOAT delx = xtmp - atom_x(j);
            MD_FLOAT dely = ytmp - atom_y(j);
            MD_FLOAT delz = ztmp - atom_z(j);
            MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;

#ifdef EXPLICIT_TYPES
            int type_j = atom->type[j];
            const MD_FLOAT cutoff = atom->cutneighsq[type_i * atom->ntypes + type_j];
#else
            const MD_FLOAT cutoff = cutneighsq;
#endif

            if( rsq <= cutoff ) {
                int idx = atom->Nlocal * n;
                neighptr[idx] = j;
                n += 1;
            }
        }
    }

    neighbor->numneigh[i] = n;
    if(n > neighbor->maxneighs) {
        atomicMax(new_maxneighs, n);
    }
}

void binatoms_cuda(Atom *c_atom, Binning *c_binning, int *c_resize_needed, Neighbor_params *np, const int threads_per_block) {
    int nall = c_atom->Nlocal + c_atom->Nghost;
    int resize = 1;
    const int num_blocks = ceil((float) nall / (float) threads_per_block);

    while(resize > 0) {
        resize = 0;
        memsetGPU(c_binning->bincount, 0, c_binning->mbins * sizeof(int));
        memsetGPU(c_resize_needed, 0, sizeof(int));

        binatoms_kernel<<<num_blocks, threads_per_block>>>(*c_atom, c_binning->bincount, c_binning->bins, c_binning->atoms_per_bin, *np, c_resize_needed);
	    cuda_assert("binatoms", cudaPeekAtLastError());
	    cuda_assert("binatoms", cudaDeviceSynchronize());

        memcpyFromGPU(&resize, c_resize_needed, sizeof(int));
        if(resize) {
            c_binning->atoms_per_bin *= 2;
            c_binning->bins = (int *) reallocateGPU(c_binning->bins, c_binning->mbins * c_binning->atoms_per_bin * sizeof(int));
        }
    }

    atoms_per_bin = c_binning->atoms_per_bin;
    const int sortBlocks = ceil((float) mbins / (float) threads_per_block);
    sort_bin_contents_kernel<<<sortBlocks, threads_per_block>>>(c_binning->bincount, c_binning->bins, c_binning->mbins, c_binning->atoms_per_bin);
	cuda_assert("sort_bin", cudaPeekAtLastError());
	cuda_assert("sort_bin", cudaDeviceSynchronize());
}

void buildNeighbor_cuda(Atom *atom, Neighbor *neighbor, Atom *c_atom, Neighbor *c_neighbor) {
    const int num_threads_per_block = get_num_threads();
    int nall = atom->Nlocal + atom->Nghost;
    c_neighbor->maxneighs = neighbor->maxneighs;

    cudaProfilerStart();

    // TODO move all of this initialization into its own method
    if(c_stencil == NULL) {
        c_stencil = (int *) allocateGPU(nstencil * sizeof(int));
        memcpyToGPU(c_stencil, stencil, nstencil * sizeof(int));
    }

    if(c_binning.mbins == 0) {
        c_binning.mbins = mbins;
        c_binning.atoms_per_bin = atoms_per_bin;
        c_binning.bincount = (int *) allocateGPU(c_binning.mbins * sizeof(int));
        c_binning.bins = (int *) allocateGPU(c_binning.mbins * c_binning.atoms_per_bin * sizeof(int));
    }

    Neighbor_params np {
        .xprd = xprd,
        .yprd = yprd,
        .zprd = zprd,
        .bininvx = bininvx,
        .bininvy = bininvy,
        .bininvz = bininvz,
        .mbinxlo = mbinxlo,
        .mbinylo = mbinylo,
        .mbinzlo = mbinzlo,
        .nbinx = nbinx,
        .nbiny = nbiny,
        .nbinz = nbinz,
        .mbinx = mbinx,
        .mbiny = mbiny,
        .mbinz = mbinz
    };

    if(c_resize_needed == NULL) {
        c_resize_needed = (int *) allocateGPU(sizeof(int));
    }

    /* bin local & ghost atoms */
    binatoms_cuda(c_atom, &c_binning, c_resize_needed, &np, num_threads_per_block);
    if(c_new_maxneighs == NULL) {
        c_new_maxneighs = (int *) allocateGPU(sizeof(int));
    }

    int resize = 1;
    
    /* extend c_neighbor arrays if necessary */
    if(nall > nmax) {
        nmax = nall;
        c_neighbor->neighbors = (int *) reallocateGPU(c_neighbor->neighbors, nmax * c_neighbor->maxneighs * sizeof(int));
        c_neighbor->numneigh  = (int *) reallocateGPU(c_neighbor->numneigh,  nmax * sizeof(int));
    }

    /* loop over each atom, storing neighbors */
    while(resize) {
        resize = 0;
        memsetGPU(c_new_maxneighs, 0, sizeof(int));
        const int num_blocks = ceil((float)atom->Nlocal / (float)num_threads_per_block);
        compute_neighborhood<<<num_blocks, num_threads_per_block>>>(*c_atom, *c_neighbor,
                                                                    np, nstencil, c_stencil,
                                                                    c_binning.bins, c_binning.atoms_per_bin, c_binning.bincount,
                                                                    c_new_maxneighs,
								                                    cutneighsq);

        cuda_assert("compute_neighborhood", cudaPeekAtLastError());
        cuda_assert("compute_neighborhood", cudaDeviceSynchronize());

        int new_maxneighs;
        memcpyFromGPU(&new_maxneighs, c_new_maxneighs, sizeof(int));
        if (new_maxneighs > c_neighbor->maxneighs){
            resize = 1;
        }

        if(resize) {
            printf("RESIZE %d\n", c_neighbor->maxneighs);
            c_neighbor->maxneighs = new_maxneighs * 1.2;
            printf("NEW SIZE %d\n", c_neighbor->maxneighs);
            c_neighbor->neighbors = (int *) reallocateGPU(c_neighbor->neighbors, c_atom->Nmax * c_neighbor->maxneighs * sizeof(int));
        }

    }

    neighbor->maxneighs = c_neighbor->maxneighs;
    cudaProfilerStop();
}
