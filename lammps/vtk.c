/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <atom.h>
#include <comm.h>
#include <mpi.h>

static MPI_File _fh; 

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


void vtkOpen(const char* filename, Comm* comm, Atom* atom ,int timestep)
{
    char msg[256];
    char timestep_filename[128];
    snprintf(timestep_filename, sizeof timestep_filename, "%s_%d.vtk", filename, timestep);
    
    MPI_File_open(MPI_COMM_WORLD, timestep_filename, MPI_MODE_WRONLY | MPI_MODE_CREATE, MPI_INFO_NULL, &_fh);
    
    if(_fh == MPI_FILE_NULL) {
        if(comm->myproc == 0) printf(stderr, "Could not open VTK file for writing!\n");
        return -1;
    }

    if (comm->myproc==0){
    
        sprintf(msg, "# vtk DataFile Version 2.0\n");
        sprintf(msg, "%sParticle data\n",msg);
        sprintf(msg, "%sASCII\n",msg);
        sprintf(msg, "%sDATASET UNSTRUCTURED_GRID\n",msg);
        sprintf(msg, "%sPOINTS %d double\n",msg, atom->Natoms);    
    } 
    
    MPI_File_write(_fh, msg, strlen(msg), MPI_CHAR, MPI_STATUS_IGNORE);  
}

void vtkVector(Comm* comm, Atom* atom)
{ 
    if (_fh == MPI_FILE_NULL) {
        if(comm->myproc==0) printf("vtk not initialize! Call vtkOpen first!\n");
        return;
    }

    int sizeline= 21;   //# of characters in "%.4f %.4f %.4f\n" 
    int mysize= sizeline*atom->Nlocal;
    int gatherSize[comm->numproc]; 
    MPI_Allgather(&mysize, 1, MPI_INT, gatherSize, 1, MPI_INT, MPI_COMM_WORLD);
   
    int offset=0;
    for(int i = 0; i < comm->myproc; i++)
        offset+= gatherSize[i];
    
    int buff_size = 1.5*mysize;
    char* msg = (char*) malloc(buff_size);
    MPI_Datatype FileType;       
    int GlobalSize[] = {atom->Natoms,sizeline}; 
    int LocalSize[]  = {atom->Nlocal,sizeline};
    int Start[] = {offset,0};
    MPI_Type_create_subarray(2, GlobalSize, LocalSize, Start, MPI_ORDER_C, MPI_CHAR, &FileType);    
    MPI_Type_commit(&FileType);

    for(int i = 0; i < atom->Nlocal; ++i) 
        sprintf(msg, "%.4f %.4f %.4f\n", atom_x(i), atom_y(i), atom_z(i));
    MPI_Offset disp;
    MPI_File_get_size(_fh, &disp);
    MPI_File_set_view(_fh, disp, FileType, FileType, "native", MPI_INFO_NULL);
    
    for(int i = 0; i < atom->Nlocal; ++i){ 
        if(i==0) sprintf(msg,"%.4f %.4f %.4f\n",atom_x(i), atom_y(i), atom_z(i)); 
        sprintf(msg, "%s%.4f %.4f %.4f\n",msg, atom_x(i), atom_y(i), atom_z(i));
    }

    MPI_File_write_all(_fh, msg, strlen(msg), MPI_CHAR, MPI_STATUS_IGNORE);
    MPI_Barrier(MPI_COMM_WORLD);
    
    MPI_File_set_view(_fh,0,MPI_CHAR, MPI_CHAR, "native", MPI_INFO_NULL);    
     
    if (comm->myproc==0){
        MPI_File_get_size(_fh, &disp);
        sprintf(msg, "Continue from here"); 
        MPI_File_write_at(_fh, disp, msg, strlen(msg), MPI_CHAR, MPI_STATUS_IGNORE);
    }
    //TODO:Finish the vtk
}

void vtkClose()
{
    MPI_File_close(&_fh);
    _fh=MPI_FILE_NULL;
}

void printvtk(const char* filename, Comm* comm, Atom* atom ,int timestep)
{
    vtkOpen(filename, comm, atom, timestep);
    vtkVector(comm, atom);
    vtkClose();   
}