/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdio.h>
#include <stdlib.h>

#include <atom.h>
#include <force.h>
#include <vtk.h>

void write_data_to_vtk_file(const char* filename, Atom* atom, int timestep)
{
    write_local_atoms_to_vtk_file(filename, atom, timestep);
    write_ghost_atoms_to_vtk_file(filename, atom, timestep);
    write_local_cluster_edges_to_vtk_file(filename, atom, timestep);
    write_ghost_cluster_edges_to_vtk_file(filename, atom, timestep);
}

int write_local_atoms_to_vtk_file(const char* filename, Atom* atom, int timestep)
{
    char timestepFilename[128];
    snprintf(timestepFilename,
        sizeof timestepFilename,
        "%s_local_%d.vtk",
        filename,
        timestep);
    FILE* fp = fopen(timestepFilename, "wb");

    if (fp == NULL) {
        fprintf(stderr, "Could not open VTK file for writing!\n");
        return -1;
    }

    fprintf(fp, "# vtk DataFile Version 2.0\n");
    fprintf(fp, "Particle data\n");
    fprintf(fp, "ASCII\n");
    fprintf(fp, "DATASET UNSTRUCTURED_GRID\n");
    fprintf(fp, "POINTS %d double\n", atom->Nlocal);
    for (int ci = 0; ci < atom->Nclusters_local; ++ci) {
        int ciVecBase = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT* ciX = &atom->cl_x[ciVecBase];
        for (int cii = 0; cii < atom->iclusters[ci].natoms; ++cii) {
            fprintf(fp,
                "%.4f %.4f %.4f\n",
                ciX[CL_X_OFFSET + cii],
                ciX[CL_Y_OFFSET + cii],
                ciX[CL_Z_OFFSET + cii]);
        }
    }
    fprintf(fp, "\n\n");
    fprintf(fp, "CELLS %d %d\n", atom->Nlocal, atom->Nlocal * 2);
    for (int i = 0; i < atom->Nlocal; ++i) {
        fprintf(fp, "1 %d\n", i);
    }
    fprintf(fp, "\n\n");
    fprintf(fp, "CELL_TYPES %d\n", atom->Nlocal);
    for (int i = 0; i < atom->Nlocal; ++i) {
        fprintf(fp, "1\n");
    }
    fprintf(fp, "\n\n");
    fprintf(fp, "POINT_DATA %d\n", atom->Nlocal);
    fprintf(fp, "SCALARS mass double\n");
    fprintf(fp, "LOOKUP_TABLE default\n");
    for (int i = 0; i < atom->Nlocal; i++) {
        fprintf(fp, "1.0\n");
    }
    fprintf(fp, "\n\n");
    fclose(fp);
    return 0;
}

int write_ghost_atoms_to_vtk_file(const char* filename, Atom* atom, int timestep)
{
    char timestepFilename[128];
    snprintf(timestepFilename,
        sizeof timestepFilename,
        "%s_ghost_%d.vtk",
        filename,
        timestep);
    FILE* fp = fopen(timestepFilename, "wb");

    if (fp == NULL) {
        fprintf(stderr, "Could not open VTK file for writing!\n");
        return -1;
    }

    fprintf(fp, "# vtk DataFile Version 2.0\n");
    fprintf(fp, "Particle data\n");
    fprintf(fp, "ASCII\n");
    fprintf(fp, "DATASET UNSTRUCTURED_GRID\n");
    fprintf(fp, "POINTS %d double\n", atom->Nghost);
    for (int ci = atom->Nclusters_local;
         ci < atom->Nclusters_local + atom->Nclusters_ghost;
         ++ci) {
        int ciVecBase = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT* ciX = &atom->cl_x[ciVecBase];
        for (int cii = 0; cii < atom->iclusters[ci].natoms; ++cii) {
            fprintf(fp,
                "%.4f %.4f %.4f\n",
                ciX[CL_X_OFFSET + cii],
                ciX[CL_Y_OFFSET + cii],
                ciX[CL_Z_OFFSET + cii]);
        }
    }
    fprintf(fp, "\n\n");
    fprintf(fp, "CELLS %d %d\n", atom->Nghost, atom->Nghost * 2);
    for (int i = 0; i < atom->Nghost; ++i) {
        fprintf(fp, "1 %d\n", i);
    }
    fprintf(fp, "\n\n");
    fprintf(fp, "CELL_TYPES %d\n", atom->Nghost);
    for (int i = 0; i < atom->Nghost; ++i) {
        fprintf(fp, "1\n");
    }
    fprintf(fp, "\n\n");
    fprintf(fp, "POINT_DATA %d\n", atom->Nghost);
    fprintf(fp, "SCALARS mass double\n");
    fprintf(fp, "LOOKUP_TABLE default\n");
    for (int i = 0; i < atom->Nghost; i++) {
        fprintf(fp, "1.0\n");
    }
    fprintf(fp, "\n\n");
    fclose(fp);
    return 0;
}

