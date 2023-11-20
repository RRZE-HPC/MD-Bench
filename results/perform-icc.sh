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

List=(0 1 1 1 0)
Method=(0 0 1 2 3)
file=("FullShell" "FullShell+HalfList" "HalfShell" "EightShell" "HalfStencil")
balance=$1
case=$2
if [ "$case" = "gromacs" ]; then
    EXE=./MDBench-gromacs-MPICC-AVX512-DP
    nmethods=4
else
    EXE=./MDBench-lammps-MPICC-AVX512-DP
    nmethods=5
fi

N0=100
for ((i = 0; i < nmethods; i++)); do
    l=${List[i]}
    m=${Method[i]}
    #iterate along procs
    for proc in {1..72}; do
        #N=$(echo "e(l($proc)/3) * $N0" | bc -l)
        #N=$(printf "%.0f" $N)
        N=$N0 
        for iter in {1..5}; do 
            srun -n $proc -B 4:$proc --cpu_bind=socket,verbose $EXE -nx $N -ny $N -nz $N -half $l -method $m -bal $balance >> out.txt
        done
        printf "$proc " >> out_stats.txt
        python3 results/stats.py >> out_stats.txt 
        rm out.txt 
    done
    python3 results/data.py >> "results/${file[i]}.dat"
    rm out_stats.txt
done

gnuplot results/perform.plot