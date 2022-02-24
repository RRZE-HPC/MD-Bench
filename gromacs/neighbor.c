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
static int *cluster_bincount;
static int *cluster_bins;
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
    clusters_per_bin = (atoms_per_bin / CLUSTER_DIM_M) + 4;
    stencil = NULL;
    bins = NULL;
    bincount = NULL;
    cluster_bins = NULL;
    cluster_bincount = NULL;
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
    MD_FLOAT atoms_in_cell = MAX(CLUSTER_DIM_M, CLUSTER_DIM_N);
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
    mbinxlo = (int) (coord * bininvx);
    if (coord < 0.0) {
        mbinxlo = mbinxlo - 1;
    }
    coord = xhi + cutneigh + SMALL * xprd;
    mbinxhi = (int) (coord * bininvx);

    coord = ylo - cutneigh - SMALL * yprd;
    mbinylo = (int) (coord * bininvy);
    if (coord < 0.0) {
        mbinylo = mbinylo - 1;
    }
    coord = yhi + cutneigh + SMALL * yprd;
    mbinyhi = (int) (coord * bininvy);

    mbinxlo = mbinxlo - 1;
    mbinxhi = mbinxhi + 1;
    mbinx = mbinxhi - mbinxlo + 1;

    mbinylo = mbinylo - 1;
    mbinyhi = mbinyhi + 1;
    mbiny = mbinyhi - mbinylo + 1;

    nextx = (int) (cutneigh * bininvx);
    if(nextx * binsizex < FACTOR * cutneigh) nextx++;

    nexty = (int) (cutneigh * bininvy);
    if(nexty * binsizey < FACTOR * cutneigh) nexty++;

    if (stencil) {
        free(stencil);
    }

    stencil = (int *) malloc((2 * nexty + 1) * (2 * nextx + 1) * sizeof(int));
    nstencil = 0;

    for(int j = -nexty; j <= nexty; j++) {
        for(int i = -nextx; i <= nextx; i++) {
            if(bindist(i, j) < cutneighsq) {
                stencil[nstencil++] = j * mbinx + i;
            }
        }
    }

    mbins = mbinx * mbiny;

    if (bincount) { free(bincount); }
    bincount = (int*) malloc(mbins * sizeof(int));

    if (bins) { free(bins); }
    bins = (int*) malloc(mbins * atoms_per_bin * sizeof(int));

    if (cluster_bincount) { free(cluster_bincount); }
    cluster_bincount = (int*) malloc(mbins * sizeof(int));

    if (cluster_bins) { free(cluster_bins); }
    cluster_bins = (int*) malloc(mbins * clusters_per_bin * sizeof(int));

    /*
    DEBUG_MESSAGE("lo, hi = (%e, %e, %e), (%e, %e, %e)\n", xlo, ylo, zlo, xhi, yhi, zhi);
    DEBUG_MESSAGE("binsize = %e, %e\n", binsizex, binsizey);
    DEBUG_MESSAGE("mbin lo, hi = (%d, %d), (%d, %d)\n", mbinxlo, mbinylo, mbinxhi, mbinyhi);
    DEBUG_MESSAGE("mbins = %d (%d x %d)\n", mbins, mbinx, mbiny);
    DEBUG_MESSAGE("nextx = %d, nexty = %d\n", nextx, nexty);
    */
}

MD_FLOAT getBoundingBoxDistanceSq(Atom *atom, int ci, int cj) {
    MD_FLOAT dl = atom->clusters[ci].bbminx - atom->clusters[cj].bbmaxx;
    MD_FLOAT dh = atom->clusters[cj].bbminx - atom->clusters[ci].bbmaxx;
    MD_FLOAT dm = MAX(dl, dh);
    MD_FLOAT dm0 = MAX(dm, 0.0);
    MD_FLOAT d2 = dm0 * dm0;

    dl = atom->clusters[ci].bbminy - atom->clusters[cj].bbmaxy;
    dh = atom->clusters[cj].bbminy - atom->clusters[ci].bbmaxy;
    dm = MAX(dl, dh);
    dm0 = MAX(dm, 0.0);
    d2 += dm0 * dm0;

    dl = atom->clusters[ci].bbminz - atom->clusters[cj].bbmaxz;
    dh = atom->clusters[cj].bbminz - atom->clusters[ci].bbmaxz;
    dm = MAX(dl, dh);
    dm0 = MAX(dm, 0.0);
    d2 += dm0 * dm0;
    return d2;
}

