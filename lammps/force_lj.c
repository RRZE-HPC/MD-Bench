/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdio.h>
#include <stdlib.h>
//---
#include <atom.h>
#include <likwid-marker.h>
#include <neighbor.h>
#include <parameter.h>
#include <stats.h>
#include <timing.h>
#include <mpi.h>
#include <util.h>
#ifdef __SIMD_KERNEL__
#include <simd.h>
#endif

void computeForceGhostShell(Parameter*, Atom*, Neighbor*);

double computeForceLJFullNeigh_plain_c(Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats) {
    int Nlocal = atom->Nlocal;
    int Nghost = atom->Nghost;
    int* neighs;
    #ifndef EXPLICIT_TYPES
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6 = param->sigma6;
    MD_FLOAT epsilon = param->epsilon;
    #endif
    const MD_FLOAT num1 = 1.0;
    const MD_FLOAT num48 = 48.0;
    const MD_FLOAT num05 = 0.5;

    for(int i = 0; i < Nlocal; i++) {
        atom_fx(i) = 0.0;
        atom_fy(i) = 0.0;
        atom_fz(i) = 0.0;
    }
    double S = getTimeStamp();

    #pragma omp parallel
    {
    LIKWID_MARKER_START("force");

    #pragma omp for
    for(int i = 0; i < Nlocal; i++) {
        neighs = &neighbor->neighbors[i * neighbor->maxneighs];
        int numneighs = neighbor->numneigh[i];
        MD_FLOAT xtmp = atom_x(i);
        MD_FLOAT ytmp = atom_y(i);
        MD_FLOAT ztmp = atom_z(i);
        MD_FLOAT fix = 0.0;
        MD_FLOAT fiy = 0.0;
        MD_FLOAT fiz = 0.0;
        
        #ifdef EXPLICIT_TYPES
        const int type_i = atom->type[i];
        #endif
        
        for(int k = 0; k < numneighs; k++) {
            int j = neighs[k];
            MD_FLOAT delx = xtmp - atom_x(j);
            MD_FLOAT dely = ytmp - atom_y(j);
            MD_FLOAT delz = ztmp - atom_z(j);
            MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;

            #ifdef EXPLICIT_TYPES
            const int type_j = atom->type[j];
            const int type_ij = type_i * atom->ntypes + type_j;
            const MD_FLOAT cutforcesq = atom->cutforcesq[type_ij];
            const MD_FLOAT sigma6 = atom->sigma6[type_ij];
            const MD_FLOAT epsilon = atom->epsilon[type_ij];
            #endif
            if(rsq < cutforcesq) {
                MD_FLOAT sr2 = num1 / rsq;
                MD_FLOAT sr6 = sr2 * sr2 * sr2 * sigma6;
                MD_FLOAT force = num48 * sr6 * (sr6 - num05) * sr2 * epsilon;  
                fix += delx * force;
                fiy += dely * force;
                fiz += delz * force; 
        
            #ifdef USE_REFERENCE_VERSION
                addStat(stats->atoms_within_cutoff, 1);
            } else {
                addStat(stats->atoms_outside_cutoff, 1);
            #endif
            }
        }              
        atom_fx(i) += fix;
        atom_fy(i) += fiy;
        atom_fz(i) += fiz;
        
        #ifdef USE_REFERENCE_VERSION
        if(numneighs % VECTOR_WIDTH > 0) {
            addStat(stats->atoms_outside_cutoff, VECTOR_WIDTH - (numneighs % VECTOR_WIDTH));
        }
        #endif

        addStat(stats->total_force_neighs, numneighs);
        addStat(stats->total_force_iters, (numneighs + VECTOR_WIDTH - 1) / VECTOR_WIDTH);
    }

    LIKWID_MARKER_STOP("force");
    }
    double E = getTimeStamp();
    return E-S;
}

