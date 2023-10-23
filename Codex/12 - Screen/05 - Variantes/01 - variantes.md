# **`VARIANTES`**

Il existe un outil permettant à l’utilisateur d’enregistrer les valeurs insérées dans un écran de sélection, appelé une variante.

En prenant l’exemple suivant :

```JS
TABLES: ztravel.

SELECTION-SCREEN BEGIN OF BLOCK b00 WITH FRAME TITLE text-t01.
SELECT-OPTIONS: s_trdate FOR ztravel-date_travel
                         DEFAULT sy-datum,
                s_trhour FOR ztravel-hour_travel,
                s_cityfr FOR ztravel-city_from,
                s_cityto FOR ztravel-city_to.
SELECTION-SCREEN END OF BLOCK b00.
```

L’écran apparaîtra ainsi après avoir rempli les champs :

![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2001.png)

Après un retour arrière, si le programme est à nouveau exécuté, toutes les valeurs ont disparu et tout doit être refait. Pour éviter cela, après avoir renseigné les champs, il suffira de cliquer sur le bouton de sauvegarde ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2002.png) pour créer une variante.

_L’écran de gestion des variantes ressemble à ceci :_

![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2003.png)

Il est possible d’y voir plusieurs options :

- La `barre d’outils`, assez rudimentaire cette fois-ci, va seulement proposer de reprendre l’affectation d’écran (si celui-ci est mis à jour dans le programme, le bouton actualisera la liste des objets de l’écran de sélection), et d’accéder à un bouton d’aide.

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2004.png)

- Viennent ensuite le nom de la variante ainsi qu’une description.

- Des options générales à la variante sont proposées :

  - `Uniquement` pour traitement en arrière-plan : obligera le programme à ne pouvoir être exécuté qu’en arrière-plan et le résultat de l’exécution ne sera visible que dans le log du job associé (transaction SM37).

  - `Protéger variante` : permet à la variante de pouvoir être modifiée seulement par la personne qui l’a créée ou la dernière l’ayant modifié. Aussi, si un autre utilisateur décide de l’utiliser et qu’il veut en changer certains paramètres, cela lui sera refusé.

  - `Afficher uniquement dans le catalogue` : signifie que la variante sera masquée de la liste des variantes du programme et qu’elle ne pourra être visible que dans le catalogue des variantes. À la suite de la partie sur les options de variantes, une manipulation sera proposée afin de rencontrer les variantes de catalogue.

  - `Variante système` est un peu particulier, car tout d’abord son nom doit commencer par SAP ou CUS, et elle doit être transportée dans les systèmes SAP ; ainsi elle ne peut être créée pour des programmes locaux (classe de développement $TMP), elles sont aussi protégées en écriture (voir option Protéger variante). Elles sont utilisées pour des programmes qui appellent d’autres programmes associés à une variante et dont les valeurs de champs ne sont pas souvent modifiées.

- `Affectation écran` donne simplement le numéro de l’écran de sélection. En effet, chaque écran est affecté à un numéro et la valeur par défaut de l’écran de sélection est 1 000.

- Enfin, la liste des champs de l’écran de sélection est affichée regroupant les caractéristiques suivantes :

![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2005.png)

- `Écran de sélection` indique le numéro de l’écran.

- `Nom de zone`.

- `Nom technique de la zone` (cette colonne est affichée si le bouton Nom technique a été utilisé, pour masquer à nouveau la colonne, cliquer alors sur Masquer nom technique).

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2006.png)

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2007.png)

- `Type de la zone` (`S` pour SELECT-OPTIONS, `P` pour PARAMETERS...).

- `Protéger zone` empêche toute modification de valeur.

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2008.png)

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2009.png)

- `Masquer zone` comme son nom l’indique masque la zone en question, mais une option de l’écran apparaîtra alors pour la rendre à nouveau visible.

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2010.png)

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2011.png)

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2012.png)

- Afficher zone `JUSQ`
