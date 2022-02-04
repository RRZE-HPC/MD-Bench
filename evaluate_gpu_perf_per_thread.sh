END=64
for ((i=1;i<=END;i*=2)); do
	output=$(eval "NUM_THREADS=$i ./MDBench-NVCC -n 2000")
	echo -n "$i,"
	echo "$output" | grep 'atom updates per second' | sed 's/[^0-9.,]//g' | awk '{print $1"e6"}'
done
