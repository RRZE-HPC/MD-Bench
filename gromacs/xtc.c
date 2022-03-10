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
#include <stdlib.h>
//---
#include <atom.h>
#include <allocate.h>
#include <xtc.h>

#ifdef XTC_OUTPUT
#include <gromacs/fileio/xtcio.h>

static struct t_fileio *xtc_file = NULL;
static rvec *x_buf = NULL;
static rvec basis[3];

void xtc_init(const char *filename, Atom *atom, int timestep) {
    basis[0][XX] = 1.0;
    basis[0][YY] = 0.0;
    basis[0][ZZ] = 0.0;
    basis[1][XX] = 0.0;
    basis[1][YY] = 1.0;
    basis[1][ZZ] = 0.0;
    basis[2][XX] = 0.0;
    basis[2][YY] = 0.0;
    basis[2][ZZ] = 1.0;

    xtc_file = open_xtc(filename, "w");
    x_buf = (rvec *) allocate(ALIGNMENT, sizeof(rvec) * (atom->Nlocal + 1));
    xtc_write(atom, timestep, 1, 1);
}

void xtc_write(Atom *atom, int timestep, int write_pos, int write_vel) {
    int i = 0;
    for(int ci = 0; ci < atom->Nclusters_local; ++ci) {
        MD_FLOAT *cptr = cluster_pos_ptr(ci);
        for(int cii = 0; cii < atom->clusters[ci].natoms; ++cii) {
            x_buf[i][XX] = cluster_x(cptr, cii);
            x_buf[i][YY] = cluster_y(cptr, cii);
            x_buf[i][ZZ] = cluster_z(cptr, cii);
            i++;
        }
    }

    write_xtc(xtc_file, atom->Nlocal, timestep, 0.0, (const rvec *) basis, (const rvec *) x_buf, 1000);
}

void xtc_end() {
    free(x_buf);
    close_xtc(xtc_file);
}
#endif
