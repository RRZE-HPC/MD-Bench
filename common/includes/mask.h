/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */

#include <atom.h>
#include <comm.h>

#define buf_x(i)  buf[3*(i)] 
#define buf_y(i)  buf[3*(i)+1]
#define buf_z(i)  buf[3*(i)+2]

void packForward(Atom*, Box, int, int*, MD_FLOAT*, int*); 
void unpackForward(Atom*, int, int, MD_FLOAT*); 
void packReverse(Atom*, int, int, MD_FLOAT*); 
void unpackReverse(Atom*, int, int*, MD_FLOAT*); 
int  packList(Atom*, Box, int, MD_FLOAT*, int*);
int  unpackList(Atom*, int, MD_FLOAT*); 
int  packExchange(Atom*, int, MD_FLOAT*);
int  unpackExchange(Atom*, int, MD_FLOAT*); 
void pbc(Atom*, Box);
void copy(Atom*, int i, int j);
