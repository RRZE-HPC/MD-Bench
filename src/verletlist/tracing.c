/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <atom.h>
#include <neighbor.h>
#include <parameter.h>
#include <tracing.h>

void traceAddresses(Parameter* param, Atom* atom, Neighbor* neighbor, int timestep)
{
    MEM_TRACER_INIT;
    INDEX_TRACER_INIT;
    int Nlocal = atom->Nlocal;
    int* neighs;

    INDEX_TRACE_NATOMS(Nlocal, atom->Nghost, neighbor->maxneighs);
    for (int i = 0; i < Nlocal; i++) {
        neighs        = &neighbor->neighbors[i * neighbor->maxneighs];
        int numneighs = neighbor->numneigh[i];
        MEM_TRACE(atom_x(i), 'R');
        MEM_TRACE(atom_y(i), 'R');
        MEM_TRACE(atom_z(i), 'R');
        INDEX_TRACE_ATOM(i);

#ifdef EXPLICIT_TYPES
        MEM_TRACE(atom->type[i], 'R');
#endif

        DIST_TRACE_SORT(neighs, numneighs);
        INDEX_TRACE(neighs, numneighs);
        DIST_TRACE(neighs, numneighs);

        for (int k = 0; k < numneighs; k++) {
            MEM_TRACE(neighs[k], 'R');
            MEM_TRACE(atom_x(j), 'R');
            MEM_TRACE(atom_y(j), 'R');
            MEM_TRACE(atom_z(j), 'R');

#ifdef EXPLICIT_TYPES
            MEM_TRACE(atom->type[j], 'R');
#endif
        }

        MEM_TRACE(atom_fx(i), 'R');
        MEM_TRACE(atom_fx(i), 'W');
        MEM_TRACE(atom_fy(i), 'R');
        MEM_TRACE(atom_fy(i), 'W');
        MEM_TRACE(atom_fz(i), 'R');
        MEM_TRACE(atom_fz(i), 'W');
    }

    INDEX_TRACER_END;
    MEM_TRACER_END;
}
