
/*
 * Temporal functions for debugging, remove before proceeding with pull request
 */

#include <stdio.h>
#include <stdlib.h>
#include <utils.h>
#include <force.h>

extern void alignDataToSuperclusters(Atom *atom);
extern void alignDataFromSuperclusters(Atom *atom);

/*
void verifyClusters(Atom *atom) {
    unsigned int count = 0;

    for (int i = 0; i < atom->Nsclusters_local; i++) {
        for (int j = 0; j < atom->siclusters[i].nclusters; j++) {
            for(int cii = 0; cii < CLUSTER_M; cii++, count++);
        }
    }

    MD_FLOAT *x = malloc(count * sizeof(MD_FLOAT));
    MD_FLOAT *y = malloc(count * sizeof(MD_FLOAT));
    MD_FLOAT *z = malloc(count * sizeof(MD_FLOAT));

    count = 0;
    unsigned int diffs = 0;

    printf("######### %d #########\r\n", atom->Nsclusters_local);
    for (int i = 0; i < atom->Nsclusters_local; i++) {
        printf("######### %d\t #########\r\n", atom->siclusters[i].nclusters);

        for (int j = 0; j < atom->siclusters[i].nclusters; j++) {
            //printf("%d\t", atom.siclusters[i].iclusters[j]);
            MD_FLOAT *ci_x = &atom->cl_x[CI_VECTOR_BASE_INDEX(atom->siclusters[i].iclusters[j])];

            if (atom->iclusters[atom->siclusters[i].iclusters[j]].bbminx < atom->siclusters[i].bbminx ||
            atom->iclusters[atom->siclusters[i].iclusters[j]].bbmaxx > atom->siclusters[i].bbmaxx ||
            atom->iclusters[atom->siclusters[i].iclusters[j]].bbminy < atom->siclusters[i].bbminy ||
            atom->iclusters[atom->siclusters[i].iclusters[j]].bbmaxy > atom->siclusters[i].bbmaxy ||
            atom->iclusters[atom->siclusters[i].iclusters[j]].bbminz < atom->siclusters[i].bbminz ||
            atom->iclusters[atom->siclusters[i].iclusters[j]].bbmaxz > atom->siclusters[i].bbmaxz) diffs++;


            for(int cii = 0; cii < CLUSTER_M; cii++, count++) {
                x[count] = ci_x[CL_X_OFFSET + cii];
                y[count] = ci_x[CL_Y_OFFSET + cii];
                z[count] = ci_x[CL_Z_OFFSET + cii];
                //printf("x: %f\ty: %f\tz: %f\r\n", ci_x[CL_X_OFFSET + cii], ci_x[CL_Y_OFFSET + cii], ci_x[CL_Z_OFFSET + cii]);
            }
        }
        printf("######### \t #########\r\n");
    }

    printf("######### Diffs: %d\t #########\r\n", diffs);

    printf("\r\n");

    count = 0;
    diffs = 0;

    for (int i = 0; i < atom->Nclusters_local; i++) {
        MD_FLOAT *ci_x = &atom->cl_x[CI_VECTOR_BASE_INDEX(i)];

        for(int cii = 0; cii < CLUSTER_M; cii++, count++) {
            if (ci_x[CL_X_OFFSET + cii] != x[count] ||
                ci_x[CL_Y_OFFSET + cii] != y[count] ||
                ci_x[CL_Z_OFFSET + cii] != z[count]) diffs++;
        }
    }

    printf("######### Diffs: %d\t #########\r\n", diffs);
}
 */

