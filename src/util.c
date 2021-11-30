/*
 * =======================================================================================
 *
 *   Author:   Jan Eitzinger (je), jan.eitzinger@fau.de
 *   Copyright (c) 2020 RRZE, University Erlangen-Nuremberg
 *
 *   This file is part of MD-Bench.
 *
 *   MD-Bench is free software: you can redistribute it and/or modify it
 *   under the terms of the GNU Lesser General Public License as published
 *   by the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   MD-Bench is distributed in the hope that it will be useful, but WITHOUT ANY
 *   WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 *   PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
 *   details.
 *
 *   You should have received a copy of the GNU Lesser General Public License along
 *   with MD-Bench.  If not, see <https://www.gnu.org/licenses/>.
 * =======================================================================================
 */
#include <util.h>

/* Park/Miller RNG w/out MASKING, so as to be like f90s version */
#define IA 16807
#define IM 2147483647
#define AM (1.0/IM)
#define IQ 127773
#define IR 2836
#define MASK 123459876

double myrandom(int* seed)
{
    int k= (*seed) / IQ;
    double ans;

    *seed = IA * (*seed - k * IQ) - IR * k;
    if(*seed < 0) *seed += IM;
    ans = AM * (*seed);
    return ans;
}

void random_reset(int *seed, int ibase, double *coord)
{
  int i;
  char *str = (char *) &ibase;
  int n = sizeof(int);
  unsigned int hash = 0;

  for (i = 0; i < n; i++) {
    hash += str[i];
    hash += (hash << 10);
    hash ^= (hash >> 6);
  }

  str = (char *) coord;
  n = 3 * sizeof(double);
  for (i = 0; i < n; i++) {
    hash += str[i];
    hash += (hash << 10);
    hash ^= (hash >> 6);
  }

  hash += (hash << 3);
  hash ^= (hash >> 11);
  hash += (hash << 15);

  // keep 31 bits of unsigned int as new seed
  // do not allow seed = 0, since will cause hang in gaussian()

  *seed = hash & 0x7ffffff;
  if (!(*seed)) *seed = 1;

  // warm up the RNG

  for (i = 0; i < 5; i++) myrandom(seed);
  //save = 0;
}

int str2ff(const char *string)
{
    if(strncmp(string, "lj", 2) == 0) return FF_LJ;
    if(strncmp(string, "eam", 3) == 0) return FF_EAM;
    return -1;
}

const char* ff2str(int ff)
{
    if(ff == FF_LJ) { return "lj"; }
    if(ff == FF_EAM) { return "eam"; }
    return "invalid";
}
