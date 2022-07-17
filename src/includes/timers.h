#ifndef __TIMERS_H_
#define __TIMERS_H_

typedef enum {
    TOTAL = 0,
    NEIGH,
    FORCE,
    NEIGH_UPDATE_ATOMS_PBC,
    NEIGH_SETUP_PBC,
    NEIGH_UPDATE_PBC,
    NEIGH_BUILD_NEIGHBOR,
    NUMTIMER
} timertype;

#endif
