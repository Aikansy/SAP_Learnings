# **`ELEMENTS DE DONNEES - CREATION`**

Dans cette section, l’élément de données `ZDRIVER_ID` sera créé et utilisera le domaine du même nom :

1. Exécuter la transaction `SE11` .
2. Dans l’écran de gestion du dictionnaire `ABAP`, cocher l’option `Type de données`.
3. Entrer le nom `ZDRIVER_ID` puis appuyer sur le bouton `Créer` (ou bouton raccourci-clavier `[F5]`).

![](../99%20-%20Ressources/05_SE11%20-%2012%20-%2001.png)

4. Comme vu au début de ce chapitre, plusieurs choix sont alors possibles car cette option du dictionnaire regroupe aussi bien les éléments de données, que les structures ou les types de tables. Pour cet exemple, on va laisser sélectionné le premier choix puis valider.

![](../99%20-%20Ressources/05_SE11%20-%2012%20-%2002.png)

5. Entrer une `description` (obligatoire), par exemple ’N° d’identification du conducteur’.
6. Renseigner le `nom de domaine` ZDRIVER_ID puis valider par la touche `[Entrée]` (les informations du domaine sont alors automatiquement renseignées).

![](../99%20-%20Ressources/05_SE11%20-%2012%20-%2003.png)

7. Dans l’onglet Descript. zone, les textes suivants seront renseignés :

| LONGUEUR   | NBR CARACTERES | NOM                          |
| ---------- | -------------- | ---------------------------- |
| `Court`    | 10             | DriverId                     |
| `Moyen`    | 20             | Ident.Cond.                  |
| `Long`     | 40             | Identification conducteur    |
| `Intitulé` | 55             | Identification du conducteur |

![](../99%20-%20Ressources/05_SE11%20-%2012%20-%2004.png)

8. Sauvegarder (pour plus de commodité, l’élément de données sera créé en local).
9. Contrôler.
10. Activer.
