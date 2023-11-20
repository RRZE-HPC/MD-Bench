titles = ("FullShell FullShell+HalfList HalfShell EightShell HalfStencil")
colors = ("forest-green red blue yellow4 dark-cyan")

set terminal pngcairo enhanced background rgb 'white' size 1024,768 font ",12" 
set xlabel 'Cores'
set xtics 1
set xrange [1:]
set yrange [0:]
set ylabel '[Million Atom-Update/s]'
set style fill transparent solid 0.2 noborder
set style line 1 linewidth 3
set grid xtics ytics lc rgb 'gray' lt 1 lw 1


set title 'Performance'
set output 'results/performance.png'

file(n) = sprintf("results/%s.dat",word(titles,n))
N = words(titles)

plot for [n=1:N] file(n) u 1:3:4 with filledcurves  fillcolor rgb word(colors,n) notitle, \
     for [n=1:N] file(n) u 1:2 w lp ls 1 pt 7 ps 1.5 lc rgb word(colors,n) title word(titles,n)
     

set title 'Speed-up'
set output 'results/speed.png'

plot for [n=1:N] file(n) u 1:6:7 with filledcurves  fillcolor rgb word(colors,n) notitle, \
     for [n=1:N] file(n) u 1:5 w lp ls 1 pt 7 ps 1.5 lc rgb word(colors,n) title word(titles,n)

set title 'Efficiency'
set output 'results/efficiency.png'

plot for [n=1:N] file(n) u 1:9:10 with filledcurves  fillcolor rgb word(colors,n) notitle, \
     for [n=1:N] file(n) u 1:8 w lp ls 1 pt 7 ps 1.5 lc rgb word(colors,n) title word(titles,n)

set title 'Final Pressure'
set output 'results/pressure.png'

plot for [n=1:N] file(n) u 1:15:16 with filledcurves  fillcolor rgb word(colors,n) notitle, \
     for [n=1:N] file(n) u 1:14 w lp ls 1 pt 7 ps 1.5 lc rgb word(colors,n) title word(titles,n)

