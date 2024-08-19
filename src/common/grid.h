/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */


#include <parameter.h>
#include <box.h>
#include <atom.h>
#include <mpi.h>

#ifndef __MAP_H_
#define __MAP_H_

#define world MPI_COMM_WORLD
#define atom_pos(i) ((dim == _x) ? atom_x((i)) : (dim == _y) ? atom_y((i)) : atom_z((i)))

enum {RCB=1, meanTimeRCB, Staggered};

typedef struct {
  int balance_every;
  int  map_size;
  MD_FLOAT* map;
  //===Param for Staggerd balance
  int nprocs[3]; 
  int coord[3];
  MD_FLOAT cutneigh[3];
  double Timer;
  //===Param for RCB balance 
  MD_FLOAT* buf_send;
  MD_FLOAT* buf_recv;
  int maxsend; 
  int maxrecv; 
} Grid; 


typedef MD_FLOAT(*RCB_Method)(Atom*,MPI_Comm,int,double);

void setupGrid(Grid*, Atom*, Parameter*);
void cartisian3d(Grid*, Parameter*, Box*);
void rcbBalance(Grid*, Atom*, Parameter* ,RCB_Method, int, double);
void staggeredBalance(Grid*, Atom*, Parameter*, double); 
void printGrid(Grid*); 
//rcb methods
MD_FLOAT meanBisect(Atom* , MPI_Comm, int, double);
MD_FLOAT meanTimeBisect(Atom*, MPI_Comm, int, double);
#endif


