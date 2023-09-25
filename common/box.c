/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdio.h>
#include <parameter.h>
#include <util.h>
#include <box.h>
#include <mpi.h>

int overlapBox(int dim, int dir, const Box* mybox, const Box* other, Box* cut, MD_FLOAT xprd, MD_FLOAT cutneigh)
{
  int pbc = -100;
  MD_FLOAT min[3], max[3];
  int same = (mybox->id == other->id) ? 1 : 0;
  
  //projections
  min[_x] = MAX(mybox->lo[_x], other->lo[_x]); max[_x] = MIN(mybox->hi[_x], other->hi[_x]); 
  min[_y] = MAX(mybox->lo[_y], other->lo[_y]); max[_y] = MIN(mybox->hi[_y], other->hi[_y]);
  min[_z] = MAX(mybox->lo[_z], other->lo[_z]); max[_z] = MIN(mybox->hi[_z], other->hi[_z]);
  
  //Intersection no periodic case
  if(!same){
    if (dir ==  0)  min[dim] = MAX(mybox->lo[dim] - cutneigh, other->lo[dim]);
    if (dir ==  1)  max[dim] = MIN(mybox->hi[dim] + cutneigh, other->hi[dim]);
    if ((min[_x]<max[_x]) && (min[_y]<max[_y]) && (min[_z]<max[_z])) pbc = 0;
  }
  
  //Intersection periodic case
  if(pbc < 0)
  {
    if(dir == 0){
      min[dim] = MAX(mybox->lo[dim] - cutneigh + xprd, other->lo[dim]);
      max[dim] = MIN(mybox->hi[dim] + xprd, other->hi[dim]); 

    } else {
      min[dim] = MAX(mybox->lo[dim] - xprd, other->lo[dim]);
      max[dim] = MIN(mybox->hi[dim] + cutneigh - xprd, other->hi[dim]);
    } 
    if((min[_x]<max[_x]) && (min[_y]<max[_y]) && (min[_z]<max[_z])) 
      pbc = (dir == 0) ? 1:-1;
  }   
  
  //store the cuts
  cut->lo[_x] = min[_x]; cut->hi[_x] = max[_x]; 
  cut->lo[_y] = min[_y]; cut->hi[_y] = max[_y];
  cut->lo[_z] = min[_z]; cut->hi[_z] = max[_z];

  return pbc;
}

void expandBox(int iswap, const Box* me, const Box* other, Box* tile, MD_FLOAT cutneigh)
 {
  switch (iswap) {
  case 0:
      tile->lo[_x] = me->lo[_x]; 
      tile->hi[_x] = me->lo[_x]+cutneigh;
      break;
  case 1: 
      tile->lo[_x] = me->hi[_x]-cutneigh; 
      tile->hi[_x] = me->hi[_x];
      break;
  case 2:
      tile->lo[_y] = me->lo[_y]; 
      tile->hi[_y] = me->lo[_y]+cutneigh;
      if(me->lo[_x] < other->lo[_x]) tile->lo[_x] -= cutneigh;
      if(me->hi[_x] > other->hi[_x]) tile->lo[_x] += cutneigh;
      break;
  case 3:
      tile->lo[_y] = me->hi[_y]-cutneigh; 
      tile->hi[_y] = me->hi[_y];
      if(me->lo[_x] < other->lo[_x]) tile->lo[_x] -= cutneigh;
      if(me->hi[_x] > other->hi[_x]) tile->lo[_x] += cutneigh;
      break;
  case 4: 
      tile->lo[_z] = me->lo[_z]; 
      tile->hi[_z] = me->lo[_z]+cutneigh;
      if(me->lo[_x] < other->lo[_x]) tile->lo[_x] -= cutneigh;
      if(me->hi[_x] > other->hi[_x]) tile->lo[_x] += cutneigh;
      if(me->lo[_y] < other->lo[_y]) tile->lo[_y] -= cutneigh;
      if(me->hi[_y] > other->hi[_y]) tile->lo[_y] += cutneigh;
      break;
  case 5: 
      tile->lo[_z] = me->hi[_z]-cutneigh; 
      tile->hi[_z] = me->hi[_z];
      if(me->lo[_x] < other->lo[_x]) tile->lo[_x] -= cutneigh;
      if(me->hi[_x] > other->hi[_x]) tile->lo[_x] += cutneigh;
      if(me->lo[_y] < other->lo[_y]) tile->lo[_y] -= cutneigh;
      if(me->hi[_y] > other->hi[_y]) tile->lo[_y] += cutneigh;
      break;
  }
}

