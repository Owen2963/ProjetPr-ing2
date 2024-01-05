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
	`awk -F";" '{print $6}' data.csv | sort -r | uniq -c > temp/temp1`
	`sort -r -n temp/temp1 > temp/temp2`
	#`sort -r -n -t' ' -k3 temp2 | head -10`
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
				echo `time d1` 
			fi
	done
else 
	echo "Le fichier data.csv doit être le premier argument"
fi

