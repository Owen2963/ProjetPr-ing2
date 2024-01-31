reset
set terminal pngcairo enhanced font "arial,13" fontscale 1.0 size 2000,1000
set output 'image/l.png'
set title "Les 10 trajets les plus long"
set datafile separator ";"
set xlabel 'ID du trajet'
set ylabel 'Distance(km)'
set yrange [0:10000]
set boxwidth 0.5
set style fill solid
plot "temp/templl.txt" u 4:xtic(1) w boxes lc rgb "blue" notitle
