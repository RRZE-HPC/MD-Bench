END=32
for ((i=16;i<=END;i++)); do
	export NUM_THREADS=$i
	$(eval "ncu --set full -o /home/hpc/rzku/ptfs410h/MD-Bench/log/MG/presentation_2/Resources/GPU/Metrics/threads_$i ./MDBench-NVCC -n 50")
done
