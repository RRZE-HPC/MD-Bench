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

static MD_FLOAT xprd, yprd;
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
void initNeighbor(Neighbor *neighbor, Parameter *param)
{
    MD_FLOAT neighscale = 5.0 / 6.0;
    xprd = param->nx * param->lattice;
    yprd = param->ny * param->lattice;
    cutneigh = param->cutneigh;
    nbinx = neighscale * param->nx;
    nbiny = neighscale * param->ny;
    nmax = 0;
    atoms_per_bin = 8;
    clusters_per_bin = (atoms_per_bin / CLUSTER_DIM_N) + 4;
    stencil = NULL;
    bins = NULL;
    bincount = NULL;
    cluster_bins = NULL;
    cluster_bincount = NULL;
    neighbor->maxneighs = 100;
    neighbor->numneigh = NULL;
    neighbor->neighbors = NULL;
}

void setupNeighbor(Parameter* param) {
    MD_FLOAT coord;
    int mbinxhi, mbinyhi;
    int nextx, nexty, nextz;

    if(param->input_file != NULL) {
        xprd = param->xprd;
        yprd = param->yprd;
    }

    // TODO: update lo and hi for standard case and use them here instead
    MD_FLOAT xlo = 0.0; MD_FLOAT xhi = xprd;
    MD_FLOAT ylo = 0.0; MD_FLOAT yhi = yprd;

    cutneighsq = cutneigh * cutneigh;

    if(param->input_file != NULL) {
        binsizex = cutneigh * 0.5;
        binsizey = cutneigh * 0.5;
        nbinx = (int)((param->xhi - param->xlo) / binsizex);
        nbiny = (int)((param->yhi - param->ylo) / binsizey);
        if(nbinx == 0) { nbinx = 1; }
        if(nbiny == 0) { nbiny = 1; }
        bininvx = nbinx / (param->xhi - param->xlo);
        bininvy = nbiny / (param->yhi - param->ylo);
    } else {
        binsizex = xprd / nbinx;
        binsizey = yprd / nbiny;
        bininvx = 1.0 / binsizex;
        bininvy = 1.0 / binsizey;
    }

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
    MD_FLOAT *ciptr = cluster_ptr(ci);
    MD_FLOAT *cjptr = cluster_ptr(cj);

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

void buildNeighbor(Parameter *param, Atom *atom, Neighbor *neighbor) {
    int nall = atom->Nlocal + atom->Nghost;

    /* extend atom arrays if necessary */
    if(nall > nmax) {
        nmax = nall;
        if(neighbor->numneigh) free(neighbor->numneigh);
        if(neighbor->neighbors) free(neighbor->neighbors);
        neighbor->numneigh = (int*) malloc(nmax * sizeof(int));
        neighbor->neighbors = (int*) malloc(nmax * neighbor->maxneighs * sizeof(int*));
    }

    const MD_FLOAT rBB = cutneighsq / 2.0; // TODO: change this
    int resize = 1;

    /* loop over each atom, storing neighbors */
    while(resize) {
        int new_maxneighs = neighbor->maxneighs;
        resize = 0;

        for(int ci = 0; ci < atom->Nclusters_local; ci++) {
            int* neighptr = &(neighbor->neighbors[ci * neighbor->maxneighs]);
            int n = 0;
            int ibin = atom->clusters[ci].bin;
            MD_FLOAT ibb_zmin = atom->clusters[ci].bbminz;
            MD_FLOAT ibb_zmax = atom->clusters[ci].bbmaxz;

            for(int k = 0; k < nstencil; k++) {
                int jbin = ibin + stencil[k];
                int *loc_bin = &cluster_bins[jbin * clusters_per_bin];
                int cj, m = -1;
                MD_FLOAT jbb_zmin, jbb_zmax;

                do {
                    m++;
                    cj = loc_bin[m];
                    jbb_zmin = atom->clusters[cj].bbminz;
                    jbb_zmax = atom->clusters[cj].bbmaxz;
                } while((ibb_zmin - jbb_zmax) * (ibb_zmin - jbb_zmax) > cutneighsq);

                while(m < cluster_bincount[jbin] && jbb_zmax - ibb_zmax < cutneighsq) {
                    if((jbb_zmin - ibb_zmax) * (jbb_zmin - ibb_zmax) > cutneighsq) {
                        break;
                    }

                    double d_bb_sq = getBoundingBoxDistanceSq(atom, ci, cj);
                    if(d_bb_sq < cutneighsq) {
                        if(d_bb_sq < rBB || atomDistanceInRange(atom, ci, cj, cutneighsq)) {
                            if(cj == ci) {
                                // Add to neighbor list with diagonal interaction mask
                            }
                            neighptr[n++] = cj;
                        }
                    }

                    m++;
                    cj = loc_bin[m];
                    jbb_zmin = atom->clusters[cj].bbminz;
                    jbb_zmax = atom->clusters[cj].bbmaxz;
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
            printf("RESIZE %d\n", neighbor->maxneighs);
            neighbor->maxneighs = new_maxneighs * 1.2;
            free(neighbor->neighbors);
            neighbor->neighbors = (int*) malloc(atom->Nmax * neighbor->maxneighs * sizeof(int));
        }
    }
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

void binatoms(Atom *atom) {
    int nall = atom->Nlocal + atom->Nghost;
    int resize = 1;

    while(resize > 0) {
        resize = 0;

        for(int i = 0; i < mbins; i++) {
            bincount[i] = 0;
        }

        for(int i = 0; i < nall; i++) {
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
}

// TODO: Use pigeonhole sorting
void sortBinAtomsByZCoord(Parameter *param, Atom *atom, int bin) {
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
                min_ac = zj;
                min_idx = j;
                min_z = zj;
            }
        }

        bin_ptr[ac_i] = min_idx;
        bin_ptr[min_ac] = i;
    }
}

void buildClusters(Parameter *param, Atom *atom) {
    /* bin local atoms */
    binatoms(atom);

    for(int bin = 0; bin < mbins; bin++) {
        sortBinAtomsByZCoord(param, atom, bin);
    }

    int resize = 1;
    while(resize > 0) {
        resize = 0;
        for(int bin = 0; bin < mbins; bin++) {
            int c = bincount[bin];
            int ac = 0;
            const int nclusters = ((c + CLUSTER_DIM_N - 1) / CLUSTER_DIM_N);

            if(nclusters < clusters_per_bin) {
                for(int cl = 0; cl < nclusters; cl++) {
                    const int ci = atom->Nclusters_local;
                    MD_FLOAT *cptr = cluster_ptr(ci);
                    MD_FLOAT bbminx = INFINITY, bbmaxx = -INFINITY;
                    MD_FLOAT bbminy = INFINITY, bbmaxy = -INFINITY;
                    MD_FLOAT bbminz = INFINITY, bbmaxz = -INFINITY;
                    atom->clusters[ci].natoms = 0;

                    for(int cii = 0; cii < CLUSTER_DIM_N; cii++) {
                        if(ac < c) {
                            int i = bins[bin * atoms_per_bin + ac];
                            MD_FLOAT xtmp = atom_x(i);
                            MD_FLOAT ytmp = atom_y(i);
                            MD_FLOAT ztmp = atom_z(i);

                            cluster_x(cptr, cii) = xtmp;
                            cluster_y(cptr, cii) = ytmp;
                            cluster_z(cptr, cii) = ztmp;

                            // TODO: To create the bounding boxes faster, we can use SIMD operations
                            if(bbminx > xtmp) { bbminx = xtmp; }
                            if(bbmaxx < xtmp) { bbmaxx = xtmp; }
                            if(bbminy > ytmp) { bbminy = ytmp; }
                            if(bbmaxy < ytmp) { bbmaxy = ytmp; }
                            if(bbminz > ytmp) { bbminz = ytmp; }
                            if(bbmaxz < ytmp) { bbmaxz = ytmp; }

                            atom->clusters[ci].type[cii] = atom->type[i];
                            atom->clusters[ci].natoms++;
                        } else {
                            cluster_x(cptr, cii) = INFINITY;
                            cluster_y(cptr, cii) = INFINITY;
                            cluster_z(cptr, cii) = INFINITY;
                        }

                        ac++;
                    }

                    cluster_bins[bin * clusters_per_bin + cl] = ci;
                    atom->clusters[ci].bin = bin;
                    atom->clusters[ci].bbminx = bbminx;
                    atom->clusters[ci].bbmaxx = bbmaxx;
                    atom->clusters[ci].bbminy = bbminy;
                    atom->clusters[ci].bbmaxy = bbmaxy;
                    atom->clusters[ci].bbminz = bbminz;
                    atom->clusters[ci].bbmaxz = bbmaxz;
                    atom->Nclusters_local++;
                }

                cluster_bincount[bin] = nclusters;
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
}

void binGhostClusters(Parameter *param, Atom *atom) {
    int nlocal = atom->Nclusters_local;

    for(int ci = 0; ci < atom->Nclusters_ghost; ci++) {
        MD_FLOAT *cptr = cluster_ptr(nlocal + ci);
        MD_FLOAT xtmp, ytmp;
        int ix = -1, iy = -1;

        xtmp = cluster_x(cptr, 0);
        ytmp = cluster_y(cptr, 0);
        coord2bin2D(xtmp, ytmp, &ix, &iy);

        for(int cii = 1; cii < atom->clusters[ci].natoms; cii++) {
            int nix, niy;
            xtmp = cluster_x(cptr, cii);
            ytmp = cluster_y(cptr, cii);
            coord2bin2D(xtmp, ytmp, &nix, &niy);
            // Always put the cluster on the bin of its innermost atom so
            // the cluster should be closer to local clusters
            if(atom->PBCx[ci] > 0 && ix > nix) { ix = nix; }
            if(atom->PBCx[ci] < 0 && ix < nix) { ix = nix; }
            if(atom->PBCy[ci] > 0 && iy > niy) { iy = niy; }
            if(atom->PBCy[ci] < 0 && iy < niy) { iy = niy; }
        }

        int bin = iy * mbinx + ix + 1;
        int c = cluster_bincount[bin];
        cluster_bins[bin * clusters_per_bin + c] = nlocal + ci;
        cluster_bincount[bin]++;
    }
}
