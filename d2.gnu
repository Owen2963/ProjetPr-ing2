reset
set terminal pngcairo enhanced font "arial,13" fontscale 1.0 size 2000,1000
set output 'image/d2.png'
set title "Les conducteurs avec la plus grande distance"
set datafile separator ";"
set xlabel 'Conducteurs'
set ylabel 'Distance(km)'
unset x2tics
unset y2tics
set yrange [0:150000]
set boxwidth 0.5
set style fill solid
plot "temp/temp222.txt" u 1:xtic(2) w boxes lc rgb "green" notitle
