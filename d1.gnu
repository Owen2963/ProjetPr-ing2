reset
set terminal pngcairo enhanced font "arial,13" fontscale 1.0 size 2000,1000
set output 'image/d1.png'
set title "Les conducteurs avec le plus de trajets"
set xlabel 'Conducteurs'
set ylabel 'Nombre de trajets'
set yrange [0:5000]
set boxwidth 0.5
set style fill solid
plot "temp/temp11.txt" u 1:xtic(2) w boxes lc rgb "green" notitle
