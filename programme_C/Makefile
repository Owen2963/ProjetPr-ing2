#!bin/make

# On rédéfinit la commande qui compile 
GCC = gcc
# On redéfinit le dossier des programmes en C, (DO=dossier)
FICHIER_DO = programme_C
# On redéfinit le dossier poubelle 
POUBELLE_DO = $(FICHIER_DO)/bin
# On redéfinit le dossier de objets
OBJET_DO = $(FICHIER_DO)/obj
# On redéfinit le dossier source
SOURCE_DO = $(FICHIER_DO)/src
# On redéfinit le nom de l'éxecutable
EXE = cytruck

# On récupère tous les fichier en c
SOURCE=$(wildcard $(SOURCE_DO)/*.c)
# On récupère tous les fichiers qui terminent avec un .o
OBJET=$(SOURCE:.c=.o)
# On supprime le dossier source 
OBJET_SUP=$(OBJET:$(SOURCE_DO)/%=%)
# On récupère les fichier .o dans le fichier objet
OBJET_DANS_DO=$(addprefix $(OBJET_DO)/, $(OBJET_SUP))

# on construit tout
tout: objet poubelle exe
# on construit éxécutable
exe: $(OBJET_DANS_DO)
	$(GCC) $^ -o $(POUBELLE_DO)/$(EXE)
# On crée le dossier poubelle
poubelle: 
	mkdir -p $(POUBELLE_DO)
# On crée le dossier objet
objet:
	mkdir -p $(OBJET_DO)
# On supprime de manière récursive les dossiers objet et poubelle sauf le gnuplot
nettoyer:
	rm -rf $(POUBELLE_DO)
	rm -rf $(OBJET_DO)
# On construit les fichiers .o
$(OBJET_DO)/%.o : $(SOURCE_DO)/%.c $(OBJET_DO) objet
	$(GCC) -c $< -o $@
