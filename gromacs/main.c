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
#include <comm.h>
#include <grid.h>
#include <shell_methods.h>
#include <mpi.h>

void debug(Atom* atom, Comm* comm)
{
    printf("Local:%i, ghost:%i\n",atom->Nclusters_local,atom->Nclusters_ghost);
        for(int ci=0; ci<atom->Nclusters_local;ci++)
        {
            int natoms = atom->iclusters[ci].natoms;
            MD_FLOAT bbminx = atom->iclusters[ci].bbminx;    MD_FLOAT bbmaxx = atom->iclusters[ci].bbmaxx;
            MD_FLOAT bbminy = atom->iclusters[ci].bbminy;    MD_FLOAT bbmaxy = atom->iclusters[ci].bbmaxy;
            MD_FLOAT bbminz = atom->iclusters[ci].bbminz;    MD_FLOAT bbmaxz = atom->iclusters[ci].bbmaxz;
    
            printf("ci:%i  natoms:%i, bbminx:%f, bbmaxx:%f, bbminy:%f, bbmaxy:%f bbminz:%f, bbmaxz:%f\n",ci,natoms,bbminx,bbmaxx,bbminy,bbmaxy,bbminz,bbmaxz);

            int cj_vec_base = CJ_VECTOR_BASE_INDEX(ci);
            int cj_sca_base = CJ_SCALAR_BASE_INDEX(ci); 
            MD_FLOAT *cj_x = &atom->cl_x[cj_vec_base];
            MD_FLOAT *cj_v = &atom->cl_v[cj_vec_base];
            MD_FLOAT *cj_f = &atom->cl_f[cj_vec_base];

            for(int cii= 0; cii < atom->iclusters[ci].natoms; cii++){
                MD_FLOAT x = cj_x[CL_X_OFFSET + cii]; 
                MD_FLOAT y = cj_x[CL_Y_OFFSET + cii];
                MD_FLOAT z = cj_x[CL_Z_OFFSET + cii];
                MD_FLOAT vx = cj_v[CL_X_OFFSET + cii]; 
                MD_FLOAT vy = cj_v[CL_Y_OFFSET + cii];
                MD_FLOAT vz = cj_v[CL_Z_OFFSET + cii];
                MD_FLOAT fx = cj_f[CL_X_OFFSET + cii]; 
                MD_FLOAT fy = cj_f[CL_Y_OFFSET + cii];
                MD_FLOAT fz = cj_f[CL_Z_OFFSET + cii];
                printf("\tatom:%i x:%f y:%f z:%f vx:%f vy:%f vz:%f fx:%f fy:%f fz:%f\n",cii,x,y,z,vx,vy,vz,fx,fy,fz);
            }
        }
        printf("Ghost atoms ===========\n");
        for(int cg=atom->Nclusters_local; cg<atom->Nclusters_local+atom->Nclusters_ghost;cg++)
        {
            int natoms = atom->jclusters[cg].natoms;
            MD_FLOAT bbminx = atom->jclusters[cg].bbminx;    MD_FLOAT bbmaxx = atom->iclusters[cg].bbmaxx;
            MD_FLOAT bbminy = atom->jclusters[cg].bbminy;    MD_FLOAT bbmaxy = atom->iclusters[cg].bbmaxy;
            MD_FLOAT bbminz = atom->jclusters[cg].bbminz;    MD_FLOAT bbmaxz = atom->iclusters[cg].bbmaxz;
    
            printf("cg:%i  natoms:%i, bbminx:%f, bbmaxx:%f, bbminy:%f, bbmaxy:%f bbminz:%f, bbmaxz:%f\n",cg,natoms,bbminx,bbmaxx,bbminy,bbmaxy,bbminz,bbmaxz);

            int cj_vec_base = CJ_VECTOR_BASE_INDEX(cg);
            int cj_sca_base = CJ_SCALAR_BASE_INDEX(cg); 
            MD_FLOAT *cj_x = &atom->cl_x[cj_vec_base];
            MD_FLOAT *cj_v = &atom->cl_v[cj_vec_base];
            MD_FLOAT *cj_f = &atom->cl_f[cj_vec_base];

            for(int cii= 0; cii < atom->jclusters[cg].natoms; cii++){
                MD_FLOAT x = cj_x[CL_X_OFFSET + cii]; 
                MD_FLOAT y = cj_x[CL_Y_OFFSET + cii];
                MD_FLOAT z = cj_x[CL_Z_OFFSET + cii];
                MD_FLOAT vx = cj_v[CL_X_OFFSET + cii]; 
                MD_FLOAT vy = cj_v[CL_Y_OFFSET + cii];
                MD_FLOAT vz = cj_v[CL_Z_OFFSET + cii];
                MD_FLOAT fx = cj_f[CL_X_OFFSET + cii]; 
                MD_FLOAT fy = cj_f[CL_Y_OFFSET + cii];
                MD_FLOAT fz = cj_f[CL_Z_OFFSET + cii];
                printf("\tghost:%i x:%f y:%f z:%f vx:%f vy:%f vz:%f fx:%f fy:%f fz:%f\n",cii,x,y,z,vx,vy,vz,fx,fy,fz);
            }
        }
 //exit(0); 
}

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
#endif

