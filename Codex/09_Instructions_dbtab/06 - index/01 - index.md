# **`INDEX`**

Comme vu dans le chapitre `Dictionnaire de données` (`DDIC - SE11`), un `index` est une `clé secondaire` à une `table de base de données`, permettant d’améliorer considérablement les performances d’une sélection.

Après avoir défini cette notion, il serait intéressant de voir comment l’utiliser dans une `requête SQL`.

_Exemple_

_Sélection des enregistrements de la table `ZTRAVEL` mais avec un filtre sur les champs `CITY_FROM` et `COUNTRY_FROM`._

```JS
CONSTANTS: c_city_from TYPE ztravel-city_from VALUE 'TOULOUSE',
           c_ctry_from TYPE ztravel-country_from VALUE 'FR'.

SELECT city_from,
       country_from,
       city_to,
       country_to,
       date_travel,
       hour_travel
  FROM ztravel
  INTO TABLE @DATA(t_travel)
  WHERE city_from    = @c_city_from
    AND country_from = @c_ctry_from.
```

Comme la sélection s'effectue sur des champs non clés de la table, il est possible, avec l'augmentation du nombre des données, que cette requête prenne du temps. Un `Index` va donc être créé.

Pour ceci, il faut :

- Exécuter la transaction `SE11`
- Choisir l'option `Table base données`, renseigner le champ avec `ZTRAVEL` puis cliquer sur `Afficher` ou `Modifier` (pas d'importance).

![](../../00_Ressources/14_01_01.png)

- Dans la barre d'outils, cliquer sur le bouton `Index`...

![](../../00_Ressources/14_01_02.png)

Une nouvelle fenêtre s'ouvre. Elle est composée d'une barre d'outils dont les trois dernières options sont les plus importantes :

    - Créer un index (icône de la feuille blanche)
    - Supprimer (corbeille)
    - Rafraichir la liste (doubles flèches)

![](../../00_Ressources/14_01_03.png)

En cliquant sur l'icône de la feuille blanche, deux options sont possibles : `Créer index d'extension`.

![](../../00_Ressources/14_01_04.png)

Techniquement, il n'y a aucune différence entre ces deux options, et il est possible de choisir aussi bien l'une que l'autre. Cependant, avec la première option, l'index créé sur une table standard, est considéré comme une modification et sera éliminé durant une mise à jour de la version `SAP` (upgrade) alors qu'un index d'extension sera préservé.

- Cliquer sur `Créer index`
- Définir un `code d'indexation` (champ alphanumérique de trois positions), par exemple `Z01`.

![](../../00_Ressources/14_01_05.png)

- Insérer une description, par exemple ` Index secondaire CITY_FROM`.

  Viennent ensuite quelques options :

  - `Index non unique` (par défaut) / `Index unique` : comme pour les tables internes, définit si les valeurs des données contenant cet index pauvent être dupliquées ou non.
  - Pour les index non-uniques, il est possible de définir si l'index doit être créé dans tous les systèmes de BD, ou bien s'il doit être spécifique à certains (`pour les systèmes de BD sélectionnées`), ou s'il ne doit apparaître dans aucun. En réalité, un index non unique est une forme détournée pour supprimer des index secondaires standards, créés par `SAP`.

- Laisser ces options par défaut (`Index non unique` / `Index dans tous les systèmes de BD`).
- Cliquer ensuite sur le bouton `Zones de table`. La liste des champs de la table apparaît ; choisir alors les deux nécessaires ; `CITY_FROM` et `COUNTRY_FROM`.

![](../../00_Ressources/14_01_06.png)

Au final, l'index devra contenir les informations suivantes :

![](../../00_Ressources/14_01_07.png)

- Sauvegarder (définir la classe de développement puis un ordre de transport si nécessaire ou bien le laisser comme objet local).
- Activer.

Ainsi, sans modifier la requête initiale, la sélection se fera beaucoup plus rapidement.
