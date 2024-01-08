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
	`awk -F";" '{print $6}' data.csv | sort -r | uniq -c > temp/temp1.txt&&awk '{print $1" "$2","$3}' temp/temp1.txt | sort -r -n | head -10 > temp/temp11.txt`
	`gnuplot 'd1.gnu'`
}

d2(){
	`awk -F";" '{print $5" "$6}' data.csv | tail +2 > temp/temp2.txt&&awk '{while(($2==p)&&($3==n)) d+=$1} {p=$2;n=$3} {print d" "p" "n}' temp/temp2.txt | sort -r -n | head -10 > temp/temp22.txt`
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
			elif [ '-d1' == $i ] ; then
				`time d1`
			elif [ '-d2' == $i ] ; then
				`time d2`
		fi
	done
else 
	echo "Le fichier data.csv doit être le premier argument"
fi
