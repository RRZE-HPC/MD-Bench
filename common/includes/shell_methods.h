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

static enum {fullShell=0, halfShell, eightShell};

double forward(Comm* comm, Atom *atom, Parameter* param){
    double S, E;    
    S = getTimeStamp(); 
    if(param->shell_method == halfShell){
        for(int iswap = 0; iswap < 5; iswap++) 
            forwardComm(comm, atom, iswap);
    } else if(param->shell_method == eightShell){
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
    if(param->shell_method == halfShell){
        for(int iswap = 4; iswap >= 0; iswap--) 
            reverseComm(comm, atom, iswap);
    } else if(param->shell_method == eightShell){
        for(int iswap = 4; iswap >= 0; iswap-=2) 
            reverseComm(comm, atom, iswap);
    } else {
        for(int iswap = 5; iswap >= 0; iswap--) 
            reverseComm(comm, atom, iswap);
    }
    E = getTimeStamp();
    return E-S;
}

void ghostNeighbour(Comm* comm, Atom* atom, Parameter* param)
{   
    atom->Nghost = 0;    
    if(param->shell_method == halfShell){
        for(int iswap=0; iswap<5; iswap++) 
            ghostComm(comm,atom,iswap);
    } else if(param->shell_method == eightShell){
        for(int iswap = 0; iswap<6; iswap+=2)
            ghostComm(comm, atom,iswap);
    } else {
        for(int iswap=0; iswap<6; iswap++) 
            ghostComm(comm,atom,iswap);
    }
}

