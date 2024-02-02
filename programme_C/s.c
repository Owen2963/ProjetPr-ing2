#define LONGUEUR_LIGNE 95
#define LONGUEUR_NOM_VILLE 50
#define LONGUEUR_NOM_CONDUCTEUR 50
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//Définition de la structure Ligne de type AVL, où la lettre e est le facteur équilibre, qui va stocker l'id de la route, le min, max et moyenne des distances
typedef struct Ligne {
    int idRoute;
    float min;
    float max;
    int moy;
    int nbr_de_pas;
    int e;
    int ecart;
    struct Ligne* gauche;
    struct Ligne* droit;
} Ligne;

//Fonction qui crée une structure de type Ligne
Ligne* CreerLigne(int idRoute, float distance) {
    Ligne* a = malloc(sizeof(Ligne));
    if (a == NULL) {
        printf("Échec de l'allocation mémoire\n");
        exit(1);
    }
    a->idRoute = idRoute;
    a->min = distance;
    a->max = distance;
    a->moy = distance;
    a->nbr_de_pas = 1;
    a->e = 0;
    a->gauche = NULL;
    a->droit = NULL;
    return a;
}

int hauteur_s(Ligne* a) {
    if (a == NULL) {
        return 0;
    }
    int hauteurGauche = hauteur_s(a->gauche);
    int hauteurDroite = hauteur_s(a->droit);
    return 1 + (hauteurGauche > hauteurDroite ? hauteurGauche : hauteurDroite);
}

//Fonction qui retourne le maximum entre deux entiers
int maximum(const int a, const int b) {
    if(a>b){
		return a;
	}
	else if(b<a){
	   return b;
	}
	else{
		return a;
	}
}

//Fonction qui retourne le minimum entre deux entiers
int minimum(const int a, const int b) {
    if(a<b){
		return a;
	}
	else if(a>b){
	   return b;
	}
	else{
		return a;
	}
}

// Rotations Simples
Ligne* rotationGauche_s(Ligne* a) {
    if (a == NULL) {
        printf("ERREUR NULL\n");
        exit(0);
    }
    Ligne* b = a->droit;
    a->droit = b->gauche;
    b->gauche = a;
    a->e = hauteur_s(a->droit) - hauteur_s(a->gauche);
    b->e = hauteur_s(b->droit) - hauteur_s(b->gauche);
    return b;
}

Ligne* rotationDroite_s(Ligne* a) {
    if (a == NULL) {
        printf("ERREUR NULL\n");
        exit(0);
    }
    Ligne* b = a->gauche;
    a->gauche = b->droit;
    b->droit = a;

    a->e = hauteur_s(a->droit) - hauteur_s(a->gauche);
    b->e = hauteur_s(b->droit) - hauteur_s(b->gauche);

    return b;
}

// Rotations doubles
Ligne* rotationDoubleGauche_s(Ligne* a) {
    if (a == NULL) {
        printf("ERREUR NULL\n");
        exit(0);
    }
    a->droit = rotationDroite_s(a->droit);
    return rotationGauche_s(a);
}

Ligne* rotationDoubleDroite_s(Ligne* a) {
    if (a == NULL) {
        printf("ERREUR NULL\n");
        exit(0);
    }
    a->gauche = rotationGauche_s(a->gauche);
    return rotationDroite_s(a);
}

// Fonction pour équilibrer Ligne
Ligne* equilibrerLigne(Ligne* a) {
    if (a == NULL) {
        printf("ERREUR NULL\n");
        exit(0);
    }
    if (a->e > 1) {
        if (a->droit->e < 0) {
            a = rotationDoubleGauche_s(a);
        } else {
            a = rotationGauche_s(a);
        }
    } else if (a->e < -1) {
        if (a->gauche->e > 0) {
            a = rotationDoubleDroite_s(a);
        } else {
            a = rotationDroite_s(a);
        }
    }
    return a;
}

// Fonction pour insérer un nouveau nœud dans l'arbre Ligne
void insererLigne(Ligne** a, int idRoute, float distance, int* h) {
    // Gérer le cas où a est vide
    if (*a == NULL) {
        *a = CreerLigne(idRoute, distance);
        *h = 1;
    } else if (idRoute < (*a)->idRoute) {
        insererLigne(&((*a)->gauche), idRoute, distance, h);
        *h = -(*h);
    } else if (idRoute > (*a)->idRoute) {
        insererLigne(&((*a)->droit), idRoute, distance, h);
    } else {
        // Gérer le cas égal puisqu'il y a plus de données qu'un Ligne normal
        (*a)->nbr_de_pas++;
        if ((*a)->max < distance) {
            (*a)->max = distance;
        }
        if ((*a)->min > distance) {
            (*a)->min = distance;
        }
        (*a)->moy += distance;
        (*a)->ecart = (*a)->max - (*a)->min;
        *h = 0;
        return;
    }
    if (*h != 0) {
        (*a)->e += *h;
        *a = equilibrerLigne(*a);
        if ((*a)->e == 0) {
            *h = 0;
        } else {
            *h = 1;
        }
    }
}

