set terminal png
set output 'OUT_FILENAME.png'
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
plot PLOT_FILES'A40_UNIMPORTANT_DAT' w lp ls 3 title 'A40_UNIMPORTANT_LEGEND', \
        'A100_UNIMPORTANT_DAT' w lp ls 4 title 'A100_UNIMPORTANT_LEGEND', \
        PLOT_CURRENT'A40_IMPORTANT_DAT' w lp ls 1 title 'A40_IMPORTANT_LEGEND', \
        'A100_IMPORTANT_DAT' w lp ls 2 title 'A100_IMPORTANT_LEGEND'
