# ==============================================================================
# SÉANCE 4 : RELIER DES VARIABLES ENTRE ELLES
# ==============================================================================

# ------------------------------------------------------------------------------
# ÉTAPE 0 : CHARGEMENT ET PRÉPARATION
# ------------------------------------------------------------------------------

# 1. Importation des données
titanic <- read.csv("titanic.csv") # Vérifiez bien le chemin et le séparateur (sep=";" ?)

# 2. Vérification de la nature des variables
# Dans le cours, nous avons vu que "Survived" (0/1) et "Pclass" (1/2/3) 
# sont des variables QUALITATIVES, même si ce sont des chiffres.
# Pour que R les traite correctement (et ne fasse pas de moyennes absurdes),
# on les transforme en "facteurs" (catégories).

titanic$Survived <- as.factor(titanic$Survived)
titanic$Pclass   <- as.factor(titanic$Pclass)
titanic$Sex      <- as.factor(titanic$Sex)

# Vérifions la structure
str(titanic)

# ==============================================================================
# PARTIE 1 : RELIER DEUX VARIABLES QUALITATIVES (Quali x Quali)
# Outil : Le Tableau Croisé (Tableau de contingence)
# ==============================================================================

# QUESTION : Le genre (Sexe) a-t-il influencé la survie ?
# -> Variable Indépendante (Cause) : Sex
# -> Variable Dépendante (Effet) : Survived

# A. Le Tri Croisé (Effectifs bruts)
# ----------------------------------
# Commande : table(Ligne, Colonne)
tab_effectifs <- table(titanic$Survived, titanic$Sex)
print(tab_effectifs)
# Lecture : Difficile de comparer car il y a beaucoup plus d'hommes que de femmes.

# B. Les Pourcentages en COLONNE
# ----------------------------------------------------------------------
# On utilise prop.table(tableau, margin = 2)
# margin = 2 signifie "On calcule le % par rapport au total de la Colonne".

tab_colonne <- prop.table(tab_effectifs, margin = 2)
round(tab_colonne * 100, 1) # On multiplie par 100 pour lire en %

# INTERPRÉTATION (Lecture verticale) :
# "Parmi les Femmes, 74.2% ont survécu."
# "Parmi les Hommes, 18.9% ont survécu."
# -> Conclusion : Être une femme augmentait drastiquement les chances de survie.

# C. Les Pourcentages en LIGNE (L'autre lecture)
# ----------------------------------------------
# On utilise prop.table(tableau, margin = 1) 
# margin = 1 signifie "On calcule le % par rapport au total de la Ligne".

tab_ligne <- prop.table(tab_effectifs, margin = 1)
round(tab_ligne * 100, 1)

# INTERPRÉTATION (Lecture horizontale) :
# "Parmi les Survivants, 68.1% sont des femmes."
# Attention : Cette lecture est descriptive, elle n'indique pas la probabilité de survie.

# ==============================================================================
# PARTIE 2 : RELIER UNE QUALITATIVE ET UNE QUANTITATIVE (Quali x Quanti)
# Outil : Comparaison de moyennes par groupe
# ==============================================================================

# QUESTION : Le prix du billet (Fare) dépend-il de la Classe (Pclass) ?
# -> Variable Indépendante (Cause/Groupe) : Pclass (Quali)
# -> Variable Dépendante (Mesure) : Fare (Quanti)

# A. Calculer la moyenne pour chaque groupe
# -----------------------------------------
# Syntaxe : aggregate(Variable_Quanti ~ Variable_Groupe, data = ..., FUN = ...)
# On lit le "~" comme "en fonction de".

aggregate(Fare ~ Pclass, data = titanic, FUN = mean)

# INTERPRÉTATION :
# Classe 1 : 84 £ (Moyenne)
# Classe 3 : 13 £ (Moyenne)
# -> Il y a un lien très fort : la hiérarchie sociale se reflète dans le prix.

# B. Aller plus loin : Moyenne, Écart-type et Médiane par groupe
# --------------------------------------------------------------
# On peut créer une fonction personnalisée ou le faire un par un.
# Essayons avec l'écart-type (sd) pour voir l'hétérogénéité :

aggregate(Fare ~ Pclass, data = titanic, FUN = sd)

# INTERPRÉTATION :
# L'écart-type est énorme en Classe 1 (78) -> Très hétérogène (des riches et des très riches).
# L'écart-type est énorme en Classe 3 (11) -> Très hétérogène (il y a des personnes qui n'ont rien payé, 
# et d'autres qui ont payé 70£ [souvent des billets familiaux]).  

# C. Visualisation : La Boîte à Moustaches (Boxplot)
# --------------------------------------------------
boxplot(Fare ~ Pclass, data = titanic,
        col = c("gold", "grey", "brown"),
        main = "Prix du billet selon la Classe",
        xlab = "Classe", ylab = "Prix (£)")

# ==============================================================================
# PARTIE 3 : RELIER DEUX VARIABLES QUANTITATIVES (Quanti x Quanti)
# Outils : Nuage de points, Covariance, Corrélation
# ==============================================================================

# QUESTION : Y a-t-il un lien entre l'Âge et le Prix du billet ?
# (Est-ce que les vieux sont plus riches ?)

# A. Approche Visuelle : Le Nuage de Points (Scatterplot)
# -------------------------------------------------------
plot(x = titanic$Age, y = titanic$Fare,
     main = "Lien entre Âge et Prix du billet",
     xlab = "Âge (années)", ylab = "Prix (£)",
     col = "blue", pch = 16)

# INTERPRÉTATION VISUELLE :
# Ça ne saute pas aux yeux. Le nuage est très dispersé.
# Il semble y avoir une légère tendance (ça monte un peu), mais c'est flou.

# B. La Co-variance
# --------------------------------
# Rappel cours : Produit des écarts.
# Attention : cov() ne supporte pas les données manquantes (NA).
# Il faut ajouter use = "complete.obs".

cov(titanic$Age, titanic$Fare, use = "complete.obs")

# RÉSULTAT : Environ 73.
# INTERPRÉTATION : C'est positif (+), donc les variables varient dans le même sens.
# MAIS : Est-ce fort ? Impossible à dire car le chiffre dépend des unités (Années * Livres).

# C. La Corrélation
# ---------------------------------------
# Rappel cours : C'est la covariance divisée par les écarts-types.
# Résultat toujours entre -1 et +1.

cor(titanic$Age, titanic$Fare, use = "complete.obs")

# RÉSULTAT : Environ 0.096
# INTERPRÉTATION :
# C'est proche de 0.
# Il y a une corrélation positive, mais elle est EXTRÊMEMENT FAIBLE.
# Conclusion : L'âge n'explique presque pas le prix du billet sur le 
