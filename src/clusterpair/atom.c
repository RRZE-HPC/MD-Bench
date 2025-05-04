/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <allocate.h>
#include <atom.h>
#include <force.h>
#include <util.h>

inline int get_ncj_from_nci(int nci)
{
#if CLUSTER_M == CLUSTER_N
    return nci;
#elif CLUSTER_M < CLUSTER_N
    return nci >> 1;
#else
    return nci << 1;
#endif
}

void initAtom(Atom* atom)
{
    atom->x               = NULL;
    atom->y               = NULL;
    atom->z               = NULL;
    atom->vx              = NULL;
    atom->vy              = NULL;
    atom->vz              = NULL;
    atom->cl_x            = NULL;
    atom->cl_v            = NULL;
    atom->cl_f            = NULL;
    atom->cl_t            = NULL;
    atom->Natoms          = 0;
    atom->Nlocal          = 0;
    atom->Nghost          = 0;
    atom->Nmax            = 0;
    atom->Nclusters       = 0;
    atom->Nclusters_local = 0;
    atom->Nclusters_ghost = 0;
    atom->Nclusters_max   = 0;
    atom->type            = NULL;
    atom->ntypes          = 0;
    atom->epsilon         = NULL;
    atom->sigma6          = NULL;
    atom->cutforcesq      = NULL;
    atom->cutneighsq      = NULL;
    atom->iclusters       = NULL;
    atom->jclusters       = NULL;
    atom->icluster_bin    = NULL;
    initMasks(atom);
}

void createAtom(Atom* atom, Parameter* param)
{
    MD_FLOAT xlo  = 0.0;
    MD_FLOAT xhi  = param->xprd;
    MD_FLOAT ylo  = 0.0;
    MD_FLOAT yhi  = param->yprd;
    MD_FLOAT zlo  = 0.0;
    MD_FLOAT zhi  = param->zprd;
    atom->Natoms  = 4 * param->nx * param->ny * param->nz;
    atom->Nlocal  = 0;
    atom->ntypes  = param->ntypes;
    atom->epsilon = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    atom->sigma6  = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    atom->cutforcesq = allocate(ALIGNMENT,
        atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    atom->cutneighsq = allocate(ALIGNMENT,
        atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));

    for (int i = 0; i < atom->ntypes * atom->ntypes; i++) {
        atom->epsilon[i]    = param->epsilon;
        atom->sigma6[i]     = param->sigma6;
        atom->cutneighsq[i] = param->cutneigh * param->cutneigh;
        atom->cutforcesq[i] = param->cutforce * param->cutforce;
    }

    MD_FLOAT alat = pow((4.0 / param->rho), (1.0 / 3.0));
    int ilo       = (int)(xlo / (0.5 * alat) - 1);
    int ihi       = (int)(xhi / (0.5 * alat) + 1);
    int jlo       = (int)(ylo / (0.5 * alat) - 1);
    int jhi       = (int)(yhi / (0.5 * alat) + 1);
    int klo       = (int)(zlo / (0.5 * alat) - 1);
    int khi       = (int)(zhi / (0.5 * alat) + 1);

    ilo = MAX(ilo, 0);
    ihi = MIN(ihi, 2 * param->nx - 1);
    jlo = MAX(jlo, 0);
    jhi = MIN(jhi, 2 * param->ny - 1);
    klo = MAX(klo, 0);
    khi = MIN(khi, 2 * param->nz - 1);

    MD_FLOAT xtmp, ytmp, ztmp, vxtmp, vytmp, vztmp;
    int i, j, k, m, n;
    int sx        = 0;
    int sy        = 0;
    int sz        = 0;
    int ox        = 0;
    int oy        = 0;
    int oz        = 0;
    int subboxdim = 8;

    while (oz * subboxdim <= khi) {
        k = oz * subboxdim + sz;
        j = oy * subboxdim + sy;
        i = ox * subboxdim + sx;

        if (((i + j + k) % 2 == 0) && (i >= ilo) && (i <= ihi) && (j >= jlo) &&
            (j <= jhi) && (k >= klo) && (k <= khi)) {
            xtmp = 0.5 * alat * i;
            ytmp = 0.5 * alat * j;
            ztmp = 0.5 * alat * k;

            if (xtmp >= xlo && xtmp < xhi && ytmp >= ylo && ytmp < yhi && ztmp >= zlo &&
                ztmp < zhi) {
                n = k * (2 * param->ny) * (2 * param->nx) + j * (2 * param->nx) + i + 1;
                for (m = 0; m < 5; m++) {
                    myrandom(&n);
                }
                vxtmp = myrandom(&n);
                for (m = 0; m < 5; m++) {
                    myrandom(&n);
                }
                vytmp = myrandom(&n);
                for (m = 0; m < 5; m++) {
                    myrandom(&n);
                }
                vztmp = myrandom(&n);

                if (atom->Nlocal == atom->Nmax) {
                    growAtom(atom);
                }
                atom_x(atom->Nlocal)     = xtmp;
                atom_y(atom->Nlocal)     = ytmp;
                atom_z(atom->Nlocal)     = ztmp;
                atom->vx[atom->Nlocal]   = vxtmp;
                atom->vy[atom->Nlocal]   = vytmp;
                atom->vz[atom->Nlocal]   = vztmp;
                atom->type[atom->Nlocal] = rand() % atom->ntypes;
                atom->Nlocal++;
            }
        }

        sx++;
        if (sx == subboxdim) {
            sx = 0;
            sy++;
        }
        if (sy == subboxdim) {
            sy = 0;
            sz++;
        }
        if (sz == subboxdim) {
            sz = 0;
            ox++;
        }
        if (ox * subboxdim > ihi) {
            ox = 0;
            oy++;
        }
        if (oy * subboxdim > jhi) {
            oy = 0;
            oz++;
        }
    }
}

