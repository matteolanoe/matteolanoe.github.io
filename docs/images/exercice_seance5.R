# ==============================================================================
# EXERCICE SÉANCE 5 : L'EXPÉRIENCE DU GHANA (DUFLO ET AL.)
# ==============================================================================

# Importe les données dans 3 objets distincts.
# Complète les noms des fichiers entre les guillemets, avec le type de sep :
df_avant <- read.csv("...")
df_apres <- read.csv("...")
df_mes   <- read.csv("...")

# ------------------------------------------------------------------------------
# ÉTAPE 1 : LE TEST D'ÉQUILIBRAGE (AVANT LA LOTERIE)
# ------------------------------------------------------------------------------
# Objectif : Vérifier que les groupes Test (1) et Contrôle (0) ont le même 
# niveau initial (score BECE).

# Utilise la fonction aggregate() pour calculer la moyenne de BECE en fonction de Test.
# Remplace les points de suspension par les bonnes variables et le bon tableau :

# Observe le résultat dans la console. Les moyennes sont-elles proches ?
# Si oui, le tirage au sort a bien fonctionné.

# ------------------------------------------------------------------------------
# ÉTAPE 2 : MESURER L'IMPACT (APRÈS LA LOTERIE)
# ------------------------------------------------------------------------------
# Objectif : Calculer l'effet causal de la bourse sur les années d'éducation.

# NOUVEAU CONCEPT : Stocker un résultat dans un objet avec "<-" ou "="
# On va ranger le tableau des moyennes dans un objet appelé "moyennes_edu".

# Affiche (print) l'objet pour voir son contenu :

# NOUVEAU CONCEPT : Les crochets [ ] pour extraire une valeur précise.
# On demande à R : "Dans moyennes_edu, prends la colonne education, 
# mais SEULEMENT pour la ligne où Test est égal à 1".
moyenne_test <- moyennes_edu$education[moyennes_edu$Test == 1]

# Fais la même chose pour isoler la moyenne du groupe Contrôle (Test est égal à 0) :
moyenne_controle <- moyennes_edu$education[...]

# Calcule maintenant l'effet causal en soustrayant la moyenne du groupe contrôle 
# à celle du groupe test, et stocke le résultat dans "effet_causal" :
effet_causal <- ... - ...
print(effet_causal)

# ------------------------------------------------------------------------------
# ÉTAPE 3 : LA MARGE D'ERREUR STATISTIQUE (MES)
# ------------------------------------------------------------------------------
# Objectif : Comparer l'effet causal à la MES.
# Formule : MES = 1.96 * Ecart-Type * (1/sqrt(n1) + 1/sqrt(n0))

# 1. Calcule l'écart-type de la variable "education" (n'oublie pas na.rm = TRUE)
# et stocke-le dans l'objet "ecart_type_edu" :
ecart_type_edu <- sd(..., na.rm = TRUE)

# 2. Comptage des effectifs
# On utilise table() pour compter combien d'élèves sont dans chaque groupe : on fait un tri à plat!

# On extrait les effectifs avec les crochets et le nom de la catégorie ("0" ou "1") :

# 3. Application de la formule de la MES
# Remplace les points de suspension par les bons objets créés juste au-dessus :
mes <- 1.96 * ... * (1/sqrt(...) + 1/sqrt(...))
print(mes)

# 4. Le test final
# Demande à R si l'effet causal est strictement supérieur à la marge d'erreur :
... > ...

# Si la console affiche TRUE, la différence ne relève pas du hasard. 
# La politique a fonctionné.