reset
set terminal pngcairo enhanced font "arial,13" fontscale 1.0 size 2000,1000
set output 'image/s.png'
set title "Option -s : Distance = f(Route)"
set datafile separator ";"
set xlabel 'ROUTE ID'
set xtics rotate by 45 right
ismin(x) = (x<min)?min=x:0
ismax(x) = (x>max)?max=x:0
set ylabel 'DISTANCE(Km)'
set yrange [0:1000]
plot for [i=1:3] "temp/temps.txt" u i+1:xtic(1) w line lw 2 notitle
