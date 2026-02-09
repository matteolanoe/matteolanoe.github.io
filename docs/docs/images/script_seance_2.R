# ==============================================================================
# FICHE MÉMO : PREMIERS PAS AVEC R ET LE TITANIC
# ==============================================================================

# IMPORTANT : Comment lire ce script ?
# 1. Tout ce qui commence par un "#" est un COMMENTAIRE.
#    R ne lit pas ces lignes, elles sont là pour vous (les humains).
# 2. Les lignes sans "#" sont du CODE.
#    C'est ce que R doit exécuter.
# 3. Pour exécuter une ligne : Placez votre curseur dessus et faites "CTRL + ENTER" (PC)
#    ou "CMD/CONTROL + ENTER" (Mac).

# ------------------------------------------------------------------------------
# ÉTAPE 0 : PRÉPARER SON ENVIRONNEMENT DE TRAVAIL
# ------------------------------------------------------------------------------
# Avant de taper du code, assurez-vous d'avoir suivi ces étapes manuelles :
# 1. Créez un projet : "File" > "New Project" > "New Directory" (Dossier vide).
# 2. Donnez-lui un nom clair (ex: "Cours_Stats_Seance2").
# 3. IMPORTANT : Téléchargez le fichier "titanic.csv" et déplacez-le DANS ce dossier.
#    (Vérifiez qu'il apparaît bien dans l'onglet "Files" en bas à droite).

# ------------------------------------------------------------------------------
# ÉTAPE 1 : IMPORTER LE JEU DE DONNÉES
# ------------------------------------------------------------------------------

# Nous allons créer un objet appelé "titanic" (le conteneur)
# et y verser le contenu du fichier .csv (les données).

# ATTENTION AU SÉPARATEUR !
# Ouvrez d'abord le fichier avec le Bloc-notes ou Excel pour vérifier.
# - Si les colonnes sont séparées par des virgules (,) -> utilisez sep = ","
# - Si les colonnes sont séparées par des points-virgules (;) -> utilisez sep = ";"

titanic <- read.csv("titanic.csv", sep = ",")

# Pour vérifier que l'importation a fonctionné, une fenêtre doit s'ouvrir :
View(titanic)
# (Attention à la majuscule à "View" !)

# ------------------------------------------------------------------------------
# ÉTAPE 2 : ANALYSE DESCRIPTIVE SIMPLE (Une seule variable)
# ------------------------------------------------------------------------------
# Question : Combien coûtait le billet ? (Variable : Fare)

# Le signe "$" permet de dire à R : "Dans le tableau 'titanic', prends la colonne 'Fare'".

# 1. Quel est le prix minimum ?
min(titanic$Fare)

# 2. Quel est le prix maximum ?
max(titanic$Fare)

# 3. Quel est le prix moyen ?
# L'option "na.rm = TRUE" (NA Remove) est cruciale.
# Elle dit à R : "Si tu trouves une case vide (NA), ignore-la et calcule quand même".
mean(titanic$Fare, na.rm = TRUE)

# 4. Voir la répartition complète (pas très lisible pour des prix continus, mais utile pour des catégories)
table(titanic$Fare)

# ------------------------------------------------------------------------------
# ÉTAPE 3 : ANALYSE BIVARIÉE (Croiser deux variables)
# ------------------------------------------------------------------------------
# Question : Les femmes ont-elles plus survécu que les hommes ?

# On utilise la fonction table() avec deux arguments séparés par une virgule.
# Argument 1 (Lignes) : Survived (0 = Mort, 1 = Survivant)
# Argument 2 (Colonnes) : Sex (male / female)

table(titanic$Survived, titanic$Sex)

# Lecture du résultat :
# Regardez l'intersection de la ligne "1" (Survivants) et des colonnes Homme/Femme.