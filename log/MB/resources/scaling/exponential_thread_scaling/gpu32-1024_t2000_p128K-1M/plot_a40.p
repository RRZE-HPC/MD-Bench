set terminal png
set output 'a40_gpu32-1024_t2000_pScaling.png'
set title 'GPU threads-per-block scaling for one single GPU and its assigned cores'
set xlabel '#GPU-Threads per block'
set xrange [32:1024]
set logscale x 2
set yrange [0:*]
set ylabel 'Atom updates [1/s]'
set datafile separator ","
set key bottom right
set key samplen 1.5 spacing 1.1 font ",10"
set style line 1 lc rgb '#ff0000' lt 1 lw 2 pt 7 ps 1.2
set style line 2 lc rgb '#ff8000' lt 1 lw 2 pt 5 ps 1.2
set style line 3 lc rgb '#ffbf00' lt 1 lw 2 pt 9 ps 1.2
set style line 4 lc rgb '#bfff00' lt 1 lw 2 pt 13 ps 1.2
plot 'a40_gpu32-1024_t2000_p128K' w lp ls 1 title '128Ki atoms', \
        'a40_gpu32-1024_t2000_p256K' w lp ls 2 title '256Ki atoms', \
        'a40_gpu32-1024_t2000_p512K' w lp ls 3 title '512Ki atoms', \
        'a40_gpu32-1024_t2000_p1M' w lp ls 4 title '1Mi atoms'
