/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdio.h>
#include <math.h>
//--
#include <likwid-marker.h>
//--
#include <atom.h>
#include <allocate.h>
#include <device.h>
#include <eam.h>
#include <integrate.h>
#include <neighbor.h>
#include <parameter.h>
#include <pbc.h>
#include <stats.h>
#include <thermo.h>
#include <timers.h>
#include <timing.h>
#include <util.h>
#include <vtk.h>
#include <xtc.h>

#define HLINE "----------------------------------------------------------------------------\n"

extern double computeForceLJ_ref(Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceLJ_4xn(Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceLJ_2xnn(Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceEam(Eam*, Parameter*, Atom*, Neighbor*, Stats*);

#ifdef CUDA_TARGET
extern int isReneighboured;
extern double computeForceLJ_cuda(Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats);
extern void copyDataToCUDADevice(Atom *atom);
extern void copyDataFromCUDADevice(Atom *atom);
extern void cudaDeviceFree();

#ifdef USE_SUPER_CLUSTERS
#include <utils.h>
extern void buildNeighborGPU(Atom *atom, Neighbor *neighbor);
extern void pruneNeighborGPU(Parameter *param, Atom *atom, Neighbor *neighbor);
extern void alignDataToSuperclusters(Atom *atom);
extern void alignDataFromSuperclusters(Atom *atom);
extern double computeForceLJSup_cuda(Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats);
#endif //USE_SUPER_CLUSTERS
#endif //CUDA_TARGET

double setup(Parameter *param, Eam *eam, Atom *atom, Neighbor *neighbor, Stats *stats) {
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

    setupNeighbor(param, atom);
    setupThermo(param, atom->Natoms);
    if(param->input_file == NULL) { adjustThermo(param, atom); }
    #if defined(CUDA_TARGET) && defined(USE_SUPER_CLUSTERS)
    buildClustersGPU(atom);
    #else
    buildClusters(atom);
    #endif //defined(CUDA_TARGET) && defined(USE_SUPER_CLUSTERS)
    defineJClusters(atom);
    #if defined(CUDA_TARGET) && defined(USE_SUPER_CLUSTERS)
    //setupPbcGPU(atom, param);
    setupPbc(atom, param);
    #else
    setupPbc(atom, param);
    #endif //defined(CUDA_TARGET) && defined(USE_SUPER_CLUSTERS)
    binClusters(atom);
    #if defined(CUDA_TARGET) && defined(USE_SUPER_CLUSTERS)
    buildNeighborGPU(atom, neighbor);
    #else
    buildNeighbor(atom, neighbor);
    #endif //defined(CUDA_TARGET) && defined(USE_SUPER_CLUSTERS)
    initDevice(atom, neighbor);
    E = getTimeStamp();
    return E-S;
}

double reneighbour(Parameter *param, Atom *atom, Neighbor *neighbor) {
    double S, E;
    S = getTimeStamp();
    LIKWID_MARKER_START("reneighbour");
    updateSingleAtoms(atom);
    updateAtomsPbc(atom, param);
    #if defined(CUDA_TARGET) && defined(USE_SUPER_CLUSTERS)
    buildClustersGPU(atom);
    #else
    buildClusters(atom);
    #endif //defined(CUDA_TARGET) && defined(USE_SUPER_CLUSTERS)
    defineJClusters(atom);
    #if defined(CUDA_TARGET) && defined(USE_SUPER_CLUSTERS)
    //setupPbcGPU(atom, param);
    setupPbc(atom, param);
    #else
    setupPbc(atom, param);
    #endif //defined(CUDA_TARGET) && defined(USE_SUPER_CLUSTERS)
    binClusters(atom);
    #if defined(CUDA_TARGET) && defined(USE_SUPER_CLUSTERS)
    buildNeighborGPU(atom, neighbor);
    #else
    buildNeighbor(atom, neighbor);
    #endif //defined(CUDA_TARGET) && defined(USE_SUPER_CLUSTERS)
    LIKWID_MARKER_STOP("reneighbour");
    E = getTimeStamp();
    return E-S;
}

void printAtomState(Atom *atom) {
    printf("Atom counts: Natoms=%d Nlocal=%d Nghost=%d Nmax=%d\n",
            atom->Natoms, atom->Nlocal, atom->Nghost, atom->Nmax);

    /*     int nall = atom->Nlocal + atom->Nghost; */

    /*     for (int i=0; i<nall; i++) { */
    /*         printf("%d  %f %f %f\n", i, atom->x[i], atom->y[i], atom->z[i]); */
    /*     } */
}

int main(int argc, char** argv) {
    double timer[NUMTIMER];
    Eam eam;
    Atom atom;
    Neighbor neighbor;
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
        if((strcmp(argv[i], "-m") == 0) || (strcmp(argv[i], "--mass") == 0)) {
            param.mass = atof(argv[++i]);
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
        if((strcmp(argv[i], "--xtc") == 0)) {
            #ifndef XTC_OUTPUT
            fprintf(stderr, "XTC not available, set XTC_OUTPUT option in config.mk file and recompile MD-Bench!");
            exit(-1);
            #else
            param.xtc_file = strdup(argv[++i]);
            #endif
            continue;
        }
        if((strcmp(argv[i], "-h") == 0) || (strcmp(argv[i], "--help") == 0)) {
            printf("MD Bench: A minimalistic re-implementation of miniMD\n");
            printf(HLINE);
            printf("-p <string>:          file to read parameters from (can be specified more than once)\n");
            printf("-f <string>:          force field (lj or eam), default lj\n");
            printf("-i <string>:          input file with atom positions (dump)\n");
            printf("-e <string>:          input file for EAM\n");
            printf("-n / --nsteps <int>:  set number of timesteps for simulation\n");
            printf("-nx/-ny/-nz <int>:    set linear dimension of systembox in x/y/z direction\n");
            printf("-r / --radius <real>: set cutoff radius\n");
            printf("-s / --skin <real>:   set skin (verlet buffer)\n");
            printf("--freq <real>:        processor frequency (GHz)\n");
            printf("--vtk <string>:       VTK file for visualization\n");
            printf("--xtc <string>:       XTC file for visualization\n");
            printf(HLINE);
            exit(EXIT_SUCCESS);
        }
    }

    param.cutneigh = param.cutforce + param.skin;
    setup(&param, &eam, &atom, &neighbor, &stats);
    printParameter(&param);
    printf(HLINE);

    //verifyNeigh(&atom, &neighbor);

    printf("step\ttemp\t\tpressure\n");
    computeThermo(0, &param, &atom);
    #if defined(MEM_TRACER) || defined(INDEX_TRACER)
    traceAddresses(&param, &atom, &neighbor, n + 1);
    #endif

    #ifdef CUDA_TARGET
    copyDataToCUDADevice(&atom);
    #endif

    if(param.force_field == FF_EAM) {
        timer[FORCE] = computeForceEam(&eam, &param, &atom, &neighbor, &stats);
    } else {
        timer[FORCE] = computeForceLJ(&param, &atom, &neighbor, &stats);
    }

    timer[NEIGH] = 0.0;
    timer[TOTAL] = getTimeStamp();

    if(param.vtk_file != NULL) {
        write_data_to_vtk_file(param.vtk_file, &atom, 0);
    }

    if(param.xtc_file != NULL) {
        xtc_init(param.xtc_file, &atom, 0);
    }

    for(int n = 0; n < param.ntimes; n++) {

        //printf("Step:\t%d\r\n", n);

        initialIntegrate(&param, &atom);

        if((n + 1) % param.reneigh_every) {
            if(!((n + 1) % param.prune_every)) {
                #if defined(CUDA_TARGET) && defined(USE_SUPER_CLUSTERS)
                pruneNeighborGPU(&param, &atom, &neighbor);
                #else
                pruneNeighbor(&param, &atom, &neighbor);
                #endif //defined(CUDA_TARGET) && defined(USE_SUPER_CLUSTERS)
            }


            copyDataFromCUDADevice(&atom);
            updatePbc(&atom, &param, 0);
            copyDataToCUDADevice(&atom);
        } else {
            #ifdef CUDA_TARGET
            copyDataFromCUDADevice(&atom);
            #endif

            timer[NEIGH] += reneighbour(&param, &atom, &neighbor);

            #ifdef CUDA_TARGET
            copyDataToCUDADevice(&atom);
            isReneighboured = 1;
            #endif
        }

        #if defined(MEM_TRACER) || defined(INDEX_TRACER)
        traceAddresses(&param, &atom, &neighbor, n + 1);
        #endif


        /*
        printf("%d\t%d\r\n", atom.Nsclusters_local, atom.Nclusters_local);
        copyDataToCUDADevice(&atom);
        verifyLayout(&atom);

        //printClusterIndices(&atom);

        */

        if(param.force_field == FF_EAM) {
            timer[FORCE] += computeForceEam(&eam, &param, &atom, &neighbor, &stats);
        } else {
            timer[FORCE] += computeForceLJ(&param, &atom, &neighbor, &stats);
        }

        /*
        copyDataFromCUDADevice(&atom);
        verifyLayout(&atom);

        getchar();
        */

        finalIntegrate(&param, &atom);




        if(!((n + 1) % param.nstat) && (n+1) < param.ntimes) {
            computeThermo(n + 1, &param, &atom);
        }

        int write_pos = !((n + 1) % param.x_out_every);
        int write_vel = !((n + 1) % param.v_out_every);
        if(write_pos || write_vel) {
            if(param.vtk_file != NULL) {
                write_data_to_vtk_file(param.vtk_file, &atom, n + 1);
            }

            if(param.xtc_file != NULL) {
                xtc_write(&atom, n + 1, write_pos, write_vel);
            }
        }
    }

    #ifdef CUDA_TARGET
    copyDataFromCUDADevice(&atom);
    #endif

    timer[TOTAL] = getTimeStamp() - timer[TOTAL];
    updateSingleAtoms(&atom);
    computeThermo(-1, &param, &atom);

    if(param.xtc_file != NULL) {
        xtc_end();
    }

    #ifdef CUDA_TARGET
    cudaDeviceFree();
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
