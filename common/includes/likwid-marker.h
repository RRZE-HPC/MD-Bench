/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#ifndef LIKWID_MARKER_H
#define LIKWID_MARKER_H


/** \addtogroup MarkerAPI Marker API module
*  @{
*/
/*!
\def LIKWID_MARKER_INIT
Shortcut for likwid_markerInit() if compiled with -DLIKWID_PERFMON. Otherwise no operation is performed
*/
/*!
\def LIKWID_MARKER_THREADINIT
Shortcut for likwid_markerThreadInit() if compiled with -DLIKWID_PERFMON. Otherwise no operation is performed
*/
/*!
\def LIKWID_MARKER_REGISTER(regionTag)
Shortcut for likwid_markerRegisterRegion() with \a regionTag if compiled with -DLIKWID_PERFMON. Otherwise no operation is performed
*/
/*!
\def LIKWID_MARKER_START(regionTag)
Shortcut for likwid_markerStartRegion() with \a regionTag if compiled with -DLIKWID_PERFMON. Otherwise no operation is performed
*/
/*!
\def LIKWID_MARKER_STOP(regionTag)
Shortcut for likwid_markerStopRegion() with \a regionTag if compiled with -DLIKWID_PERFMON. Otherwise no operation is performed
*/
/*!
\def LIKWID_MARKER_GET(regionTag, nevents, events, time, count)
Shortcut for likwid_markerGetResults() for \a regionTag if compiled with -DLIKWID_PERFMON. Otherwise no operation is performed
*/
/*!
\def LIKWID_MARKER_SWITCH
Shortcut for likwid_markerNextGroup() if compiled with -DLIKWID_PERFMON. Otherwise no operation is performed
*/
/*!
\def LIKWID_MARKER_RESET(regionTag)
Shortcut for likwid_markerResetRegion() if compiled with -DLIKWID_PERFMON. Otherwise no operation is performed
*/
/*!
\def LIKWID_MARKER_CLOSE
Shortcut for likwid_markerClose() if compiled with -DLIKWID_PERFMON. Otherwise no operation is performed
*/
/** @}*/

#ifdef LIKWID_PERFMON
#include <likwid.h>
#define LIKWID_MARKER_INIT likwid_markerInit()
#define LIKWID_MARKER_THREADINIT likwid_markerThreadInit()
#define LIKWID_MARKER_SWITCH likwid_markerNextGroup()
#define LIKWID_MARKER_REGISTER(regionTag) likwid_markerRegisterRegion(regionTag)
#define LIKWID_MARKER_START(regionTag) likwid_markerStartRegion(regionTag)
#define LIKWID_MARKER_STOP(regionTag) likwid_markerStopRegion(regionTag)
#define LIKWID_MARKER_CLOSE likwid_markerClose()
#define LIKWID_MARKER_RESET(regionTag) likwid_markerResetRegion(regionTag)
#define LIKWID_MARKER_GET(regionTag, nevents, events, time, count) likwid_markerGetRegion(regionTag, nevents, events, time, count)
#else  /* LIKWID_PERFMON */
#define LIKWID_MARKER_INIT
#define LIKWID_MARKER_THREADINIT
#define LIKWID_MARKER_SWITCH
#define LIKWID_MARKER_REGISTER(regionTag)
#define LIKWID_MARKER_START(regionTag)
#define LIKWID_MARKER_STOP(regionTag)
#define LIKWID_MARKER_CLOSE
#define LIKWID_MARKER_GET(regionTag, nevents, events, time, count)
#define LIKWID_MARKER_RESET(regionTag)
#endif /* LIKWID_PERFMON */


/** \addtogroup NvMarkerAPI NvMarker API module (MarkerAPI for Nvidia GPUs)
*  @{
*/
/*!
\def LIKWID_NVMARKER_INIT
Shortcut for likwid_gpuMarkerInit() if compiled with -DLIKWID_PERFMON. Otherwise no operation is performed
*/
/*!
\def LIKWID_NVMARKER_THREADINIT
Shortcut for likwid_gpuMarkerThreadInit() if compiled with -DLIKWID_PERFMON. Otherwise no operation is performed
*/
/*!
\def LIKWID_NVMARKER_REGISTER(regionTag)
Shortcut for likwid_gpuMarkerRegisterRegion() with \a regionTag if compiled with -DLIKWID_NVMON. Otherwise no operation is performed
*/
/*!
\def LIKWID_NVMARKER_START(regionTag)
Shortcut for likwid_gpuMarkerStartRegion() with \a regionTag if compiled with -DLIKWID_NVMON. Otherwise no operation is performed
*/
/*!
\def LIKWID_NVMARKER_STOP(regionTag)
Shortcut for likwid_gpuMarkerStopRegion() with \a regionTag if compiled with -DLIKWID_NVMON. Otherwise no operation is performed
*/
/*!
\def LIKWID_NVMARKER_GET(regionTag, ngpus, nevents, events, time, count)
Shortcut for likwid_gpuMarkerGetRegion() for \a regionTag if compiled with -DLIKWID_NVMON. Otherwise no operation is performed
*/
/*!
\def LIKWID_NVMARKER_SWITCH
Shortcut for likwid_gpuMarkerNextGroup() if compiled with -DLIKWID_NVMON. Otherwise no operation is performed
*/
/*!
\def LIKWID_NVMARKER_RESET(regionTag)
Shortcut for likwid_gpuMarkerResetRegion() if compiled with -DLIKWID_NVMON. Otherwise no operation is performed
*/
/*!
\def LIKWID_NVMARKER_CLOSE
Shortcut for likwid_gpuMarkerClose() if compiled with -DLIKWID_NVMON. Otherwise no operation is performed
*/
/** @}*/

#ifdef LIKWID_NVMON
#ifndef LIKWID_WITH_NVMON
#define LIKWID_WITH_NVMON
#endif
#include <likwid.h>
#define LIKWID_NVMARKER_INIT likwid_gpuMarkerInit()
#define LIKWID_NVMARKER_THREADINIT likwid_gpuMarkerThreadInit()
#define LIKWID_NVMARKER_SWITCH likwid_gpuMarkerNextGroup()
#define LIKWID_NVMARKER_REGISTER(regionTag) likwid_gpuMarkerRegisterRegion(regionTag)
#define LIKWID_NVMARKER_START(regionTag) likwid_gpuMarkerStartRegion(regionTag)
#define LIKWID_NVMARKER_STOP(regionTag) likwid_gpuMarkerStopRegion(regionTag)
#define LIKWID_NVMARKER_CLOSE likwid_gpuMarkerClose()
#define LIKWID_NVMARKER_RESET(regionTag) likwid_gpuMarkerResetRegion(regionTag)
#define LIKWID_NVMARKER_GET(regionTag, ngpus, nevents, events, time, count) \
    likwid_gpuMarkerGetRegion(regionTag, ngpus, nevents, events, time, count)
#else /* LIKWID_NVMON */
#define LIKWID_NVMARKER_INIT
#define LIKWID_NVMARKER_THREADINIT
#define LIKWID_NVMARKER_SWITCH
#define LIKWID_NVMARKER_REGISTER(regionTag)
#define LIKWID_NVMARKER_START(regionTag)
#define LIKWID_NVMARKER_STOP(regionTag)
#define LIKWID_NVMARKER_CLOSE
#define LIKWID_NVMARKER_GET(regionTag, nevents, events, time, count)
#define LIKWID_NVMARKER_RESET(regionTag)
#endif /* LIKWID_NVMON */



#endif /* LIKWID_MARKER_H */
