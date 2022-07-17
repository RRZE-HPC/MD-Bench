#!/bin/bash -l
#SBATCH --nodes=1 --ntasks=1 --time=01:00:00
#SBATCH --export=NONE
#SBATCH --gres=gpu:a100 --partition=a100
unset SLURM_EXPORT_ENV

module load likwid cuda		#load modules necessary for GPU profiling
 
srun nsys profile -s cpu -e NUM_THREADS=32 -o /home/hpc/ptfs/ptfs176h/training/second_presentation/a100_profile /home/hpc/ptfs/ptfs176h/MD-Bench/MDBench-NVCC #execute MDBench
