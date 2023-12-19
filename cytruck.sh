#!/bin/bash
for i in $*
do
	if [ '-h' == $i ] ; then
			echo "L'argument -h ne marhe pas, les options disponibles sont:
		option -d1 : conducteurs avec le plus de trajets
		option -d2 : conducteurs et la plus grande distance
		option -t  : les 10 villes les plus traversées
		option -s  : statistiques sur les étapes"
			exit
	fi
done
t='temp'
if [ -e $h ] ;	then
	echo -n `rm -r temp && mkdir temp`
else
	echo -n `mkdir temp`
fi
i='image'
if [ -e $i ] ;	then
	echo -n `rm -r image && mkdir image`
else
	echo -n `mkdir image`
fi

#d1(){
	#for i in $ligne ; do
	#	if [ 'Laura NAVARRO' == $i ] ; then
	#		a=$((a+1))
	#	fi
	#done
	#echo -e $a
#}

`touch temp1`
f=`head -10 data.csv | cut -d';' -f6 > temp1`
ligne=`read temp1`
echo $ligne
