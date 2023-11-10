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

- Afficher zone `JUSQ.` (entendre "JUSQU’A") : supprime l’intervalle pour les zones de type SELECT-OPTIONS.

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2013.png)

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2014.png)

- `Enregistrer zone sans valeurs` signifie que lors de l’importation de la variante, si une zone a déjà été renseignée, elle ne sera pas écrasée par les valeurs de la variante. Un exemple concret sera proposé à la suite de la partie sur les options de variantes.

- `Désactiver GPA` est utilisée dans le cas où une zone de l’écran de sélection utilise une mémoire système pour importer automatiquement des valeurs (GET MEMORY ID/SET MEMORY ID) comme mentionné dans le chapitre Dictionnaire de données (DDIC) - Éléments de données. Cette option permet d’annuler cet import automatique.

- `Zone saisie obligatoire` définit la zone de l’écran de sélection comme requis.

- `Variable sélection`, `Option` et `Nom des variables` sont trois paramètres permettant d’importer les valeurs d’une zone de l’écran de sélection via une table standard (comme la TVARV) ou via un calcul dynamique (pour les champs de type Date et Heure).

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2015.png)

Pour sauver la variante, il suffit de cliquer sur le bouton de sauvegarde. Ainsi, lorsque le programme est exécuté de nouveau, une nouvelle icône apparaît dans la barre d’outils de l’écran de sélection ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2016.png).

En cliquant dessus, la liste des variantes apparaîtra pour sélection sauf celles définies comme étant à afficher uniquement dans le catalogue.

![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2017.png)

_Manipulation pour rechercher une variante dans le catalogue :_

- Il suffit de se rendre dans l’éditeur ABAP (transaction SE38).

- Renseigner le nom du programme et choisir l’option Variantes, puis cliquer sur Afficher.

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2018.png)

- Une nouvelle fenêtre apparaît, où il est demandé de renseigner le nom de la variante.

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2019.png)

- Il suffit d’aller dans le menu déroulant suivant pour afficher les variantes du catalogue :

  _Variantes - Catalogue_

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2020.png)

- La liste des variantes de catalogue s’affiche donc et il est alors possible de les sélectionner pour les modifier.

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2021.png)

  Force est de constater qu’il est assez difficile de modifier ce type de variante. On l’utilisera donc en général lorsqu’il y a peu de modifications, ce qui est peu probable dans le cas d’une variante utilisée pour des tests.

  _Exemple de l’option Enregistrer zone sans valeurs :_

  _Création d’une variante (`SANS_VAL`) avec les zones `Ville de départ` égale à `TOULOUSE` et Ville d’arrivée à `PERPIGNAN`._

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2022.png)

  L’option Enregistrer zone sans valeurs est définie pour la zone Ville d’arrivée.

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2023.png)

  Le programme est exécuté de nouveau ; la zone Ville de départ est renseignée avec la valeur `BARCELONE` et Ville d’arrivée avec `TOULOUSE`.

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2024.png)

  Lorsque la variante SANS_VAL est importée, la valeur de la ville de départ est écrasée par celle de la variante (`TOULOUSE`), mais celle de la ville d’arrivée ne l’est pas.

  ![](../../99%20-%20Ressources/12_Screen%20-%2005%20-%2001%20-%2025.png)
