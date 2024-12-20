#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --time=06:00:00
#SBATCH --constraint=hwperf
#SBATCH --partition=spr1tb
#SBATCH --export=NONE

unset SLURM_EXPORT_ENV
module load likwid
module load python
module load intelmpi 
module load intel

if [ -z "$1" ]; then
  echo "No size provided."
  exit 1
fi
sort=20
half=0
nrep=2

#bin="MDBench-VL-ICC-X86-AVX512-SP"
#bin="MDBench-VL-ICC-X86-AVX512-DP"
#bin="MDBench-CP-ICC-X86-AVX512-SP"
#bin="MDBench-CP-ICC-X86-AVX512-DP"

#bin="MDBench-VL-ICC-X86-AVX2-SP"
#bin="MDBench-VL-ICC-X86-AVX2-DP"
#bin="MDBench-CP-ICC-X86-AVX2-SP"
#bin="MDBench-CP-ICC-X86-AVX2-DP"

#bin="MDBench-VL-ICC-X86-SSE-SP"
#bin="MDBench-VL-ICC-X86-SSE-DP"
#bin="MDBench-CP-ICC-X86-SSE-SP"
#bin="MDBench-CP-ICC-X86-SSE-DP"

step=4

if [[ $half -eq 1 ]]; then
  name="$bin-half"
else 
  name="$bin-full"
fi

tmp=$TMPDIR/tmp.dat
data=$TMPDIR/data.dat

pwd
cp collector.py $TMPDIR
cp speed.py $TMPDIR
cp "../$bin" $TMPDIR
cd $TMPDIR

radius="2.5"

# Print the parameter
echo "Size problem: $1"
for ((cores = 0; cores  <= 104; cores +=$step)); do
  nc=$(( cores > 1 ? $cores : 1 ))
  echo $nc
  rm $tmp
  for ((rep = 0; rep < nrep; rep++)); do
    srun --cpu-freq=2000000-2000000:performance -n $nc $bin -nx $1 -ny $1 -nz $1 -r $radius -half $half >> $tmp 
  done 
  python collector.py >> $data
done 
python speed.py $step > "out.txt"
mv "out.txt" "$HOME/MD-Bench-test/results/$name"