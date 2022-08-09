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
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <limits.h>
#include <math.h>
#include <float.h>

#include <likwid-marker.h>

#include <timing.h>
#include <allocate.h>
#include <neighbor.h>
#include <parameter.h>
#include <atom.h>
#include <stats.h>
#include <thermo.h>
#include <pbc.h>
#include <timers.h>
#include <eam.h>
#include <vtk.h>
#include <util.h>
#include <integrate.h>

#define HLINE "----------------------------------------------------------------------------\n"

extern double computeForceLJFullNeigh_plain_c(Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceLJFullNeigh_simd(Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceLJHalfNeigh(Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceEam(Eam*, Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceDemFullNeigh(Parameter*, Atom*, Neighbor*, Stats*);

#ifdef CUDA_TARGET
#include <cuda_atom.h>
extern double computeForceLJFullNeigh_cuda(Parameter*, Atom*, Neighbor*, Atom*, Neighbor*);
#endif

double setup(Parameter *param, Eam *eam, Atom *atom, Neighbor *neighbor, Atom *c_atom, Neighbor *c_neighbor, Stats *stats) {
    if(param->force_field == FF_EAM) { initEam(eam, param); }
    double S, E;
    param->lattice = pow((4.0 / param->rho), (1.0 / 3.0));
    param->xprd = param->nx * param->lattice;
    param->yprd = param->ny * param->lattice;
    param->zprd = param->nz * param->lattice;

    S = getTimeStamp();
    initAtom(atom);
    initPbc(atom);
    initStats(stats);
    initNeighbor(neighbor, param);
    if(param->input_file == NULL) {
        createAtom(atom, param);
    } else {
        readAtom(atom, param);
    }

    setupNeighbor(param);
    setupThermo(param, atom->Natoms);
    if(param->input_file == NULL) { adjustThermo(param, atom); }
    setupPbc(atom, param);
    #ifdef CUDA_TARGET
    initCuda(atom, neighbor, c_atom, c_neighbor);
    #endif
    updatePbc(atom, c_atom, param, true);
    buildNeighbor(atom, neighbor, c_atom, c_neighbor);
    E = getTimeStamp();
    return E-S;
}

double reneighbour(Parameter *param, Atom *atom, Neighbor *neighbor, Atom *c_atom, Neighbor *c_neighbor) {
    double S, E;
    S = getTimeStamp();
    LIKWID_MARKER_START("reneighbour");
    updateAtomsPbc(atom, c_atom, param);
    setupPbc(atom, param);
    updatePbc(atom, c_atom, param, true);
    //sortAtom(atom);
    buildNeighbor(atom, neighbor, c_atom, c_neighbor);
    LIKWID_MARKER_STOP("reneighbour");
    E = getTimeStamp();
    return E-S;
}

void printAtomState(Atom *atom) {
    printf("Atom counts: Natoms=%d Nlocal=%d Nghost=%d Nmax=%d\n", atom->Natoms, atom->Nlocal, atom->Nghost, atom->Nmax);
    // int nall = atom->Nlocal + atom->Nghost;
    // for (int i=0; i<nall; i++) {
    //     printf("%d  %f %f %f\n", i, atom->x[i], atom->y[i], atom->z[i]);
    // }
}

double computeForce(Eam *eam, Parameter *param, Atom *atom, Neighbor *neighbor, Atom *c_atom, Neighbor *c_neighbor, Stats *stats) {
    if(param->force_field == FF_EAM) {
        return computeForceEam(eam, param, atom, neighbor, stats);
    } else if(param->force_field == FF_DEM) {
        if(param->half_neigh) {
            fprintf(stderr, "Error: DEM cannot use half neighbor-lists!\n");
            return 0.0;
        } else {
            return computeForceDemFullNeigh(param, atom, neighbor, stats);
        }
    }

    if(param->half_neigh) {
        return computeForceLJHalfNeigh(param, atom, neighbor, stats);
    }

    #ifdef CUDA_TARGET
    return computeForceLJFullNeigh(param, atom, neighbor, c_atom, c_neighbor);
    #else
    return computeForceLJFullNeigh(param, atom, neighbor, stats);
    #endif
}

int main(int argc, char** argv) {
    double timer[NUMTIMER];
    Eam eam;
    Atom atom, c_atom;
    Neighbor neighbor, c_neighbor;
    Stats stats;
    Parameter param;

    LIKWID_MARKER_INIT;
#pragma omp parallel
    {
        LIKWID_MARKER_REGISTER("force");
        //LIKWID_MARKER_REGISTER("reneighbour");
        //LIKWID_MARKER_REGISTER("pbc");
    }

    initParameter(&param);
    for(int i = 0; i < argc; i++) {
        if((strcmp(argv[i], "-p") == 0)) {
            readParameter(&param, argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-f") == 0)) {
            if((param.force_field = str2ff(argv[++i])) < 0) {
                fprintf(stderr, "Invalid force field!\n");
                exit(-1);
            }
            continue;
        }
        if((strcmp(argv[i], "-i") == 0)) {
            param.input_file = strdup(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-e") == 0)) {
            param.eam_file = strdup(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-n") == 0) || (strcmp(argv[i], "--nsteps") == 0)) {
            param.ntimes = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-nx") == 0)) {
            param.nx = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-ny") == 0)) {
            param.ny = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-nz") == 0)) {
            param.nz = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-half") == 0)) {
            param.half_neigh = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-r") == 0) || (strcmp(argv[i], "--radius") == 0)) {
            param.cutforce = atof(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-s") == 0) || (strcmp(argv[i], "--skin") == 0)) {
            param.skin = atof(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "--freq") == 0)) {
            param.proc_freq = atof(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "--vtk") == 0)) {
            param.vtk_file = strdup(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-h") == 0) || (strcmp(argv[i], "--help") == 0)) {
            printf("MD Bench: A minimalistic re-implementation of miniMD\n");
            printf(HLINE);
            printf("-p <string>:          file to read parameters from (can be specified more than once)\n");
            printf("-f <string>:          force field (lj, eam or dem), default lj\n");
            printf("-i <string>:          input file with atom positions (dump)\n");
            printf("-e <string>:          input file for EAM\n");
            printf("-n / --nsteps <int>:  set number of timesteps for simulation\n");
            printf("-nx/-ny/-nz <int>:    set linear dimension of systembox in x/y/z direction\n");
            printf("-r / --radius <real>: set cutoff radius\n");
            printf("-s / --skin <real>:   set skin (verlet buffer)\n");
            printf("--freq <real>:        processor frequency (GHz)\n");
            printf("--vtk <string>:       VTK file for visualization\n");
            printf(HLINE);
            exit(EXIT_SUCCESS);
        }
    }

    param.cutneigh = param.cutforce + param.skin;
    setup(&param, &eam, &atom, &neighbor, &c_atom, &c_neighbor, &stats);
    printParameter(&param);

    printf("step\ttemp\t\tpressure\n");
    computeThermo(0, &param, &atom);
    #if defined(MEM_TRACER) || defined(INDEX_TRACER)
    traceAddresses(&param, &atom, &neighbor, n + 1);
    #endif

    timer[FORCE] = computeForce(&eam, &param, &atom, &neighbor, &c_atom, &c_neighbor, &stats);
    timer[NEIGH] = 0.0;
    timer[TOTAL] = getTimeStamp();

    if(param.vtk_file != NULL) {
        write_atoms_to_vtk_file(param.vtk_file, &atom, 0);
    }

    for(int n = 0; n < param.ntimes; n++) {
        bool reneigh = (n + 1) % param.reneigh_every == 0;
        initialIntegrate(reneigh, &param, &atom, &c_atom);
        if((n + 1) % param.reneigh_every) {
            updatePbc(&atom, &c_atom, &param, false);
        } else {
            timer[NEIGH] += reneighbour(&param, &atom, &neighbor, &c_atom, &c_neighbor);
        }

        #if defined(MEM_TRACER) || defined(INDEX_TRACER)
        traceAddresses(&param, &atom, &neighbor, n + 1);
        #endif

        timer[FORCE] += computeForce(&eam, &param, &atom, &neighbor, &c_atom, &c_neighbor, &stats);
        finalIntegrate(reneigh, &param, &atom, &c_atom);

        if(!((n + 1) % param.nstat) && (n+1) < param.ntimes) {
            #ifdef CUDA_TARGET
            checkCUDAError("computeThermo atom->x memcpy back", cudaMemcpy(atom.x, c_atom.x, atom.Nmax * sizeof(MD_FLOAT) * 3, cudaMemcpyDeviceToHost));
            #endif

            computeThermo(n + 1, &param, &atom);
        }

        if(param.vtk_file != NULL) {
            write_atoms_to_vtk_file(param.vtk_file, &atom, n + 1);
        }
    }

    timer[TOTAL] = getTimeStamp() - timer[TOTAL];
    computeThermo(-1, &param, &atom);

    printf(HLINE);
    printf("Force field: %s\n", ff2str(param.force_field));
    printf("Data layout for positions: %s\n", POS_DATA_LAYOUT);
    #if PRECISION == 1
    printf("Using single precision floating point.\n");
    #else
    printf("Using double precision floating point.\n");
    #endif
    printf(HLINE);
    printf("System: %d atoms %d ghost atoms, Steps: %d\n", atom.Natoms, atom.Nghost, param.ntimes);
    printf("TOTAL %.2fs FORCE %.2fs NEIGH %.2fs REST %.2fs\n",
            timer[TOTAL], timer[FORCE], timer[NEIGH], timer[TOTAL]-timer[FORCE]-timer[NEIGH]);
    printf(HLINE);
    printf("Performance: %.2f million atom updates per second\n",
            1e-6 * (double) atom.Natoms * param.ntimes / timer[TOTAL]);
#ifdef COMPUTE_STATS
    displayStatistics(&atom, &param, &stats, timer);
#endif
    LIKWID_MARKER_CLOSE;
    return EXIT_SUCCESS;
}
