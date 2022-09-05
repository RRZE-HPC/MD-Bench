/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#include <neighbor.h>
#include <parameter.h>
#include <atom.h>
#include <util.h>

#define SMALL 1.0e-6
#define FACTOR 0.999

static MD_FLOAT xprd, yprd, zprd;
static MD_FLOAT bininvx, bininvy;
static int mbinxlo, mbinylo;
static int nbinx, nbiny;
static int mbinx, mbiny; // n bins in x, y
static int *bincount;
static int *bins;
static int *bin_nclusters;
static int *bin_clusters;
static int mbins; //total number of bins
static int atoms_per_bin;  // max atoms per bin
static int clusters_per_bin;  // max clusters per bin
static MD_FLOAT cutneigh;
static MD_FLOAT cutneighsq;  // neighbor cutoff squared
static int nmax;
static int nstencil;      // # of bins in stencil
static int* stencil;      // stencil list of bin offsets
static MD_FLOAT binsizex, binsizey;

static int coord2bin(MD_FLOAT, MD_FLOAT);
static MD_FLOAT bindist(int, int);

/* exported subroutines */
void initNeighbor(Neighbor *neighbor, Parameter *param) {
    MD_FLOAT neighscale = 5.0 / 6.0;
    xprd = param->nx * param->lattice;
    yprd = param->ny * param->lattice;
    zprd = param->nz * param->lattice;
    cutneigh = param->cutneigh;
    nmax = 0;
    atoms_per_bin = 8;
    clusters_per_bin = (atoms_per_bin / CLUSTER_M) + 10;
    stencil = NULL;
    bins = NULL;
    bincount = NULL;
    bin_clusters = NULL;
    bin_nclusters = NULL;
    neighbor->half_neigh = param->half_neigh;
    neighbor->maxneighs = 100;
    neighbor->numneigh = NULL;
    neighbor->neighbors = NULL;
}

void setupNeighbor(Parameter *param, Atom *atom) {
    MD_FLOAT coord;
    int mbinxhi, mbinyhi;
    int nextx, nexty, nextz;

    if(param->input_file != NULL) {
        xprd = param->xprd;
        yprd = param->yprd;
        zprd = param->zprd;
    }

    // TODO: update lo and hi for standard case and use them here instead
    MD_FLOAT xlo = 0.0; MD_FLOAT xhi = xprd;
    MD_FLOAT ylo = 0.0; MD_FLOAT yhi = yprd;
    MD_FLOAT zlo = 0.0; MD_FLOAT zhi = zprd;

    MD_FLOAT atom_density = ((MD_FLOAT)(atom->Nlocal)) / ((xhi - xlo) * (yhi - ylo) * (zhi - zlo));
    MD_FLOAT atoms_in_cell = MAX(CLUSTER_M, CLUSTER_N);
    MD_FLOAT targetsizex = cbrt(atoms_in_cell / atom_density);
    MD_FLOAT targetsizey = cbrt(atoms_in_cell / atom_density);
    nbinx = MAX(1, (int)ceil((xhi - xlo) / targetsizex));
    nbiny = MAX(1, (int)ceil((yhi - ylo) / targetsizey));
    binsizex = (xhi - xlo) / nbinx;
    binsizey = (yhi - ylo) / nbiny;
    bininvx = 1.0 / binsizex;
    bininvy = 1.0 / binsizey;
    cutneighsq = cutneigh * cutneigh;

    coord = xlo - cutneigh - SMALL * xprd;
    mbinxlo = (int)(coord * bininvx);
    if(coord < 0.0) { mbinxlo = mbinxlo - 1; }
    coord = xhi + cutneigh + SMALL * xprd;
    mbinxhi = (int)(coord * bininvx);

    coord = ylo - cutneigh - SMALL * yprd;
    mbinylo = (int)(coord * bininvy);
    if(coord < 0.0) { mbinylo = mbinylo - 1; }
    coord = yhi + cutneigh + SMALL * yprd;
    mbinyhi = (int)(coord * bininvy);

    mbinxlo = mbinxlo - 1;
    mbinxhi = mbinxhi + 1;
    mbinx = mbinxhi - mbinxlo + 1;

    mbinylo = mbinylo - 1;
    mbinyhi = mbinyhi + 1;
    mbiny = mbinyhi - mbinylo + 1;

    nextx = (int)(cutneigh * bininvx);
    nexty = (int)(cutneigh * bininvy);
    if(nextx * binsizex < FACTOR * cutneigh) nextx++;
    if(nexty * binsizey < FACTOR * cutneigh) nexty++;

    if (stencil) { free(stencil); }
    stencil = (int *) malloc((2 * nexty + 1) * (2 * nextx + 1) * sizeof(int));
    nstencil = 0;

    for(int j = -nexty; j <= nexty; j++) {
        for(int i = -nextx; i <= nextx; i++) {
            if(bindist(i, j) < cutneighsq) {
                stencil[nstencil++] = j * mbinx + i;
            }
        }
    }

    if(bincount) { free(bincount); }
    if(bins) { free(bins); }
    if(bin_nclusters) { free(bin_nclusters); }
    if(bin_clusters) { free(bin_clusters); }
    mbins = mbinx * mbiny;
    bincount = (int*) malloc(mbins * sizeof(int));
    bins = (int*) malloc(mbins * atoms_per_bin * sizeof(int));
    bin_nclusters = (int*) malloc(mbins * sizeof(int));
    bin_clusters = (int*) malloc(mbins * clusters_per_bin * sizeof(int));

    /*
    DEBUG_MESSAGE("lo, hi = (%e, %e, %e), (%e, %e, %e)\n", xlo, ylo, zlo, xhi, yhi, zhi);
    DEBUG_MESSAGE("binsize = %e, %e\n", binsizex, binsizey);
    DEBUG_MESSAGE("mbin lo, hi = (%d, %d), (%d, %d)\n", mbinxlo, mbinylo, mbinxhi, mbinyhi);
    DEBUG_MESSAGE("mbins = %d (%d x %d)\n", mbins, mbinx, mbiny);
    DEBUG_MESSAGE("nextx = %d, nexty = %d\n", nextx, nexty);
    */
}

