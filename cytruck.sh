#!/bin/bash
if [ -e 'temp' ] ;	then
	echo -n `rm -r temp && mkdir temp`
else
	echo -n `mkdir temp`
fi
if [ -e 'image' ] ;	then
	echo -n `rm -r image && mkdir image`
else
	echo -n `mkdir image`
fi

d1(){
	`awk -F";" '$2 == 1 {p=$6} {if($6==p) print ";"$6}' data.csv | sort -r -t';' -k2 | uniq -c > temp/temp1.txt&&sort -r -n -t';' -k1 temp/temp1.txt | head -10 > temp/temp11.txt`
	`gnuplot 'd1.gnu'`
}

d2(){
	`awk -F";" '{print $5" "$6}' data.csv | tail +2 | sort -k2 > temp/temp2.txt&&awk '{if(($2 == p)&&($3 == n)) d+=$1; else d=$1} {p=$2;n=$3} {print d" "p" "n}' temp/temp2.txt > temp/temp22.txt&&awk '{if(($2 == p)&&($3 == n)) ; else print d";"p" "n;} {d=$1;p=$2;n=$3}' temp/temp22.txt | sort -r -n | head -10 > temp/temp2.txt`
	`gnuplot 'd2.gnu'`
}

l(){
	`awk -F";" '{tab[$1]+=$5} END {for (i in tab) printf "%d;%d\n", i,tab[i]}' data.csv | tail +2 | sort -t';' -r -n -k2 | head -10 | sort -t';' -n -k1 > temp/templ.txt`
	`gnuplot 'l.gnu'`
}

t(){
	`awk -F";" '{print $3";"$4";"$6}' data.csv | tail +2 | sort -t';' -r -k1 > temp/tempt.txt`
}

if [ 'data.csv' == $1 ] ; then
	echo `clear`
	for i in $* ; do
		if [ '-h' == $i ] ; then
				echo "L'argument -h ne marche pas, les options disponibles sont:
			option -d1 : conducteurs avec le plus de trajets
			option -d2 : conducteurs et la plus grande distance
			option -l  : les 10 trajets les plus longs 
			option -t  : les 10 villes les plus traversées
			option -s  : statistiques sur les étapes"
			echo -e
			exit
		fi
	done
	for i in $* ; do
			if [ '-d1' == $i ] ; then
				echo -n "temps d1:"
				`time d1`
				echo -e
			elif [ '-d2' == $i ] ; then
				echo -n "temps d2:"
				`time d2`
				echo -e
			elif [ '-l' == $i ] ; then
				echo -n "temps l:"
				`time l`
				echo -e
			elif [ '-t' == $i ] ; then
				echo -n "temps t:"
				`time t`
				echo -e
		fi
	done
else 
	echo "Le fichier data.csv doit être le premier argument"
fi
