/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <math.h>
#include <stdio.h>
#include <string.h>

#include <likwid-marker.h>
#ifdef _OPENMP
#include <omp.h>
#endif

#include <allocate.h>
#include <atom.h>
#include <device.h>
#include <eam.h>
#include <force.h>
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

extern void copyDataToCUDADevice(Atom*);
extern void copyDataFromCUDADevice(Atom*);
extern void cudaDeviceFree(void);
extern int isReneighboured;

#define HLINE "----------------------------------------------------------------------------\n"

double dynamicBalance(Comm* comm, Grid* grid, Atom* atom, Parameter* param, double time)
{
    double S, E;
    int dims = 3;   //TODO: Adjust to do in 3d and 2d
    S = getTimeStamp();
    if(param->balance == RCB) {
        rcbBalance(grid, atom, param, meanBisect,dims,0);
        neighComm(comm, param, grid);
    }else if(param->balance == meanTimeRCB){
        rcbBalance(grid, atom, param, meanTimeBisect,dims,time);
        neighComm(comm, param, grid);
    }else if(param->balance == Staggered) {
        staggeredBalance(grid, atom, param, time);
        neighComm(comm, param, grid);
        exchangeComm(comm,atom);
    }else { } //Do nothing
    //printGrid(grid);
    E = getTimeStamp();

    return E-S;
} 

double initialBalance(Parameter *param, Eam *eam, Atom *atom, Neighbor *neighbor, Stats *stats, Comm *comm, Grid *grid)
{      
    double E,S,time;
    int me;
    MPI_Comm_rank(world,&me);
    S = getTimeStamp();
    if(param->balance == meanTimeRCB || param->balance == RCB){
        rcbBalance(grid, atom, param, meanBisect,3,0);
        neighComm(comm, param, grid); 
    }      
    MPI_Allreduce(&atom->Nlocal, &atom->Natoms, 1, MPI_INT, MPI_SUM, world); 
    printf("Processor:%i, Local atoms:%i, Total atoms:%i\n",me, atom->Nlocal,atom->Natoms);
    MPI_Barrier(world);
    E = getTimeStamp();
    return E-S;
}

double setup(Parameter* param, Eam* eam, Atom* atom, Neighbor *neighbor, Stats *stats, Comm *comm, Grid *grid) 
{
    if (param->force_field == FF_EAM) { 
        initEam(param); 
        }
    double timeStart, timeStop;
    param->lattice = pow((4.0 / param->rho), (1.0 / 3.0));
    param->xprd    = param->nx * param->lattice;
    param->yprd    = param->ny * param->lattice;
    param->zprd    = param->nz * param->lattice;

    timeStart = getTimeStamp();
    initAtom(atom);
    initForce(param);
    //initPbc(atom);
    initStats(stats);
    initNeighbor(neighbor, param);
    if (param->input_file == NULL) {
        createAtom(atom, param);
    } else {
        readAtom(atom, param);
    }
    setupGrid(grid,atom,param);
    setupNeighbor(param, atom);
    setupComm(comm, param, grid);
    if(param->balance){  
        initialBalance(param, eam, atom, neighbor, stats, comm, grid);
    }
    setupThermo(param, atom->Natoms);
    if (param->input_file == NULL) { 
        adjustThermo(param, atom); 
    }
    buildClusters(atom);
    defineJClusters(atom);
    //setupPbc(atom, param);
    ghostNeighbor(comm, atom, param);
    binClusters(atom);
    buildNeighbor(atom, neighbor);
    initDevice(atom, neighbor);
    timeStop = getTimeStamp();
    return timeStop - timeStart;
}

double reneighbour(Comm* comm, Parameter *param, Atom *atom, Neighbor *neighbor) {
    double timeStart, timeStop;
    timeStart = getTimeStamp();
    LIKWID_MARKER_START("reneighbour");
    //updateSingleAtoms(atom); 
    //updateAtomsPbc(atom, param);
    buildClusters(atom);
    defineJClusters(atom);
    //setupPbc(atom, param);
    ghostNeighbor(comm, atom, param);
    binClusters(atom);
    buildNeighbor(atom, neighbor);
    LIKWID_MARKER_STOP("reneighbour");
    timeStop = getTimeStamp();
    return timeStop - timeStart;
}