MD_FLOAT getBoundingBoxDistanceSq(Atom *atom, int ci, int cj) {
    MD_FLOAT dl = atom->iclusters[ci].bbminx - atom->jclusters[cj].bbmaxx;
    MD_FLOAT dh = atom->jclusters[cj].bbminx - atom->iclusters[ci].bbmaxx;
    MD_FLOAT dm = MAX(dl, dh);
    MD_FLOAT dm0 = MAX(dm, 0.0);
    MD_FLOAT d2 = dm0 * dm0;

    dl = atom->iclusters[ci].bbminy - atom->jclusters[cj].bbmaxy;
    dh = atom->jclusters[cj].bbminy - atom->iclusters[ci].bbmaxy;
    dm = MAX(dl, dh);
    dm0 = MAX(dm, 0.0);
    d2 += dm0 * dm0;

    dl = atom->iclusters[ci].bbminz - atom->jclusters[cj].bbmaxz;
    dh = atom->jclusters[cj].bbminz - atom->iclusters[ci].bbmaxz;
    dm = MAX(dl, dh);
    dm0 = MAX(dm, 0.0);
    d2 += dm0 * dm0;
    return d2;
}

int atomDistanceInRange(Atom *atom, int ci, int cj, MD_FLOAT rsq) {
    int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
    int cj_vec_base = CJ_VECTOR_BASE_INDEX(cj);
    MD_FLOAT *ci_x = &atom->cl_x[ci_vec_base];
    MD_FLOAT *cj_x = &atom->cl_x[cj_vec_base];

    for(int cii = 0; cii < atom->iclusters[ci].natoms; cii++) {
        for(int cjj = 0; cjj < atom->jclusters[cj].natoms; cjj++) {
            MD_FLOAT delx = ci_x[CL_X_OFFSET + cii] - cj_x[CL_X_OFFSET + cjj];
            MD_FLOAT dely = ci_x[CL_Y_OFFSET + cii] - cj_x[CL_Y_OFFSET + cjj];
            MD_FLOAT delz = ci_x[CL_Z_OFFSET + cii] - cj_x[CL_Z_OFFSET + cjj];
            if(delx * delx + dely * dely + delz * delz < rsq) {
                return 1;
            }
        }
    }

    return 0;
}

