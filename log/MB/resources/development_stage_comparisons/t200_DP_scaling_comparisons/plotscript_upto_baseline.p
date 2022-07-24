set terminal png
set output 'plot_upto_baseline.png'
set title '1 GPU & 16 CPU cores - scaling threads-per-block'
set xlabel '#GPU-Threads per block'
set xrange [1:32]
set yrange [0:*]
set ylabel 'Atom updates [1/s]'
set datafile separator ","
set key left top maxrows 3
set key samplen 1.3 spacing 1.1 font ",11"
set style line 1 lc rgb 'magenta' lt 1 lw 2 pt 7 ps 1.2
set style line 2 lc rgb 'cyan' lt 1 lw 2 pt 5 ps 1.2
set style line 3 lc rgb 'gray' lt 1 lw 2 pt 7 ps 1.2
set style line 4 lc rgb 'gray' lt 1 lw 2 pt 5 ps 1.2
plot 'a40_gpu1-32_sr_t200_DP_baseline_condensed.csv' w lp ls 1 title 'A40 DP BL', \
        'a100_gpu1-32_sr_t200_DP_baseline_condensed.csv' w lp ls 2 title 'A100 DP BL'
