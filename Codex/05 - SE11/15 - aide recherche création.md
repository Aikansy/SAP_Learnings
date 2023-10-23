# **`AIDE A LA RECHERCHE - CREATION`**

La suite de cette section va lister toutes les étapes nécessaires à la création d’une aide à la recherche élémentaire de la table `MARA` :

1. Exécuter la transaction `SE11`.
2. Dans l’écran de gestion du dictionnaire `ABAP`, cocher l’option `Aide recherche`.
3. Entrer le nom `ZAR_MARA` puis appuyer sur le bouton `Créer` (ou bouton raccourci-clavier `[F5]`).

![](../99%20-%20Ressources/05_SE11%20-%2015%20-%2001.png)

4. Choisir `Aide recherche élémentaire`.

![](../99%20-%20Ressources/05_SE11%20-%2015%20-%2002.png)

5. Entrer une `description` (obligatoire), par exemple `Aide à la recherche MARA`.
6. Renseigner la `méthode de sélection` avec la table `MARA` puis confirmer par la touche `[Entrée]`. Automatiquement, `SAP` importe la table des textes `MAKT`.

![](../99%20-%20Ressources/05_SE11%20-%2015%20-%2003.png)

7. Choisir l’option `Affichage de valeurs immédiat` pour le Type de dialogue.
8. Cette aide à la recherche affichera les champs :

- `MATNR` (n° d’article) qui sera à la fois un champ d’import et d’export
- `MAKTX` (désignation de l’article)
- `MTART` (type d’article)
- `MATKL` (groupe marchandise)

Les paramètres ressembleront à ceci :

| CHAMP   | IMP | EXP | PosL | PAR. | Elmt données |
| ------- | --- | --- | ---- | ---- | ------------ |
| `MATNR` | X   | X   | 1    | 1    | MATNR        |
| `MAKTX` |     |     | 2    | 2    | MAKTX        |
| `MTART` |     |     | 3    | 3    | MTART        |
| `MATKL` |     |     | 4    | 4    | MATKL        |

![](../99%20-%20Ressources/05_SE11%20-%2015%20-%2004.png)

9. `Sauvegarder` (pour plus de commodité, l’aide à la recherche sera créée en local).
10. `Contrôler`.
11. `Activer`.

Au final, l’aide à la recherche ressemblera à ceci :

![](../99%20-%20Ressources/05_SE11%20-%2015%20-%2005.png)

Il est également possible de la tester avec le bouton `Tester...` de la barre d’outils, via le raccourci-clavier `[F8]` ou par le menu déroulant.

Aide à la recherche - `Tester...` `[F8]`

![](../99%20-%20Ressources/05_SE11%20-%2015%20-%2006.png)

Il suffit alors de cliquer sur le petit bouton à droite du champ afin que l’aide à la recherche apparaisse.