double computeForceLJHalfNeigh(Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats) {
    int Nlocal = atom->Nlocal;
    int Nghost = atom->Nghost;
    int* neighs;
    #ifndef EXPLICIT_TYPES
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6 = param->sigma6;
    MD_FLOAT epsilon = param->epsilon;
    #endif
    const MD_FLOAT num1 = 1.0;
    const MD_FLOAT num48 = 48.0;
    const MD_FLOAT num05 = 0.5;

    for(int i = 0; i < Nlocal+Nghost; i++) {
        atom_fx(i) = 0.0;
        atom_fy(i) = 0.0;
        atom_fz(i) = 0.0;
    }
    double S = getTimeStamp();

    #pragma omp parallel
    {
    LIKWID_MARKER_START("forceLJ-halfneigh");

    #pragma omp for
    for(int i = 0; i < Nlocal; i++) {
        neighs = &neighbor->neighbors[i * neighbor->maxneighs];
        int numneighs = neighbor->numneigh[i];
        MD_FLOAT xtmp = atom_x(i);
        MD_FLOAT ytmp = atom_y(i);
        MD_FLOAT ztmp = atom_z(i);
        MD_FLOAT fix = 0;
        MD_FLOAT fiy = 0;
        MD_FLOAT fiz = 0;

        #ifdef EXPLICIT_TYPES
        const int type_i = atom->type[i];
        #endif

        // Pragma required to vectorize the inner loop
        #ifdef ENABLE_OMP_SIMD
        #pragma omp simd reduction(+: fix,fiy,fiz)
        #endif
        for(int k = 0; k < numneighs; k++) {
            int j = neighs[k];
            MD_FLOAT delx = xtmp - atom_x(j);
            MD_FLOAT dely = ytmp - atom_y(j);
            MD_FLOAT delz = ztmp - atom_z(j);
            MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;

            #ifdef EXPLICIT_TYPES
            const int type_j = atom->type[j];
            const int type_ij = type_i * atom->ntypes + type_j;
            const MD_FLOAT cutforcesq = atom->cutforcesq[type_ij];
            const MD_FLOAT sigma6 = atom->sigma6[type_ij];
            const MD_FLOAT epsilon = atom->epsilon[type_ij];
            #endif

            if(rsq < cutforcesq) {
                MD_FLOAT sr2 = num1 / rsq;
                MD_FLOAT sr6 = sr2 * sr2 * sr2 * sigma6;
                MD_FLOAT force = num48 * sr6 * (sr6 - num05) * sr2 * epsilon;
                fix += delx * force;
                fiy += dely * force;
                fiz += delz * force;
                // We need to update forces for ghost atoms if shell_method  or half stencil is requiered
                if((param->half_neigh && j<Nlocal) || param->method){
                    atom_fx(j) -= delx * force;
                    atom_fy(j) -= dely * force;
                    atom_fz(j) -= delz * force;
                }
            }
        }
        atom_fx(i) += fix;
        atom_fy(i) += fiy;
        atom_fz(i) += fiz;

        addStat(stats->total_force_neighs, numneighs);
        addStat(stats->total_force_iters, (numneighs + VECTOR_WIDTH - 1) / VECTOR_WIDTH);
    }

    if(param->method == eightShell) computeForceGhostShell(param, atom, neighbor); 
    LIKWID_MARKER_STOP("forceLJ-halfneigh");
    }

    double E = getTimeStamp();
    return E-S;
}

