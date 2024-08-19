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
    if(param->method == halfShell){
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
    if(param->method == halfShell){
        for(int iswap = 4; iswap >= 0; iswap--) 
            reverseComm(comm, atom, iswap);
    } else if(param->method == eightShell){
        for(int iswap = 4; iswap >= 0; iswap-=2) 
            reverseComm(comm, atom, iswap);
    } else if(param->method == halfStencil){
        for(int iswap = 5; iswap >= 0; iswap--) 
            reverseComm(comm, atom, iswap);
    }  else { }  //Full Shell Reverse does nothing 
    E = getTimeStamp();
    return E-S;
}

void ghostNeighbor(Comm* comm, Atom* atom, Parameter* param){  

#ifdef CLUSTER_PAIR
    atom->Nclusters_ghost = 0;
#endif
    atom->Nghost = 0;    
    if(param->method == halfShell){
        for(int iswap=0; iswap<5; iswap++) 
            ghostComm(comm,atom,iswap);
    } else if(param->method == eightShell){
        for(int iswap = 0; iswap<6; iswap+=2)
            ghostComm(comm, atom,iswap);
    } else {
        for(int iswap=0; iswap<6; iswap++) 
            ghostComm(comm,atom,iswap);
    }
   
#ifdef CLUSTER_PAIR
    //atom->Nclusters_ghost++; // GHOST J CLUSTERS
    //atom->Nclusters = atom->Nclusters_local + Nghost + 1;
    atom->dummy_cj = LOCAL+GHOST;  
    
    if ((LOCAL+GHOST)*JFAC >= atom->Nclusters_max) growClusters(atom);
    // Add dummy cluster at the end 
    int cjVecBase = CJ_VECTOR_BASE_INDEX(atom->dummy_cj);
    MD_FLOAT* cjX = &atom->cl_x[cjVecBase];
    
    for (int cjj = 0; cjj < CLUSTER_N; cjj++) {
        //printf("Test 1: x:%f y:%f z:%f\n",cjX[CL_X_OFFSET + cjj], cjX[CL_Y_OFFSET + cjj], cjX[CL_Z_OFFSET + cjj],atom->dummy_cj);
        cjX[CL_X_OFFSET + cjj] = INFINITY;
        cjX[CL_Y_OFFSET + cjj] = INFINITY;
        cjX[CL_Z_OFFSET + cjj] = INFINITY;
    }
#endif
}
