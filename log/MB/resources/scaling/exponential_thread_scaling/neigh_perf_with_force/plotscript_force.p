set terminal png
set output 'force_perf.png'
set title 'force performance, 1 GPU \& 16 cores, exponentially scaling threads per block'
set xlabel '#GPU-Threads per block'
set xrange [1:1024]
set yrange [0:*]
set ylabel 'force computation throughput [1*10^6/s]'
set logscale x 2
set datafile separator ","
set key left top
set key samplen 1.5 spacing 1.2 font ",10"
set style line 1 lc rgb 'red' lt 1 lw 2 pt 7 ps 1.2
set style line 2 lc rgb 'blue' lt 1 lw 2 pt 5 ps 1.2
set style line 3 lc rgb 'gray' lt 1 lw 2 pt 7 ps 1.2
set style line 4 lc rgb 'gray' lt 1 lw 2 pt 5 ps 1.2
plot 'a40_forcePerf.csv' w lp ls 1 title 'A40 DP force performance', \
        'a100_forcePerf.csv' w lp ls 2 title 'A100 DP force performance'
