#!/bin/bash

TAG=ICX
OPT_SCHEME=gromacs
MDBENCH_BIN=./MDBench-$TAG-$OPT_SCHEME
FREQ=2.4
NRUNS=3
FIXED_PARAMS=--freq $FREQ

if [ "$OPT_SCHEME" = "gromacs" ]; then
    STUB1_NAME=Stub-33
    STUB1_PARAMS=-na 4 -nn 33
    STUB2_NAME=Stub-128
    STUB2_PARAMS=-na 4 -nn 128
else
    STUB1_NAME=Stub-76
    STUB1_PARAMS=-nn 76
    STUB2_NAME=Stub-1024
    STUB2_PARAMS=-nn 1024
fi

function run_benchmark() {
    for i in $(seq $NRUNS); do
        likwid-pin -c 0 "$* $FIXED_PARAMS" 2>&1 | grep "Cycles/SIMD iteration" | cut -d ' ' -f3
    done
}

echo "Tag: $TAG"
echo "Optimization scheme: $OPT_SCHEME"
echo "Binary: $MDBENCH_BIN(-stub)"
echo "Frequency: $FREQ"
echo "Number of runs: $NRUNS"

echo "Fixing frequencies..."
likwid-setFrequencies -f $FREQ -t 0

echo "Standard"
run_benchmark $MDBENCH_BIN
echo "Melt"
run_benchmark $MDBENCH_BIN -i data/copper_melting/input_lj_cu_one_atomtype_20x20x20.dmp
echo "Argon"
run_benchmark $MDBENCH_BIN -p data/argon_1000/mdbench_params.conf -i data/argon_1000/tprout.gro
echo "$STUB1_NAME"
run_benchmark $MDBENCH_BIN-stub $STUB1_PARAMS
echo "$STUB2_NAME"
run_benchmark $MDBENCH_BIN-stub $STUB2_PARAMS