double setup(Parameter *param, Eam *eam, Atom *atom, Neighbor *neighbor, Stats *stats, Comm *comm, Grid *grid) {
    if(param->force_field == FF_EAM) { initEam(eam, param); }
    double S, E;
    param->lattice = pow((4.0 / param->rho), (1.0 / 3.0));
    param->xprd = param->nx * param->lattice;
    param->yprd = param->ny * param->lattice;
    param->zprd = param->nz * param->lattice;

    S = getTimeStamp();
    initAtom(atom);
    //initPbc(atom);
    initStats(stats);
    initNeighbor(neighbor, param);
    initGrid(grid); //change
    if(param->input_file == NULL) {
        setupGrid(grid,atom,param);
        createAtom(atom, param);
    } else {
        readAtom(atom, param);
        setupGrid(grid,atom,param);
    }
    //printGrid(grid);
    setupComm(comm, param, grid->map);
    setupNeighbor(param, atom);
    setupThermo(param, atom->Natoms);
    if(param->input_file == NULL) { adjustThermo(param, atom); }
    buildClusters(atom);
    defineJClusters(atom);
    //setupPbc(atom, param);
    ghostNeighbor(comm, atom, param); //change
    binClusters(atom);
    buildNeighbor(atom, neighbor);
    initDevice(atom, neighbor);
    E = getTimeStamp();
    return E-S;
}

