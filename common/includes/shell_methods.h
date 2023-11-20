/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <limits.h>
#include <math.h>
#include <comm.h>
#include <atom.h>
#include <timing.h>
#include <parameter.h>
#include <util.h>

//static void addDummyCluster(Atom*);

double forward(Comm* comm, Atom *atom, Parameter* param){
    double S, E;    
    S = getTimeStamp();  
    if(param->method == halfShell || param->method == halfStencil){
        for(int iswap = 0; iswap < 5; iswap++) 
            forwardComm(comm, atom, iswap);
    } else if(param->method == eightShell){
        for(int iswap = 0; iswap < 6; iswap+=2) 
            forwardComm(comm, atom, iswap);
    } else {
        for(int iswap = 0; iswap < 6; iswap++) 
            forwardComm(comm, atom, iswap);
    }
    E = getTimeStamp();
    return E-S;
}

double reverse(Comm* comm, Atom *atom, Parameter* param){
    double S, E;    
    S = getTimeStamp(); 
    if(param->method == halfShell || param->method == halfStencil){
        for(int iswap = 4; iswap >= 0; iswap--) 
            reverseComm(comm, atom, iswap);
    } else if(param->method == eightShell){
        for(int iswap = 4; iswap >= 0; iswap-=2) 
            reverseComm(comm, atom, iswap);
    } else { }  //Full Shell Reverse does nothing 
    E = getTimeStamp();
    return E-S;
}

void ghostNeighbor(Comm* comm, Atom* atom, Parameter* param)
{   
    #ifdef GROMACS
    atom->Nclusters_ghost = 0;
    #endif
    atom->Nghost = 0;    
    if(param->method == halfShell || param->method == halfStencil){
        for(int iswap=0; iswap<5; iswap++) 
            ghostComm(comm,atom,iswap);
    } else if(param->method == eightShell){
        for(int iswap = 0; iswap<6; iswap+=2)
            ghostComm(comm, atom,iswap);
    } else {
        for(int iswap=0; iswap<6; iswap++) 
            ghostComm(comm,atom,iswap);
    }
}

/*
#ifdef GROMACS 
void addDummyCluster(Atom* atom)
{
    int Nghost = atom->Nclusters_ghost;
    int jfac = MAX(1, CLUSTER_N / CLUSTER_M);
    int ncj = atom->Nclusters_local / jfac;
    if(ncj + (Nghost + 1) * jfac >= atom->Nclusters_max) {
        growClusters(atom);
    }
   
    // Add dummy cluster at the end
    int cj_vec_base = CJ_VECTOR_BASE_INDEX(ncj + Nghost);
    MD_FLOAT *cj_x = &atom->cl_x[cj_vec_base];
    for(int cjj = 0; cjj < CLUSTER_N; cjj++) {
        cj_x[CL_X_OFFSET + cjj] = INFINITY;
        cj_x[CL_Y_OFFSET + cjj] = INFINITY;
        cj_x[CL_Z_OFFSET + cjj] = INFINITY;
    }
    atom->dummy_cj = ncj + Nghost +1;
    atom->Nclusters = atom->Nclusters_local + Nghost + 1;
}
#endif
*/