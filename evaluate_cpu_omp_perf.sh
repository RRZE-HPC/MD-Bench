#!/bin/bash
for i in $(seq 1 32); do
	echo "$i"
	export "OMP_NUM_THREADS=$i"
	./MDBench-GCC -n 50 | grep "Performance"
done

## likwid perf measurements on testfront1:
# srun --nodes=1 --exclusive --nodelist=rome1 --time=00:30:00 --export=NONE -c 64 -C hwperf --pty /bin/bash -l
# likwid-mpirun -np 1 -t 32 -m -g MEM -omp gnu -d ./MDBench-GCC
