set terminal png
set output 'SingleGPU_gpu_threads_per_block_scaling.png'
set title 'GPU threads-per-block scaling for one single GPU and its assigned cores'
set xlabel '#GPU-Threads per block'
set xrange [1:32]
set yrange [0:10e6]
set ylabel 'Atom updates [1/s]'
set datafile separator ","
set key right bottom
set style line 1 linecolor rgb '#ff0000'
set style line 2 linecolor rgb '#0000ff'
set style line 3 linecolor rgb '#8f0000'
set style line 4 linecolor rgb '#00008f'
set style line 5 linecolor rgb '#00ff00'
plot 'a40_gpu_scaling_SP.csv' w linespoints linestyle 1 title 'A40 SP', \
        'a100_gpu_scaling_SP.csv' w linespoints linestyle 2 title 'A100 SP', \
        'a40_gpu_scaling_DP.csv' w linespoints linestyle 3 title 'A40 DP', \
        'a100_gpu_scaling_DP.csv' w linespoints linestyle 4 title 'A100 DP', \
        'CPU_cpu_scaling_DP.csv' w linespoints linestyle 5 title 'CPU DP'