void verifyLayout(Atom *atom) {

    printf("verifyLayout start\r\n");

    /*
    unsigned int count = 0;

    for (int i = 0; i < atom->Nsclusters_local; i++) {
        for (int j = 0; j < atom->siclusters[i].nclusters; j++, count++);
    }

    MD_FLOAT *scl_x = malloc(atom->Nsclusters_local * SCLUSTER_SIZE * 3 * CLUSTER_M * sizeof(MD_FLOAT));


    for (int sci = 0; sci < atom->Nsclusters_local; sci++) {
        const unsigned int scl_offset = sci * SCLUSTER_SIZE * 3 * CLUSTER_M;

        for (int ci = 0, scci = scl_offset; ci < atom->siclusters[sci].nclusters; ci++, scci += CLUSTER_M) {
            MD_FLOAT *ci_x = &atom->cl_x[CI_VECTOR_BASE_INDEX(atom->siclusters[sci].iclusters[ci])];

            const unsigned int atom_offset = scci;

            /*
            for(int cii = 0, scii = atom_offset; cii < CLUSTER_M; cii++, scii += 3) {
                scl_x[CL_X_OFFSET + scii] = ci_x[CL_X_OFFSET + cii];
                scl_x[CL_Y_OFFSET + scii] = ci_x[CL_Y_OFFSET + cii];
                scl_x[CL_Z_OFFSET + scii] = ci_x[CL_Z_OFFSET + cii];
                //printf("x: %f\ty: %f\tz: %f\r\n", ci_x[CL_X_OFFSET + cii], ci_x[CL_Y_OFFSET + cii], ci_x[CL_Z_OFFSET + cii]);
            }


            memcpy(&scl_x[atom_offset], &ci_x[0], CLUSTER_M * sizeof(MD_FLOAT));
            memcpy(&scl_x[atom_offset + SCLUSTER_SIZE * CLUSTER_M], &ci_x[0 + CLUSTER_M], CLUSTER_M * sizeof(MD_FLOAT));
            memcpy(&scl_x[atom_offset + 2 * SCLUSTER_SIZE * CLUSTER_M], &ci_x[0 + 2 * CLUSTER_M], CLUSTER_M * sizeof(MD_FLOAT));

        }
    }

    */
    //alignDataToSuperclusters(atom);

    //for (int sci = 0; sci < 2; sci++) {
    for (int sci = 4; sci < 6; sci++) {
        const unsigned int scl_offset = sci * SCLUSTER_SIZE;

        MD_FLOAT *sci_x = &atom->scl_f[SCI_VECTOR_BASE_INDEX(sci)];

        for (int cii = 0; cii < SCLUSTER_M; ++cii) {

            const unsigned int cl_idx = cii / CLUSTER_M;
            const unsigned int ciii = cii % CLUSTER_M;

            /*
            printf("%d\t%f\t%f\t%f\r\n", cl_idx, sci_x[cii],
                   sci_x[cii + SCLUSTER_SIZE * CLUSTER_M], sci_x[cii + 2 * SCLUSTER_SIZE * CLUSTER_M]);
            */

            printf("%d\t%d\t%f\t%f\t%f\r\n", atom->icluster_idx[SCLUSTER_SIZE * sci + cl_idx], cl_idx, sci_x[SCL_CL_X_OFFSET(cl_idx) + ciii],
                   sci_x[SCL_CL_Y_OFFSET(cl_idx) + ciii], sci_x[SCL_CL_Z_OFFSET(cl_idx) + ciii]);
        }



        /*
        //for (int cii = 0; cii < SCLUSTER_M; ++cii) {
        for (int cii = 0; cii < SCLUSTER_M; ++cii) {

            const unsigned int cl_idx = cii / CLUSTER_M;
            const unsigned int ciii = cii % CLUSTER_M;

            /*
            printf("%d\t%f\t%f\t%f\r\n", cl_idx, sci_x[SCL_X_OFFSET(cl_idx) + cii],
                   sci_x[SCL_Y_OFFSET(cl_idx) + cii], sci_x[SCL_Z_OFFSET(cl_idx) + cii]);
                   */

        /*
            printf("%d\t%f\t%f\t%f\r\n", cl_idx, sci_x[SCL_X_OFFSET(cl_idx) + ciii],
                   sci_x[SCL_Y_OFFSET(cl_idx) + ciii], sci_x[SCL_Z_OFFSET(cl_idx) + ciii]);
        }
        */










        /*
        for (int scii = scl_offset; scii < scl_offset + SCLUSTER_SIZE; scii++) {

            for (int cii = 0; cii < CLUSTER_M; ++cii) {
                printf("%f\t%f\t%f\r\n", sci_x[SCL_X_OFFSET(scii) + cii],
                       sci_x[SCL_Y_OFFSET(scii) + cii], sci_x[SCL_Z_OFFSET(scii) + cii]);
            }
            /*

            const unsigned int cl_offset = scii * 3 * CLUSTER_M;
            //MD_FLOAT *sci_x = &scl_x[CI_VECTOR_BASE_INDEX(scii)];

            for (int cii = cl_offset; cii < cl_offset + CLUSTER_M; ++cii) {
                printf("%f\t%f\t%f\r\n", sci_x[CL_X_OFFSET + cii],
                       sci_x[CL_Y_OFFSET + cii], sci_x[CL_Z_OFFSET + cii]);
            }
            */


        /*
        for (int cii = cl_offset; cii < cl_offset + CLUSTER_M; ++cii) {
            printf("%f\t%f\t%f\r\n", scl_x[CL_X_OFFSET + cii],
                   scl_x[CL_Y_OFFSET + cii], scl_x[CL_Z_OFFSET + cii]);
        }
        */

        //}

        printf("##########\t##########\r\n");
    }

    printf("\r\n");

    //for (int ci = 0; ci < 16; ci++) {
    for (int ci = 35; ci < 37; ci++) {
        printf("$$$$$$$$$$\t%d\t%d\t$$$$$$$$$$\r\n", ci, atom->icluster_bin[ci]);
        MD_FLOAT *ci_x = &atom->cl_f[CI_VECTOR_BASE_INDEX(ci)];

        //for(int cii = 0; cii < CLUSTER_M; cii++, count++) {
        for(int cii = 0; cii < CLUSTER_M; cii++) {

            printf("%f\t%f\t%f\r\n", ci_x[CL_X_OFFSET + cii],
                   ci_x[CL_Y_OFFSET + cii],
                   ci_x[CL_Z_OFFSET + cii]);
        }
        printf("##########\t##########\r\n");
    }

    printf("verifyLayout end\r\n");

    /*
    for (int i = 0; i < atom->Nclusters_local; i++) {
        MD_FLOAT *ci_x = &atom->cl_x[CI_VECTOR_BASE_INDEX(i)];

        for(int cii = 0; cii < CLUSTER_M; cii++, count++) {
            if (ci_x[CL_X_OFFSET + cii] != x[count] ||
                ci_x[CL_Y_OFFSET + cii] != y[count] ||
                ci_x[CL_Z_OFFSET + cii] != z[count]) diffs++;
        }
    }
     */
}

