#include <stdio.h>
#include <stdlib.h>

#include <atom.h>

int write_local_atoms_to_vtk_file(const char* filename, Atom* atom, int timestep) {
    char timestep_filename[128];
    snprintf(timestep_filename, sizeof timestep_filename, "%s_local_%d.vtk", filename, timestep);
    FILE* fp = fopen(timestep_filename, "wb");

    if(fp == NULL) {
        fprintf(stderr, "Could not open VTK file for writing!\n");
        return -1;
    }

    fprintf(fp, "# vtk DataFile Version 2.0\n");
    fprintf(fp, "Particle data\n");
    fprintf(fp, "ASCII\n");
    fprintf(fp, "DATASET UNSTRUCTURED_GRID\n");
    fprintf(fp, "POINTS %d double\n", atom->Nlocal);
    for(int ci = 0; ci < atom->Nclusters_local; ++ci) {
        MD_FLOAT *cptr = cluster_pos_ptr(ci);
        for(int cii = 0; cii < atom->clusters[ci].natoms; ++cii) {
            fprintf(fp, "%.4f %.4f %.4f\n", cluster_x(cptr, cii), cluster_y(cptr, cii), cluster_z(cptr, cii));
        }
    }
    fprintf(fp, "\n\n");
    fprintf(fp, "CELLS %d %d\n", atom->Nlocal, atom->Nlocal * 2);
    for(int i = 0; i < atom->Nlocal; ++i) {
        fprintf(fp, "1 %d\n", i);
    }
    fprintf(fp, "\n\n");
    fprintf(fp, "CELL_TYPES %d\n", atom->Nlocal);
    for(int i = 0; i < atom->Nlocal; ++i) {
        fprintf(fp, "1\n");
    }
    fprintf(fp, "\n\n");
    fprintf(fp, "POINT_DATA %d\n", atom->Nlocal);
    fprintf(fp, "SCALARS mass double\n");
    fprintf(fp, "LOOKUP_TABLE default\n");
    for(int i = 0; i < atom->Nlocal; i++) {
        fprintf(fp, "1.0\n");
    }
    fprintf(fp, "\n\n");
    fclose(fp);
    return 0;
}

int write_ghost_atoms_to_vtk_file(const char* filename, Atom* atom, int timestep) {
    char timestep_filename[128];
    snprintf(timestep_filename, sizeof timestep_filename, "%s_ghost_%d.vtk", filename, timestep);
    FILE* fp = fopen(timestep_filename, "wb");

    if(fp == NULL) {
        fprintf(stderr, "Could not open VTK file for writing!\n");
        return -1;
    }

    fprintf(fp, "# vtk DataFile Version 2.0\n");
    fprintf(fp, "Particle data\n");
    fprintf(fp, "ASCII\n");
    fprintf(fp, "DATASET UNSTRUCTURED_GRID\n");
    fprintf(fp, "POINTS %d double\n", atom->Nghost);
    for(int ci = atom->Nclusters_local; ci < atom->Nclusters_local + atom->Nclusters_ghost; ++ci) {
        MD_FLOAT *cptr = cluster_pos_ptr(ci);
        for(int cii = 0; cii < atom->clusters[ci].natoms; ++cii) {
            fprintf(fp, "%.4f %.4f %.4f\n", cluster_x(cptr, cii), cluster_y(cptr, cii), cluster_z(cptr, cii));
        }
    }
    fprintf(fp, "\n\n");
    fprintf(fp, "CELLS %d %d\n", atom->Nghost, atom->Nghost * 2);
    for(int i = 0; i < atom->Nghost; ++i) {
        fprintf(fp, "1 %d\n", i);
    }
    fprintf(fp, "\n\n");
    fprintf(fp, "CELL_TYPES %d\n", atom->Nghost);
    for(int i = 0; i < atom->Nghost; ++i) {
        fprintf(fp, "1\n");
    }
    fprintf(fp, "\n\n");
    fprintf(fp, "POINT_DATA %d\n", atom->Nghost);
    fprintf(fp, "SCALARS mass double\n");
    fprintf(fp, "LOOKUP_TABLE default\n");
    for(int i = 0; i < atom->Nghost; i++) {
        fprintf(fp, "1.0\n");
    }
    fprintf(fp, "\n\n");
    fclose(fp);
    return 0;
}

int write_cluster_edges_to_vtk_file(const char* filename, Atom* atom, int timestep) {
    char timestep_filename[128];
    snprintf(timestep_filename, sizeof timestep_filename, "%s_edges_%d.vtk", filename, timestep);
    FILE* fp = fopen(timestep_filename, "wb");
    int Nclusters_all = atom->Nclusters_local + atom->Nclusters_ghost;
    int tot_lines = 0;
    int i = 0;

    if(fp == NULL) {
        fprintf(stderr, "Could not open VTK file for writing!\n");
        return -1;
    }

    fprintf(fp, "# vtk DataFile Version 2.0\n");
    fprintf(fp, "Particle data\n");
    fprintf(fp, "ASCII\n");
    fprintf(fp, "DATASET POLYDATA\n");
    fprintf(fp, "POINTS %d double\n", atom->Nlocal + atom->Nghost);
    for(int ci = 0; ci < Nclusters_all; ++ci) {
        MD_FLOAT *cptr = cluster_pos_ptr(ci);
        for(int cii = 0; cii < atom->clusters[ci].natoms; ++cii) {
            fprintf(fp, "%.4f %.4f %.4f\n", cluster_x(cptr, cii), cluster_y(cptr, cii), cluster_z(cptr, cii));
        }

        tot_lines += atom->clusters[ci].natoms;
    }
    fprintf(fp, "\n\n");
    fprintf(fp, "LINES %d %d\n", Nclusters_all, Nclusters_all + tot_lines);
    for(int ci = 0; ci < Nclusters_all; ++ci) {
        fprintf(fp, "%d ", atom->clusters[ci].natoms);
        for(int cii = 0; cii < atom->clusters[ci].natoms; ++cii) {
            fprintf(fp, "%d ", i++);
        }

        fprintf(fp, "\n");
    }
    fprintf(fp, "\n\n");
    fclose(fp);
    return 0;
}
