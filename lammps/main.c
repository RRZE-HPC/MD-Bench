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
#include <float.h>
#include <likwid-marker.h>
#include <allocate.h>
#include <atom.h>
#include <device.h>
#include <eam.h>
#include <integrate.h>
#include <thermo.h>
#include <timing.h>
#include <neighbor.h>
#include <parameter.h>
#include <stats.h>
#include <timers.h>
#include <util.h>
#include <vtk.h>
#include <comm.h>
#include <grid.h>
#include <shell_methods.h>
#include <mpi.h>

#define HLINE "----------------------------------------------------------------------------\n"
#ifdef CUDA_TARGET
extern double computeForceLJFullNeigh_cuda(Parameter*, Atom*, Neighbor*);
#endif

extern double computeForceLJFullNeigh_plain_c(Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceLJFullNeigh_simd(Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceLJHalfNeigh(Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceEam(Eam*, Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceDemFullNeigh(Parameter*, Atom*, Neighbor*, Stats*);

void debug(Atom* atom, Comm* comm)
{
    int me = comm->myproc;

    printf("rank:%i, Local:%i, ghost:%i\n",me,atom->Nlocal,atom->Nghost);
    MPI_Barrier(MPI_COMM_WORLD);  
    if(me==0)
        for(int i=0; i<atom->Nlocal;i++)   
            printf("%i x:%f y:%f z:%f vx:%f vy:%f vz:%f fx:%f fy:%f fz:%f\n",me,atom_x(i),atom_y(i),atom_z(i),atom_vx(i),atom_vy(i),atom_vz(i),atom_fx(i),atom_fy(i),atom_fz(i));
          
    MPI_Barrier(MPI_COMM_WORLD);
    printf("===================== rank2 =====================\n");
    if(comm->myproc==1)
        for(int i=0; i<atom->Nlocal;i++)
            printf("%i x:%f y:%f z:%f vx:%f vy:%f vz:%f fx:%f fy:%f fz:%f\n",me,atom_x(i),atom_y(i),atom_z(i),atom_vx(i),atom_vy(i),atom_vz(i),atom_fx(i),atom_fy(i),atom_fz(i));
    MPI_Barrier(MPI_COMM_WORLD);
    endComm(comm);
    exit(0);
}

double computeForce(Eam *eam, Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats) {
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

    if(param->half_neigh || param->method) {
        return computeForceLJHalfNeigh(param, atom, neighbor, stats);
    }

    #ifdef CUDA_TARGET
    return computeForceLJFullNeigh(param, atom, neighbor);
    #else
    return computeForceLJFullNeigh(param, atom, neighbor, stats);
    #endif
}

double dynamicBalance(Comm* comm, Grid* grid, Atom* atom, Parameter* param, double time)
{
    double S, E;
    MD_FLOAT prd[3] = {param->xprd, param->yprd, param->zprd};
    int dims = 3;   //TODO: Adjust to do in 3d and 2d
    S = getTimeStamp();
    if(param->balance == RCB) {
        rcbBalance(grid, atom, param, meanBisect,dims,0);
        neighComm(comm, grid->map, param->cutneigh, prd);
    }else if(param->balance == meanTimeRCB){
        rcbBalance(grid, atom, param, meanTimeBisect,dims,time);
        neighComm(comm, grid->map, param->cutneigh, prd);
    }else if(param->balance == Staggered) {
        staggeredBalance(grid, atom, param, time);
        neighComm(comm, grid->map, param->cutneigh, prd);
        exchangeComm(comm,atom);
    }else { } //Do nothing
    //printGrid(grid);
  E = getTimeStamp();
  
  return E-S;
} 

double initialBalance(Parameter *param, Eam *eam, Atom *atom, Neighbor *neighbor, Stats *stats, Comm *comm, Grid *grid)
{      
    double E,S;
    double time = 0;
    int me;
    MPI_Comm_rank(world,&me);
    S = getTimeStamp();
    if(param->balance == Staggered || param->balance == meanTimeRCB){
        buildNeighbor(atom, neighbor);
        time = computeForce(eam, param, atom, neighbor, stats);        
    }
    dynamicBalance(comm,grid,atom,param,time);
    MPI_Allreduce(&atom->Nlocal, &atom->Natoms, 1, MPI_INT, MPI_SUM, world); 
    printf("Processor:%i, Local atoms:%i, Total atoms:%i\n",me, atom->Nlocal,atom->Natoms);
    MPI_Barrier(world);
    E = getTimeStamp();
    return E-S;
}

double setup(Parameter *param, Eam *eam, Atom *atom, Neighbor *neighbor, Stats *stats, Comm *comm, Grid *grid) {
    if(param->force_field == FF_EAM) { initEam(eam, param); }
    double S, E;
    param->lattice = pow((4.0 / param->rho), (1.0 / 3.0));
    param->xprd = param->nx * param->lattice;
    param->yprd = param->ny * param->lattice;
    param->zprd = param->nz * param->lattice;
    S = getTimeStamp();
    initAtom(atom);
    initStats(stats);
    initNeighbor(neighbor, param);
    if(param->input_file == NULL) {
        createAtom(atom, param);
    } else {
        readAtom(atom, param);
    }
    setupGrid(grid,atom,param);
    setupNeighbor(param);
    setupComm(comm, param, grid->map);
    if(param->balance){  
        initialBalance(param, eam, atom, neighbor, stats, comm, grid);
    }
    setupThermo(param, atom->Natoms);
    if(param->input_file == NULL) { adjustThermo(param, atom); }
    #ifdef SORT_ATOMS
    atom->Nghost = 0;
    sortAtom(atom);
    #endif
    initDevice(atom, neighbor);
    ghostNeighbor(comm, atom, param);
    buildNeighbor(atom, neighbor); 
    E = getTimeStamp();
    return E-S;
}

double reneighbour(Comm* comm, Parameter *param, Atom *atom, Neighbor *neighbor) {
    double S, E;
    S = getTimeStamp();
    LIKWID_MARKER_START("reneighbour");
     #ifdef SORT_ATOMS
    atom->Nghost = 0;
    sortAtom(atom);
    #endif
    ghostNeighbor(comm, atom, param);
    buildNeighbor(atom, neighbor);
    LIKWID_MARKER_STOP("reneighbour");
    E = getTimeStamp();
    return E-S;
}

double updateAtoms(Comm* comm, Atom* atom){
    double S,E;
    S = getTimeStamp();
        exchangeComm(comm, atom);
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

void writeInput(Parameter *param, Atom *atom) {
    FILE *fpin = fopen("input.in", "w");
    fprintf(fpin, "0,%f,0,%f,0,%f\n", param->xprd, param->yprd, param->zprd);

    for(int i = 0; i < atom->Nlocal; i++) {
        fprintf(fpin, "1,%f,%f,%f,%f,%f,%f\n", atom_x(i), atom_y(i), atom_z(i), atom_vx(i), atom_vy(i), atom_vz(i));
    }

    fclose(fpin);
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
    initComm(&argc, &argv, &comm);
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
        if((strcmp(argv[i], "-method") == 0)) {
            param.method = atoi(argv[++i]);
            if (param.method>3 || param.method< 0){
                if(comm.myproc == 0) fprintf(stderr, "Method does not exist!\n");
                endComm(&comm);   
                exit(0);
            }
            continue;
        }
        if((strcmp(argv[i], "-bal") == 0)) {
            param.balance = atoi(argv[++i]);
            if (param.balance>3 || param.balance< 0){
                if(comm.myproc == 0) fprintf(stderr, "Load Balance does not exist!\n");
                endComm(&comm);   
                exit(0);
            }
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
            if(comm.myproc ==0 ){
                //TODO: add the shell and ac print options
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
            }
                exit(EXIT_SUCCESS);
        }
    }  
    param.cutneigh = param.cutforce + param.skin;
    setup(&param, &eam, &atom, &neighbor, &stats, &comm, &grid);
    if(comm.myproc == 0)printParameter(&param);
    if(comm.myproc == 0)printf(HLINE);
    if(comm.myproc == 0) printf("step\ttemp\t\tpressure\n");
    computeThermo(0, &param, &atom);
    #if defined(MEM_TRACER) || defined(INDEX_TRACER)
    traceAddresses(&param, &atom, &neighbor, n + 1);// TODO: trace adress
    #endif
    
    //writeInput(&param, &atom);
    timer[FORCE]    = computeForce(&eam, &param, &atom, &neighbor, &stats); 
    timer[NEIGH]    = 0.0;
    timer[FORWARD]  = 0.0;
    timer[UPDATE]   = 0.0;
    timer[BALANCE]  = 0.0;  
    timer[REVERSE]  = reverse(&comm, &atom, &param);
    MPI_Barrier(world);
    timer[TOTAL]    = getTimeStamp();
    
    if(param.vtk_file != NULL) {
        printvtk(param.vtk_file, &comm, &atom, &param, 0);
    }
    for(int n = 0; n < param.ntimes; n++) {
        bool reneigh = (n + 1) % param.reneigh_every == 0;
        initialIntegrate(reneigh, &param, &atom);
        if(reneigh) {
            timer[UPDATE] +=updateAtoms(&comm,&atom);            
            if(param.balance && !((n+1)%param.balance_every))
                timer[BALANCE] +=dynamicBalance(&comm, &grid, &atom , &param, timer[FORCE]);
            timer[NEIGH] += reneighbour(&comm, &param, &atom, &neighbor);
        } else {
            timer[FORWARD] += forward(&comm, &atom, &param);
        } 
        #if defined(MEM_TRACER) || defined(INDEX_TRACER)
        traceAddresses(&param, &atom, &neighbor, n + 1);
        #endif
        timer[FORCE] += computeForce(&eam, &param, &atom, &neighbor, &stats);
        timer[REVERSE] += reverse(&comm, &atom, &param);
        finalIntegrate(reneigh, &param, &atom);
        
        if(!((n + 1) % param.nstat) && (n+1) < param.ntimes) {
            #ifdef CUDA_TARGET
            memcpyFromGPU(atom.x, atom.d_atom.x, atom.Nmax * sizeof(MD_FLOAT) * 3);
            #endif
            computeThermo(n + 1, &param, &atom);
        }

        if(param.vtk_file != NULL) {
            printvtk(param.vtk_file, &comm, &atom ,&param, n+1);
        } 
    }
    MPI_Barrier(world);
    timer[TOTAL] = getTimeStamp() - timer[TOTAL];
    computeThermo(-1, &param, &atom);
        
    double mint[NUMTIMER];
    double maxt[NUMTIMER];
    double sumt[NUMTIMER];
    timer[REST] = timer[TOTAL]-timer[FORCE]-timer[NEIGH]-timer[BALANCE]-timer[FORWARD]-timer[REVERSE];
    MPI_Reduce(timer,mint,NUMTIMER,MPI_DOUBLE,MPI_MIN,0,world);
    MPI_Reduce(timer,maxt,NUMTIMER,MPI_DOUBLE,MPI_MAX,0,world);
    MPI_Reduce(timer,sumt,NUMTIMER,MPI_DOUBLE,MPI_SUM,0,world);

    if(comm.myproc == 0){
        int n = comm.numproc;
        printf(HLINE);
        printf("System: %d atoms %d ghost atoms, Steps: %d\n", atom.Natoms, atom.Nghost, param.ntimes);
        printf("TOTAL %.2fs\n\n",timer[TOTAL]);
        printf("%4s|%7s|%7s|%7s|%7s|%7s|%7s|%7s|\n","","FORCE ", "NEIGH ", "BALANCE", "FORWARD", "REVERSE","UPDATE","REST ");
        printf("----|-------|-------|-------|-------|-------|-------|-------|\n");
        printf("%4s|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|\n", "AVG", sumt[FORCE]/n,sumt[NEIGH]/n,sumt[BALANCE]/n,sumt[FORWARD]/n,sumt[REVERSE]/n,sumt[UPDATE]/n,sumt[REST]/n);
        printf("%4s|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|\n", "MIN", mint[FORCE],mint[NEIGH],mint[BALANCE],mint[FORWARD],mint[REVERSE],mint[UPDATE],mint[REST]);
        printf("%4s|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|%7.2f|\n", "MAX", maxt[FORCE],maxt[NEIGH],maxt[BALANCE],maxt[FORWARD],maxt[REVERSE],maxt[UPDATE],maxt[REST]);
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
