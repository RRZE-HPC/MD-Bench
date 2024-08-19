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
    if (dir ==  0)  max[dim] = MIN(mybox->hi[dim], other->hi[dim]+ cutneigh);
    if (dir ==  1)  min[dim] = MAX(mybox->lo[dim], other->lo[dim]- cutneigh);
    if ((min[_x]<max[_x]) && (min[_y]<max[_y]) && (min[_z]<max[_z])) pbc = 0;
  }

  //Intersection periodic case
  if(pbc < 0)
  {
    if(dir == 0){
      min[dim] = MAX(mybox->lo[dim] , other->lo[dim]- xprd);
      max[dim] = MIN(mybox->hi[dim] , other->hi[dim]- xprd + cutneigh);

    } else {
      min[dim] = MAX(mybox->lo[dim], other->lo[dim]+ xprd - cutneigh);
      max[dim] = MIN(mybox->hi[dim], other->hi[dim]+ xprd); 

    } 
    if((min[_x]<max[_x]) && (min[_y]<max[_y]) && (min[_z]<max[_z])) 
      pbc = (dir == 0) ? 1:-1;
  }   
  
  //storing the cuts
  cut->lo[_x] = min[_x]; cut->hi[_x] = max[_x]; 
  cut->lo[_y] = min[_y]; cut->hi[_y] = max[_y];
  cut->lo[_z] = min[_z]; cut->hi[_z] = max[_z];

  return pbc;
}

int overlapFullBox(Parameter* param, MD_FLOAT *cutneigh ,const Box* mybox, const Box* other)
{
  MD_FLOAT min[3], max[3];
  MD_FLOAT xprd = param->xprd; 
  MD_FLOAT yprd = param->yprd; 
  MD_FLOAT zprd = param->zprd;
  
  for(int k = -1; k < 2; k++)
  {
    for(int j = -1; j < 2; j++)
    {
      for(int i= -1; i < 2; i++)
      {
        min[_x] = MAX(mybox->lo[_x], other->lo[_x]-cutneigh[_x] + i*xprd);
        min[_y] = MAX(mybox->lo[_y], other->lo[_y]-cutneigh[_y] + j*yprd); 
        min[_z] = MAX(mybox->lo[_z], other->lo[_z]-cutneigh[_z] + k*zprd);
        max[_x] = MIN(mybox->hi[_x], other->hi[_x]+cutneigh[_x] + i*xprd);
        max[_y] = MIN(mybox->hi[_y], other->hi[_y]+cutneigh[_y] + j*yprd);
        max[_z] = MIN(mybox->hi[_z], other->hi[_z]+cutneigh[_z] + k*zprd);
        if ((min[_x]<max[_x]) && (min[_y]<max[_y]) && (min[_z]<max[_z])) 
          return 1;
      }
    }
  }

  return 0;
}

void expandBox(int iswap, const Box* me, const Box* other, Box* cut, MD_FLOAT cutneigh)
 {
    if(iswap==2 || iswap==3){
      if(me->lo[_x] <= other->lo[_x]) cut->lo[_x] -= cutneigh;
      if(me->hi[_x] >= other->hi[_x]) cut->hi[_x] += cutneigh;
    }

    if(iswap==4 || iswap==5){
      if(me->lo[_x] <= other->lo[_x]) cut->lo[_x] -= cutneigh;
      if(me->hi[_x] >= other->hi[_x]) cut->hi[_x] += cutneigh;
      if(me->lo[_y] <= other->lo[_y]) cut->lo[_y] -= cutneigh;
      if(me->hi[_y] >= other->hi[_y]) cut->hi[_y] += cutneigh;
    }
}

