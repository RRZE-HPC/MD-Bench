/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <parameter.h>
#include <lammps/includes/atom.h>


#ifndef __MAP_H_
#define __MAP_H_

typedef struct {
  int  map_size;
  MD_FLOAT* map;
} Grid; 
 
void initGrid(Grid* grid); 
void setupGrid(Grid*, Atom*, int*, int);
void cartisian3d(Grid*, Atom*, int*);
void RCB(Grid*, Atom*, int*);
#endif
