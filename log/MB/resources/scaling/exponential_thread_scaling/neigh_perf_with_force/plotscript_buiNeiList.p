set terminal png
set output 'buiNeiList_perf.png'
set title 'buildNeighborLists performance, 1 GPU \& 16 cores, exp. scaling threads per block'
set xlabel '#GPU-Threads per block'
set xrange [1:1024]
set yrange [0:*]
set ylabel 'buildNeighborLists throughput [1*10^6/s]'
set logscale x 2
set datafile separator ","
set key left top
set key samplen 1.5 spacing 1.2 font ",10"
set style line 1 lc rgb 'red' lt 1 lw 2 pt 7 ps 1.2
set style line 2 lc rgb 'blue' lt 1 lw 2 pt 5 ps 1.2
set style line 3 lc rgb 'gray' lt 1 lw 2 pt 7 ps 1.2
set style line 4 lc rgb 'gray' lt 1 lw 2 pt 5 ps 1.2
plot 'a40_buiNeiListPerf.csv' w lp ls 1 title 'A40 DP buildNeighborLists performance', \
        'a100_buiNeiListPerf.csv' w lp ls 2 title 'A100 DP buildNeighborLists performance'
