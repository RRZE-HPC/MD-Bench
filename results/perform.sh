cd ..
rm -r results/*.dat
rm -r results/*.png

List=(0 1 1 1 0)
Method=(0 0 1 2 3)
file=("FullShell" "FullShell+HalfList" "HalfShell" "EightShell" "HalfStencil")
balance=$1
case=$2
if [ "$case" = "gromacs" ]; then
    EXE=./MDBench-gromacs-MPICC-AVX2-DP
    nmethods=4
else
    EXE=./MDBench-lammps-MPICC-AVX2-DP
    nmethods=5
fi
N0=20
for ((i = 0; i < nmethods; i++)); do
    l=${List[i]}
    m=${Method[i]}
    for proc in {1..2}; do
        #N=$(echo "e(l($proc)/3) * $N0" | bc -l)
        #N=$(printf "%.0f" $N)
        N=$N0
        for iter in {1..5}; do
            mpirun -n $proc  $EXE -nx $N -ny $N -nz $N -half $l -method $m -bal $balance >>  out.txt 
        done
        printf "$proc " >> out_stats.txt
        python3 results/stats.py >> out_stats.txt
        rm out.txt
    done
    python3 results/data.py >> "results/${file[i]}.dat"
    rm out_stats.txt
done

gnuplot results/perform.plot



