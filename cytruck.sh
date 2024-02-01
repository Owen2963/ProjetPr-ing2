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

#Le traitement d1
d1(){
	#Calcul du nombre de fois que le nom et prénom de conducteurs apparaissent
	`awk -F";" '$2 == 1 {p=$6} {if($6==p) print ";"$6}' data.csv | sort -r -t';' -k2 | uniq -c > temp/temp1.txt`
	#Tri par ordre décroissant le nombre de trajets et séléction des 10 premiers conducteurs.
	`sort -r -n -t';' -k1 temp/temp1.txt | head -10 > temp/temp11.txt`
	#Création du graphique de type histogramme horizontal
	`gnuplot 'd1.gnu'&&convert -rotate 90 image/d11.png image/d1.png&&rm image/d11.png`
}

#Le traitement d2
d2(){
	#Calcul de la distance que chaque conducteur a parcouru
	`awk -F";" '{tab[$6]+=$5} END {for (i in tab) print tab[i]";"i}' data.csv | tail +2 | sort -r -t';' -n -k1 | head -10 > temp/temp2.txt`
	#Création du graphique  de type histogramme horizontal
	`gnuplot 'd2.gnu'&&convert -rotate 90 image/d22.png image/d2.png&&rm image/d22.png`
}

#Le traitement l
l(){
	#Somme de chaque étape pour chaque trajet
	`awk -F";" '{tab[$1]+=$5} END {for (i in tab) print i";"tab[i]}' data.csv | sort -t';' -r -n -k2 | head -10 | sort -r -t';' -n -k1 > temp/templ.txt`
	#Création du graphique de type histogramme horizontal
	`gnuplot 'l.gnu'`
}

#Le traitement t
t(){
	#Compilation du traitement t
	`gcc t.c -o -t`
	#éxécution du traitement t
	`./-t`
	#Création du graphique
	`gnuplot 't.gnu'`
}

#Le traitement s
s(){
	#Création du graphique
	`gnuplot 's.gnu'`
}

if [ 'data.csv' == $1 ] ; then
	echo `clear`
	#On parcours les arguments pour voir si l'argumment -h est présent, si c'est le cas on affiche le message et le programme s'arrête
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
	#On parcours les arguments pour voir quel traitement éxécuter
	for i in $* ; do
			if [ '-d1' == $i ] ; then
				echo -n "temps d1:"
				#Durée et éxécution du traitement d1
				`time d1`
				echo -e
			elif [ '-d2' == $i ] ; then
				echo -n "temps d2:"
				#Durée et éxécution du traitement d2
				`time d2`
				echo -e
			elif [ '-l' == $i ] ; then
				echo -n "temps l:"
				#Durée et éxécution du traitement l
				`time l`
				echo -e
			elif [ '-t' == $i ] ; then
				echo -n "temps t:"
				#Durée et éxécution du traitement t
				`time t`
				echo -e
			elif [ '-s' == $i ] ; then
				echo -n "temps s:"
				#Durée et éxécution du traitement s
				`time s`
				echo -e
		fi
	done
else 
	#Si le fichier data.csv n'est pas présent dans les arguments
	echo "Le fichier data.csv doit être le premier argument"
fi
