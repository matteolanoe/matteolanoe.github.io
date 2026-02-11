# ==============================================================================
# SÉANCE 3 : DÉCRIRE UNE VARIABLE AVEC R
# Cas d'étude : Le Titanic (Inégalités et Démographie)
# ==============================================================================

#Ne pas oublier de déterminer votre espace de travail (Session > Set Working Directory)

# ------------------------------------------------------------------------------
# ÉTAPE 0 : IMPORTATION
# ------------------------------------------------------------------------------
# 1. Assurez-vous d'avoir placé "titanic.csv" dans votre dossier de projet.
# 2. Importez les données :
titanic <- read.csv("titanic.csv") # Ajoutez sep=";" si nécessaire

# Vérification rapide : On regarde les premières lignes
head(titanic)

# ==============================================================================
# EXERCICE 1 : LA DÉMOGRAPHIE (VARIABLE "Age")
# Objectif : Comprendre la tendance centrale et gérer les données manquantes (NA)
# ==============================================================================

# Q1. Quel est l'âge moyen des passagers ?
# ATTENTION : Si vous tapez mean(titanic$Age), R répondra "NA" car il y a des trous.
# Il faut dire à R d'ignorer les manquants avec na.rm = TRUE.
mean(titanic$Age, na.rm = TRUE)

# Q2. Quel est l'âge médian ? (50% sont plus jeunes, 50% sont plus vieux)
median(titanic$Age, na.rm = TRUE)

# -> INTERPRÉTATION SOCIOLOGIQUE :
# La moyenne (~29 ans) et la médiane (~28 ans) sont très proches.
# Cela signifie que la distribution des âges est assez équilibrée (symétrique).

# Q3. Quelle est l'étendue des âges ? (Le plus jeune et le plus vieux)
min(titanic$Age, na.rm = TRUE) # Un bébé de quelques mois (0.42)
max(titanic$Age, na.rm = TRUE) # Le doyen avait 80 ans

# ==============================================================================
# EXERCICE 1 BIS : LA MOYENNE PONDÉRÉE (CAS PARTICULIER)
# ==============================================================================

# Comme chaque ligne est un passager unique, ils ont tous le même "poids".
# Mais essayons une expérience sociologique :
# Calculons l'âge moyen, en donnant plus d'importance (de poids) aux billets chers.

# Syntaxe : weighted.mean(Variable, Poids, na.rm = TRUE)
weighted.mean(titanic$Age, titanic$Fare, na.rm = TRUE)

# -> RÉSULTAT :
# L'âge moyen pondéré par l'argent (~32 ans) est plus élevé que l'âge moyen réel (~29 ans).
# Interprétation : L'argent est concentré chez les passagers plus âgés.

# (RAPPEL SYNTAXE SCOLAIRE) : Si vous voulez tester avec des notes et coeffs
# notes <- c(18, 8)
# coeffs <- c(1, 4)
# weighted.mean(notes, coeffs) # Donne 10

# ==============================================================================
# EXERCICE 2 : LES INÉGALITÉS ÉCONOMIQUES (VARIABLE "Fare")
# Objectif : Comprendre la dispersion et le piège de la moyenne
# ==============================================================================

# La variable "Fare" correspond au prix du billet en Livres Sterling (£).

# Q1. Calculez la moyenne et la médiane du prix du billet.
mean(titanic$Fare, na.rm = TRUE)   # Résultat attendu : environ 32 £
median(titanic$Fare, na.rm = TRUE) # Résultat attendu : environ 14 £

# -> INTERPRÉTATION SOCIOLOGIQUE (TRES IMPORTANT) :
# Il y a un écart énorme ! La moyenne (32) est plus du double de la médiane (14).
# Pourquoi ? Parce que quelques ultra-riches (suites de luxe) tirent la moyenne vers le haut.
# La médiane (14 £) est beaucoup plus représentative du passager "typique".

# Q2. Mesurer la dispersion (L'hétérogénéité des richesses).

# A. LA VARIANCE (Moyenne des carrés des écarts)
# C'est l'étape intermédiaire de calcul, difficile à interpréter (en livres au carré).
var(titanic$Fare, na.rm = TRUE)

# B. L'ÉCART-TYPE (Standard Deviation - Racine carrée de la variance)
# C'est la mesure reine : elle est dans la même unité que la variable (£).
sd(titanic$Fare, na.rm = TRUE)

# Un écart-type de ~49 £ (alors que la médiane est de 14 £) montre une
# dispersion gigantesque. C'est le signe d'une population extrêmement inégalitaire.

# Q3. Les Quantiles (Pour voir les tranches de richesse).
# Cela nous donne : Min, Q1 (25%), Médiane, Q3 (75%), Max.
quantile(titanic$Fare, na.rm = TRUE)

# Lecture :
# - 25% des passagers ont payé moins de 7.91 £ (Les pauvres/migrants).
# - 75% des passagers ont payé moins de 31 £.
# - Le Max est à 512 £ ! (L'équivalent d'une fortune aujourd'hui).

# ==============================================================================
# EXERCICE 3 : VISUALISER POUR COMPRENDRE
# Objectif : Voir la distribution et identifier les "Outliers"
# ==============================================================================

# 1. L'Histogramme (Pour voir la forme de la distribution)
# On voit bien le pic à gauche (les billets pas chers) et la longue traîne à droite.
hist(titanic$Fare,
     main = "Répartition du prix des billets",
     xlab = "Prix (£)",
     col = "lightblue",
     breaks = 20)

# 2. La Boîte à Moustaches (Boxplot) - L'outil roi pour les inégalités
# La boîte représente le "cœur" (50% des gens).
# Les points au-dessus sont les "Outliers" (les valeurs aberrantes/extrêmes).
boxplot(titanic$Fare,
        main = "Les inégalités de prix (Outliers)",
        ylab = "Prix (£)",
        col = "tomato")

# -> QUESTION : Voyez-vous les points tout en haut ?
# Ce sont les passagers de 1ère classe comme Mme Cardeza (512£).
# Ils sont "hors normes" par rapport au reste de la population.

# ==============================================================================
# EXERCICE 4 : LA STRUCTURE SOCIALE (VARIABLE QUALITATIVE "Pclass")
# Objectif : Utiliser le Mode et les fréquences
# ==============================================================================

# La classe n'est pas un chiffre continu, c'est une catégorie (1, 2, 3).
# On ne fait pas de moyenne (ça n'a pas de sens de dire "Classe 2.3").

# Q1. Quelle était la classe la plus fréquente (Le Mode) ?
table(titanic$Pclass)

# Résultat :
# 1 (Riches) : 216
# 2 (Moyens) : 184
# 3 (Pauvres) : 491
# -> Sociologiquement : C'est une pyramide sociale classique. La base (les pauvres)
# est deux fois plus nombreuse que le sommet.

# Q2. Visualiser cette hiérarchie sociale
barplot(table(titanic$Pclass),
        main = "Structure sociale du Titanic",
        xlab = "Classe",
        ylab = "Nombre de passagers",
        col = c("gold", "grey", "brown")) # Or, Argent, Bronze 