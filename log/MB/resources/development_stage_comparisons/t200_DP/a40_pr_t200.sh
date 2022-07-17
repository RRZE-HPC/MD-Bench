#!/bin/bash -l
#SBATCH --nodes=1 --ntasks=1 --time=01:00:00
#SBATCH --export=NONE
#SBATCH --gres=gpu:a40 --partition=a40
unset SLURM_EXPORT_ENV

module load likwid cuda		#load modules necessary for GPU profiling

export NUM_THREADS=32 
srun nsys profile -o /home/hpc/ptfs/ptfs176h/training/second_presentation/a40_profile /home/hpc/ptfs/ptfs176h/MD-Bench/MDBench-NVCC #execute MDBench
