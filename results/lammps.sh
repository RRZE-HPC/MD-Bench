#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --partition=singlenode
#SBATCH --time=01:00:00
#SBATCH --export=none

unset SLURM_EXPORT_ENV

module load intelmpi
module load intel


cd /home/hpc/ihpc/ihpc120h/Thesis/MD-Bench
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
    for proc in {1..72}; do
        srun -n $proc -N 1 -B 4:$proc --cpu_bind=sockets,verbose ./MDBench-lammps-MPICC-AVX512-DP -nx $size -ny $size -nz $size -half $l -method $m
        #size=$(echo "scale=0; $size * 12 / 10" | bc)
    done
    python3 results/macro.py >> "results/${file[i]}.dat"
    rm out.txt
done

gnuplot results/performance.plot