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
void updatePbc(Atom *atom, Parameter *param) {
    int *border_map = atom->border_map;
    int nlocal = atom->Nclusters_local;
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;

    for(int ci = 0; ci < atom->Nclusters_ghost; ci++) {
        MD_FLOAT *cptr = cluster_ptr(nlocal + ci);
        MD_FLOAT *bmap_cptr = cluster_ptr(border_map[ci]);

        for(int cii = 0; cii < atom->clusters[ci].natoms; cii++) {
            cluster_x(cptr, cii) = cluster_x(bmap_cptr, cii) + atom->PBCx[ci] * xprd;
            cluster_y(cptr, cii) = cluster_y(bmap_cptr, cii) + atom->PBCy[ci] * yprd;
            cluster_z(cptr, cii) = cluster_z(bmap_cptr, cii) + atom->PBCz[ci] * zprd;
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
#define ADDGHOST(dx,dy,dz)                                          \
    Nghost++;                                                       \
    border_map[Nghost] = ci;                                        \
    atom->PBCx[Nghost] = dx;                                        \
    atom->PBCy[Nghost] = dy;                                        \
    atom->PBCz[Nghost] = dz;                                        \
    copy_cluster_types(atom, atom->Nclusters_local + Nghost, ci)

void copy_cluster_types(Atom *atom, int dest, int src) {
    for(int cii = 0; cii < atom->clusters[src].natoms; cii++) {
        atom->clusters[dest].type[cii] = atom->clusters[src].type[cii];
    }
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

    // increase by one to make it the ghost atom count
    atom->Nclusters_ghost = Nghost + 1;
    atom->Nclusters = atom->Nclusters_local + Nghost + 1;

    // Update created ghost clusters positions
    updatePbc(atom, param);
}
