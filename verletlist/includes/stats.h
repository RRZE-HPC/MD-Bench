/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <atom.h>
#include <parameter.h>

#ifndef __STATS_H_
#define __STATS_H_
typedef struct {
    long long int total_force_neighs;
    long long int total_force_iters;
    long long int atoms_within_cutoff;
    long long int atoms_outside_cutoff;
} Stats;

void initStats(Stats *s);
void displayStatistics(Atom *atom, Parameter *param, Stats *stats, double *timer);

#ifdef COMPUTE_STATS
#   define addStat(stat, value)     stat += value;
#   define beginStatTimer()         double Si = getTimeStamp();
#   define endStatTimer(stat)       stat += getTimeStamp() - Si;
#else
#   define addStat(stat, value)
#   define beginStatTimer()
#   define endStatTimer(stat)
#endif

#endif
