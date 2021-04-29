#!/bin/bash

while getopts "a:f:n:o:r:x:y:z:" flag; do
    case "${flag}" in
        a) atoms_per_unit_cell=${OPTARG};;
        f) frequency=${OPTARG};;
        n) timesteps=${OPTARG};;
        o) output_file=${OPTARG};;
        r) nruns=${OPTARG};;
        x) nx=${OPTARG};;
        y) ny=${OPTARG};;
        z) nz=${OPTARG};;
    esac
done

EXEC="../MDBench-ICC-stub"
ATOMS_PER_UNIT_CELL="${atoms_per_unit_cell:-8}"
FREQUENCY="${frequency:-0.0}"
TIMESTEPS="${timesteps:-200}"
OUTPUT_FILE="${output_file:-run_results.txt}"
NRUNS="${nruns:-3}"
NX="${nx:-4}"
NY="${ny:-4}"
NZ="${nz:-2}"

for timesteps in ${TIMESTEPS}; do
    for atoms_per_unit_cell in ${ATOMS_PER_UNIT_CELL}; do
        for nx in ${NX}; do
            for ny in ${NY}; do
                for nz in ${NZ}; do
                    best_perf=
                    best_output=
                    for nruns in ${NRUNS}; do
                        output=$(
                            ./${EXEC} -f ${FREQUENCY} -n ${timesteps} -na ${atoms_per_unit_cell} -nx ${nx} -ny ${ny} -nz ${nz} -csv |
                            grep -v steps
                        )
                        perf=$(echo $output | cut -d',' -f8)
                        if [ -z "$best_perf" ]; then
                            best_perf="$perf"
                            best_output="$output"
                        elif (( $(echo "$perf < $best_perf" | bc -l) )); then
                            best_perf="$perf"
                            best_output="$output"
                        fi
                    done

                    echo "${best_output}" | tee -a "${OUTPUT_FILE}"
                done
            done
        done
    done
done
