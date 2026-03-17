# ==============================================================================
# EXERCICE SÉANCE 7 : L'ÉCHANTILLONNAGE DES COMMUNES FRANÇAISES
# ==============================================================================

# 1. IMPORTATION DES DONNÉES
# Importer le fichier "communes_france.csv" en complétant la ligne suivante :
df_communes <- read.csv("...", sep = "...")

# ------------------------------------------------------------------------------
# ÉTAPE 1 : L'ÉCHANTILLONNAGE ALÉATOIRE SIMPLE
# ------------------------------------------------------------------------------

# Question de réflexion 1 : Exécuter la fonction set.seed(42) puis faire le tirage.
# Recommencer l'opération en mettant un # devant set.seed(42).
# Que constate-t-on ? Quelle est l'utilité stricte de cette fonction ?
set.seed(...)

# Tirer au sort 1000 numéros de lignes parmi l'ensemble du tableau :
lignes_tirees <- sample(1:nrow(...), ...)

# Créer l'échantillon en extrayant ces lignes :
echantillon_simple <- df_communes[..., ]

# Vérifier la taille du nouveau tableau :
nrow(...)

# ------------------------------------------------------------------------------
# ÉTAPE 2 : VÉRIFIER LA REPRÉSENTATIVITÉ
# ------------------------------------------------------------------------------

# Calculer la moyenne de la variable "Population" sur la base complète :
moyenne_totale <- mean(df_communes$..., na.rm = ...)
print(moyenne_totale)

# Calculer la moyenne de cette même variable sur l'échantillon :
moyenne_echantillon <- mean(...$..., na.rm = ...)
print(moyenne_echantillon)

# Question de réflexion 2 : Comparer les deux résultats obtenus.
# Que permet de déduire cette comparaison sur la validité de la méthode employée ?
# Que faudrait-il conclure si l'écart entre les deux moyennes était gigantesque ?

# ------------------------------------------------------------------------------
# ÉTAPE 3 : L'ÉCHANTILLONNAGE STRATIFIÉ (QUOTAS)
# ------------------------------------------------------------------------------

install.packages("dplyr")
library(dplyr)

set.seed(...)

# Créer l'échantillon stratifié en tirant 5% des communes par région :
echantillon_strate <- df_communes %>%
  group_by(...) %>%
  slice_sample(prop = ...)

# Afficher la répartition par région :
table(echantillon_strate$...)

# Question de réflexion 3 : Analyser le tableau généré par la commande précédente.
# Quel biais potentiel du tirage aléatoire simple (Étape 1) cette méthode 
# par strates permet-elle d'éliminer définitivement ?