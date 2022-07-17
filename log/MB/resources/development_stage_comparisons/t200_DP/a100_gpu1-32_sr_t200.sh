#!/bin/bash -l
#SBATCH --nodes=1 --ntasks=1 --time=01:00:00
#SBATCH --export=NONE
#SBATCH --gres=gpu:a100:1 --partition=a100
unset SLURM_EXPORT_ENV

module load likwid cuda		#load modules necessary for GPU profiling

END=32
for ((i=1;i<=END;i+=1)); do
        output=$(eval "NUM_THREADS=$i ~/MD-Bench/MDBench-NVCC -n 200")
        echo -n "$i,"
        echo "$output" | grep 'atom updates per second' | sed 's/[^0-9.,]//g' | awk '{print $1"e6"}'
done
