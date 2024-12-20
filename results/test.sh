#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --time=01:00:00
#SBATCH --constraint=hwperf
#SBATCH --partition=spr1tb
#SBATCH --export=NONE

unset SLURM_EXPORT_ENV
module load likwid
module load python
module load intelmpi 
module load intel

n_methdos=5 #5 method for CP and 6 for VL
bin="MDBench-VL-ICC-X86-AVX512-DP" #change the binary

nranks=(1 54 104)  # run the test with  this number of ranks
balance=(0 1 2 3)   # cartesian - rcb  - rcb time - staggered 
bal_text=("Cartesian" "rcb-mean" "rcb-time" "staggered")
method=(0 0 1 2 3 4)  # full_shell - full_shell - half_shell - eight_shell - Half Stencil


tmp=$TMPDIR/tmp.dat
data=$TMPDIR/data.dat

pwd
cp collector.py $TMPDIR
cp "../$bin" $TMPDIR
cd $TMPDIR

radius="2.5"
s="32"

echo " running MD-bench: $bin"
# Print the parameter
for ((i=0; i<3; i++)); do
  nc=${nranks[i]}
  echo " =================  number of cores: $nc ==================" >> $data
  for ((j=0; j<4; j++)); do
    bal=${balance[j]}
    half="0"
    echo " ++++++++ Balance: ${bal_text[j]} ++++++++" >> $data
      for ((k=0; k<$n_methdos; k++)); do
          m=${method[k]}
          echo "running for cores:$nc, balance:$bal, method:$m half:$half"
          srun -n $nc $bin -nx $s -ny $s -nz $s -r $radius -half $half -bal $bal -method $m > $tmp  
          python collector.py $m $half>> $data
          half="1"
      done  
  done 
done 
mv $data "$HOME/MD-Bench/results/$bin"