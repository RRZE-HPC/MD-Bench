#!/bin/bash -l
#SBATCH --nodes=1 --ntasks=1 --time=01:00:00
#SBATCH --export=NONE
#SBATCH --gres=gpu:a100 --partition=a100
unset SLURM_EXPORT_ENV

module load likwid cuda		#load modules necessary for GPU profiling

GPU="a100"

perf_file="$GPU""_gpu1-1024_t2000_p1M_SP.csv"
perf_content=""
END=1024
for ((i=1;i<=END;i*=2)); do
        output=$(eval "NUM_THREADS=$i ~/MD-Bench/MDBench-NVCC -nx 64 -ny 64 -nz 64 -n 2000")
	perfs=$(echo "$output" | grep 'Performance:')
	set -- $perfs
	i_num="$i"","
	if [ "$perf_content" != "" ]
	then
		i_num=$'\n'$i_num
	fi
	perf_content+=$i_num$2
done
echo "$perf_content" > "$perf_file"
