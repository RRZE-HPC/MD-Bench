#include <stdio.h>
#include <stdlib.h>

#include <atom.h>

int write_atoms_to_vtk_file(const char* filename, Atom* atom, int timestep) {
    char timestep_filename[128];
    snprintf(timestep_filename, sizeof timestep_filename, "%s_%d.vtk", filename, timestep);
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
    for(int i = 0; i < atom->Nlocal; ++i) {
        fprintf(fp, "%.4f %.4f %.4f\n", atom_x(i), atom_y(i), atom_z(i));
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
