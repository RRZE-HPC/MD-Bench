/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdio.h>
#include <stdlib.h>
//---
#include <atom.h>
#include <eam.h>
#include <neighbor.h>
#include <parameter.h>
#include <neighbor.h>
#include <stats.h>
#include <timing.h>
#include <comm2.h>


//TODO: Add eight shell method to compute the force

void fullShell(Comm* comm, Eam *eam, Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats){
    for(int iswap = 0; iswap < 6; iswap++)
        forwardComm(comm, atom, iswap);
    
    computeForce(eam, param, atom, neighbor, stats);
    
    for(int iswap = 0; iswap < 6; iswap++)
        reverseComm(comm, atom, iswap);
}

void halfShell(Comm* comm, Eam *eam, Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats){
   for(int iswap = 0; iswap < 5; iswap++) 
        forwardComm(comm, atom, iswap);

    computeForce(eam, param, atom, neighbor, stats);

    for(int iswap = 0; iswap < 5; iswap++)
        reverseComm(comm, atom, iswap);

}

void eightShell(Comm* comm, Eam *eam, Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats){
    for(int iswap = 0; iswap<6; iswap+=2)
        forwardComm(comm, atom, iswap);
    
    computeForce(eam, param, atom, neighbor, stats);
    
    for(int iswap = 0; iswap<6; iswap+=2)
        reverseComm(comm, atom, iswap);
}


double computeForce(Eam *eam, Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats) {
    if(param->force_field == FF_EAM) {
        return computeForceEam(eam, param, atom, neighbor, stats);
    } else if(param->force_field == FF_DEM) {
        if(param->half_neigh) {
            fprintf(stderr, "Error: DEM cannot use half neighbor-lists!\n");
            return 0.0;
        } else {
            return computeForceDemFullNeigh(param, atom, neighbor, stats);
        }
    }

    if(param->half_neigh) {
        return computeForceLJHalfNeigh(param, atom, neighbor, stats);
    }

    #ifdef CUDA_TARGET
    return computeForceLJFullNeigh(param, atom, neighbor);
    #else
    return computeForceLJFullNeigh(param, atom, neighbor, stats);
    #endif
}
