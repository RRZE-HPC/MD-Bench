set terminal png size 1024,768 enhanced font ,12
set output 'results/performance.png'
set xlabel 'Cores'
set xtics 5
set xrange [0:]
set yrange [0:]
set ylabel '[Million Atom-Update/s]'
set title 'Performance'

plot 'results/fulllist.dat' u 1:2 w linespoints title 'Full Shell', \
     'results/halflist.dat' u 1:2 w linespoints title 'Full Shell + Half List', \
     'results/halfshell.dat' u 1:2 w linespoints title 'Half Shell',  \
     'results/eightshell.dat' u 1:2 w linespoints title 'Eight Shell',  \
     'results/halfstencil.dat' u 1:2 w linespoints title 'Half Stencil'  

set terminal png size 1024,768 enhanced font ,12
set output 'results/speed.png'
set xlabel 'Cores'
set xtics 5
set xrange [0:]
set yrange [0:]
set ylabel 
set title 'Speed-up'


plot 'results/fulllist.dat' u 1:3 w linespoints title 'Full Shell', \
     'results/halflist.dat' u 1:3 w linespoints title 'Full Shell + Half List', \
     'results/halfshell.dat' u 1:3 w linespoints title 'Half Shell', \
     'results/eightshell.dat' u 1:3 w linespoints title 'Eight Shell',  \
     'results/halfstencil.dat' u 1:3 w linespoints title 'Half Stencil'  


set terminal png size 1024,768 enhanced font ,12
set output 'results/pressure.png'
set xlabel 'Cores'
set xtics 5
set xrange [0:]
set yrange [0:]
set ylabel '[MPa]'
set title 'Final Pressure'

plot 'results/fulllist.dat' u 1:5 w linespoints title 'Full Shell', \
     'results/halflist.dat' u 1:5 w linespoints title 'Full Shell + Half List', \
     'results/halfshell.dat' u 1:5 w linespoints title 'Half Shell', \
     'results/eightshell.dat' u 1:5 w linespoints title 'Eight Shell', \
     'results/halfstencil.dat' u 1:5 w linespoints title 'Half Stencil'  

