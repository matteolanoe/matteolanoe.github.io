# Script d'application : Tests statistiques sur le Titanic

# Préparation des données
titanic <- read.csv("titanic.csv")
titanic$Survived <- as.factor(titanic$Survived)
titanic$Pclass <- as.factor(titanic$Pclass)

# ------------------------------------------------------------------------------
# 1. Le test de Student (Croisement Quanti x Quali)
# ------------------------------------------------------------------------------
# Questionnement sociologique : La règle morale "les femmes et les enfants d'abord" 
# a-t-elle eu un effet réel et significatif ? Pour le savoir, on vérifie si 
# l'âge moyen des survivants est statistiquement différent de celui des victimes.

# Hypothèse nulle (H0) : L'âge moyen est identique dans les deux groupes.

# Exécution du test (on compare l'âge en fonction de la survie)
t.test(Age ~ Survived, data = titanic)

# Interprétation des résultats affichés dans la console :
# Il faut d'abord regarder la ligne "p-value".
# Si cette valeur est inférieure à 0.05, on rejette l'hypothèse nulle.
# Il faut ensuite regarder la section "sample estimates" tout en bas. 
# Elle donne la moyenne d'âge du groupe 0 (décès) et du groupe 1 (survie).
# Conclusion attendue : La valeur p est très petite et la moyenne d'âge des 
# survivants est plus basse. L'application de la norme morale a donc 
# produit une différence significative.


# ------------------------------------------------------------------------------
# 2. Le test du Khi-deux (Croisement Quali x Quali)
# ------------------------------------------------------------------------------
# Questionnement sociologique : Le capital économique a-t-il protégé les 
# passagers face à la mort ? On cherche à savoir si l'appartenance à une classe 
# sociale (le type de billet) est liée aux chances de survie.

# Hypothèse nulle (H0) : La survie est totalement indépendante de la classe sociale.

# Exécution du test : Il faut obligatoirement construire le tableau croisé 
# avec la fonction table() avant d'appliquer le test sur ce tableau.
tableau_survie <- table(titanic$Pclass, titanic$Survived)
print(tableau_survie)
chisq.test(tableau_survie)

# Interprétation des résultats affichés dans la console :
# Le logiciel donne un score brut (X-squared) et sa probabilité associée (p-value).
# Si la console affiche "p-value < 2.2e-16", cela signifie que la probabilité 
# est de 0 avec 16 zéros après la virgule.
# Cette probabilité étant largement inférieure à 0.05, on rejette l'hypothèse nulle.
# Conclusion attendue : Il n'y a pas d'indépendance. La classe sociale a joué 
# un rôle statistiquement significatif dans les chances de survie.