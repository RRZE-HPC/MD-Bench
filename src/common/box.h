/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <parameter.h>

#ifndef __BOX_H_
#define __BOX_H_

typedef struct {
  int id;
  MD_FLOAT xprd, yprd, zprd;     //Domain Dimension
  MD_FLOAT lo[3];               //smallest coordinate of my subdomain
  MD_FLOAT hi[3];               //Highest coordinate of my subdomain
} Box;

int overlapBox(int, int , const Box*, const Box* , Box* , MD_FLOAT , MD_FLOAT);
int overlapFullBox(Parameter*, MD_FLOAT*, const Box*, const Box*);
void expandBox(int , const Box*, const Box* , Box* , MD_FLOAT);
#endif
