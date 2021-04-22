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
    int atoms_per_unit_cell = 8;
    int csv = 0;
    double freq = 0.0;

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
        if((strcmp(argv[i], "-na") == 0))
        {
            atoms_per_unit_cell = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-f") == 0))
        {
            freq = atof(argv[++i]) * 1.E9;
            continue;
        }
        if((strcmp(argv[i], "-csv") == 0))
        {
            csv = 1;
            continue;
        }
        if((strcmp(argv[i], "-h") == 0) || (strcmp(argv[i], "--help") == 0))
        {
            printf("MD Bench: A minimalistic re-implementation of miniMD\n");
            printf(HLINE);
            printf("-n / --nsteps <int>:  set number of timesteps for simulation\n");
            printf("-nx/-ny/-nz <int>:    set linear dimension of systembox in x/y/z direction\n");
            printf("-na <int>:            set number of atoms per unit cell\n");
            printf("-f <real>:            set CPU frequency (GHz) and display average cycles per atom and neighbors\n");
            printf("-csv:                 set output as CSV style\n");
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
    for(int i = 0; i < param.nx; ++i) {
        for(int j = 0; j < param.ny; ++j) {
            for(int k = 0; k < param.nz; ++k) {
                int added_atoms = 0;
                int fac_x = 1;
                int fac_y = 1;
                int fac_z = 1;
                int fmod = 0;
                MD_FLOAT base_x = i * LATTICE_DISTANCE;
                MD_FLOAT base_y = j * LATTICE_DISTANCE;
                MD_FLOAT base_z = k * LATTICE_DISTANCE;
                MD_FLOAT vx = 0.0;
                MD_FLOAT vy = 0.0;
                MD_FLOAT vz = 0.0;

                while(atom->Nlocal > atom->Nmax - atoms_per_unit_cell) {
                    growAtom(atom);
                }

                while(fac_x * fac_y * fac_z < atoms_per_unit_cell) {
                    if(fmod == 0) { fac_x *= 2; }
                    if(fmod == 1) { fac_y *= 2; }
                    if(fmod == 2) { fac_z *= 2; }
                    fmod = (fmod + 1) % 3;
                }

                MD_FLOAT offset_x = (fac_x > 1) ? 1.0 / (fac_x - 1) : (int)fac_x;
                MD_FLOAT offset_y = (fac_y > 1) ? 1.0 / (fac_y - 1) : (int)fac_y;
                MD_FLOAT offset_z = (fac_z > 1) ? 1.0 / (fac_z - 1) : (int)fac_z;
                for(int ii = 0; ii < fac_x; ++ii) {
                    for(int jj = 0; jj < fac_y; ++jj) {
                        for(int kk = 0; kk < fac_z; ++kk) {
                            if(added_atoms < atoms_per_unit_cell) {
                                ADD_ATOM(ii * offset_x, jj * offset_y, kk * offset_z, vx, vy, vz);
                                added_atoms++;
                            }
                        }
                    }
                }
            }
        }
    }

    const double estim_atom_volume = (double)(atom->Nlocal * 3 * sizeof(MD_FLOAT));
    const double estim_neighbors_volume = (double)(atom->Nlocal * (atoms_per_unit_cell - 1 + 2) * sizeof(int));
    const double estim_volume = (double)(atom->Nlocal * 6 * sizeof(MD_FLOAT) + estim_neighbors_volume);

    if(!csv) {
        printf("Number of timesteps: %d\n", param.ntimes);
        printf("System size (unit cells): %dx%dx%d\n", param.nx, param.ny, param.nz);
        printf("Atoms per unit cell: %d\n", atoms_per_unit_cell);
        printf("Total number of atoms: %d\n", atom->Nlocal);
        printf("Estimated total data volume (kB): %.4f\n", estim_volume / 1000.0);
        printf("Estimated atom data volume (kB): %.4f\n", estim_atom_volume / 1000.0);
        printf("Estimated neighborlist data volume (kB): %.4f\n", estim_neighbors_volume / 1000.0);
    }

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
    const double atoms_updates_per_sec = atom->Nlocal * param.ntimes / T_accum;
    const double cycles_per_atom = T_accum * freq / (atom->Nlocal * param.ntimes);
    const double cycles_per_neigh = T_accum * freq / (atom->Nlocal * (atoms_per_unit_cell - 1) * param.ntimes);

    if(!csv) {
        printf("Total time: %.4f, Mega atom updates/s: %.4f\n", T_accum, atoms_updates_per_sec / 1.E6);
        if(freq > 0.0) {
            printf("Cycles per atom: %.4f, Cycles per neighbor: %.4f\n", cycles_per_atom, cycles_per_neigh);
        }
    } else {
        printf("steps,unit cells,atoms/unit cell,total atoms,total vol.(kB),atoms vol.(kB),neigh vol.(kB),time(s),atom upds/s(M)");
        if(freq > 0.0) {
            printf(",cy/atom,cy/neigh");
        }
        printf("\n");

        printf("%d,%dx%dx%d,%d,%d,%.4f,%.4f,%.4f,%.4f,%.4f",
            param.ntimes, param.nx, param.ny, param.nz, atoms_per_unit_cell, atom->Nlocal,
            estim_volume / 1.E3, estim_atom_volume / 1.E3, estim_neighbors_volume / 1.E3, T_accum, atoms_updates_per_sec / 1.E6);

        if(freq > 0.0) {
            printf(",%.4f,%.4f", cycles_per_atom, cycles_per_neigh);
        }
        printf("\n");
    }

    LIKWID_MARKER_CLOSE;
    return EXIT_SUCCESS;
}
