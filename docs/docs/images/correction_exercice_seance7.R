# ==============================================================================
# EXERCICE SÉANCE 7 : L'ÉCHANTILLONNAGE DES COMMUNES FRANÇAISES
# ==============================================================================

# 1. IMPORTATION DES DONNÉES
# read.csv charge les données en mémoire. Le paramètre sep = "," est crucial ici :
# les fichiers CSV francophones utilisent généralement le point-virgule comme 
# séparateur car la virgule sert déjà pour les nombres décimaux, mais ça n'est 
# pas le cas pour ce fichier.
df_communes <- read.csv("communes-france-2025.csv", sep = ",")

# ------------------------------------------------------------------------------
# ÉTAPE 1 : L'ÉCHANTILLONNAGE ALÉATOIRE SIMPLE
# ------------------------------------------------------------------------------

# set.seed initialise le générateur de nombres pseudo-aléatoires de R.
set.seed(42)

# nrow(df_communes) compte le nombre total de lignes du tableau.
# L'opérateur 1:nrow(...) crée une suite de nombres de 1 jusqu'à la dernière ligne.
# sample() va piocher au hasard 1000 nombres dans cette suite.
lignes_tirees <- sample(1:nrow(df_communes), 1000)

# On utilise les crochets [lignes, colonnes] pour filtrer le tableau.
# En plaçant "lignes_tirees" avant la virgule et rien après, on demande à R de 
# garder uniquement les 1000 lignes tirées au sort, mais toutes les colonnes.
echantillon_simple <- df_communes[lignes_tirees, ]

# nrow() vérifie que le nouveau tableau contient bien exactement 1000 lignes.
nrow(echantillon_simple)

# ------------------------------------------------------------------------------
# ÉTAPE 2 : VÉRIFIER LA REPRÉSENTATIVITÉ
# ------------------------------------------------------------------------------

# Le symbole $ permet d'isoler une seule colonne du tableau (ici Population).
# na.rm = TRUE demande à la fonction mean() d'ignorer les valeurs manquantes (NA).
# Si une seule commune n'a pas de population renseignée, le calcul échouerait sans cela.
moyenne_totale <- mean(df_communes$population, na.rm = TRUE)
print(moyenne_totale)

# On fait la même opération mathématique, mais restreinte à notre échantillon.
moyenne_echantillon <- mean(echantillon_simple$population, na.rm = TRUE)
print(moyenne_echantillon)


# ------------------------------------------------------------------------------
# ÉTAPE 3 : L'ÉCHANTILLONNAGE STRATIFIÉ (QUOTAS)
# ------------------------------------------------------------------------------

#install.packages("dplyr")
library(dplyr)

set.seed(42)

# L'opérateur %>% (pipe) prend le résultat de gauche et l'injecte à droite.
# group_by(Region) découpe virtuellement le tableau selon les différentes régions.
# slice_sample(prop = 0.05) va tirer aléatoirement 5% (0.05) des lignes, 
# mais en appliquant cette règle séparément à l'intérieur de chaque groupe (région).
echantillon_strate <- df_communes %>%
  group_by(reg_nom) %>%
  slice_sample(prop = 0.05)

# table() compte le nombre d'occurrences pour chaque région dans notre échantillon.
table(echantillon_strate$reg_nom)