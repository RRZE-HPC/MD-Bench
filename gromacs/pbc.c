/*
 * =======================================================================================
 *
 *   Author:   Jan Eitzinger (je), jan.eitzinger@fau.de
 *   Copyright (c) 2020 RRZE, University Erlangen-Nuremberg
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

#include <pbc.h>
#include <atom.h>
#include <allocate.h>
#include <neighbor.h>

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
    int *border_map = atom->border_map;
    int nlocal = atom->Nclusters_local;
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;

    for(int cg = 0; cg < atom->Nclusters_ghost; cg++) {
        const int ci = nlocal + cg;
        MD_FLOAT *cptr = cluster_pos_ptr(ci);
        MD_FLOAT *bmap_cptr = cluster_pos_ptr(border_map[cg]);
        MD_FLOAT bbminx = INFINITY, bbmaxx = -INFINITY;
        MD_FLOAT bbminy = INFINITY, bbmaxy = -INFINITY;
        MD_FLOAT bbminz = INFINITY, bbmaxz = -INFINITY;

        for(int cii = 0; cii < atom->clusters[ci].natoms; cii++) {
            MD_FLOAT xtmp = cluster_x(bmap_cptr, cii) + atom->PBCx[cg] * xprd;
            MD_FLOAT ytmp = cluster_y(bmap_cptr, cii) + atom->PBCy[cg] * yprd;
            MD_FLOAT ztmp = cluster_z(bmap_cptr, cii) + atom->PBCz[cg] * zprd;

            cluster_x(cptr, cii) = xtmp;
            cluster_y(cptr, cii) = ytmp;
            cluster_z(cptr, cii) = ztmp;

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
            for(int cii = atom->clusters[ci].natoms; cii < CLUSTER_DIM_M; cii++) {
                cluster_x(cptr, cii) = INFINITY;
                cluster_y(cptr, cii) = INFINITY;
                cluster_z(cptr, cii) = INFINITY;
            }

            atom->clusters[ci].bbminx = bbminx;
            atom->clusters[ci].bbmaxx = bbmaxx;
            atom->clusters[ci].bbminy = bbminy;
            atom->clusters[ci].bbmaxy = bbmaxy;
            atom->clusters[ci].bbminz = bbminz;
            atom->clusters[ci].bbmaxz = bbmaxz;
        }
    }
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
    const int g_atom_idx = atom->Nclusters_local + Nghost;                      \
    border_map[Nghost] = ci;                                                    \
    atom->PBCx[Nghost] = dx;                                                    \
    atom->PBCy[Nghost] = dy;                                                    \
    atom->PBCz[Nghost] = dz;                                                    \
    atom->clusters[g_atom_idx].natoms = atom->clusters[ci].natoms;              \
    Nghost_atoms += atom->clusters[g_atom_idx].natoms;                          \
    for(int cii = 0; cii < atom->clusters[ci].natoms; cii++) {                  \
        atom->clusters[g_atom_idx].type[cii] = atom->clusters[ci].type[cii];    \
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
    int *border_map = atom->border_map;
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;
    MD_FLOAT Cutneigh = param->cutneigh;
    int Nghost = -1;
    int Nghost_atoms = 0;

    for(int ci = 0; ci < atom->Nclusters_local; ci++) {
        if (atom->Nclusters_local + Nghost + 7 >= atom->Nclusters_max) {
            growClusters(atom);
        }

        if (Nghost + 7 >= NmaxGhost) {
            growPbc(atom);
            border_map = atom->border_map;
        }

        MD_FLOAT bbminx = atom->clusters[ci].bbminx;
        MD_FLOAT bbmaxx = atom->clusters[ci].bbmaxx;
        MD_FLOAT bbminy = atom->clusters[ci].bbminy;
        MD_FLOAT bbmaxy = atom->clusters[ci].bbmaxy;
        MD_FLOAT bbminz = atom->clusters[ci].bbminz;
        MD_FLOAT bbmaxz = atom->clusters[ci].bbmaxz;

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

    if(atom->Nclusters_local + Nghost + 1 >= atom->Nclusters_max) {
        growClusters(atom);
    }

    // Add dummy cluster at the end
    MD_FLOAT *cptr = cluster_pos_ptr(atom->Nclusters_local + Nghost + 1);
    for(int cii = 0; cii < CLUSTER_DIM_M; cii++) {
        cluster_x(cptr, cii) = INFINITY;
        cluster_y(cptr, cii) = INFINITY;
        cluster_z(cptr, cii) = INFINITY;
    }

    // increase by one to make it the ghost atom count
    atom->Nghost = Nghost_atoms;
    atom->Nclusters_ghost = Nghost + 1;
    atom->Nclusters = atom->Nclusters_local + Nghost + 1;

    // Update created ghost clusters positions
    updatePbc(atom, param, 1);
}
