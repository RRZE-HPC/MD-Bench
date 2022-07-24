set terminal png
set output 'a100_perf_comp_log_before_after.png'
set title '1 A100 GPU \& 16 CPU cores; scaling threads-per-block; before \& after'
set xlabel '#GPU-Threads per block'
set logscale x 2
set xrange [1:1024]
set yrange [0:*]
set ylabel 'Million Atom updates per second [1*10^6/s]'
set datafile separator ","
set key left top
set key samplen 1.1 spacing .9 font ",7"
set style line 1 lc rgb '#ff00ff' lt 1 lw 2 pt 7 ps 1.2
set style line 2 lc rgb '#8f008f' lt 1 lw 2 pt 5 ps 1.2
set style line 3 lc rgb '#00ffff' lt 1 lw 2 pt 7 ps 1.2
set style line 4 lc rgb '#008f8f' lt 1 lw 2 pt 5 ps 1.2
set style line 5 lc rgb '#ff0000' lt 1 lw 2 pt 7 ps 1.2
set style line 6 lc rgb '#8f0000' lt 1 lw 2 pt 5 ps 1.2
set style line 7 lc rgb '#0000ff' lt 1 lw 2 pt 7 ps 1.2
set style line 8 lc rgb '#00008f' lt 1 lw 2 pt 5 ps 1.2
plot 'a100_gpu1-1024_t2000_p1M_SP_beforePar.csv' w lp ls 7 title 'A100 SP before', \
        'a100_gpu1-1024_t2000_p1M_DP_beforePar.csv' w lp ls 8 title 'A100 DP before', \
        'a100_gpu1-1024_t2000_p1M_SP.csv' w lp ls 3 title 'A100 SP after', \
        'a100_gpu1-1024_t2000_p1M_DP.csv' w lp ls 4 title 'A100 DP after'