int atomDistanceInRange(Atom *atom, int ci, int cj, MD_FLOAT rsq) {
    MD_FLOAT *ciptr = cluster_pos_ptr(ci);
    MD_FLOAT *cjptr = cluster_pos_ptr(cj);

    for(int cii = 0; cii < atom->clusters[ci].natoms; cii++) {
        for(int cjj = 0; cjj < atom->clusters[cj].natoms; cjj++) {
            MD_FLOAT delx = cluster_x(ciptr, cii) - cluster_x(cjptr, cjj);
            MD_FLOAT dely = cluster_y(ciptr, cii) - cluster_y(cjptr, cjj);
            MD_FLOAT delz = cluster_z(ciptr, cii) - cluster_z(cjptr, cjj);
            if(delx * delx + dely * dely + delz * delz < rsq) {
                return 1;
            }
        }
    }

    return 0;
}

void buildNeighbor(Atom *atom, Neighbor *neighbor) {
    DEBUG_MESSAGE("buildNeighbor start\n");
    int nall = atom->Nclusters_local + atom->Nclusters_ghost;

    /* extend atom arrays if necessary */
    if(nall > nmax) {
        nmax = nall;
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
            int* neighptr = &(neighbor->neighbors[ci * neighbor->maxneighs]);
            int n = 0;
            int ibin = atom->clusters[ci].bin;
            MD_FLOAT ibb_xmin = atom->clusters[ci].bbminx;
            MD_FLOAT ibb_xmax = atom->clusters[ci].bbmaxx;
            MD_FLOAT ibb_ymin = atom->clusters[ci].bbminy;
            MD_FLOAT ibb_ymax = atom->clusters[ci].bbmaxy;
            MD_FLOAT ibb_zmin = atom->clusters[ci].bbminz;
            MD_FLOAT ibb_zmax = atom->clusters[ci].bbmaxz;

            for(int k = 0; k < nstencil; k++) {
                int jbin = ibin + stencil[k];
                int *loc_bin = &cluster_bins[jbin * clusters_per_bin];
                int cj, m = -1;
                MD_FLOAT jbb_xmin, jbb_xmax, jbb_ymin, jbb_ymax, jbb_zmin, jbb_zmax;
                const int c = cluster_bincount[jbin];

                if(c > 0) {
                    MD_FLOAT dl, dh, dm, dm0, d_bb_sq;

                    do {
                        m++;
                        cj = loc_bin[m];
                        jbb_zmin = atom->clusters[cj].bbminz;
                        jbb_zmax = atom->clusters[cj].bbmaxz;
                        dl = ibb_zmin - jbb_zmax;
                        dh = jbb_zmin - ibb_zmax;
                        dm = MAX(dl, dh);
                        dm0 = MAX(dm, 0.0);
                        d_bb_sq = dm0 * dm0;
                    } while(m + 1 < c && d_bb_sq > cutneighsq);

                    jbb_xmin = atom->clusters[cj].bbminx;
                    jbb_xmax = atom->clusters[cj].bbmaxx;
                    jbb_ymin = atom->clusters[cj].bbminy;
                    jbb_ymax = atom->clusters[cj].bbmaxy;

                    while(m < c) {
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

                        m++;
                        if(m < c) {
                            cj = loc_bin[m];
                            jbb_xmin = atom->clusters[cj].bbminx;
                            jbb_xmax = atom->clusters[cj].bbmaxx;
                            jbb_ymin = atom->clusters[cj].bbminy;
                            jbb_ymax = atom->clusters[cj].bbmaxy;
                            jbb_zmin = atom->clusters[cj].bbminz;
                            jbb_zmax = atom->clusters[cj].bbmaxz;
                        }
                    }
                }
            }

            if(CLUSTER_DIM_N > CLUSTER_DIM_M) {
                while(n % (CLUSTER_DIM_N / CLUSTER_DIM_M)) {
                    neighptr[n++] = nall - 1; // Last cluster is always a dummy cluster
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
        MD_FLOAT *ciptr = cluster_pos_ptr(ci);
        int* neighptr = &(neighbor->neighbors[ci * neighbor->maxneighs]);

        DEBUG_MESSAGE("Cluster %d, bbx = {%f, %f}, bby = {%f, %f}, bbz = {%f, %f}\n",
            ci,
            atom->clusters[ci].bbminx,
            atom->clusters[ci].bbmaxx,
            atom->clusters[ci].bbminy,
            atom->clusters[ci].bbmaxy,
            atom->clusters[ci].bbminz,
            atom->clusters[ci].bbmaxz);

        for(int cii = 0; cii < CLUSTER_DIM_M; cii++) {
            DEBUG_MESSAGE("%f, %f, %f\n", cluster_x(ciptr, cii), cluster_y(ciptr, cii), cluster_z(ciptr, cii));
        }

        DEBUG_MESSAGE("Neighbors:\n");
        for(int k = 0; k < neighbor->numneigh[ci]; k++) {
            const int cj = neighptr[k];
            MD_FLOAT *cjptr = cluster_pos_ptr(cj);

            DEBUG_MESSAGE("    Cluster %d, bbx = {%f, %f}, bby = {%f, %f}, bbz = {%f, %f}\n",
                cj,
                atom->clusters[cj].bbminx,
                atom->clusters[cj].bbmaxx,
                atom->clusters[cj].bbminy,
                atom->clusters[cj].bbmaxy,
                atom->clusters[cj].bbminz,
                atom->clusters[cj].bbmaxz);

            for(int cjj = 0; cjj < CLUSTER_DIM_M; cjj++) {
                DEBUG_MESSAGE("    %f, %f, %f\n", cluster_x(cjptr, cjj), cluster_y(cjptr, cjj), cluster_z(cjptr, cjj));
            }
        }
    }
    */

    DEBUG_MESSAGE("buildNeighbor end\n");
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
        const int nclusters = ((c + CLUSTER_DIM_M - 1) / CLUSTER_DIM_M);
        for(int cl = 0; cl < nclusters; cl++) {
            const int ci = atom->Nclusters_local;

            if(ci >= atom->Nclusters_max) {
                growClusters(atom);
            }

            MD_FLOAT *cptr = cluster_pos_ptr(ci);
            MD_FLOAT *cvptr = cluster_velocity_ptr(ci);
            MD_FLOAT bbminx = INFINITY, bbmaxx = -INFINITY;
            MD_FLOAT bbminy = INFINITY, bbmaxy = -INFINITY;
            MD_FLOAT bbminz = INFINITY, bbmaxz = -INFINITY;
            atom->clusters[ci].natoms = 0;

            for(int cii = 0; cii < CLUSTER_DIM_M; cii++) {
                if(ac < c) {
                    int i = bins[bin * atoms_per_bin + ac];
                    MD_FLOAT xtmp = atom_x(i);
                    MD_FLOAT ytmp = atom_y(i);
                    MD_FLOAT ztmp = atom_z(i);

                    cluster_x(cptr, cii) = xtmp;
                    cluster_y(cptr, cii) = ytmp;
                    cluster_z(cptr, cii) = ztmp;
                    cluster_x(cvptr, cii) = atom->vx[i];
                    cluster_y(cvptr, cii) = atom->vy[i];
                    cluster_z(cvptr, cii) = atom->vz[i];

                    // TODO: To create the bounding boxes faster, we can use SIMD operations
                    if(bbminx > xtmp) { bbminx = xtmp; }
                    if(bbmaxx < xtmp) { bbmaxx = xtmp; }
                    if(bbminy > ytmp) { bbminy = ytmp; }
                    if(bbmaxy < ytmp) { bbmaxy = ytmp; }
                    if(bbminz > ztmp) { bbminz = ztmp; }
                    if(bbmaxz < ztmp) { bbmaxz = ztmp; }

                    atom->clusters[ci].type[cii] = atom->type[i];
                    atom->clusters[ci].natoms++;
                } else {
                    cluster_x(cptr, cii) = INFINITY;
                    cluster_y(cptr, cii) = INFINITY;
                    cluster_z(cptr, cii) = INFINITY;
                }

                ac++;
            }

            atom->clusters[ci].bin = bin;
            atom->clusters[ci].bbminx = bbminx;
            atom->clusters[ci].bbmaxx = bbmaxx;
            atom->clusters[ci].bbminy = bbminy;
            atom->clusters[ci].bbmaxy = bbmaxy;
            atom->clusters[ci].bbminz = bbminz;
            atom->clusters[ci].bbmaxz = bbmaxz;
            atom->Nclusters_local++;
        }
    }

    DEBUG_MESSAGE("buildClusters end\n");
}

void binClusters(Atom *atom) {
    DEBUG_MESSAGE("binClusters start\n");

    /*
    DEBUG_MESSAGE("Nghost = %d\n", atom->Nclusters_ghost);
    for(int ci = atom->Nclusters_local; ci < atom->Nclusters_local + 4; ci++) {
        MD_FLOAT *cptr = cluster_pos_ptr(ci);
        DEBUG_MESSAGE("Cluster %d:\n", ci);
        DEBUG_MESSAGE("bin=%d, Natoms=%d, bbox={%f,%f},{%f,%f},{%f,%f}\n",
            atom->clusters[ci].bin,
            atom->clusters[ci].natoms,
            atom->clusters[ci].bbminx,
            atom->clusters[ci].bbmaxx,
            atom->clusters[ci].bbminy,
            atom->clusters[ci].bbmaxy,
            atom->clusters[ci].bbminz,
            atom->clusters[ci].bbmaxz);

        for(int cii = 0; cii < CLUSTER_DIM_M; cii++) {
            DEBUG_MESSAGE("%f, %f, %f\n", cluster_x(cptr, cii), cluster_y(cptr, cii), cluster_z(cptr, cii));
        }
    }
    */

    const int nlocal = atom->Nclusters_local;
    int resize = 1;

    while(resize > 0) {
        resize = 0;

        for(int bin = 0; bin < mbins; bin++) {
            cluster_bincount[bin] = 0;
        }

        for(int ci = 0; ci < nlocal && !resize; ci++) {
            int bin = atom->clusters[ci].bin;
            int c = cluster_bincount[bin];
            if(c < clusters_per_bin) {
                cluster_bins[bin * clusters_per_bin + c] = ci;
                cluster_bincount[bin]++;
            } else {
                resize = 1;
            }
        }

        for(int cg = 0; cg < atom->Nclusters_ghost && !resize; cg++) {
            const int ci = nlocal + cg;
            MD_FLOAT *cptr = cluster_pos_ptr(ci);
            MD_FLOAT ci_minz = atom->clusters[ci].bbminz;
            MD_FLOAT xtmp, ytmp;
            int ix = -1, iy = -1;

            xtmp = cluster_x(cptr, 0);
            ytmp = cluster_y(cptr, 0);
            coord2bin2D(xtmp, ytmp, &ix, &iy);
            ix = MAX(MIN(ix, mbinx - 1), 0);
            iy = MAX(MIN(iy, mbiny - 1), 0);
            for(int cii = 1; cii < atom->clusters[ci].natoms; cii++) {
                int nix, niy;
                xtmp = cluster_x(cptr, cii);
                ytmp = cluster_y(cptr, cii);
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
            int c = cluster_bincount[bin];
            if(c < clusters_per_bin) {
                // Insert the current ghost cluster in the bin keeping clusters
                // sorted by z coordinate
                int inserted = 0;
                for(int i = 0; i < c; i++) {
                    int last_cl = cluster_bins[bin * clusters_per_bin + i];
                    if(atom->clusters[last_cl].bbminz > ci_minz) {
                        cluster_bins[bin * clusters_per_bin + i] = ci;

                        for(int j = i + 1; j <= c; j++) {
                            int tmp = cluster_bins[bin * clusters_per_bin + j];
                            cluster_bins[bin * clusters_per_bin + j] = last_cl;
                            last_cl = tmp;
                        }

                        inserted = 1;
                        break;
                    }
                }

                if(!inserted) {
                    cluster_bins[bin * clusters_per_bin + c] = ci;
                }

                atom->clusters[ci].bin = bin;
                cluster_bincount[bin]++;
            } else {
                resize = 1;
            }
        }

        if(resize) {
            free(cluster_bins);
            clusters_per_bin *= 2;
            cluster_bins = (int*) malloc(mbins * clusters_per_bin * sizeof(int));
        }
    }

    /*
    DEBUG_MESSAGE("cluster_bincount\n");
    for(int i = 0; i < mbins; i++) { DEBUG_MESSAGE("%d, ", cluster_bincount[i]); }
    DEBUG_MESSAGE("\n");
    */

    DEBUG_MESSAGE("binClusters stop\n");
}

void updateSingleAtoms(Atom *atom) {
    DEBUG_MESSAGE("updateSingleAtoms start\n");
    int Natom = 0;

    for(int ci = 0; ci < atom->Nclusters_local; ci++) {
        MD_FLOAT *cptr = cluster_pos_ptr(ci);
        MD_FLOAT *cvptr = cluster_velocity_ptr(ci);

        for(int cii = 0; cii < atom->clusters[ci].natoms; cii++) {
            atom_x(Natom) = cluster_x(cptr, cii);
            atom_y(Natom) = cluster_y(cptr, cii);
            atom_z(Natom) = cluster_z(cptr, cii);
            atom->vx[Natom] = cluster_x(cvptr, cii);
            atom->vy[Natom] = cluster_y(cvptr, cii);
            atom->vz[Natom] = cluster_z(cvptr, cii);
            Natom++;
        }
    }

    if(Natom != atom->Nlocal) {
        fprintf(stderr, "updateSingleAtoms(): Number of atoms changed!\n");
    }

    DEBUG_MESSAGE("updateSingleAtoms stop\n");
}