void buildNeighbor(Atom *atom, Neighbor *neighbor) {
    DEBUG_MESSAGE("buildNeighbor start\n");

    /* extend atom arrays if necessary */
    if(atom->Nclusters_local > nmax) {
        nmax = atom->Nclusters_local;
        if(neighbor->numneigh) free(neighbor->numneigh);
        if(neighbor->neighbors) free(neighbor->neighbors);
        neighbor->numneigh = (int*) malloc(nmax * sizeof(int));
        neighbor->neighbors = (int*) malloc(nmax * neighbor->maxneighs * sizeof(int*));
    }

    MD_FLOAT bbx = 0.5 * (binsizex + binsizex);
    MD_FLOAT bby = 0.5 * (binsizey + binsizey);
    MD_FLOAT rbb_sq = MAX(0.0, cutneigh - 0.5 * sqrt(bbx * bbx + bby * bby));
    rbb_sq = rbb_sq * rbb_sq;
    int resize = 1;

    /* loop over each atom, storing neighbors */
    while(resize) {
        int new_maxneighs = neighbor->maxneighs;
        resize = 0;

        for(int ci = 0; ci < atom->Nclusters_local; ci++) {
            int ci_cj1 = CJ1_FROM_CI(ci);
            int *neighptr = &(neighbor->neighbors[ci * neighbor->maxneighs]);
            int n = 0;
            int ibin = atom->icluster_bin[ci];
            MD_FLOAT ibb_xmin = atom->iclusters[ci].bbminx;
            MD_FLOAT ibb_xmax = atom->iclusters[ci].bbmaxx;
            MD_FLOAT ibb_ymin = atom->iclusters[ci].bbminy;
            MD_FLOAT ibb_ymax = atom->iclusters[ci].bbmaxy;
            MD_FLOAT ibb_zmin = atom->iclusters[ci].bbminz;
            MD_FLOAT ibb_zmax = atom->iclusters[ci].bbmaxz;

            for(int k = 0; k < nstencil; k++) {
                int jbin = ibin + stencil[k];
                int *loc_bin = &bin_clusters[jbin * clusters_per_bin];
                int cj, m = -1;
                MD_FLOAT jbb_xmin, jbb_xmax, jbb_ymin, jbb_ymax, jbb_zmin, jbb_zmax;
                const int c = bin_nclusters[jbin];

                if(c > 0) {
                    MD_FLOAT dl, dh, dm, dm0, d_bb_sq;

                    do {
                        m++;
                        cj = loc_bin[m];
                        if(neighbor->half_neigh && ci_cj1 > cj) {
                            continue;
                        }
                        jbb_zmin = atom->jclusters[cj].bbminz;
                        jbb_zmax = atom->jclusters[cj].bbmaxz;
                        dl = ibb_zmin - jbb_zmax;
                        dh = jbb_zmin - ibb_zmax;
                        dm = MAX(dl, dh);
                        dm0 = MAX(dm, 0.0);
                        d_bb_sq = dm0 * dm0;
                    } while(m + 1 < c && d_bb_sq > cutneighsq);

                    jbb_xmin = atom->jclusters[cj].bbminx;
                    jbb_xmax = atom->jclusters[cj].bbmaxx;
                    jbb_ymin = atom->jclusters[cj].bbminy;
                    jbb_ymax = atom->jclusters[cj].bbmaxy;

                    while(m < c) {
                        if(!neighbor->half_neigh || ci_cj1 <= cj) {
                            dl = ibb_zmin - jbb_zmax;
                            dh = jbb_zmin - ibb_zmax;
                            dm = MAX(dl, dh);
                            dm0 = MAX(dm, 0.0);
                            d_bb_sq = dm0 * dm0;

                            /*if(d_bb_sq > cutneighsq) {
                                break;
                            }*/

                            dl = ibb_ymin - jbb_ymax;
                            dh = jbb_ymin - ibb_ymax;
                            dm = MAX(dl, dh);
                            dm0 = MAX(dm, 0.0);
                            d_bb_sq += dm0 * dm0;

                            dl = ibb_xmin - jbb_xmax;
                            dh = jbb_xmin - ibb_xmax;
                            dm = MAX(dl, dh);
                            dm0 = MAX(dm, 0.0);
                            d_bb_sq += dm0 * dm0;

                            if(d_bb_sq < cutneighsq) {
                                if(d_bb_sq < rbb_sq || atomDistanceInRange(atom, ci, cj, cutneighsq)) {
                                    neighptr[n++] = cj;
                                }
                            }
                        }

                        m++;
                        if(m < c) {
                            cj = loc_bin[m];
                            jbb_xmin = atom->jclusters[cj].bbminx;
                            jbb_xmax = atom->jclusters[cj].bbmaxx;
                            jbb_ymin = atom->jclusters[cj].bbminy;
                            jbb_ymax = atom->jclusters[cj].bbmaxy;
                            jbb_zmin = atom->jclusters[cj].bbminz;
                            jbb_zmax = atom->jclusters[cj].bbmaxz;
                        }
                    }
                }
            }

            // Fill neighbor list with dummy values to fit vector width
            if(CLUSTER_N < VECTOR_WIDTH) {
                while(n % (VECTOR_WIDTH / CLUSTER_N)) {
                    neighptr[n++] = atom->dummy_cj; // Last cluster is always a dummy cluster
                }
            }

            neighbor->numneigh[ci] = n;
            if(n >= neighbor->maxneighs) {
                resize = 1;

                if(n >= new_maxneighs) {
                    new_maxneighs = n;
                }
            }
        }

        if(resize) {
            fprintf(stdout, "RESIZE %d\n", neighbor->maxneighs);
            neighbor->maxneighs = new_maxneighs * 1.2;
            free(neighbor->neighbors);
            neighbor->neighbors = (int*) malloc(atom->Nmax * neighbor->maxneighs * sizeof(int));
        }
    }

    /*
    DEBUG_MESSAGE("\ncutneighsq = %f, rbb_sq = %f\n", cutneighsq, rbb_sq);
    for(int ci = 0; ci < 6; ci++) {
        int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT *ci_x = &atom->cl_x[ci_vec_base];
        int* neighptr = &(neighbor->neighbors[ci * neighbor->maxneighs]);

        DEBUG_MESSAGE("Cluster %d, bbx = {%f, %f}, bby = {%f, %f}, bbz = {%f, %f}\n",
            ci,
            atom->iclusters[ci].bbminx,
            atom->iclusters[ci].bbmaxx,
            atom->iclusters[ci].bbminy,
            atom->iclusters[ci].bbmaxy,
            atom->iclusters[ci].bbminz,
            atom->iclusters[ci].bbmaxz);

        for(int cii = 0; cii < CLUSTER_M; cii++) {
            DEBUG_MESSAGE("%f, %f, %f\n", ci_x[CL_X_OFFSET + cii], ci_x[CL_Y_OFFSET + cii], ci_x[CL_Z_OFFSET + cii]);
        }

        DEBUG_MESSAGE("Neighbors:\n");
        for(int k = 0; k < neighbor->numneigh[ci]; k++) {
            int cj = neighptr[k];
            int cj_vec_base = CJ_VECTOR_BASE_INDEX(cj);
            MD_FLOAT *cj_x = &atom->cl_x[cj_vec_base];

            DEBUG_MESSAGE("    Cluster %d, bbx = {%f, %f}, bby = {%f, %f}, bbz = {%f, %f}\n",
                cj,
                atom->jclusters[cj].bbminx,
                atom->jclusters[cj].bbmaxx,
                atom->jclusters[cj].bbminy,
                atom->jclusters[cj].bbmaxy,
                atom->jclusters[cj].bbminz,
                atom->jclusters[cj].bbmaxz);

            for(int cjj = 0; cjj < CLUSTER_N; cjj++) {
                DEBUG_MESSAGE("    %f, %f, %f\n", cj_x[CL_X_OFFSET + cjj], cj_x[CL_Y_OFFSET + cjj], cj_x[CL_Z_OFFSET + cjj]);
            }
        }
    }
    */

    DEBUG_MESSAGE("buildNeighbor end\n");
}

