/*
 * =======================================================================================
 *
 *   Author:   Jan Eitzinger (je), jan.eitzinger@fau.de
 *   Copyright (c) 2021 RRZE, University Erlangen-Nuremberg
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
#include <neighbor.h>
#include <parameter.h>
#include <atom.h>
#include <tracing.h>

void traceAddresses(Parameter *param, Atom *atom, Neighbor *neighbor, int timestep) {
    MEM_TRACER_INIT;
    INDEX_TRACER_INIT;
    int Nlocal = atom->Nlocal;
    int* neighs;
    //MD_FLOAT* fx = atom->fx; MD_FLOAT* fy = atom->fy; MD_FLOAT* fz = atom->fz;

    INDEX_TRACE_NATOMS(Nlocal, atom->Nghost, neighbor->maxneighs);
    for(int i = 0; i < Nlocal; i++) {
        neighs = &neighbor->neighbors[i * neighbor->maxneighs];
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

        for(int k = 0; k < numneighs; k++) {
            MEM_TRACE(neighs[k], 'R');
            MEM_TRACE(atom_x(j), 'R');
            MEM_TRACE(atom_y(j), 'R');
            MEM_TRACE(atom_z(j), 'R');

            #ifdef EXPLICIT_TYPES
            MEM_TRACE(atom->type[j], 'R');
            #endif
        }

        /*
        MEM_TRACE(fx[i], 'R');
        MEM_TRACE(fx[i], 'W');
        MEM_TRACE(fy[i], 'R');
        MEM_TRACE(fy[i], 'W');
        MEM_TRACE(fz[i], 'R');
        MEM_TRACE(fz[i], 'W');
        */
    }

    INDEX_TRACER_END;
    MEM_TRACER_END;
}
