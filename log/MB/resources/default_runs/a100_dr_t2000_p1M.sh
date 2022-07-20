#!/bin/bash -l
#SBATCH --nodes=1 --ntasks=1 --time=01:00:00
#SBATCH --export=NONE
#SBATCH --gres=gpu:a100 --partition=a100
unset SLURM_EXPORT_ENV

module load likwid cuda		#load modules necessary for GPU profiling

NUM_THREADS=32 srun /home/hpc/ptfs/ptfs176h/MD-Bench/MDBench-NVCC -nx 64 -ny 64 -nz 64 -n 2000 #execute MDBench
