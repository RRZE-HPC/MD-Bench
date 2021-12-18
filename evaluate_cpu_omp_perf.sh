#!/bin/bash
for i in $(seq 1 32); do
	echo "$i"
	export "OMP_NUM_THREADS=$i"
	./MDBench-GCC -n 50 | grep "Performance"
done
