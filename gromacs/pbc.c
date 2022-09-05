/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#include <pbc.h>
#include <atom.h>
#include <allocate.h>
#include <neighbor.h>
#include <util.h>

#define DELTA 20000

static int NmaxGhost;

static void growPbc(Atom*);

/* exported subroutines */
void initPbc(Atom* atom) {
    NmaxGhost = 0;
    atom->border_map = NULL;
    atom->PBCx = NULL; atom->PBCy = NULL; atom->PBCz = NULL;
}

/* update coordinates of ghost atoms */
/* uses mapping created in setupPbc */
void updatePbc(Atom *atom, Parameter *param, int firstUpdate) {
    DEBUG_MESSAGE("updatePbc start\n");
    int jfac = MAX(1, CLUSTER_N / CLUSTER_M);
    int ncj = atom->Nclusters_local / jfac;
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;

    for(int cg = 0; cg < atom->Nclusters_ghost; cg++) {
        const int cj = ncj + cg;
        int cj_vec_base = CJ_VECTOR_BASE_INDEX(cj);
        int bmap_vec_base = CJ_VECTOR_BASE_INDEX(atom->border_map[cg]);
        MD_FLOAT *cj_x = &atom->cl_x[cj_vec_base];
        MD_FLOAT *bmap_x = &atom->cl_x[bmap_vec_base];
        MD_FLOAT bbminx = INFINITY, bbmaxx = -INFINITY;
        MD_FLOAT bbminy = INFINITY, bbmaxy = -INFINITY;
        MD_FLOAT bbminz = INFINITY, bbmaxz = -INFINITY;

        for(int cjj = 0; cjj < atom->jclusters[cj].natoms; cjj++) {
            MD_FLOAT xtmp = bmap_x[CL_X_OFFSET + cjj] + atom->PBCx[cg] * xprd;
            MD_FLOAT ytmp = bmap_x[CL_Y_OFFSET + cjj] + atom->PBCy[cg] * yprd;
            MD_FLOAT ztmp = bmap_x[CL_Z_OFFSET + cjj] + atom->PBCz[cg] * zprd;

            cj_x[CL_X_OFFSET + cjj] = xtmp;
            cj_x[CL_Y_OFFSET + cjj] = ytmp;
            cj_x[CL_Z_OFFSET + cjj] = ztmp;

            if(firstUpdate) {
                // TODO: To create the bounding boxes faster, we can use SIMD operations
                if(bbminx > xtmp) { bbminx = xtmp; }
                if(bbmaxx < xtmp) { bbmaxx = xtmp; }
                if(bbminy > ytmp) { bbminy = ytmp; }
                if(bbmaxy < ytmp) { bbmaxy = ytmp; }
                if(bbminz > ztmp) { bbminz = ztmp; }
                if(bbmaxz < ztmp) { bbmaxz = ztmp; }
            }
        }

        if(firstUpdate) {
            for(int cjj = atom->jclusters[cj].natoms; cjj < CLUSTER_N; cjj++) {
                cj_x[CL_X_OFFSET + cjj] = INFINITY;
                cj_x[CL_Y_OFFSET + cjj] = INFINITY;
                cj_x[CL_Z_OFFSET + cjj] = INFINITY;
            }

            atom->jclusters[cj].bbminx = bbminx;
            atom->jclusters[cj].bbmaxx = bbmaxx;
            atom->jclusters[cj].bbminy = bbminy;
            atom->jclusters[cj].bbmaxy = bbmaxy;
            atom->jclusters[cj].bbminz = bbminz;
            atom->jclusters[cj].bbmaxz = bbmaxz;
        }
    }

    DEBUG_MESSAGE("updatePbc end\n");
}

/* relocate atoms that have left domain according
 * to periodic boundary conditions */
void updateAtomsPbc(Atom *atom, Parameter *param) {
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;

    for(int i = 0; i < atom->Nlocal; i++) {
        if(atom_x(i) < 0.0) {
            atom_x(i) += xprd;
        } else if(atom_x(i) >= xprd) {
            atom_x(i) -= xprd;
        }

        if(atom_y(i) < 0.0) {
            atom_y(i) += yprd;
        } else if(atom_y(i) >= yprd) {
            atom_y(i) -= yprd;
        }

        if(atom_z(i) < 0.0) {
            atom_z(i) += zprd;
        } else if(atom_z(i) >= zprd) {
            atom_z(i) -= zprd;
        }
    }
}

