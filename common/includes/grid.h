/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */


#include <parameter.h>
#include <box.h>
#include <atom.h>

#ifndef __MAP_H_
#define __MAP_H_

#define world MPI_COMM_WORLD
#define atom_pos(i) ((dim == _x) ? atom_x((i)) : (dim == _y) ? atom_y((i)) : atom_z((i)))

typedef struct {
  int  map_size;
  MD_FLOAT* map;
} Grid; 


typedef MD_FLOAT(*RCB_Method)(Atom*,MD_FLOAT*,int);

void initGrid(Grid*); 
void setupGrid(Grid*, Atom*, Parameter*);
void cartisian3d(Grid*, Parameter*, Box*);
void RCB(Grid*, Atom*, Parameter* ,RCB_Method, int);
void printGrid(Grid*); 
#endif