void pruneNeighbor(Parameter *param, Atom *atom, Neighbor *neighbor) {
    DEBUG_MESSAGE("pruneNeighbor start\n");
    //MD_FLOAT cutsq = param->cutforce * param->cutforce;
    MD_FLOAT cutsq = cutneighsq;

    for(int ci = 0; ci < atom->Nclusters_local; ci++) {
        int *neighs = &neighbor->neighbors[ci * neighbor->maxneighs];
        int numneighs = neighbor->numneigh[ci];
        int k = 0;

        // Remove dummy clusters if necessary
        if(CLUSTER_N < VECTOR_WIDTH) {
            while(neighs[numneighs - 1] == atom->dummy_cj) {
                numneighs--;
            }
        }

        while(k < numneighs) {
            int cj = neighs[k];
            if(atomDistanceInRange(atom, ci, cj, cutsq)) {
                k++;
            } else {
                numneighs--;
                neighs[k] = neighs[numneighs];
            }
        }

        // Readd dummy clusters if necessary
        if(CLUSTER_N < VECTOR_WIDTH) {
            while(numneighs % (VECTOR_WIDTH / CLUSTER_N)) {
                neighs[numneighs++] = atom->dummy_cj; // Last cluster is always a dummy cluster
            }
        }

        neighbor->numneigh[ci] = numneighs;
    }

    DEBUG_MESSAGE("pruneNeighbor end\n");
}

/* internal subroutines */
MD_FLOAT bindist(int i, int j) {
    MD_FLOAT delx, dely, delz;

    if(i > 0) {
        delx = (i - 1) * binsizex;
    } else if(i == 0) {
        delx = 0.0;
    } else {
        delx = (i + 1) * binsizex;
    }

    if(j > 0) {
        dely = (j - 1) * binsizey;
    } else if(j == 0) {
        dely = 0.0;
    } else {
        dely = (j + 1) * binsizey;
    }

    return (delx * delx + dely * dely);
}

int coord2bin(MD_FLOAT xin, MD_FLOAT yin) {
    int ix, iy;

    if(xin >= xprd) {
        ix = (int)((xin - xprd) * bininvx) + nbinx - mbinxlo;
    } else if(xin >= 0.0) {
        ix = (int)(xin * bininvx) - mbinxlo;
    } else {
        ix = (int)(xin * bininvx) - mbinxlo - 1;
    }

    if(yin >= yprd) {
        iy = (int)((yin - yprd) * bininvy) + nbiny - mbinylo;
    } else if(yin >= 0.0) {
        iy = (int)(yin * bininvy) - mbinylo;
    } else {
        iy = (int)(yin * bininvy) - mbinylo - 1;
    }

    return (iy * mbinx + ix + 1);
}

