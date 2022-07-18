#!/bin/bash -l
#SBATCH --nodes=1 --ntasks=1 --time=01:00:00
#SBATCH --export=NONE
#SBATCH --gres=gpu:a100 --partition=a100
unset SLURM_EXPORT_ENV

module load likwid cuda		#load modules necessary for GPU profiling

nx=32
ny=32
nz=32
MAXTHREADS=1024
GPU="a100"
pSizeFancy="128K"

all_output=""
test_MD_Bench_scaling(){
	part_filename=$GPU"_gpu32-1024_t2000_p"$pSizeFancy
	all_output+="BEGIN Problem Size: $pSizeFancy"$'\n'
	part_output=""
	all_output+="nx:$nx ny:$ny nz:$nz"$'\n'
	for ((tc=32;tc<=MAXTHREADS;tc*=2)); do #tc = threadcount per block
	        output=$(eval "NUM_THREADS=$tc ~/MD-Bench/MDBench-NVCC -nx $nx -ny $ny -nz $nz -n 2000")
		single_output=""
		if [ "$part_output" != "" ]
		then
			single_output+=$'\n'
		fi
		single_output+=$(echo -n "$tc,")
		single_output+=$(echo -n "$output" | grep 'atom updates per second' \
			| sed 's/[^0-9.,]//g' | awk '{print $1"e6"}')
		part_output+=$single_output
		all_output+=$single_output
	done
	echo "$part_output"
	echo "$part_output" > "$part_filename"
	all_output+=$'\n'"END Problem Size: $pSizeFancy"$'\n'
}

test_MD_Bench_scaling
nx=$((nx*2))
pSizeFancy="256K"
test_MD_Bench_scaling
ny=$((ny*2))
pSizeFancy="512K"
test_MD_Bench_scaling
nz=$((nz*2))
pSizeFancy="1M"
test_MD_Bench_scaling
out_file="$GPU""_cumulated"
echo "$all_output" > "$out_file"
