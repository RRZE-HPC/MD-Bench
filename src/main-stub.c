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

extern double computeForce( Parameter*, Atom*, Neighbor*, int);

void init(Parameter *param) {
    param->epsilon = 1.0;
    param->sigma6 = 1.0;
    param->rho = 0.8442;
    param->ntimes = 200;
    param->nx = 4;
    param->ny = 4;
    param->nz = 2;
    param->lattice = LATTICE_DISTANCE;
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

// Show debug messages
//#define DEBUG(msg)  printf(msg)
// Do not show debug messages
#define DEBUG(msg)

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
    DEBUG("Initializing parameters...\n");
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

    param.xprd = param.nx * LATTICE_DISTANCE;
    param.yprd = param.ny * LATTICE_DISTANCE;
    param.zprd = param.nz * LATTICE_DISTANCE;

    DEBUG("Initializing atoms...\n");
    initAtom(atom);

    DEBUG("Creating atoms...\n");
    const int atoms_per_unit_cell = 8;

    for(int i = 0; i < param.nx; ++i) {
        for(int j = 0; j < param.ny; ++j) {
            for(int k = 0; k < param.nz; ++k) {
                MD_FLOAT base_x = i * LATTICE_DISTANCE;
                MD_FLOAT base_y = j * LATTICE_DISTANCE;
                MD_FLOAT base_z = k * LATTICE_DISTANCE;
                MD_FLOAT vx = 0.0;
                MD_FLOAT vy = 0.0;
                MD_FLOAT vz = 0.0;

                while(atom->Nlocal > atom->Nmax - atoms_per_unit_cell) {
                    growAtom(atom);
                }

                if(atoms_per_unit_cell == 4) {
                    ADD_ATOM(0.0, 0.0, 0.0, vx, vy, vz);
                    ADD_ATOM(1.0, 0.0, 0.0, vx, vy, vz);
                    ADD_ATOM(0.0, 1.0, 0.0, vx, vy, vz);
                    ADD_ATOM(0.0, 0.0, 1.0, vx, vy, vz);
                } else if(atoms_per_unit_cell == 8) {
                    ADD_ATOM(0.0, 0.0, 0.0, vx, vy, vz);
                    ADD_ATOM(1.0, 0.0, 0.0, vx, vy, vz);
                    ADD_ATOM(0.0, 1.0, 0.0, vx, vy, vz);
                    ADD_ATOM(0.0, 0.0, 1.0, vx, vy, vz);
                    ADD_ATOM(1.0, 1.0, 0.0, vx, vy, vz);
                    ADD_ATOM(1.0, 0.0, 1.0, vx, vy, vz);
                    ADD_ATOM(0.0, 1.0, 1.0, vx, vy, vz);
                    ADD_ATOM(1.0, 1.0, 1.0, vx, vy, vz);
                } else if(atoms_per_unit_cell == 16) {
                    ADD_ATOM(0.0, 0.0, 0.0, vx, vy, vz);
                    ADD_ATOM(1.0, 0.0, 0.0, vx, vy, vz);
                    ADD_ATOM(0.0, 1.0, 0.0, vx, vy, vz);
                    ADD_ATOM(0.0, 0.0, 1.0, vx, vy, vz);
                    ADD_ATOM(1.0, 1.0, 0.0, vx, vy, vz);
                    ADD_ATOM(1.0, 0.0, 1.0, vx, vy, vz);
                    ADD_ATOM(0.0, 1.0, 1.0, vx, vy, vz);
                    ADD_ATOM(1.0, 1.0, 1.0, vx, vy, vz);
                    ADD_ATOM(0.5, 0.5, 0.5, vx, vy, vz);
                    ADD_ATOM(1.5, 0.5, 0.5, vx, vy, vz);
                    ADD_ATOM(0.5, 1.5, 0.5, vx, vy, vz);
                    ADD_ATOM(0.5, 0.5, 1.5, vx, vy, vz);
                    ADD_ATOM(1.5, 1.5, 0.5, vx, vy, vz);
                    ADD_ATOM(1.5, 0.5, 1.5, vx, vy, vz);
                    ADD_ATOM(0.5, 1.5, 1.5, vx, vy, vz);
                    ADD_ATOM(1.5, 1.5, 1.5, vx, vy, vz);
                } else {
                    printf("Invalid number of atoms per unit cell, must be: 4, 8 or 16\n");
                    return EXIT_FAILURE;
                }
            }
        }
    }

    const double estim_volume = (double)
	    (atom->Nlocal * 6 * sizeof(MD_FLOAT) +
	     atom->Nlocal * (atoms_per_unit_cell - 1 + 2) * sizeof(int)) / 1000.0;
    printf("System size (unit cells): %dx%dx%d\n", param.nx, param.ny, param.nz);
    printf("Atoms per unit cell: %d\n", atoms_per_unit_cell);
    printf("Total number of atoms: %d\n", atom->Nlocal);
    printf("Estimated total data volume (kB): %.4f\n", estim_volume );
    printf("Estimated atom data volume (kB): %.4f\n",
		    (double)(atom->Nlocal * 3 * sizeof(MD_FLOAT)  / 1000.0));
    printf("Estimated neighborlist data volume (kB): %.4f\n",
		    (double)(atom->Nlocal * (atoms_per_unit_cell - 1 + 2) * sizeof(int)) / 1000.0);

    DEBUG("Initializing neighbor lists...\n");
    initNeighbor(&neighbor, &param);
    DEBUG("Setting up neighbor lists...\n");
    setupNeighbor();
    DEBUG("Building neighbor lists...\n");
    buildNeighbor(atom, &neighbor);
    DEBUG("Computing forces...\n");
    computeForce(&param, atom, &neighbor, 0);

    double S, E;
    S = getTimeStamp();
    LIKWID_MARKER_START("force");
    for(int i = 0; i < param.ntimes; i++) {
        computeForce(&param, atom, &neighbor, 1);
    }
    LIKWID_MARKER_STOP("force");
    E = getTimeStamp();
    double T_accum = E-S;

    printf("Total time: %.4f, Mega atom updates/s: %.4f\n",
		    T_accum, atom->Nlocal * param.ntimes/T_accum/1.E6);
    LIKWID_MARKER_CLOSE;
    return EXIT_SUCCESS;
}
