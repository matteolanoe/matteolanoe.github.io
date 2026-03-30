# ==============================================================================
# DEVOIR MAISON : RECODAGE DE VARIABLES ET ANALYSE
# ==============================================================================
# CONSIGNES : 
# Ce script contient des trous (notés "...") que vous devez compléter.
# L'objectif est de nettoyer et transformer les données brutes du Titanic 
# pour créer des catégories ayant un véritable sens sociologique (statut 
# matrimonial, classe sociale, stade de la vie).
# ==============================================================================

# 0. Importation des données
titanic <- read.csv(...)

# ------------------------------------------------------------------------------
# PARTIE 1 : CRÉATION D'UNE VARIABLE PAR OPÉRATION MATHÉMATIQUE
# ------------------------------------------------------------------------------
# Dans le jeu de données, "SibSp" représente le nombre de frères/sœurs/conjoints à bord.
# "Parch" représente le nombre de parents/enfants à bord.
# Pour obtenir la taille totale de la famille, il faut additionner ces deux variables
# et ajouter 1 (le passager lui-même).

# Créez une nouvelle colonne "Taille_Famille" dans la base de données :
titanic$... <- titanic$... + titanic$... + 1

# ------------------------------------------------------------------------------
# PARTIE 2 : RECODAGE D'UNE VARIABLE QUANTITATIVE EN CLASSES (DISCRÉTISATION)
# ------------------------------------------------------------------------------
# Nous voulons catégoriser l'âge des passagers. En 1912, la majorité légale, 
# la mise au travail et la vieillesse ne répondent pas aux mêmes normes qu'aujourd'hui.
# Nous allons créer trois catégories : "Enfant" (strictement moins de 15 ans), 
# "Adulte" (de 15 à 60 ans inclus), et "Senior" (strictement plus de 60 ans).

# Étape 2.1 : Observez la distribution de la variable Age pour vérifier sa structure.
summary(titanic$...)
hist(titanic$..., main = "Distribution des âges", col = "lightblue")

# NOUVELLE COMMANDE : ifelse(condition, valeur_si_vrai, valeur_si_faux)
# Pour créer 3 catégories, il faut "imbriquer" deux ifelse().

# Étape 2.2 : Complétez le recodage imbriqué.
titanic$Age_Groupe <- ifelse(titanic$... < 15, "Enfant", 
                             ifelse(titanic$... > ..., "...", "..."))

# Vérifiez votre recodage avec un tri à plat (tableau d'effectifs) :
table(titanic$...)

# ------------------------------------------------------------------------------
# PARTIE 3 : RECODAGE COMPLEXE D'UNE VARIABLE QUALITATIVE NON CATÉGORISÉE
# ------------------------------------------------------------------------------
# La colonne "Name" contient le nom complet, mais aussi le titre du passager 
# (Mr, Mrs, Capt, Jonkheer...). C'est un indicateur massif de statut social.

# Étape 3.1 : Extraction du texte (Code fourni)
# NOUVELLE COMMANDE : gsub() cherche un motif de texte (RegEx) et le remplace.
# Ici, on supprime tout ce qui est avant la virgule et après le point pour isoler le titre.
titanic$Titre <- gsub("(.*, )|(\\..*)", "", titanic$Name)

# Faites un tri à plat de cette nouvelle variable "Titre" pour observer la diversité :
...(titanic$Titre)

# Étape 3.2 : Regroupement des modalités
# On constate des effectifs très faibles pour certains titres. Il faut les regrouper 
# de manière sociologiquement pertinente.
# NOUVELLE COMMANDE : L'opérateur %in% permet de vérifier si une valeur appartient 
# à une liste de valeurs : c("valeur1", "valeur2").

# On duplique d'abord la variable pour ne pas écraser les données originales :
titanic$Titre_Recode <- titanic$Titre

# Regroupez les titres aristocratiques  
# dans une modalité nommée "Noblesse" :
titanic$Titre_Recode[titanic$Titre_Recode %in% c("Don", "Dona", "...", "...", "...", "...")] <- "Noblesse"

# Regroupez les titres militaires et académiques  
# dans une modalité nommée "Elite_Pro" :
titanic$...[titanic$... %in% c("...", "...", "...", "...", "...")] <- "Elite_Pro"

# Regroupez les abréviations françaises ("Mlle", "Ms") avec les "Miss", 
# et ("Mme") avec les "Mrs" :
titanic$Titre_Recode[titanic$Titre_Recode %in% c("...", "...")] <- "Miss"
titanic$Titre_Recode[titanic$Titre_Recode == "..."] <- "Mrs"

# Vérifiez que votre nouvelle variable "Titre_Recode" ne contient plus que des 
# catégories aux effectifs suffisants (Master, Miss, Mr, Mrs, Noblesse, Elite_Pro) :
table(titanic$...)

# ==============================================================================
# QUESTIONS D'ANALYSE
# ==============================================================================
# À partir des variables que vous venez de créer et de nettoyer, exécutez les 
# croisements statistiques nécessaires pour répondre aux questions suivantes 
# sous forme de commentaires (ajoutez des # pour rédiger vos réponses).

# Q1. Utilisez la fonction prop.table(table(Variable_Dependante, Variable_Independante), 2)
# pour croiser la variable "Survived" avec votre nouvelle variable "Age_Groupe".
# Quel est le taux de survie des enfants comparé à celui des adultes et des seniors ? 
# Que nous dit cet écart sur les normes morales de sauvetage en 1912 ?
# [Tapez votre code de croisement ici]
...

# [Rédigez votre réponse ici]
# ...
# ...

# Q2. Croisez maintenant "Survived" avec "Titre_Recode" (en pourcentages en colonnes).
# Comparez le taux de survie de la modalité "Mr" avec la modalité "Elite_Pro" et "Noblesse".
# Le prestige social (titre professionnel ou aristocratique) a-t-il protégé les 
# hommes face à la mort autant que le fait d'être une femme ("Mrs", "Miss") ?
# Que déduisez-vous de la hiérarchie des valeurs (Genre vs Classe sociale) dans 
# cette situation d'urgence ?
# [Tapez votre code de croisement ici]
...

# [Rédigez votre réponse ici]
# ...
# ...

# Q3. Réalisez un tableau croisé entre "Titre_Recode" et "Pclass" (Classe du billet).
# La catégorie "Noblesse" voyage-t-elle exclusivement en 1ère classe ? 
# Y a-t-il des "Elite_Pro" en 3ème classe ? Qu'est-ce que cela nous apprend sur 
# la corrélation entre les titres déclaratifs et la richesse économique réelle ?
# [Tapez votre code de croisement ici]
...

# [Rédigez votre réponse ici]
# ...
# ...