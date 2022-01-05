END=32
for ((i=1;i<=END;i++)); do
	output=$(eval "likwid-mpirun -np 1 -t $i -m -g FLOPS_DP -omp gnu ./MDBench-GCC -n 50")
	echo -n "$i,"
	echo "$output" > "FLOPS_DP/thread_$i.txt"
done

## likwid perf measurements on testfront1:
# srun --nodes=1 --exclusive --nodelist=rome1 --time=00:30:00 --export=NONE -c 64 -C hwperf --pty /bin/bash -l
# likwid-mpirun -np 1 -t 32 -m -g MEM -omp gnu -d ./MDBench-GCC