double reneighbour(Comm* comm, Parameter *param, Atom *atom, Neighbor *neighbor) {
    double S, E;
    S = getTimeStamp();
    LIKWID_MARKER_START("reneighbour");
    updateSingleAtoms(atom);
    exchangeComm(comm, atom);
    //printf("atom->Nocal:%i \n",atom->Nlocal);
    //updateAtomsPbc(atom, param);
    buildClusters(atom);
    defineJClusters(atom);
    //setupPbc(atom, param);
    ghostNeighbor(comm, atom, param); //change
    binClusters(atom);
    buildNeighbor(atom, neighbor);
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
    Comm comm; 
    Grid grid;
    LIKWID_MARKER_INIT;
#pragma omp parallel
    {
        LIKWID_MARKER_REGISTER("force");
        //LIKWID_MARKER_REGISTER("reneighbour");
        //LIKWID_MARKER_REGISTER("pbc");
    }
    initComm(&argc, &argv, &comm); //change
    initParameter(&param);
    for(int i = 0; i < argc; i++) {
        if((strcmp(argv[i], "-p") == 0) || (strcmp(argv[i], "--param") == 0)) {
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
        if((strcmp(argv[i], "-method") == 0)) {
            param.method = atoi(argv[++i]);
            if (param.method>3 || param.method< 0){
                if(comm.myproc == 0) fprintf(stderr, "Method does not exist!\n");
                endComm(&comm);   
                exit(0);
            }
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
            //TODO: add the shell and ac print options
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
    setup(&param, &eam, &atom, &neighbor, &stats, &comm, &grid);
    //debug(&atom,&comm);
    if(comm.myproc == 0) printParameter(&param);
    if(comm.myproc == 0) printf(HLINE);
    if(comm.myproc == 0) printf("step\ttemp\t\tpressure\n");
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

    timer[NEIGH]    = 0.0;
    timer[FORWARD]  = 0.0;
    timer[REVERSE]  = reverse(&comm, &atom, &param);
    timer[TOTAL] = getTimeStamp();

    if(param.vtk_file != NULL) {
        //write_data_to_vtk_file(param.vtk_file, &comm ,&atom, 0);
        printvtk(param.vtk_file, &comm, &atom, &param, 0); 
    }
    //TODO: modify xct
    if(param.xtc_file != NULL) {
        xtc_init(param.xtc_file, &atom, 0);
    }

    for(int n = 0; n < param.ntimes; n++) {
        initialIntegrate(&param, &atom);

        if((n + 1) % param.reneigh_every) {
            if(!((n + 1) % param.prune_every)) {
                pruneNeighbor(&param, &atom, &neighbor);
            }
            timer[FORWARD]+=forward(&comm, &atom, &param);
            //updatePbc(&atom, &param, 0);
        } else {
            #ifdef CUDA_TARGET
            copyDataFromCUDADevice(&atom);
            #endif

            timer[NEIGH] += reneighbour(&comm, &param, &atom, &neighbor);

            #ifdef CUDA_TARGET
            copyDataToCUDADevice(&atom);
            isReneighboured = 1;
            #endif
        }

        #if defined(MEM_TRACER) || defined(INDEX_TRACER)
        traceAddresses(&param, &atom, &neighbor, n + 1);
        #endif

        if(param.force_field == FF_EAM) {
            timer[FORCE] += computeForceEam(&eam, &param, &atom, &neighbor, &stats);
        } else {
            timer[FORCE] += computeForceLJ(&param, &atom, &neighbor, &stats);
        }
        timer[REVERSE] += reverse(&comm, &atom, &param);
        finalIntegrate(&param, &atom);

        if(!((n + 1) % param.nstat) && (n+1) < param.ntimes) {
            computeThermo(n + 1, &param, &atom);
        }

        int write_pos = !((n + 1) % param.x_out_every);
        int write_vel = !((n + 1) % param.v_out_every);
        if(write_pos || write_vel) {
            if(param.vtk_file != NULL) {
                //write_data_to_vtk_file(param.vtk_file, &atom, n + 1);
                printvtk(param.vtk_file, &comm, &atom, &param, n+1);
            }
            //TODO: xtc file
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
    exchangeComm(&comm, &atom);
    computeThermo(-1, &param, &atom);
    //TODO:
    if(param.xtc_file != NULL) {
        xtc_end();
    }

    #ifdef CUDA_TARGET
    cudaDeviceFree();
    #endif
    if(comm.myproc == 0){
        printf(HLINE);
        printf("System: %d atoms %d ghost atoms, Steps: %d\n", atom.Natoms, atom.Nghost, param.ntimes);
        printf("TOTAL %.2fs FORCE %.2fs NEIGH %.2fs FORWARD %.2fs REVERSE %.2fs REST %.2fs\n",
                timer[TOTAL], timer[FORCE], timer[NEIGH], timer[FORWARD], timer[REVERSE], 
                timer[TOTAL]-timer[FORCE]-timer[NEIGH]-timer[FORWARD]-timer[REVERSE]);
        printf(HLINE);
        printf("Performance: %.2f million atom updates per second\n",
                1e-6 * (double) atom.Natoms * param.ntimes / timer[TOTAL]);
#ifdef COMPUTE_STATS
        displayStatistics(&atom, &param, &stats, timer);
#endif
    }
    endComm(&comm);
    LIKWID_MARKER_CLOSE;
    return EXIT_SUCCESS;
}
