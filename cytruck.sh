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
n=0
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

d='data.csv'
d1(){
	f=`cat  data.csv | head -n+10 | tail -9 | cut -d';' -f6`
	echo $f
}

echo $(d1)
