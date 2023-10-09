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
#include <stdio.h>
#include <stdlib.h>

// Structure to hold atom id and distance
typedef struct {
    int id;
    MD_FLOAT rsq;
} SortDist;

// Custom comparison function for sorting based on distance
int compare(const void *p1, const void *p2) {
    SortDist *neigh1 = (SortDist *)p1;
    SortDist *neigh2 = (SortDist *)p2;
    return (neigh1->rsq < neigh2->rsq) - (neigh1->rsq > neigh2->rsq);
}

int sortNeighbors(Atom* atom, int* list, int size, int id) {
    int j; 
    MD_FLOAT delx, dely, delz;

    SortDist neigh[size];
    MD_FLOAT x = atom_x(id);
    MD_FLOAT y = atom_y(id);
    MD_FLOAT z = atom_z(id);

    // Initialize the array of structures with Ids and distances
    for (int i = 0; i < size; i++) {
        j = list[i];
        neigh[i].id = j;
        delx = x - atom_x(j);
        dely = y - atom_y(j);
        delz = z - atom_z(j);
        neigh[i].rsq = delx * delx + dely * dely + delz * delz;
    }

    // Sort the array of structures by distance
    qsort(neigh, size, sizeof(SortDist), compare);

    for (int i = 0; i < size; i++) {
        list[i] = neigh[i].id;
    }
    
    return 0;
}