// Fonction pour libérer Ligne
void libererLigne(Ligne* a) {
    if (a == NULL){
    	return;
    }
    libererLigne(a->gauche);
    libererLigne(a->droit);
    free(a);
}

// Utilisé pour trier les villes en comparant leurs écarts min-max
int fonctionTri_s(const void* arg1, const void* arg2) {
    return (*(Ligne**)arg2)->ecart - (*(Ligne**)arg1)->ecart;
}

//Séléction des 50 villes avec le plus grand écart min-max
int ObtenirTop50(Ligne* lligne, int* compter, Ligne* tab[50]) {
    if (lligne == NULL || tab == NULL) {
    	return 0;
    }
    if (lligne->nbr_de_pas <= 1){
    	return 1;
    }
    if (*compter < 50) {
    	tab[(*compter)++] = lligne;
    } else {
        int min_id = 0;
        for (int i = 0; i < 50; i++) {
            if (tab[i]->ecart > tab[min_id]->ecart) {
                min_id = i;
            }
        }
        if (lligne->ecart > (tab[min_id])->ecart) {
            tab[min_id] = lligne;
        }
    }

    return 1;
}

int parcourirLigne(Ligne* lligne, int* compter, Ligne* tab[50]) {
    if (lligne == NULL){
    	return 1;
    }
    parcourirLigne(lligne->gauche, compter, tab);
    parcourirLigne(lligne->droit, compter, tab);
    return ObtenirTop50(lligne, compter, tab);
}

int main() {
    printf("Début du traitement 's'...\n");
    char* ligne = malloc(sizeof(char) * LONGUEUR_LIGNE);
    int idRoute;
    float distance;
    int idEtape;
    char nomVille_A[LONGUEUR_NOM_VILLE + 1];
    char nomVille_B[LONGUEUR_NOM_VILLE + 1];
    char nomConducteur[LONGUEUR_NOM_CONDUCTEUR];
    Ligne* lligne = CreerLigne(0, 0.0);
	//On ouvre le fichier data.csv et on stocke ses données dans la variable fichierSource
	FILE* fichierSource = fopen("data.csv", "r");
	if (fichierSource == NULL) {
		printf("Erreur d'ouverture du fichier");
		free(ligne);
		libererLigne(lligne);
		return 0;
	}
	// En supposant que la première ligne contient les en-têtes
	fgets(ligne, sizeof(char) * (LONGUEUR_LIGNE), fichierSource);
	printf("Première ligne ignorée : %s\n", ligne);

	//On récupère et analyse toutes les lignes du fichier en calculant le nombre de fois que la ville est la ville de départ le chaque ligne
	while (!feof(fichierSource)) {
		fgets(ligne, sizeof(char) * LONGUEUR_LIGNE, fichierSource);
		if (fichierSource == NULL) {
			printf("Erreur de lecture du fichier");
			libererLigne(lligne);
			free(ligne);
		return 0;
	}
	sscanf(ligne, "%d;%d;%50[^;];%50[^;];%f;%[^\n]", &idRoute, &idEtape, nomVille_A, nomVille_B, &distance, nomConducteur);
	insererLigne(&lligne, idRoute, distance, &(lligne->e));
	}
	fclose(fichierSource);
    free(ligne);
    FILE* fichierSortie = fopen("temp/temps.txt", "w+");
    if (fichierSortie == NULL) {
        printf("Échec de la création du fichier de sortie ");
        libererLigne(lligne);
        return 0;
    }
    int compter = 0;
    Ligne* tab[50];
    int res = parcourirLigne(lligne, &compter, tab);
    if (1 != res) {
        printf("Erreur lors de la tentative d'obtention des 50 premiers.\n");
        libererLigne(lligne);
        fclose(fichierSortie);
        return res;
    }
    qsort(tab, 50, sizeof(*tab), fonctionTri_s);
    for (int i = 0; i < 50; i++) {
        if (tab[i] != NULL) {
            fprintf(fichierSortie, "%d;%.3f;%.3f;%.3f\n", (tab[i])->idRoute, (tab[i])->moy / (float)(tab[i])->nbr_de_pas, (tab[i])->min, (tab[i])->max);
        }
    }
    //On libére les mémoires alloués et on ferme le fichier de sortie
    fclose(fichierSortie);
    libererLigne(lligne);
    return 1;
}