/* setup periodic boundary conditions by
 * defining ghost atoms around domain
 * only creates mapping and coordinate corrections
 * that are then enforced in updatePbc */
#define ADDGHOST(dx,dy,dz);                                                     \
    Nghost++;                                                                   \
    const int cg = ncj + Nghost;                                                \
    const int cj_natoms = atom->jclusters[cj].natoms;                           \
    atom->border_map[Nghost] = cj;                                              \
    atom->PBCx[Nghost] = dx;                                                    \
    atom->PBCy[Nghost] = dy;                                                    \
    atom->PBCz[Nghost] = dz;                                                    \
    atom->jclusters[cg].natoms = cj_natoms;                                     \
    Nghost_atoms += cj_natoms;                                                  \
    int cj_sca_base = CJ_SCALAR_BASE_INDEX(cj);                                 \
    int cg_sca_base = CJ_SCALAR_BASE_INDEX(cg);                                 \
    for(int cjj = 0; cjj < cj_natoms; cjj++) {                                  \
        atom->cl_type[cg_sca_base + cjj] = atom->cl_type[cj_sca_base + cjj];    \
    }

/* internal subroutines */
void growPbc(Atom* atom) {
    int nold = NmaxGhost;
    NmaxGhost += DELTA;

    atom->border_map = (int*) reallocate(atom->border_map, ALIGNMENT, NmaxGhost * sizeof(int), nold * sizeof(int));
    atom->PBCx = (int*) reallocate(atom->PBCx, ALIGNMENT, NmaxGhost * sizeof(int), nold * sizeof(int));
    atom->PBCy = (int*) reallocate(atom->PBCy, ALIGNMENT, NmaxGhost * sizeof(int), nold * sizeof(int));
    atom->PBCz = (int*) reallocate(atom->PBCz, ALIGNMENT, NmaxGhost * sizeof(int), nold * sizeof(int));
}

