END=32
for ((i=1;i<=END;i++)); do
	output=$(eval "NUM_THREADS=$i ./MDBench-NVCC -n 50")
	echo "$output" | grep 'atom updates per second' | sed 's/[^0-9.]//g' | awk '{print $1"e6"}'
done
