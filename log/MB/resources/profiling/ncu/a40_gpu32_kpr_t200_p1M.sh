#!/bin/bash -l
#SBATCH --nodes=1 --ntasks=1 --time=01:00:00
#SBATCH --export=NONE
#SBATCH --gres=gpu:a40 --partition=a40
unset SLURM_EXPORT_ENV

module load likwid cuda		#load modules necessary for GPU profiling

export NUM_THREADS=32 
srun ncu --set full -o /home/hpc/ptfs/ptfs176h/training/second_presentation/profiling/ncu/a40_gpu32_t2000_p1M_kernelProfile /home/hpc/ptfs/ptfs176h/MD-Bench/MDBench-NVCC -nx 64 -ny 64 -nz 64 -n 200 #execute MDBench