double updateAtoms(Comm* comm, Atom* atom){
    double timeStart, timeStop;
    timeStart = getTimeStamp();
        updateSingleAtoms(atom);
        exchangeComm(comm, atom);
    timeStop = getTimeStamp();
    return timeStop - timeStart;
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
        // LIKWID_MARKER_REGISTER("reneighbour");
        // LIKWID_MARKER_REGISTER("pbc");
    }
    initComm(&argc, &argv, &comm); //change
    initParameter(&param);
    for (int i = 0; i < argc; i++) {
        if ((strcmp(argv[i], "-p") == 0) || (strcmp(argv[i], "--param") == 0)) {
            readParameter(&param, argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-f") == 0)) {
            if ((param.force_field = str2ff(argv[++i])) < 0) {
                fprintf(stderr, "Invalid force field!\n");
                exit(-1);
            }
            continue;
        }
        if ((strcmp(argv[i], "-i") == 0)) {
            param.input_file = strdup(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-e") == 0)) {
            param.eam_file = strdup(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-n") == 0) || (strcmp(argv[i], "--nsteps") == 0)) {
            param.ntimes = atoi(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-nx") == 0)) {
            param.nx = atoi(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-ny") == 0)) {
            param.ny = atoi(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-nz") == 0)) {
            param.nz = atoi(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-half") == 0)) {
            param.half_neigh = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-method") == 0)) {
            param.method = atoi(argv[++i]);
            if (param.method>2 || param.method< 0){
                if(comm.myproc == 0) fprintf(stderr, "Method does not exist!\n");
                endComm(&comm);   
                exit(0);
            }
            continue;
        }
        if((strcmp(argv[i], "-bal") == 0)) {
            param.balance = atoi(argv[++i]);
            if (param.balance>3 || param.balance< 0){
                if(comm.myproc == 0) fprintf(stderr, "Load balance does not exist!\n");
                endComm(&comm);   
                exit(0);
            }
            continue;
        }
        if ((strcmp(argv[i], "-m") == 0) || (strcmp(argv[i], "--mass") == 0)) {
            param.mass = atof(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-r") == 0) || (strcmp(argv[i], "--radius") == 0)) {
            param.cutforce = atof(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-s") == 0) || (strcmp(argv[i], "--skin") == 0)) {
            param.skin = atof(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "--freq") == 0)) {
            param.proc_freq = atof(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "--vtk") == 0)) {
            param.vtk_file = strdup(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "--xtc") == 0)) {
            #ifndef XTC_OUTPUT
            fprintf(stderr, 
                "XTC not available, set XTC_OUTPUT option in config.mk file and " 
                "recompile MD-Bench!");
            exit(-1);
            #else
            param.xtc_file = strdup(argv[++i]);
            #endif
            continue;
        }
        if ((strcmp(argv[i], "-h") == 0) || (strcmp(argv[i], "--help") == 0)) {
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
    
    if(param.balance>0 && param.method == 1){
        if(comm.myproc == 0) fprintf(stderr, "Half Shell is not supported with load balance!\n");
        endComm(&comm);   
        exit(0);
    }

    param.cutneigh = param.cutforce + param.skin;
    timer[SETUP]=setup(&param, &eam, &atom, &neighbor, &stats, &comm, &grid);
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
    timer[FORCE]   = computeForce(&param, &atom, &neighbor, &stats);
    //debug(&atom,&comm);
    timer[NEIGH]   = 0.0;
    timer[FORWARD] = 0.0;
    timer[UPDATE]  = 0.0;
    timer[BALANCE] = 0.0;
    timer[REVERSE] = reverse(&comm, &atom, &param);
    MPI_Barrier(world);
    timer[TOTAL] = getTimeStamp();

    if (param.vtk_file != NULL) {
        //write_data_to_vtk_file(param.vtk_file, &comm ,&atom, 0);
        printvtk(param.vtk_file, &comm, &atom, &param, 0); 
    }
    //TODO: modify xct
    if (param.xtc_file != NULL) {
        xtc_init(param.xtc_file, &atom, 0);
    }
    double forceTime = 0.0;
    double commTime  = 0.0;
    for (int n = 0; n < param.ntimes; n++) {  
        initialIntegrate(&param, &atom);
        if ((n + 1) % param.reneigh_every) {
            timer[FORWARD]+=forward(&comm, &atom, &param);
            if (!((n + 1) % param.prune_every)) {
                pruneNeighbor(&param, &atom, &neighbor);
            }
        } else {
            #ifdef CUDA_TARGET
            copyDataFromCUDADevice(&atom);
            #endif
            timer[UPDATE] +=updateAtoms(&comm,&atom);
            if(param.balance && !((n+1)%param.balance_every))
                timer[BALANCE] +=dynamicBalance(&comm, &grid, &atom , &param, timer[FORCE]);   
            timer[NEIGH]  += reneighbour(&comm, &param, &atom, &neighbor);
            #ifdef CUDA_TARGET
            copyDataToCUDADevice(&atom);
            isReneighboured = 1;
            #endif
        }
        #if defined(MEM_TRACER) || defined(INDEX_TRACER)
        traceAddresses(&param, &atom, &neighbor, n + 1);
        #endif
        timer[FORCE] += computeForce(&param, &atom, &neighbor, &stats);
        timer[REVERSE] += reverse(&comm, &atom, &param);
        finalIntegrate(&param, &atom);

        if (!((n + 1) % param.nstat) && (n + 1) < param.ntimes) {
            computeThermo(n + 1, &param, &atom);
        }

        int writePos = !((n + 1) % param.x_out_every);
        int writeVel = !((n + 1) % param.v_out_every);
        if (writePos || writeVel) {
            if (param.vtk_file != NULL) {
                //write_data_to_vtk_file(param.vtk_file, &atom, n + 1);
                printvtk(param.vtk_file, &comm, &atom, &param, n+1);
            }
            //TODO: xtc file
            if (param.xtc_file != NULL) {
                xtc_write(&atom, n + 1, write_pos, write_vel);
            }
        } 
    }

    #ifdef CUDA_TARGET
    copyDataFromCUDADevice(&atom);
    #endif
    MPI_Barrier(world);
    timer[TOTAL] = getTimeStamp() - timer[TOTAL];
    updateAtoms(&comm,&atom);
    computeThermo(-1, &param, &atom);
    //TODO: xtc file
    if (param.xtc_file != NULL) {
        xtc_end();
    }

    #ifdef CUDA_TARGET
    cudaDeviceFree();
    #endif
    double mint[NUMTIMER];
    double maxt[NUMTIMER];
    double sumt[NUMTIMER];
    timer[REST] = timer[TOTAL]-timer[FORCE]-timer[NEIGH]-timer[BALANCE]-timer[FORWARD]-timer[REVERSE];
    MPI_Reduce(timer,mint,NUMTIMER,MPI_DOUBLE,MPI_MIN,0,world);
    MPI_Reduce(timer,maxt,NUMTIMER,MPI_DOUBLE,MPI_MAX,0,world);
    MPI_Reduce(timer,sumt,NUMTIMER,MPI_DOUBLE,MPI_SUM,0,world);
    int Nghost;
    MPI_Reduce(&atom.Nghost,&Nghost,1,MPI_INT,MPI_SUM,0,world);
    
    if(comm.myproc == 0){
        int n = comm.numproc;
        printf(HLINE);
        printf("System: %d atoms %d ghost atoms, Steps: %d\n", 
        atom.Natoms, 
        Nghost, 
        param.ntimes);
        printf("TOTAL %.2fs\n\n",timer[TOTAL]);
        printf("%4s|%7s|%7s|%7s|%7s|%7s|%7s|%7s|%7s|\n","","FORCE ", "NEIGH ", "BALANCE", "FORWARD", "REVERSE","UPDATE","REST ","SETUP");
        printf("----|-------|-------|-------|-------|-------|-------|-------|-------|\n");
        printf("%4s|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|\n", "AVG", sumt[FORCE]/n,sumt[NEIGH]/n,sumt[BALANCE]/n,sumt[FORWARD]/n,sumt[REVERSE]/n,sumt[UPDATE]/n,sumt[REST]/n,sumt[SETUP]/n);
        printf("%4s|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|\n", "MIN", mint[FORCE],mint[NEIGH],mint[BALANCE],mint[FORWARD],mint[REVERSE],mint[UPDATE],mint[REST],mint[SETUP]);
        printf("%4s|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|\n", "MAX", maxt[FORCE],maxt[NEIGH],maxt[BALANCE],maxt[FORWARD],maxt[REVERSE],maxt[UPDATE],maxt[REST],maxt[SETUP]);
        printf(HLINE);
#ifdef _OPENMP
    int nthreads  = 0;
    int chunkSize = 0;
    omp_sched_t schedKind;
    char schedType[10];
#pragma omp parallel
#pragma omp master
    {
        omp_get_schedule(&schedKind, &chunkSize);

        switch (schedKind) {
        case omp_sched_static:
            strcpy(schedType, "static");
            break;
        case omp_sched_dynamic:
            strcpy(schedType, "dynamic");
            break;
        case omp_sched_guided:
            strcpy(schedType, "guided");
            break;
        case omp_sched_auto:
            strcpy(schedType, "auto");
            break;
        }

        nthreads = omp_get_max_threads();
    }

    printf("Num threads: %d\n", nthreads);
    printf("Schedule: (%s,%d)\n", schedType, chunkSize);
#endif

        printf("Performance: %.2f million atom updates per second\n",
                1e-6 * (double)atom.Natoms * param.ntimes / timer[TOTAL]);
#ifdef COMPUTE_STATS
    displayStatistics(&atom, &param, &stats, timer);
#endif
    }
    endComm(&comm);
    LIKWID_MARKER_CLOSE;
    return EXIT_SUCCESS;
}
