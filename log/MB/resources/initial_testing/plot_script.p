set terminal png
set output 'SingleGPU_cpu_scaling.png'
set title 'CPU Scaling for one single GPU and its assigned cores'
set xlabel '#CPU-Threads'
set xrange [1:64]
set ylabel 'Atom updates [Millions/second]
set datafile separator ","
plot 'a40_cpu_scaling_initial_condensed.csv' w linespoints title 'Throughput'