void coord2bin2D(MD_FLOAT xin, MD_FLOAT yin, int *ix, int *iy) {
    if(xin >= xprd) {
        *ix = (int)((xin - xprd) * bininvx) + nbinx - mbinxlo;
    } else if(xin >= 0.0) {
        *ix = (int)(xin * bininvx) - mbinxlo;
    } else {
        *ix = (int)(xin * bininvx) - mbinxlo - 1;
    }

    if(yin >= yprd) {
        *iy = (int)((yin - yprd) * bininvy) + nbiny - mbinylo;
    } else if(yin >= 0.0) {
        *iy = (int)(yin * bininvy) - mbinylo;
    } else {
        *iy = (int)(yin * bininvy) - mbinylo - 1;
    }
}

void binAtoms(Atom *atom) {
    DEBUG_MESSAGE("binAtoms start\n");
    int resize = 1;

    while(resize > 0) {
        resize = 0;

        for(int i = 0; i < mbins; i++) {
            bincount[i] = 0;
        }

        for(int i = 0; i < atom->Nlocal; i++) {
            int ibin = coord2bin(atom_x(i), atom_y(i));
            if(bincount[ibin] < atoms_per_bin) {
                int ac = bincount[ibin]++;
                bins[ibin * atoms_per_bin + ac] = i;
            } else {
                resize = 1;
            }
        }

        if(resize) {
            free(bins);
            atoms_per_bin *= 2;
            bins = (int*) malloc(mbins * atoms_per_bin * sizeof(int));
        }
    }

    DEBUG_MESSAGE("binAtoms end\n");
}

// TODO: Use pigeonhole sorting
void sortAtomsByZCoord(Atom *atom) {
    DEBUG_MESSAGE("sortAtomsByZCoord start\n");
    for(int bin = 0; bin < mbins; bin++) {
        int c = bincount[bin];
        int *bin_ptr = &bins[bin * atoms_per_bin];

        for(int ac_i = 0; ac_i < c; ac_i++) {
            int i = bin_ptr[ac_i];
            int min_ac = ac_i;
            int min_idx = i;
            MD_FLOAT min_z = atom_z(i);

            for(int ac_j = ac_i + 1; ac_j < c; ac_j++) {
                int j = bin_ptr[ac_j];
                MD_FLOAT zj = atom_z(j);
                if(zj < min_z) {
                    min_ac = ac_j;
                    min_idx = j;
                    min_z = zj;
                }
            }

            bin_ptr[ac_i] = min_idx;
            bin_ptr[min_ac] = i;
        }
    }

    DEBUG_MESSAGE("sortAtomsByZCoord end\n");
}

void buildClusters(Atom *atom) {
    DEBUG_MESSAGE("buildClusters start\n");
    atom->Nclusters_local = 0;

    /* bin local atoms */
    binAtoms(atom);
    sortAtomsByZCoord(atom);

    for(int bin = 0; bin < mbins; bin++) {
        int c = bincount[bin];
        int ac = 0;
        int nclusters = ((c + CLUSTER_M - 1) / CLUSTER_M);
        if(CLUSTER_N > CLUSTER_M && nclusters % 2) { nclusters++; }
        for(int cl = 0; cl < nclusters; cl++) {
            const int ci = atom->Nclusters_local;
            if(ci >= atom->Nclusters_max) {
                growClusters(atom);
            }

            int ci_sca_base = CI_SCALAR_BASE_INDEX(ci);
            int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
            MD_FLOAT *ci_x = &atom->cl_x[ci_vec_base];
            MD_FLOAT *ci_v = &atom->cl_v[ci_vec_base];
            int *ci_type = &atom->cl_type[ci_sca_base];
            MD_FLOAT bbminx = INFINITY, bbmaxx = -INFINITY;
            MD_FLOAT bbminy = INFINITY, bbmaxy = -INFINITY;
            MD_FLOAT bbminz = INFINITY, bbmaxz = -INFINITY;

            atom->iclusters[ci].natoms = 0;
            for(int cii = 0; cii < CLUSTER_M; cii++) {
                if(ac < c) {
                    int i = bins[bin * atoms_per_bin + ac];
                    MD_FLOAT xtmp = atom_x(i);
                    MD_FLOAT ytmp = atom_y(i);
                    MD_FLOAT ztmp = atom_z(i);

                    ci_x[CL_X_OFFSET + cii] = xtmp;
                    ci_x[CL_Y_OFFSET + cii] = ytmp;
                    ci_x[CL_Z_OFFSET + cii] = ztmp;
                    ci_v[CL_X_OFFSET + cii] = atom->vx[i];
                    ci_v[CL_Y_OFFSET + cii] = atom->vy[i];
                    ci_v[CL_Z_OFFSET + cii] = atom->vz[i];

                    // TODO: To create the bounding boxes faster, we can use SIMD operations
                    if(bbminx > xtmp) { bbminx = xtmp; }
                    if(bbmaxx < xtmp) { bbmaxx = xtmp; }
                    if(bbminy > ytmp) { bbminy = ytmp; }
                    if(bbmaxy < ytmp) { bbmaxy = ytmp; }
                    if(bbminz > ztmp) { bbminz = ztmp; }
                    if(bbmaxz < ztmp) { bbmaxz = ztmp; }

                    ci_type[cii] = atom->type[i];
                    atom->iclusters[ci].natoms++;
                } else {
                    ci_x[CL_X_OFFSET + cii] = INFINITY;
                    ci_x[CL_Y_OFFSET + cii] = INFINITY;
                    ci_x[CL_Z_OFFSET + cii] = INFINITY;
                }

                ac++;
            }

            atom->icluster_bin[ci] = bin;
            atom->iclusters[ci].bbminx = bbminx;
            atom->iclusters[ci].bbmaxx = bbmaxx;
            atom->iclusters[ci].bbminy = bbminy;
            atom->iclusters[ci].bbmaxy = bbmaxy;
            atom->iclusters[ci].bbminz = bbminz;
            atom->iclusters[ci].bbmaxz = bbmaxz;
            atom->Nclusters_local++;
        }
    }

    DEBUG_MESSAGE("buildClusters end\n");
}