int typeStr2int(const char* type)
{
    if (strncmp(type, "Ar", 2) == 0) {
        return 0;
    } // Argon
    fprintf(stderr, "Invalid atom type: %s\n", type);
    exit(-1);
    return -1;
}

int readAtom(Atom* atom, Parameter* param)
{
    int len = strlen(param->input_file);
    if (strncmp(&param->input_file[len - 4], ".pdb", 4) == 0) {
        return readAtomPdb(atom, param);
    }
    if (strncmp(&param->input_file[len - 4], ".gro", 4) == 0) {
        return readAtomGro(atom, param);
    }
    if (strncmp(&param->input_file[len - 4], ".dmp", 4) == 0) {
        return readAtomDmp(atom, param);
    }
    fprintf(stderr,
        "Invalid input file extension: %s\nValid choices are: pdb, gro, dmp\n",
        param->input_file);
    exit(-1);
    return -1;
}

int readAtomPdb(Atom* atom, Parameter* param)
{
    FILE* fp = fopen(param->input_file, "r");
    char line[MAXLINE];
    int readAtoms = 0;

    if (!fp) {
        fprintf(stderr, "Could not open input file: %s\n", param->input_file);
        exit(-1);
        return -1;
    }

    while (!feof(fp)) {
        readline(line, fp);
        char* item = strtok(line, " ");
        if (strncmp(item, "CRYST1", 6) == 0) {
            param->xlo  = 0.0;
            param->xhi  = atof(strtok(NULL, " "));
            param->ylo  = 0.0;
            param->yhi  = atof(strtok(NULL, " "));
            param->zlo  = 0.0;
            param->zhi  = atof(strtok(NULL, " "));
            param->xprd = param->xhi - param->xlo;
            param->yprd = param->yhi - param->ylo;
            param->zprd = param->zhi - param->zlo;
            // alpha, beta, gamma, sGroup, z
        } else if (strncmp(item, "ATOM", 4) == 0) {
            char* label;
            int atomId, compId;
            MD_FLOAT occupancy, charge;
            atomId = atoi(strtok(NULL, " ")) - 1;

            while (atomId + 1 >= atom->Nmax) {
                growAtom(atom);
            }

            atom->type[atomId] = typeStr2int(strtok(NULL, " "));
            label              = strtok(NULL, " ");
            compId             = atoi(strtok(NULL, " "));
            atom_x(atomId)     = atof(strtok(NULL, " "));
            atom_y(atomId)     = atof(strtok(NULL, " "));
            atom_z(atomId)     = atof(strtok(NULL, " "));
            atom->vx[atomId]   = 0.0;
            atom->vy[atomId]   = 0.0;
            atom->vz[atomId]   = 0.0;
            occupancy          = atof(strtok(NULL, " "));
            charge             = atof(strtok(NULL, " "));
            atom->ntypes       = MAX(atom->type[atomId] + 1, atom->ntypes);
            atom->Natoms++;
            atom->Nlocal++;
            readAtoms++;
        } else if (strncmp(item, "HEADER", 6) == 0 || strncmp(item, "REMARK", 6) == 0 ||
                   strncmp(item, "MODEL", 5) == 0 || strncmp(item, "TER", 3) == 0 ||
                   strncmp(item, "ENDMDL", 6) == 0) {
            // Do nothing
        } else {
            fprintf(stderr, "Invalid item: %s\n", item);
            exit(-1);
            return -1;
        }
    }

    if (!readAtoms) {
        fprintf(stderr, "Input error: No atoms read!\n");
        exit(-1);
        return -1;
    }

    atom->epsilon = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    atom->sigma6  = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    atom->cutforcesq = allocate(ALIGNMENT,
        atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    atom->cutneighsq = allocate(ALIGNMENT,
        atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    for (int i = 0; i < atom->ntypes * atom->ntypes; i++) {
        atom->epsilon[i]    = param->epsilon;
        atom->sigma6[i]     = param->sigma6;
        atom->cutneighsq[i] = param->cutneigh * param->cutneigh;
        atom->cutforcesq[i] = param->cutforce * param->cutforce;
    }

    fprintf(stdout, "Read %d atoms from %s\n", readAtoms, param->input_file);
    fclose(fp);
    return readAtoms;
}

int readAtomGro(Atom* atom, Parameter* param)
{
    FILE* fp = fopen(param->input_file, "r");
    char line[MAXLINE];
    char desc[MAXLINE];
    int readAtoms   = 0;
    int atomsToRead = 0;
    int i           = 0;

    if (!fp) {
        fprintf(stderr, "Could not open input file: %s\n", param->input_file);
        exit(-1);
        return -1;
    }

    readline(desc, fp);
    for (i = 0; desc[i] != '\n'; i++)
        ;
    desc[i] = '\0';
    readline(line, fp);
    atomsToRead = atoi(strtok(line, " "));
    fprintf(stdout, "System: %s with %d atoms\n", desc, atomsToRead);

    while (!feof(fp) && readAtoms < atomsToRead) {
        readline(line, fp);
        char* label = strtok(line, " ");
        int type    = typeStr2int(strtok(NULL, " "));
        int atomId  = atoi(strtok(NULL, " ")) - 1;
        atomId      = readAtoms;
        while (atomId + 1 >= atom->Nmax) {
            growAtom(atom);
        }

        atom->type[atomId] = type;
        atom_x(atomId)     = atof(strtok(NULL, " "));
        atom_y(atomId)     = atof(strtok(NULL, " "));
        atom_z(atomId)     = atof(strtok(NULL, " "));
        atom->vx[atomId]   = atof(strtok(NULL, " "));
        atom->vy[atomId]   = atof(strtok(NULL, " "));
        atom->vz[atomId]   = atof(strtok(NULL, " "));
        atom->ntypes       = MAX(atom->type[atomId] + 1, atom->ntypes);
        atom->Natoms++;
        atom->Nlocal++;
        readAtoms++;
    }

    if (!feof(fp)) {
        readline(line, fp);
        param->xlo  = 0.0;
        param->xhi  = atof(strtok(line, " "));
        param->ylo  = 0.0;
        param->yhi  = atof(strtok(NULL, " "));
        param->zlo  = 0.0;
        param->zhi  = atof(strtok(NULL, " "));
        param->xprd = param->xhi - param->xlo;
        param->yprd = param->yhi - param->ylo;
        param->zprd = param->zhi - param->zlo;
    }

    if (readAtoms != atomsToRead) {
        fprintf(stderr,
            "Input error: Number of atoms read do not match (%d/%d).\n",
            readAtoms,
            atomsToRead);
        exit(-1);
        return -1;
    }

    atom->epsilon = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    atom->sigma6  = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    atom->cutforcesq = allocate(ALIGNMENT,
        atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    atom->cutneighsq = allocate(ALIGNMENT,
        atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    for (int i = 0; i < atom->ntypes * atom->ntypes; i++) {
        atom->epsilon[i]    = param->epsilon;
        atom->sigma6[i]     = param->sigma6;
        atom->cutneighsq[i] = param->cutneigh * param->cutneigh;
        atom->cutforcesq[i] = param->cutforce * param->cutforce;
    }

    fprintf(stdout, "Read %d atoms from %s\n", readAtoms, param->input_file);
    fclose(fp);
    return readAtoms;
}

int readAtomDmp(Atom* atom, Parameter* param)
{
    FILE* fp = fopen(param->input_file, "r");
    char line[MAXLINE];
    int natoms    = 0;
    int readAtoms = 0;
    int atomId    = -1;
    int ts        = -1;

    if (!fp) {
        fprintf(stderr, "Could not open input file: %s\n", param->input_file);
        exit(-1);
        return -1;
    }

    while (!feof(fp) && ts < 1 && !readAtoms) {
        readline(line, fp);
        if (strncmp(line, "ITEM: ", 6) == 0) {
            char* item = &line[6];

            if (strncmp(item, "TIMESTEP", 8) == 0) {
                readline(line, fp);
                ts = atoi(line);
            } else if (strncmp(item, "NUMBER OF ATOMS", 15) == 0) {
                readline(line, fp);
                natoms       = atoi(line);
                atom->Natoms = natoms;
                atom->Nlocal = natoms;
                while (atom->Nlocal >= atom->Nmax) {
                    growAtom(atom);
                }
            } else if (strncmp(item, "BOX BOUNDS pp pp pp", 19) == 0) {
                readline(line, fp);
                param->xlo  = atof(strtok(line, " "));
                param->xhi  = atof(strtok(NULL, " "));
                param->xprd = param->xhi - param->xlo;

                readline(line, fp);
                param->ylo  = atof(strtok(line, " "));
                param->yhi  = atof(strtok(NULL, " "));
                param->yprd = param->yhi - param->ylo;

                readline(line, fp);
                param->zlo  = atof(strtok(line, " "));
                param->zhi  = atof(strtok(NULL, " "));
                param->zprd = param->zhi - param->zlo;
            } else if (strncmp(item, "ATOMS id type x y z vx vy vz", 28) == 0) {
                for (int i = 0; i < natoms; i++) {
                    readline(line, fp);
                    atomId             = atoi(strtok(line, " ")) - 1;
                    atom->type[atomId] = atoi(strtok(NULL, " "));
                    atom_x(atomId)     = atof(strtok(NULL, " "));
                    atom_y(atomId)     = atof(strtok(NULL, " "));
                    atom_z(atomId)     = atof(strtok(NULL, " "));
                    atom->vx[atomId]   = atof(strtok(NULL, " "));
                    atom->vy[atomId]   = atof(strtok(NULL, " "));
                    atom->vz[atomId]   = atof(strtok(NULL, " "));
                    atom->ntypes       = MAX(atom->type[atomId], atom->ntypes);
                    readAtoms++;
                }
            } else {
                fprintf(stderr, "Invalid item: %s\n", item);
                exit(-1);
                return -1;
            }
        } else {
            fprintf(stderr,
                "Invalid input from file, expected item reference but got:\n%s\n",
                line);
            exit(-1);
            return -1;
        }
    }

    if (ts < 0 || !natoms || !readAtoms) {
        fprintf(stderr, "Input error: atom data was not read!\n");
        exit(-1);
        return -1;
    }

    atom->epsilon = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    atom->sigma6  = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    atom->cutforcesq = allocate(ALIGNMENT,
        atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    atom->cutneighsq = allocate(ALIGNMENT,
        atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    for (int i = 0; i < atom->ntypes * atom->ntypes; i++) {
        atom->epsilon[i]    = param->epsilon;
        atom->sigma6[i]     = param->sigma6;
        atom->cutneighsq[i] = param->cutneigh * param->cutneigh;
        atom->cutforcesq[i] = param->cutforce * param->cutforce;
    }

    fprintf(stdout, "Read %d atoms from %s\n", natoms, param->input_file);
    fclose(fp);
    return natoms;
}

void initMasks(Atom* atom)
{
    const unsigned int halfMaskBits = VECTOR_WIDTH >> 1;
    unsigned int mask0, mask1, mask2, mask3;

    atom->exclusion_filter        = allocate(ALIGNMENT,
        CLUSTER_M * VECTOR_WIDTH * sizeof(MD_UINT));
    atom->diagonal_4xn_j_minus_i  = allocate(ALIGNMENT,
        MAX(CLUSTER_M, VECTOR_WIDTH) * sizeof(MD_UINT));
    atom->diagonal_2xnn_j_minus_i = allocate(ALIGNMENT, VECTOR_WIDTH * sizeof(MD_UINT));
    // atom->masks_2xnn = allocate(ALIGNMENT, 8 * sizeof(unsigned int));

    for (int j = 0; j < MAX(CLUSTER_M, VECTOR_WIDTH); j++) {
        atom->diagonal_4xn_j_minus_i[j] = (MD_FLOAT)(j)-0.5;
    }

    for (int j = 0; j < VECTOR_WIDTH / 2; j++) {
        atom->diagonal_2xnn_j_minus_i[j]                    = (MD_FLOAT)(j)-0.5;
        atom->diagonal_2xnn_j_minus_i[VECTOR_WIDTH / 2 + j] = (MD_FLOAT)(j - 1) - 0.5;
    }

    for (int i = 0; i < CLUSTER_M * VECTOR_WIDTH; i++) {
        atom->exclusion_filter[i] = (1U << i);
    }

#if CLUSTER_M == CLUSTER_N
    for (unsigned int cond0 = 0; cond0 < 2; cond0++) {
        mask0                              = (unsigned int)(0xf - 0x1 * cond0);
        mask1                              = (unsigned int)(0xf - 0x3 * cond0);
        mask2                              = (unsigned int)(0xf - 0x7 * cond0);
        mask3                              = (unsigned int)(0xf - 0xf * cond0);
        atom->masks_2xnn_hn[cond0 * 2 + 0] = (mask1 << halfMaskBits) | mask0;
        atom->masks_2xnn_hn[cond0 * 2 + 1] = (mask3 << halfMaskBits) | mask2;

        mask0                              = (unsigned int)(0xf - 0x1 * cond0);
        mask1                              = (unsigned int)(0xf - 0x2 * cond0);
        mask2                              = (unsigned int)(0xf - 0x4 * cond0);
        mask3                              = (unsigned int)(0xf - 0x8 * cond0);
        atom->masks_2xnn_fn[cond0 * 2 + 0] = (mask1 << halfMaskBits) | mask0;
        atom->masks_2xnn_fn[cond0 * 2 + 1] = (mask3 << halfMaskBits) | mask2;

        atom->masks_4xn_hn[cond0 * 4 + 0] = (unsigned int)(0xf - 0x1 * cond0);
        atom->masks_4xn_hn[cond0 * 4 + 1] = (unsigned int)(0xf - 0x3 * cond0);
        atom->masks_4xn_hn[cond0 * 4 + 2] = (unsigned int)(0xf - 0x7 * cond0);
        atom->masks_4xn_hn[cond0 * 4 + 3] = (unsigned int)(0xf - 0xf * cond0);

        atom->masks_4xn_fn[cond0 * 4 + 0] = (unsigned int)(0xf - 0x1 * cond0);
        atom->masks_4xn_fn[cond0 * 4 + 1] = (unsigned int)(0xf - 0x2 * cond0);
        atom->masks_4xn_fn[cond0 * 4 + 2] = (unsigned int)(0xf - 0x4 * cond0);
        atom->masks_4xn_fn[cond0 * 4 + 3] = (unsigned int)(0xf - 0x8 * cond0);

        atom->masks_2xn_hn[cond0 * 2 + 0] = (unsigned int)(0x3 - 0x1 * cond0);
        atom->masks_2xn_hn[cond0 * 2 + 1] = (unsigned int)(0x3 - 0x3 * cond0);

        atom->masks_2xn_fn[cond0 * 2 + 0] = (unsigned int)(0x3 - 0x1 * cond0);
        atom->masks_2xn_fn[cond0 * 2 + 1] = (unsigned int)(0x3 - 0x2 * cond0);
    }
#else
    for (unsigned int cond0 = 0; cond0 < 2; cond0++) {
        for (unsigned int cond1 = 0; cond1 < 2; cond1++) {
#if CLUSTER_M < CLUSTER_N
            mask0 = (unsigned int)(0xff - 0x1 * cond0 - 0x1f * cond1);
            mask1 = (unsigned int)(0xff - 0x3 * cond0 - 0x3f * cond1);
            mask2 = (unsigned int)(0xff - 0x7 * cond0 - 0x7f * cond1);
            mask3 = (unsigned int)(0xff - 0xf * cond0 - 0xff * cond1);
#else
            mask0 = (unsigned int)(0x3 - 0x1 * cond0);
            mask1 = (unsigned int)(0x3 - 0x3 * cond0);
            mask2 = (unsigned int)(0x3 - cond0 * 0x3 - 0x1 * cond1);
            mask3 = (unsigned int)(0x3 - cond0 * 0x3 - 0x3 * cond1);
#endif

            atom->masks_2xnn_hn[cond0 * 4 + cond1 * 2 + 0] = (mask1 << halfMaskBits) |
                                                             mask0;
            atom->masks_2xnn_hn[cond0 * 4 + cond1 * 2 + 1] = (mask3 << halfMaskBits) |
                                                             mask2;

#if CLUSTER_M < CLUSTER_N
            mask0 = (unsigned int)(0xff - 0x1 * cond0 - 0x10 * cond1);
            mask1 = (unsigned int)(0xff - 0x2 * cond0 - 0x20 * cond1);
            mask2 = (unsigned int)(0xff - 0x4 * cond0 - 0x40 * cond1);
            mask3 = (unsigned int)(0xff - 0x8 * cond0 - 0x80 * cond1);
#else
            mask0 = (unsigned int)(0x3 - 0x1 * cond0);
            mask1 = (unsigned int)(0x3 - 0x2 * cond0);
            mask2 = (unsigned int)(0x3 - 0x1 * cond1);
            mask3 = (unsigned int)(0x3 - 0x2 * cond1);
#endif

            atom->masks_2xnn_fn[cond0 * 4 + cond1 * 2 + 0] = (mask1 << halfMaskBits) |
                                                             mask0;
            atom->masks_2xnn_fn[cond0 * 4 + cond1 * 2 + 1] = (mask3 << halfMaskBits) |
                                                             mask2;

#if CLUSTER_M < CLUSTER_N
            atom->masks_4xn_hn[cond0 * 8 + cond1 * 4 + 0] = (unsigned int)(0xff -
                                                                           0x1 * cond0 -
                                                                           0x1f * cond1);
            atom->masks_4xn_hn[cond0 * 8 + cond1 * 4 + 1] = (unsigned int)(0xff -
                                                                           0x3 * cond0 -
                                                                           0x3f * cond1);
            atom->masks_4xn_hn[cond0 * 8 + cond1 * 4 + 2] = (unsigned int)(0xff -
                                                                           0x7 * cond0 -
                                                                           0x7f * cond1);
            atom->masks_4xn_hn[cond0 * 8 + cond1 * 4 + 3] = (unsigned int)(0xff -
                                                                           0xf * cond0 -
                                                                           0xff * cond1);

            atom->masks_4xn_fn[cond0 * 8 + cond1 * 4 + 0] = (unsigned int)(0xff -
                                                                           0x1 * cond0 -
                                                                           0x10 * cond1);
            atom->masks_4xn_fn[cond0 * 8 + cond1 * 4 + 1] = (unsigned int)(0xff -
                                                                           0x2 * cond0 -
                                                                           0x20 * cond1);
            atom->masks_4xn_fn[cond0 * 8 + cond1 * 4 + 2] = (unsigned int)(0xff -
                                                                           0x4 * cond0 -
                                                                           0x40 * cond1);
            atom->masks_4xn_fn[cond0 * 8 + cond1 * 4 + 3] = (unsigned int)(0xff -
                                                                           0x8 * cond0 -
                                                                           0x80 * cond1);
#else
            atom->masks_4xn_hn[cond0 * 8 + cond1 * 4 + 0] = (unsigned int)(0x3 -
                                                                           0x1 * cond0);
            atom->masks_4xn_hn[cond0 * 8 + cond1 * 4 + 1] = (unsigned int)(0x3 -
                                                                           0x3 * cond0);
            atom->masks_4xn_hn[cond0 * 8 + cond1 * 4 + 2] = (unsigned int)(0x3 -
                                                                           0x3 * cond0 -
                                                                           0x1 * cond1);
            atom->masks_4xn_hn[cond0 * 8 + cond1 * 4 + 3] = (unsigned int)(0x3 -
                                                                           0x3 * cond0 -
                                                                           0x3 * cond1);

            atom->masks_4xn_fn[cond0 * 8 + cond1 * 4 + 0] = (unsigned int)(0x3 -
                                                                           0x1 * cond0);
            atom->masks_4xn_fn[cond0 * 8 + cond1 * 4 + 1] = (unsigned int)(0x3 -
                                                                           0x2 * cond0);
            atom->masks_4xn_fn[cond0 * 8 + cond1 * 4 + 2] = (unsigned int)(0x3 -
                                                                           0x1 * cond1);
            atom->masks_4xn_fn[cond0 * 8 + cond1 * 4 + 3] = (unsigned int)(0x3 -
                                                                           0x2 * cond1);
#endif
        }
    }
#endif
}

void growAtom(Atom* atom)
{
    int nold = atom->Nmax;
    atom->Nmax += DELTA;

#ifdef AOS
    atom->x = (MD_FLOAT*)reallocate(atom->x,
        ALIGNMENT,
        atom->Nmax * sizeof(MD_FLOAT) * 3,
        nold * sizeof(MD_FLOAT) * 3);
#else
    atom->x = (MD_FLOAT*)reallocate(atom->x,
        ALIGNMENT,
        atom->Nmax * sizeof(MD_FLOAT),
        nold * sizeof(MD_FLOAT));
    atom->y = (MD_FLOAT*)reallocate(atom->y,
        ALIGNMENT,
        atom->Nmax * sizeof(MD_FLOAT),
        nold * sizeof(MD_FLOAT));
    atom->z = (MD_FLOAT*)reallocate(atom->z,
        ALIGNMENT,
        atom->Nmax * sizeof(MD_FLOAT),
        nold * sizeof(MD_FLOAT));
#endif
    atom->vx   = (MD_FLOAT*)reallocate(atom->vx,
        ALIGNMENT,
        atom->Nmax * sizeof(MD_FLOAT),
        nold * sizeof(MD_FLOAT));
    atom->vy   = (MD_FLOAT*)reallocate(atom->vy,
        ALIGNMENT,
        atom->Nmax * sizeof(MD_FLOAT),
        nold * sizeof(MD_FLOAT));
    atom->vz   = (MD_FLOAT*)reallocate(atom->vz,
        ALIGNMENT,
        atom->Nmax * sizeof(MD_FLOAT),
        nold * sizeof(MD_FLOAT));
    atom->type = (int*)
        reallocate(atom->type, ALIGNMENT, atom->Nmax * sizeof(int), nold * sizeof(int));
}

void growClusters(Atom* atom)
{
    int nold  = atom->Nclusters_max;
    int jterm = MAX(1,
        CLUSTER_M / CLUSTER_N); // If M>N, we need to allocate more j-clusters
    atom->Nclusters_max += DELTA;
    atom->iclusters    = (Cluster*)reallocate(atom->iclusters,
        ALIGNMENT,
        atom->Nclusters_max * sizeof(Cluster),
        nold * sizeof(Cluster));
    atom->jclusters    = (Cluster*)reallocate(atom->jclusters,
        ALIGNMENT,
        atom->Nclusters_max * jterm * sizeof(Cluster),
        nold * jterm * sizeof(Cluster));
    atom->icluster_bin = (int*)reallocate(atom->icluster_bin,
        ALIGNMENT,
        atom->Nclusters_max * sizeof(int),
        nold * sizeof(int));
    atom->cl_x         = (MD_FLOAT*)reallocate(atom->cl_x,
        ALIGNMENT,
        atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT),
        nold * CLUSTER_M * 3 * sizeof(MD_FLOAT));
    atom->cl_f         = (MD_FLOAT*)reallocate(atom->cl_f,
        ALIGNMENT,
        atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT),
        nold * CLUSTER_M * 3 * sizeof(MD_FLOAT));
    atom->cl_v         = (MD_FLOAT*)reallocate(atom->cl_v,
        ALIGNMENT,
        atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT),
        nold * CLUSTER_M * 3 * sizeof(MD_FLOAT));
    atom->cl_t         = (int*)reallocate(atom->cl_t,
        ALIGNMENT,
        atom->Nclusters_max * CLUSTER_M * sizeof(int),
        nold * CLUSTER_M * sizeof(int));
}
