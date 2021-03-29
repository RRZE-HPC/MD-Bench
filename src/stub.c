#include <stdio.h>
#include <string.h>
//---
#include <likwid-marker.h>
//---
#include <timing.h>
#include <allocate.h>
#include <neighbor.h>
#include <parameter.h>
#include <atom.h>
#include <thermo.h>
#include <pbc.h>

#define HLINE "----------------------------------------------------------------------------\n"

#define LATTICE_DISTANCE    10.0
#define NEIGH_DISTANCE      1.0
#define NX                  4
#define NY                  4
#define NZ                  2

extern double computeForce( Parameter*, Atom*, Neighbor*);

void init(Parameter *param) {
    param->epsilon = 1.0;
    param->sigma6 = 1.0;
    param->rho = 0.8442;
    param->ntimes = 200;
    param->nx = NX;
    param->ny = NY;
    param->nz = NZ; 
    param->lattice = LATTICE_DISTANCE;
    param->xprd = NX * LATTICE_DISTANCE;
    param->yprd = NY * LATTICE_DISTANCE;
    param->zprd = NZ * LATTICE_DISTANCE;
    param->cutforce = 5.0;
    param->cutneigh = param->cutforce;
    param->mass = 1.0;
    // Unused
    param->dt = 0.005;
    param->dtforce = 0.5 * param->dt;
    param->nstat = 100;
    param->temp = 1.44;
    param->every = 20;
}

#define ADD_ATOM(x, y, z, vx, vy, vz)   atom_x(atom->Nlocal) = base_x + x * NEIGH_DISTANCE; \
                                        atom_y(atom->Nlocal) = base_y + y * NEIGH_DISTANCE; \
                                        atom_z(atom->Nlocal) = base_z + z * NEIGH_DISTANCE; \
                                        atom->vx[atom->Nlocal] = vy;                        \
                                        atom->vy[atom->Nlocal] = vy;                        \
                                        atom->vz[atom->Nlocal] = vz;                        \
                                        atom->Nlocal++ 

int main(int argc, const char *argv[]) {
    Atom atom_data;
    Atom *atom = (Atom *)(&atom_data);
    Neighbor neighbor;
    Parameter param;

    LIKWID_MARKER_INIT;
    LIKWID_MARKER_REGISTER("force");
    printf("Initializing parameters...\n");
    init(&param);

    for(int i = 0; i < argc; i++)
    {
        if((strcmp(argv[i], "-n") == 0) || (strcmp(argv[i], "--nsteps") == 0))
        {
            param.ntimes = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-nx") == 0))
        {
            param.nx = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-ny") == 0))
        {
            param.ny = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-nz") == 0))
        {
            param.nz = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-h") == 0) || (strcmp(argv[i], "--help") == 0))
        {
            printf("MD Bench: A minimalistic re-implementation of miniMD\n");
            printf(HLINE);
            printf("-n / --nsteps <int>:  set number of timesteps for simulation\n");
            printf("-nx/-ny/-nz <int>:    set linear dimension of systembox in x/y/z direction\n");
            printf(HLINE);
            exit(EXIT_SUCCESS);
        }
    }

    printf("Initializing atoms...\n");
    initAtom(atom);

    printf("Creating atoms...\n");
    // Neighbors per atom
    // Total atoms: NX * NY * NZ * atoms_per_unit_cell
    const int atoms_per_unit_cell = 8;

    for(int i = 0; i < NX; ++i) {
        for(int j = 0; j < NY; ++j) {
            for(int k = 0; k < NZ; ++k) {
                MD_FLOAT base_x = i * LATTICE_DISTANCE;
                MD_FLOAT base_y = j * LATTICE_DISTANCE;
                MD_FLOAT base_z = k * LATTICE_DISTANCE;
                MD_FLOAT vx = 0.0;
                MD_FLOAT vy = 0.0;
                MD_FLOAT vz = 0.0;

                while(atom->Nlocal > atom->Nmax - atoms_per_unit_cell) {
                    growAtom(atom);
                }

                ADD_ATOM(0.0, 0.0, 0.0, vx, vy, vz);
                ADD_ATOM(1.0, 0.0, 0.0, vx, vy, vz);
                ADD_ATOM(0.0, 1.0, 0.0, vx, vy, vz);
                ADD_ATOM(0.0, 0.0, 1.0, vx, vy, vz);
                ADD_ATOM(1.0, 1.0, 0.0, vx, vy, vz);
                ADD_ATOM(1.0, 0.0, 1.0, vx, vy, vz);
                ADD_ATOM(0.0, 1.0, 1.0, vx, vy, vz);
                ADD_ATOM(1.0, 1.0, 1.0, vx, vy, vz);
            }
        }
    }

    printf("Initializing neighbor lists...\n");
    initNeighbor(&neighbor, &param);
    printf("Setting up neighbor lists...\n");
    setupNeighbor();
    printf("Building neighbor lists...\n");
    buildNeighbor(atom, &neighbor);
    printf("Computing forces...\n");
    computeForce(&param, atom, &neighbor);
    LIKWID_MARKER_CLOSE;
    return EXIT_SUCCESS;
}
