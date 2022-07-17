set terminal png
set output 'OUT_FILENAME.png'
set title 'GPU threads-per-block scaling for one single GPU and its assigned cores'
set xlabel '#GPU-Threads per block'
set xrange [1:32]
set yrange [0:*]
set ylabel 'Atom updates [1/s]'
set datafile separator ","
set key right bottom
set style line 1 lc rgb 'magenta' lt 1 lw 2 pt 7 ps 1.2
set style line 2 lc rgb 'cyan' lt 1 lw 2 pt 5 ps 1.2
set style line 3 lc rgb 'gray' lt 1 lw 2 pt 7 ps 1.2
set style line 4 lc rgb 'gray' lt 1 lw 2 pt 5 ps 1.2
plot 'a40_gpu1-32_sr_t200_DP_baseline_condensed.csv' w lp ls 1 title 'A40 DP baseline', \
        'a100_gpu1-32_sr_t200_DP_baseline_condensed.csv' w lp ls 2 title 'A100 DP baseline', \
        'a40_gpu1-32_sr_t200_DP_buiNeiPar_condensed.csv' w lp ls 3 title 'A40 DP buiNeiPar', \
        'a100_gpu1-32_sr_t200_DP_buiNeiPar_condensed.csv' w lp ls 4 title 'A100 DP buiNeiPar'
