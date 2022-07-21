set terminal png
set output 'a100_gpu32-1024_t2000_pScaling.png'
set title '1 A100-GPU \& 16 CPU cores; scaling threads/block; different #atoms'
set xlabel '#GPU-Threads per block'
set xrange [32:1024]
set logscale x 2
set yrange [0:*]
set ylabel 'Atom updates [1/s]'
set datafile separator ","
set key bottom right
set key samplen 1.5 spacing 1.1 font ",10"
set style line 1 lc rgb '#0000ff' lt 1 lw 2 pt 7 ps 1.2
set style line 2 lc rgb '#0080ff' lt 1 lw 2 pt 5 ps 1.2
set style line 3 lc rgb '#00bfff' lt 1 lw 2 pt 9 ps 1.2
set style line 4 lc rgb '#00ffbf' lt 1 lw 2 pt 13 ps 1.2
plot 'a100_gpu32-1024_t2000_p128K' w lp ls 1 title '128Ki atoms', \
        'a100_gpu32-1024_t2000_p256K' w lp ls 2 title '256Ki atoms', \
        'a100_gpu32-1024_t2000_p512K' w lp ls 3 title '512Ki atoms', \
        'a100_gpu32-1024_t2000_p1M' w lp ls 4 title '1Mi atoms'
