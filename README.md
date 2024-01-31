Description du Projet :

Ce projet vise à développer un programme de gestion de données pour une société nationale de transport routier. Le programme comprend un script Shell qui interagit avec un programme C pour analyser un fichier de données CSV et générer des graphiques résumant l'activité de la société.

Structure du Projet :

- data : Dossier contenant le fichier CSV d'entrée.
- programme_C: Dossier contenant le programme C, le makefile, et l'exécutable.
- image :  Dossier où seront stockées les images générées.


Utilisation du Script Shell :

```bash
./script.sh chemin_vers_fichier_csv [options]
```
- Le chemin du fichier CSV est obligatoire en premier argument.

- Les options possibles :
[-h] : Affiche l'aide et ignore les autres arguments.
[-d1] : Traitement des conducteurs avec le plus de trajets.
[-d2] : Traitement des conducteurs avec la plus grande distance parcourue.
[-l] : Traitement des 10 trajets les plus longs.
[-t] : Traitement des 10 villes les plus traversées.
[-s] : Statistiques sur les étapes.

Fonctionnalités du Script Shell :

- Vérification de la présence de l'exécutable C et compilation si nécessaire.
- Création ou vidage des dossiers temp et images.
- Affichage de la durée de chaque traitement.
- Génération d'un graphique à partir des résultats du traitement.

Traitements Possibles :

1. [D1] Conducteurs avec le plus de trajets (-d1) :
   - Histogramme horizontal des 10 conducteurs avec le plus de trajets.

2. [D2] Conducteurs et la plus grande distance (-d2) :
   - Histogramme horizontal des 10 conducteurs avec la plus grande distance parcourue.

3. [L] Les 10 trajets les plus longs (-l) :
   - Histogramme vertical des 10 trajets les plus longs.

4. [T] Les 10 villes les plus traversées (-t) :
   - Histogramme regroupé des 10 villes les plus traversées.

5. [S] Statistiques sur les étapes (-s) :
   - Courbes min-max-moyenne des distances des étapes pour les 50 trajets les plus significatifs.

Remarques Importantes :

- Les traitements [D1], [D2], [L], et [T] peuvent être réalisés en utilisant uniquement le script Shell et des commandes Unix.
- Le traitement [S] nécessite l'utilisation d'un programme C pour le tri des données.

Avertissement :
Si le programme C n'est pas présent, le script Shell le compilera. En cas d'échec de compilation, un message d'erreur sera affiché.

Exemple d'Utilisation :

```bash
./script.sh data/data.csv -d1 
```

Notes Techniques :

- Le script Shell utilise GNU Plot pour générer les graphiques.
- Le programme C utilise une structure de type AVL pour le tri des données.
