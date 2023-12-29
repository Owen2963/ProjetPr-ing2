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
	`touch temp/temp1`
	`touch temp/temp2`
	`tail +2 data.csv | cut -d';' -f6 > temp/temp1`
	a=0
	while read PRENOM NOM
	do
		if  [ "Laura" == $PRENOM ]  && [ "NAVARRO" == $NOM ]  ; then
				a=$((a+1))
		fi
	done < temp/temp1
	echo $a
	echo "Laura NAVARRO $a" >> temp/temp2
}

for i in $*
do
	if [ '-h' == $i ] ; then
			echo "L'argument -h ne marhe pas, les options disponibles sont:
		option -d1 : conducteurs avec le plus de trajets
		option -d2 : conducteurs et la plus grande distance
		option -t  : les 10 villes les plus traversées
		option -s  : statistiques sur les étapes"
	elif [ '-d1' == $i ] ; then
		echo `time d1` 
	fi
done
