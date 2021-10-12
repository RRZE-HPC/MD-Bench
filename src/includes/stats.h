/*
 * =======================================================================================
 *
 *   Author:   Jan Eitzinger (je), jan.eitzinger@fau.de
 *   Copyright (c) 2020 RRZE, University Erlangen-Nuremberg
 *
 *   This file is part of MD-Bench.
 *
 *   MD-Bench is free software: you can redistribute it and/or modify it
 *   under the terms of the GNU Lesser General Public License as published
 *   by the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   MD-Bench is distributed in the hope that it will be useful, but WITHOUT ANY
 *   WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 *   PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
 *   details.
 *
 *   You should have received a copy of the GNU Lesser General Public License along
 *   with MD-Bench.  If not, see <https://www.gnu.org/licenses/>.
 * =======================================================================================
 */
#include <atom.h>
#include <parameter.h>

#ifndef __STATS_H_
#define __STATS_H_
typedef struct {
    long long int total_force_neighs;
    long long int total_force_iters;
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
