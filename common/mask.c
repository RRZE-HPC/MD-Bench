/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */

#include <mask.h>


//List contains the atoms to be move to neighbours procs, This function put together all atoms. 
void packForward(Atom* atom, Box box, int n, int* list, MD_FLOAT* buf, int* pbc_flags)
{
  int i, j;
    #pragma omp for schedule(static)
    for(i = 0; i < n; i++) {
      j = list[i];
      buf_x(i) = atom_x(j) + pbc_flags[0] * box.xprd;
      buf_y(i) = atom_y(j) + pbc_flags[1] * box.yprd;
      buf_z(i) = atom_z(j) + pbc_flags[2] * box.zprd;
    }
}


void unpackForward(Atom* atom, int n, int first, MD_FLOAT* buf)
{
  int i;
  
  for( i = 0; i < n; i++) {
    atom_x((first + i)) = buf_x(i);
    atom_y((first + i)) = buf_y(i);
    atom_z((first + i)) = buf_z(i);
  }
}

void packReverse(Atom* atom, int n, int first, MD_FLOAT* buf)
{
  int i;

  #pragma omp for schedule(static)
  for(i = 0; i < n; i++) {
    buf_x(i) = atom_fx(first + i);
    buf_y(i) = atom_fy((first + i));
    buf_z(i) = atom_fz((first + i));
  }
}

void unpackReverse(Atom* atom, int n, int* list, MD_FLOAT* buf)
{
  int i, j;

  #pragma omp for schedule(static)
  for(i = 0; i < n; i++) {
    j = list[i];
    atom_fx(j) += buf_x(i);
    atom_fy(j) += buf_y(i);
    atom_fz(j) += buf_z(i);
  }
}

int packList(Atom* atom, Box box, int i, MD_FLOAT* buf, int* pbc_flags)
{
  int m = 0;

    buf[m++] = atom_x(i) + pbc_flags[0] * box.xprd;
    buf[m++] = atom_y(i) + pbc_flags[1] * box.yprd;
    buf[m++] = atom_z(i) + pbc_flags[2] * box.zprd;
    buf[m++] = atom->type[i];
  
  return m;
}

int unpackList(Atom* atom, int i, MD_FLOAT* buf)
{
  if(i == atom->Nmax) growAtom(atom);

  int m = 0;
  atom_x(i) = buf[m++];
  atom_y(i) = buf[m++];
  atom_z(i) = buf[m++];
  atom->type[i] = buf[m++];
  return m;
}

int packExchange(Atom* atom, int i, MD_FLOAT* buf)
{
  int m = 0;
  buf[m++] = atom_x(i);
  buf[m++] = atom_y(i);
  buf[m++] = atom_z(i);
  buf[m++] = atom_vx(i);
  buf[m++] = atom_vy(i);
  buf[m++] = atom_vz(i);
  buf[m++] = atom->type[i];
  return m;
}

int unpackExchange(Atom* atom, int i, MD_FLOAT* buf)
{
  if(i == atom->Nmax) growAtom(atom);

  int m = 0;
  atom_x(i) = buf[m++];
  atom_y(i) = buf[m++];
  atom_z(i) = buf[m++];
  atom_vx(i) = buf[m++];
  atom_vy(i) = buf[m++];
  atom_vz(i) = buf[m++];
  atom->type[i] = buf[m++];
  return m;
}

void pbc(Atom* atom, Box box)
{
  #pragma omp for
  for(int i = 0; i < atom->Nlocal; i++) {
    
    int xprd = box.xprd;
    int yprd = box.yprd;
    int zprd = box.zprd; 

    if(atom_x(i) < 0.0) atom_x(i) += xprd;

    if(atom_x(i) >= xprd) atom_x(i) -= yprd;

    if(atom_y(i) < 0.0) atom_y(i) += yprd;

    if(atom_y(i) >= yprd) atom_y(i) -= yprd;

    if(atom_z(i) < 0.0)  atom_z(i)+= zprd;

    if(atom_z(i) >= zprd) atom_z(i) -= zprd;
  }
}

void copy(Atom* atom, int i, int j)
{
  atom_x(j) = atom_x(i);
  atom_y(j) = atom_y(i);
  atom_z(j) = atom_z(i);
  atom_vx(j) = atom_vx(i);
  atom_vy(j) = atom_vy(i);
  atom_vx(j) = atom_vz(i);
  atom->type[j] = atom->type[i];
}