void checkAlignment(Atom *atom) {
    alignDataToSuperclusters(atom);

    for (int sci = 4; sci < 6; sci++) {
        MD_FLOAT *sci_x = &atom->scl_x[SCI_VECTOR_BASE_INDEX(sci)];

        for (int cii = 0; cii < SCLUSTER_M; ++cii) {

            const unsigned int cl_idx = cii / CLUSTER_M;
            const unsigned int ciii = cii % CLUSTER_M;

            printf("%d\t%f\t%f\t%f\r\n", cl_idx, sci_x[SCL_CL_X_OFFSET(cl_idx) + ciii],
                   sci_x[SCL_CL_Y_OFFSET(cl_idx) + ciii], sci_x[SCL_CL_Z_OFFSET(cl_idx) + ciii]);
        }

    }

    for (int ci = 35; ci < 37; ci++) {
        printf("$$$$$$$$$$\t%d\t%d\t$$$$$$$$$$\r\n", ci, atom->icluster_bin[ci]);
        MD_FLOAT *ci_x = &atom->cl_x[CI_VECTOR_BASE_INDEX(ci)];

        for(int cii = 0; cii < CLUSTER_M; cii++) {

            printf("%f\t%f\t%f\r\n", ci_x[CL_X_OFFSET + cii],
                   ci_x[CL_Y_OFFSET + cii],
                   ci_x[CL_Z_OFFSET + cii]);
        }
        printf("##########\t##########\r\n");
    }
}

void showSuperclusters(Atom *atom) {
    for (int sci = 4; sci < 6; sci++) {
        MD_FLOAT *sci_x = &atom->scl_x[SCI_VECTOR_BASE_INDEX(sci)];

        for (int cii = 0; cii < SCLUSTER_M; ++cii) {

            const unsigned int cl_idx = cii / CLUSTER_M;
            const unsigned int ciii = cii % CLUSTER_M;

            printf("%d\t%f\t%f\t%f\r\n", cl_idx, sci_x[SCL_CL_X_OFFSET(cl_idx) + ciii],
                   sci_x[SCL_CL_Y_OFFSET(cl_idx) + ciii], sci_x[SCL_CL_Z_OFFSET(cl_idx) + ciii]);
        }

    }
}

void printNeighs(Atom *atom, Neighbor *neighbor) {
    for (int i = 0; i < atom->Nclusters_local; ++i) {
        int neigh_num = neighbor->numneigh[i];
        for (int j = 0; j < neigh_num; j++) {
            printf("%d ", neighbor->neighbors[ i * neighbor->maxneighs + j]);
        }
        printf("\r\n");
    }
}

void printClusterIndices(Atom *atom) {
    for (int i = 0; i < atom->Nsclusters_local; ++i) {
        int clusters_num = atom->siclusters[i].nclusters;
        for (int j = 0; j < clusters_num; j++) {
            printf("%d ", atom->icluster_idx[j + SCLUSTER_SIZE * i]);
        }
        printf("\r\n");
    }
}

void verifyNeigh(Atom *atom, Neighbor *neighbor) {

    buildNeighbor(atom, neighbor);
    int *numneigh = (int*) malloc(atom->Nclusters_local * sizeof(int));
    int *neighbors = (int*) malloc(atom->Nclusters_local * neighbor->maxneighs * sizeof(int*));

    for (int i = 0; i < atom->Nclusters_local; ++i) {
        int neigh_num = neighbor->numneigh[i];
        numneigh[i] = neighbor->numneigh[i];
        neighbor->numneigh[i] = 0;
        for (int j = 0; j < neigh_num; j++) {
            neighbors[i * neighbor->maxneighs + j] = neighbor->neighbors[i * neighbor->maxneighs + j];
            neighbor->neighbors[i * neighbor->maxneighs + j] = 0;
        }
    }


    buildNeighbor(atom, neighbor);

    unsigned int num_diff = 0;
    unsigned int neigh_diff = 0;

    for (int i = 0; i < atom->Nclusters_local; ++i) {
        int neigh_num = neighbor->numneigh[i];
        if (numneigh[i] != neigh_num) num_diff++;
        for (int j = 0; j < neigh_num; j++) {
            if (neighbors[i * neighbor->maxneighs + j] !=
            neighbor->neighbors[ i * neighbor->maxneighs + j]) neigh_diff++;
        }
    }

    printf("%d\t%d\r\n", num_diff, neigh_diff);
}
