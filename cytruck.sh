#!/bin/bash
n=$*
m=$#
l=$3
for i in $*
do
	if [ '-h' == $i ]
	then
		echo "Vous ne pouvez pas introduire un argument qui vaut -h"
		exit
	fi
done
fichier=`cat data.csv | head -10 | tail -9 | cut -d';' -f6| sort -r -d`
echo $n
echo $m
echo $l
echo $fichier