double computeForceLJFullNeigh_simd(Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats) {
    int Nlocal = atom->Nlocal;
    int* neighs;
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6 = param->sigma6;
    MD_FLOAT epsilon = param->epsilon;

    for(int i = 0; i < Nlocal; i++) {
        atom_fx(i) = 0.0;
        atom_fy(i) = 0.0;
        atom_fz(i) = 0.0;
    }

    double S = getTimeStamp();

    #ifndef __SIMD_KERNEL__
    fprintf(stderr, "Error: SIMD kernel not implemented for specified instruction set!");
    exit(-1);
    #else
    MD_SIMD_FLOAT cutforcesq_vec = simd_broadcast(cutforcesq);
    MD_SIMD_FLOAT sigma6_vec = simd_broadcast(sigma6);
    MD_SIMD_FLOAT eps_vec = simd_broadcast(epsilon);
    MD_SIMD_FLOAT c48_vec = simd_broadcast(48.0);
    MD_SIMD_FLOAT c05_vec = simd_broadcast(0.5);


    #pragma omp parallel
    {
    LIKWID_MARKER_START("force");

    #pragma omp for
    for(int i = 0; i < Nlocal; i++) {
        neighs = &neighbor->neighbors[i * neighbor->maxneighs];
        int numneighs = neighbor->numneigh[i];
        MD_SIMD_INT numneighs_vec = simd_int_broadcast(numneighs);
        MD_SIMD_FLOAT xtmp = simd_broadcast(atom_x(i));
        MD_SIMD_FLOAT ytmp = simd_broadcast(atom_y(i));
        MD_SIMD_FLOAT ztmp = simd_broadcast(atom_z(i));
        MD_SIMD_FLOAT fix = simd_zero();
        MD_SIMD_FLOAT fiy = simd_zero();
        MD_SIMD_FLOAT fiz = simd_zero();

        for(int k = 0; k < numneighs; k += VECTOR_WIDTH) {
            // If the last iteration of this loop is separated from the rest, this mask can be set only there
            MD_SIMD_MASK mask_numneighs = simd_mask_int_cond_lt(simd_int_add(simd_int_broadcast(k), simd_int_seq()), numneighs_vec);
            MD_SIMD_INT j = simd_int_mask_load(&neighs[k], mask_numneighs);
            #ifdef AOS
            MD_SIMD_INT j3 = simd_int_add(simd_int_add(j, j), j); // j * 3
            MD_SIMD_FLOAT delx = xtmp - simd_gather(j3, &(atom->x[0]), sizeof(MD_FLOAT));
            MD_SIMD_FLOAT dely = ytmp - simd_gather(j3, &(atom->x[1]), sizeof(MD_FLOAT));
            MD_SIMD_FLOAT delz = ztmp - simd_gather(j3, &(atom->x[2]), sizeof(MD_FLOAT));
            #else
            MD_SIMD_FLOAT delx = xtmp - simd_gather(j, atom->x, sizeof(MD_FLOAT));
            MD_SIMD_FLOAT dely = ytmp - simd_gather(j, atom->y, sizeof(MD_FLOAT));
            MD_SIMD_FLOAT delz = ztmp - simd_gather(j, atom->z, sizeof(MD_FLOAT));
            #endif
            MD_SIMD_FLOAT rsq = simd_fma(delx, delx, simd_fma(dely, dely, simd_mul(delz, delz)));
            MD_SIMD_MASK cutoff_mask = simd_mask_and(mask_numneighs, simd_mask_cond_lt(rsq, cutforcesq_vec));
            MD_SIMD_FLOAT sr2 = simd_reciprocal(rsq);
            MD_SIMD_FLOAT sr6 = simd_mul(sr2, simd_mul(sr2, simd_mul(sr2, sigma6_vec)));
            MD_SIMD_FLOAT force = simd_mul(c48_vec, simd_mul(sr6, simd_mul(simd_sub(sr6, c05_vec), simd_mul(sr2, eps_vec))));

            fix = simd_masked_add(fix, simd_mul(delx, force), cutoff_mask);
            fiy = simd_masked_add(fiy, simd_mul(dely, force), cutoff_mask);
            fiz = simd_masked_add(fiz, simd_mul(delz, force), cutoff_mask);
        }

        atom_fx(i) += simd_h_reduce_sum(fix);
        atom_fy(i) += simd_h_reduce_sum(fiy);
        atom_fz(i) += simd_h_reduce_sum(fiz);
    }

    LIKWID_MARKER_STOP("force");
    }
    #endif

    double E = getTimeStamp();
    return E-S;
}

void computeForceGhostShell(Parameter *param, Atom *atom, Neighbor *neighbor) {
    int Nshell = neighbor->Nshell;
    int* neighs;
    #ifndef EXPLICIT_TYPES
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6 = param->sigma6;
    MD_FLOAT epsilon = param->epsilon;
    #endif
    const MD_FLOAT num1 = 1.0;
    const MD_FLOAT num48 = 48.0;
    const MD_FLOAT num05 = 0.5;

    for(int i = 0; i < Nshell; i++) {
        neighs = &(neighbor->neighshell[i * neighbor->maxneighs]);
        int numneigh = neighbor->numNeighShell[i];
        int iatom = neighbor->listshell[i];
        MD_FLOAT xtmp = atom_x(iatom);
        MD_FLOAT ytmp = atom_y(iatom);
        MD_FLOAT ztmp = atom_z(iatom);
        MD_FLOAT fix = 0;
        MD_FLOAT fiy = 0;
        MD_FLOAT fiz = 0;

        #ifdef EXPLICIT_TYPES
        const int type_i = atom->type[i];
        #endif

        for(int k = 0; k < numneigh; k++) {
            int jatom = neighs[k];
            MD_FLOAT delx = xtmp - atom_x(jatom);
            MD_FLOAT dely = ytmp - atom_y(jatom);
            MD_FLOAT delz = ztmp - atom_z(jatom);
            MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;

            if(rsq < cutforcesq) {
                MD_FLOAT sr2 = num1 / rsq;
                MD_FLOAT sr6 = sr2 * sr2 * sr2 * sigma6;
                MD_FLOAT force = num48 * sr6 * (sr6 - num05) * sr2 * epsilon;
                fix += delx * force;
                fiy += dely * force;
                fiz += delz * force;
                
                atom_fx(jatom) -= delx * force;
                atom_fy(jatom) -= dely * force;
                atom_fz(jatom) -= delz * force;
            }
        }
        atom_fx(iatom) += fix;
        atom_fy(iatom) += fiy;
        atom_fz(iatom) += fiz;

    }
}

