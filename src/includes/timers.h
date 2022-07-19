#ifndef __TIMERS_H_
#define __TIMERS_H_

typedef enum {
    TOTAL = 0,
    NEIGH,
    FORCE,
    NEIGH_UPDATE_ATOMS_PBC,
    NEIGH_SETUP_PBC,
    NEIGH_UPDATE_PBC,
    NEIGH_BINATOMS,
    NEIGH_BUILD_LISTS,
    NUMTIMER
} timertype;

#endif
