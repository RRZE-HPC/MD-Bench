#!/bin/bash

MDBENCH_BIN=./MDBench-ICX-lammps
FREQ=2.1
NRUNS=3
FIXED_PARAMS=--freq $FREQ

function run_benchmark() {
    for i in $(seq $NRUNS); do
        likwid-pin -c 0 "$* $FIXED_PARAMS" 2>&1 | grep "Cycles/SIMD iteration" | cut -d ' ' -f3
    done
}

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
echo "Stub-76"
run_benchmark $MDBENCH_BIN-stub -nn 76
echo "Stub-1024"
run_benchmark $MDBENCH_BIN-stub -nn 1024
