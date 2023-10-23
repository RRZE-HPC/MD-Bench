#!/bin/bash -l
#SBATCH --nodes=4
#SBATCH --partition=multinode
#SBATCH --time=03:00:00
#SBATCH --cpus-per-task=18
#SBATCH --export=none

#unset SLURM_EXPORT_ENV

#module load intelmpi
#module load intel
#export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
#export OMP_PLACES=cores
#export OMP_PROC_BIND="close" 

#cd /lustre/pavl/pavl108h
#mkdir output
#cd /home/hpc/pavl/pavl108h/project
#rm -r output

cd ..
rm -r results/*.dat
rm -r results/*.png

size=20
nmethods=5
List=(0 1 1 1 0)
Method=(0 0 1 2 3)
file=("fulllist" "halflist" "halfshell" "eightshell" "halfstencil") 
for ((i = 0; i < nmethods; i++)); do
    l=${List[i]}
    m=${Method[i]}
    for processes in {1..2}; do
        #srun -n $processes --cpu_bind=ldoms,verbose ./MDBench-lammps-MPICC-AVX-DP -nx 20 -ny 20 -nz 20 >>  out.txt 
        mpirun -n $processes  ./MDBench-lammps-MPICC-AVX2-DP -nx $size -ny $size -nz $size -half $l -method $m  >>  out.txt  
    done
    python3 results/macro.py >> "results/${file[i]}.dat"
    rm out.txt
done

gnuplot results/performance.plot