void defineJClusters(Atom *atom) {
    DEBUG_MESSAGE("defineJClusters start\n");

    for(int ci = 0; ci < atom->Nclusters_local; ci++) {
        int cj0 = CJ0_FROM_CI(ci);

        if(CLUSTER_M == CLUSTER_N) {
            atom->jclusters[cj0].bbminx = atom->iclusters[ci].bbminx;
            atom->jclusters[cj0].bbmaxx = atom->iclusters[ci].bbmaxx;
            atom->jclusters[cj0].bbminy = atom->iclusters[ci].bbminy;
            atom->jclusters[cj0].bbmaxy = atom->iclusters[ci].bbmaxy;
            atom->jclusters[cj0].bbminz = atom->iclusters[ci].bbminz;
            atom->jclusters[cj0].bbmaxz = atom->iclusters[ci].bbmaxz;
            atom->jclusters[cj0].natoms = atom->iclusters[ci].natoms;

        } else if(CLUSTER_M > CLUSTER_N) {
            int cj1 = CJ1_FROM_CI(ci);
            int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
            MD_FLOAT *ci_x = &atom->cl_x[ci_vec_base];
            MD_FLOAT bbminx = INFINITY, bbmaxx = -INFINITY;
            MD_FLOAT bbminy = INFINITY, bbmaxy = -INFINITY;
            MD_FLOAT bbminz = INFINITY, bbmaxz = -INFINITY;

            for(int cii = 0; cii < MAX(atom->iclusters[ci].natoms, CLUSTER_N); cii++) {
                MD_FLOAT xtmp = ci_x[CL_X_OFFSET + cii];
                MD_FLOAT ytmp = ci_x[CL_Y_OFFSET + cii];
                MD_FLOAT ztmp = ci_x[CL_Z_OFFSET + cii];

                // TODO: To create the bounding boxes faster, we can use SIMD operations
                if(bbminx > xtmp) { bbminx = xtmp; }
                if(bbmaxx < xtmp) { bbmaxx = xtmp; }
                if(bbminy > ytmp) { bbminy = ytmp; }
                if(bbmaxy < ytmp) { bbmaxy = ytmp; }
                if(bbminz > ztmp) { bbminz = ztmp; }
                if(bbmaxz < ztmp) { bbmaxz = ztmp; }
            }

            atom->jclusters[cj0].bbminx = bbminx;
            atom->jclusters[cj0].bbmaxx = bbmaxx;
            atom->jclusters[cj0].bbminy = bbminy;
            atom->jclusters[cj0].bbmaxy = bbmaxy;
            atom->jclusters[cj0].bbminz = bbminz;
            atom->jclusters[cj0].bbmaxz = bbmaxz;
            atom->jclusters[cj0].natoms = MAX(atom->iclusters[ci].natoms, CLUSTER_N);

            bbminx = INFINITY, bbmaxx = -INFINITY;
            bbminy = INFINITY, bbmaxy = -INFINITY;
            bbminz = INFINITY, bbmaxz = -INFINITY;

            for(int cii = CLUSTER_N; cii < atom->iclusters[ci].natoms; cii++) {
                MD_FLOAT xtmp = ci_x[CL_X_OFFSET + cii];
                MD_FLOAT ytmp = ci_x[CL_Y_OFFSET + cii];
                MD_FLOAT ztmp = ci_x[CL_Z_OFFSET + cii];

                // TODO: To create the bounding boxes faster, we can use SIMD operations
                if(bbminx > xtmp) { bbminx = xtmp; }
                if(bbmaxx < xtmp) { bbmaxx = xtmp; }
                if(bbminy > ytmp) { bbminy = ytmp; }
                if(bbmaxy < ytmp) { bbmaxy = ytmp; }
                if(bbminz > ztmp) { bbminz = ztmp; }
                if(bbmaxz < ztmp) { bbmaxz = ztmp; }
            }

            atom->jclusters[cj1].bbminx = bbminx;
            atom->jclusters[cj1].bbmaxx = bbmaxx;
            atom->jclusters[cj1].bbminy = bbminy;
            atom->jclusters[cj1].bbmaxy = bbmaxy;
            atom->jclusters[cj1].bbminz = bbminz;
            atom->jclusters[cj1].bbmaxz = bbmaxz;
            atom->jclusters[cj1].natoms = MIN(0, atom->iclusters[ci].natoms - CLUSTER_N);

        } else {
            if(ci % 2 == 0) {
                const int ci1 = ci + 1;
                atom->jclusters[cj0].bbminx = MIN(atom->iclusters[ci].bbminx, atom->iclusters[ci1].bbminx);
                atom->jclusters[cj0].bbmaxx = MAX(atom->iclusters[ci].bbmaxx, atom->iclusters[ci1].bbmaxx);
                atom->jclusters[cj0].bbminy = MIN(atom->iclusters[ci].bbminy, atom->iclusters[ci1].bbminy);
                atom->jclusters[cj0].bbmaxy = MAX(atom->iclusters[ci].bbmaxy, atom->iclusters[ci1].bbmaxy);
                atom->jclusters[cj0].bbminz = MIN(atom->iclusters[ci].bbminz, atom->iclusters[ci1].bbminz);
                atom->jclusters[cj0].bbmaxz = MAX(atom->iclusters[ci].bbmaxz, atom->iclusters[ci1].bbmaxz);
                atom->jclusters[cj0].natoms = atom->iclusters[ci].natoms + atom->iclusters[ci1].natoms;
            }
        }
    }

    DEBUG_MESSAGE("defineJClusters end\n");
}