int write_local_cluster_edges_to_vtk_file(const char* filename, Atom* atom, int timestep)
{
    char timestepFilename[128];
    snprintf(timestepFilename,
        sizeof timestepFilename,
        "%s_local_edges_%d.vtk",
        filename,
        timestep);
    FILE* fp     = fopen(timestepFilename, "wb");
    int N        = atom->Nclusters_local;
    int totLines = 0;
    int i        = 0;

    if (fp == NULL) {
        fprintf(stderr, "Could not open VTK file for writing!\n");
        return -1;
    }

    fprintf(fp, "# vtk DataFile Version 2.0\n");
    fprintf(fp, "Particle data\n");
    fprintf(fp, "ASCII\n");
    fprintf(fp, "DATASET POLYDATA\n");
    fprintf(fp, "POINTS %d double\n", atom->Nlocal);
    for (int ci = 0; ci < N; ++ci) {
        int ciVecBase = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT* ciX = &atom->cl_x[ciVecBase];
        for (int cii = 0; cii < atom->iclusters[ci].natoms; ++cii) {
            fprintf(fp,
                "%.4f %.4f %.4f\n",
                ciX[CL_X_OFFSET + cii],
                ciX[CL_Y_OFFSET + cii],
                ciX[CL_Z_OFFSET + cii]);
        }

        totLines += atom->iclusters[ci].natoms;
    }
    fprintf(fp, "\n\n");
    fprintf(fp, "LINES %d %d\n", N, N + totLines);
    for (int ci = 0; ci < N; ++ci) {
        fprintf(fp, "%d ", atom->iclusters[ci].natoms);
        for (int cii = 0; cii < atom->iclusters[ci].natoms; ++cii) {
            fprintf(fp, "%d ", i++);
        }

        fprintf(fp, "\n");
    }
    fprintf(fp, "\n\n");
    fclose(fp);
    return 0;
}

int write_ghost_cluster_edges_to_vtk_file(const char* filename, Atom* atom, int timestep)
{
    char timestepFilename[128];
    snprintf(timestepFilename,
        sizeof timestepFilename,
        "%s_ghost_edges_%d.vtk",
        filename,
        timestep);
    FILE* fp     = fopen(timestepFilename, "wb");
    int N        = atom->Nclusters_local + atom->Nclusters_ghost;
    int totLines = 0;
    int i        = 0;

    if (fp == NULL) {
        fprintf(stderr, "Could not open VTK file for writing!\n");
        return -1;
    }

    fprintf(fp, "# vtk DataFile Version 2.0\n");
    fprintf(fp, "Particle data\n");
    fprintf(fp, "ASCII\n");
    fprintf(fp, "DATASET POLYDATA\n");
    fprintf(fp, "POINTS %d double\n", atom->Nghost);
    for (int ci = atom->Nclusters_local; ci < N; ++ci) {
        int ciVecBase = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT* ciX = &atom->cl_x[ciVecBase];
        for (int cii = 0; cii < atom->iclusters[ci].natoms; ++cii) {
            fprintf(fp,
                "%.4f %.4f %.4f\n",
                ciX[CL_X_OFFSET + cii],
                ciX[CL_Y_OFFSET + cii],
                ciX[CL_Z_OFFSET + cii]);
        }

        totLines += atom->iclusters[ci].natoms;
    }
    fprintf(fp, "\n\n");
    fprintf(fp, "LINES %d %d\n", atom->Nclusters_ghost, atom->Nclusters_ghost + totLines);
    for (int ci = atom->Nclusters_local; ci < N; ++ci) {
        fprintf(fp, "%d ", atom->iclusters[ci].natoms);
        for (int cii = 0; cii < atom->iclusters[ci].natoms; ++cii) {
            fprintf(fp, "%d ", i++);
        }

        fprintf(fp, "\n");
    }
    fprintf(fp, "\n\n");
    fclose(fp);
    return 0;
}