void setupPbc(Atom *atom, Parameter *param) {
    DEBUG_MESSAGE("setupPbc start\n");
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;
    MD_FLOAT Cutneigh = param->cutneigh;
    int jfac = MAX(1, CLUSTER_N / CLUSTER_M);
    int ncj = atom->Nclusters_local / jfac;
    int Nghost = -1;
    int Nghost_atoms = 0;

    for(int cj = 0; cj < ncj; cj++) {
        if(atom->jclusters[cj].natoms > 0) {
            if(atom->Nclusters_local + (Nghost + 7) * jfac >= atom->Nclusters_max) {
                growClusters(atom);
            }

            if((Nghost + 7) * jfac >= NmaxGhost) {
                growPbc(atom);
            }

            MD_FLOAT bbminx = atom->jclusters[cj].bbminx;
            MD_FLOAT bbmaxx = atom->jclusters[cj].bbmaxx;
            MD_FLOAT bbminy = atom->jclusters[cj].bbminy;
            MD_FLOAT bbmaxy = atom->jclusters[cj].bbmaxy;
            MD_FLOAT bbminz = atom->jclusters[cj].bbminz;
            MD_FLOAT bbmaxz = atom->jclusters[cj].bbmaxz;

            /* Setup ghost atoms */
            /* 6 planes */
            if (bbminx < Cutneigh)         { ADDGHOST(+1,0,0); }
            if (bbmaxx >= (xprd-Cutneigh)) { ADDGHOST(-1,0,0); }
            if (bbminy < Cutneigh)         { ADDGHOST(0,+1,0); }
            if (bbmaxy >= (yprd-Cutneigh)) { ADDGHOST(0,-1,0); }
            if (bbminz < Cutneigh)         { ADDGHOST(0,0,+1); }
            if (bbmaxz >= (zprd-Cutneigh)) { ADDGHOST(0,0,-1); }
            /* 8 corners */
            if (bbminx < Cutneigh         && bbminy < Cutneigh         && bbminz < Cutneigh)         { ADDGHOST(+1,+1,+1); }
            if (bbminx < Cutneigh         && bbmaxy >= (yprd-Cutneigh) && bbminz < Cutneigh)         { ADDGHOST(+1,-1,+1); }
            if (bbminx < Cutneigh         && bbminy < Cutneigh         && bbmaxz >= (zprd-Cutneigh)) { ADDGHOST(+1,+1,-1); }
            if (bbminx < Cutneigh         && bbmaxy >= (yprd-Cutneigh) && bbmaxz >= (zprd-Cutneigh)) { ADDGHOST(+1,-1,-1); }
            if (bbmaxx >= (xprd-Cutneigh) && bbminy < Cutneigh         && bbminz < Cutneigh)         { ADDGHOST(-1,+1,+1); }
            if (bbmaxx >= (xprd-Cutneigh) && bbmaxy >= (yprd-Cutneigh) && bbminz < Cutneigh)         { ADDGHOST(-1,-1,+1); }
            if (bbmaxx >= (xprd-Cutneigh) && bbminy < Cutneigh         && bbmaxz >= (zprd-Cutneigh)) { ADDGHOST(-1,+1,-1); }
            if (bbmaxx >= (xprd-Cutneigh) && bbmaxy >= (yprd-Cutneigh) && bbmaxz >= (zprd-Cutneigh)) { ADDGHOST(-1,-1,-1); }
            /* 12 edges */
            if (bbminx < Cutneigh         && bbminz < Cutneigh)         { ADDGHOST(+1,0,+1); }
            if (bbminx < Cutneigh         && bbmaxz >= (zprd-Cutneigh)) { ADDGHOST(+1,0,-1); }
            if (bbmaxx >= (xprd-Cutneigh) && bbminz < Cutneigh)         { ADDGHOST(-1,0,+1); }
            if (bbmaxx >= (xprd-Cutneigh) && bbmaxz >= (zprd-Cutneigh)) { ADDGHOST(-1,0,-1); }
            if (bbminy < Cutneigh         && bbminz < Cutneigh)         { ADDGHOST(0,+1,+1); }
            if (bbminy < Cutneigh         && bbmaxz >= (zprd-Cutneigh)) { ADDGHOST(0,+1,-1); }
            if (bbmaxy >= (yprd-Cutneigh) && bbminz < Cutneigh)         { ADDGHOST(0,-1,+1); }
            if (bbmaxy >= (yprd-Cutneigh) && bbmaxz >= (zprd-Cutneigh)) { ADDGHOST(0,-1,-1); }
            if (bbminy < Cutneigh         && bbminx < Cutneigh)         { ADDGHOST(+1,+1,0); }
            if (bbminy < Cutneigh         && bbmaxx >= (xprd-Cutneigh)) { ADDGHOST(-1,+1,0); }
            if (bbmaxy >= (yprd-Cutneigh) && bbminx < Cutneigh)         { ADDGHOST(+1,-1,0); }
            if (bbmaxy >= (yprd-Cutneigh) && bbmaxx >= (xprd-Cutneigh)) { ADDGHOST(-1,-1,0); }
        }
    }

    if(ncj + (Nghost + 1) * jfac >= atom->Nclusters_max) {
        growClusters(atom);
    }

    // Add dummy cluster at the end
    int cj_vec_base = CJ_VECTOR_BASE_INDEX(ncj + Nghost + 1);
    MD_FLOAT *cj_x = &atom->cl_x[cj_vec_base];
    for(int cjj = 0; cjj < CLUSTER_N; cjj++) {
        cj_x[CL_X_OFFSET + cjj] = INFINITY;
        cj_x[CL_Y_OFFSET + cjj] = INFINITY;
        cj_x[CL_Z_OFFSET + cjj] = INFINITY;
    }

    // increase by one to make it the ghost atom count
    atom->dummy_cj = ncj + Nghost + 1;
    atom->Nghost = Nghost_atoms;
    atom->Nclusters_ghost = Nghost + 1;
    atom->Nclusters = atom->Nclusters_local + Nghost + 1;

    // Update created ghost clusters positions
    updatePbc(atom, param, 1);
    DEBUG_MESSAGE("setupPbc end\n");
}