void binClusters(Atom *atom) {
    DEBUG_MESSAGE("binClusters start\n");

    /*
    DEBUG_MESSAGE("Nghost = %d\n", atom->Nclusters_ghost);
    for(int ci = atom->Nclusters_local; ci < atom->Nclusters_local + 4; ci++) {
        MD_FLOAT *cptr = cluster_pos_ptr(ci);
        DEBUG_MESSAGE("Cluster %d:\n", ci);
        DEBUG_MESSAGE("bin=%d, Natoms=%d, bbox={%f,%f},{%f,%f},{%f,%f}\n",
            atom->icluster_bin[ci],
            atom->clusters[ci].natoms,
            atom->clusters[ci].bbminx,
            atom->clusters[ci].bbmaxx,
            atom->clusters[ci].bbminy,
            atom->clusters[ci].bbmaxy,
            atom->clusters[ci].bbminz,
            atom->clusters[ci].bbmaxz);

        for(int cii = 0; cii < CLUSTER_M; cii++) {
            DEBUG_MESSAGE("%f, %f, %f\n", cluster_x(cptr, cii), cluster_y(cptr, cii), cluster_z(cptr, cii));
        }
    }
    */

    const int nlocal = atom->Nclusters_local;
    const int jfac = MAX(1, CLUSTER_N / CLUSTER_M);
    const int ncj = atom->Nclusters_local / jfac;

    int resize = 1;
    while(resize > 0) {
        resize = 0;

        for(int bin = 0; bin < mbins; bin++) {
            bin_nclusters[bin] = 0;
        }

        for(int ci = 0; ci < nlocal && !resize; ci++) {
            // Assure we add this j-cluster only once in the bin
            if(!(CLUSTER_M < CLUSTER_N && ci % 2)) {
                int bin = atom->icluster_bin[ci];
                int c = bin_nclusters[bin];
                if(c + 1 < clusters_per_bin) {
                    bin_clusters[bin * clusters_per_bin + c] = CJ0_FROM_CI(ci);
                    bin_nclusters[bin]++;

                    if(CLUSTER_M > CLUSTER_N) {
                        int cj1 = CJ1_FROM_CI(ci);
                        if(atom->jclusters[cj1].natoms > 0) {
                            bin_clusters[bin * clusters_per_bin + c + 1] = cj1;
                            bin_nclusters[bin]++;
                        }
                    }
                } else {
                    resize = 1;
                }
            }
        }

        for(int cg = 0; cg < atom->Nclusters_ghost && !resize; cg++) {
            const int cj = ncj + cg;
            int ix = -1, iy = -1;
            MD_FLOAT xtmp, ytmp;

            if(atom->jclusters[cj].natoms > 0) {
                int cj_vec_base = CJ_VECTOR_BASE_INDEX(cj);
                MD_FLOAT *cj_x = &atom->cl_x[cj_vec_base];
                MD_FLOAT cj_minz = atom->jclusters[cj].bbminz;

                xtmp = cj_x[CL_X_OFFSET + 0];
                ytmp = cj_x[CL_Y_OFFSET + 0];
                coord2bin2D(xtmp, ytmp, &ix, &iy);
                ix = MAX(MIN(ix, mbinx - 1), 0);
                iy = MAX(MIN(iy, mbiny - 1), 0);
                for(int cjj = 1; cjj < atom->jclusters[cj].natoms; cjj++) {
                    int nix, niy;
                    xtmp = cj_x[CL_X_OFFSET + cjj];
                    ytmp = cj_x[CL_Y_OFFSET + cjj];
                    coord2bin2D(xtmp, ytmp, &nix, &niy);
                    nix = MAX(MIN(nix, mbinx - 1), 0);
                    niy = MAX(MIN(niy, mbiny - 1), 0);

                    // Always put the cluster on the bin of its innermost atom so
                    // the cluster should be closer to local clusters
                    if(atom->PBCx[cg] > 0 && ix > nix) { ix = nix; }
                    if(atom->PBCx[cg] < 0 && ix < nix) { ix = nix; }
                    if(atom->PBCy[cg] > 0 && iy > niy) { iy = niy; }
                    if(atom->PBCy[cg] < 0 && iy < niy) { iy = niy; }
                }

                int bin = iy * mbinx + ix + 1;
                int c = bin_nclusters[bin];
                if(c < clusters_per_bin) {
                    // Insert the current ghost cluster in the bin keeping clusters
                    // sorted by z coordinate
                    int inserted = 0;
                    for(int i = 0; i < c; i++) {
                        int last_cl = bin_clusters[bin * clusters_per_bin + i];
                        if(atom->jclusters[last_cl].bbminz > cj_minz) {
                            bin_clusters[bin * clusters_per_bin + i] = cj;

                            for(int j = i + 1; j <= c; j++) {
                                int tmp = bin_clusters[bin * clusters_per_bin + j];
                                bin_clusters[bin * clusters_per_bin + j] = last_cl;
                                last_cl = tmp;
                            }

                            inserted = 1;
                            break;
                        }
                    }

                    if(!inserted) {
                        bin_clusters[bin * clusters_per_bin + c] = cj;
                    }

                    bin_nclusters[bin]++;
                } else {
                    resize = 1;
                }
            }
        }

        if(resize) {
            free(bin_clusters);
            clusters_per_bin *= 2;
            bin_clusters = (int*) malloc(mbins * clusters_per_bin * sizeof(int));
        }
    }

    /*
    DEBUG_MESSAGE("bin_nclusters\n");
    for(int i = 0; i < mbins; i++) { DEBUG_MESSAGE("%d, ", bin_nclusters[i]); }
    DEBUG_MESSAGE("\n");
    */

    DEBUG_MESSAGE("binClusters stop\n");
}

void updateSingleAtoms(Atom *atom) {
    DEBUG_MESSAGE("updateSingleAtoms start\n");
    int Natom = 0;

    for(int ci = 0; ci < atom->Nclusters_local; ci++) {
        int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT *ci_x = &atom->cl_x[ci_vec_base];
        MD_FLOAT *ci_v = &atom->cl_v[ci_vec_base];

        for(int cii = 0; cii < atom->iclusters[ci].natoms; cii++) {
            atom_x(Natom) = ci_x[CL_X_OFFSET + cii];
            atom_y(Natom) = ci_x[CL_Y_OFFSET + cii];
            atom_z(Natom) = ci_x[CL_Z_OFFSET + cii];
            atom->vx[Natom] = ci_v[CL_X_OFFSET + cii];
            atom->vy[Natom] = ci_v[CL_Y_OFFSET + cii];
            atom->vz[Natom] = ci_v[CL_Z_OFFSET + cii];
            Natom++;
        }
    }

    if(Natom != atom->Nlocal) {
        fprintf(stderr, "updateSingleAtoms(): Number of atoms changed!\n");
    }

    DEBUG_MESSAGE("updateSingleAtoms stop\n");
}
