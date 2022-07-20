#!/bin/bash -l
#SBATCH --nodes=1 --ntasks=1 --time=01:00:00
#SBATCH --export=NONE
#SBATCH --gres=gpu:a40 --partition=a40
unset SLURM_EXPORT_ENV

module load likwid cuda		#load modules necessary for GPU profiling

GPU="a40"

force_file=$GPU"_forcePerf.csv"
upAtPbc_file=$GPU"_upAtPerf.csv"
setupPbc_file=$GPU"_setupPbcPerf.csv"
upPbc_file=$GPU"_upPbcPerf.csv"
binAt_file=$GPU"_binAtomsPerf.csv"
buiNeiList_file=$GPU"_buiNeiListPerf.csv"

force=""
upAt=""
setupPbc=""
upPbc=""
binAt=""
buiNeiList=""
END=1024
for ((i=1;i<=END;i*=2)); do
        output=$(eval "NUM_THREADS=$i ~/MD-Bench/MDBench-NVCC -nx 64 -ny 64 -nz 64 -n 2000")
	perfs=$(echo "$output" | grep 'Neighbor_perf')
	forc=$(echo "$output" | grep 'Force_perf')
	forc=${forc#*sec: }
	echo "$i"".""$perfs"
	perfs=${perfs#*updateAtomsPbc:}
	set -- $perfs
	i_num="$i"","
	if [ "$upAt" != "" ]
	then
		i_num=$'\n'$i_num
	fi
	force+=$i_num$forc
	upAt+=$i_num$1
	setupPbc+=$i_num$3
	upPbc+=$i_num$5
	binAt+=$i_num$7
	buiNeiList+=$i_num$9
done
echo "$force" > "$force_file"
echo "$upAt" > "$upAtPbc_file"
echo "$setupPbc" > "$setupPbc_file"
echo "$upPbc" > "$upPbc_file"
echo "$binAt" > "$binAt_file"
echo "$buiNeiList" > "$buiNeiList_file"
