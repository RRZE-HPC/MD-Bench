#!/bin/bash

TAG=ICC
OPT_SCHEME=lammps
MDBENCH_BIN=./MDBench-$TAG-$OPT_SCHEME
CORE=0
FREQ=2.4
NRUNS=3
FIXED_PARAMS="--freq $FREQ"
CPU_VENDOR=$(lscpu | grep "Vendor ID" | tr -s ' ' | cut -d ' ' -f3)
LOG=latencies_and_cfds.log

if [ "$CPU_VENDOR" == "GenuineIntel" ]; then
    ALL_PREFETCHERS="HW_PREFETCHER,CL_PREFETCHER,DCU_PREFETCHER,IP_PREFETCHER"
    PREFETCHERS=("ALL HW_PREFETCHER CL_PREFETCHER DCU_PREFETCHER IP_PREFETCHER NONE")
else
    ALL_PREFETCHERS=""
    PREFETCHERS=("IGNORE")
fi

if [ "$OPT_SCHEME" == "gromacs" ]; then
    STUB1_NAME=stub-33
    STUB1_PARAMS="-na 4 -nn 33"
    STUB2_NAME=stub-128
    STUB2_PARAMS="-na 4 -nn 128"
else
    STUB1_NAME=stub-76
    STUB1_PARAMS="-nn 76"
    STUB2_NAME=stub-1024
    STUB2_PARAMS="-nn 1024"
fi

function run_benchmark() {
    BEST=10000000
    for i in $(seq $NRUNS); do
        RES=$(likwid-pin -c $CORE "$* $FIXED_PARAMS" 2>&1 | grep "Cycles/SIMD iteration" | cut -d ' ' -f3)
        if (( $(echo "$BEST > $RES" | bc -l ) )); then
            BEST=$RES
        fi
    done
}

echo "Tag: $TAG" | tee -a $LOG
echo "Optimization scheme: $OPT_SCHEME" | tee -a $LOG
echo "Binary: $MDBENCH_BIN(-stub)" | tee -a $LOG
echo "Frequency: $FREQ" | tee -a $LOG
echo "Number of runs: $NRUNS" | tee -a $LOG

echo "Fixing frequencies..."
likwid-setFrequencies -f $FREQ -t 0

for p in $PREFETCHERS; do
    if [ "$p" != "IGNORE" ]; then
        if [ "$p" == "ALL" ]; then
            likwid-features -c $CORE -e $ALL_PREFETCHERS
        elif [ "$p" == "NONE" ]; then
            likwid-features -c $CORE -d $ALL_PREFETCHERS
        else
            likwid-features -c $CORE -d $ALL_PREFETCHERS
            likwid-features -c $CORE -e $p
        fi

        echo "Prefetcher settings: $p"
        likwid-features -c $CORE -l
    fi

    MSG="$p: "
    run_benchmark $MDBENCH_BIN
    MSG+="standard=$BEST, "
    run_benchmark $MDBENCH_BIN -i data/copper_melting/input_lj_cu_one_atomtype_20x20x20.dmp
    MSG+="melt=$BEST, "
    run_benchmark $MDBENCH_BIN -p data/argon_1000/mdbench_params.conf -i data/argon_1000/tprout.gro
    MSG+="argon=$BEST, "
    run_benchmark $MDBENCH_BIN-stub $STUB1_PARAMS
    MSG+="$STUB1_NAME=$BEST, "
    run_benchmark $MDBENCH_BIN-stub $STUB2_PARAMS
    MSG+="$STUB2_NAME=$BEST"
    echo $MSG | tee -a $LOG
done
