#!/bin/bash
for i in $*
do
	if [ '-h' == $i ]
	then
		echo "L'argument -h ne marhe pas, les options disponibles sont:
	option -d1 : conducteurs avec le plus de trajets
	option -d2 : conducteurs et la plus grande distance
	option -t  : les 10 villes les plus traversées
	option -s  : statistiques sur les étapes"
		exit
	fi
done
for i in $#
do
	if [ 'temp' == $i ]
	then
		n=0
		echo $(`rm -r temp`)
	fi
done

fichier=`cat data.csv | head -10 | tail -9 | cut -d';' -f6| sort -r -d`
echo $fichier
