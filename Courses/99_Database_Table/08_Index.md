# **PROGRAMMATION**

## **INDEX**

Comme vu dans le chapitre Dictionnaire de données (**DDIC**), un index est une clé secondaire à une table de base de données, permettant d’améliorer considérablement les performances d’une sélection. Après avoir défini cette notion, il serait intéressant de voir comment l’utiliser dans une requête SQL.

_Exemple_

Sélection des enregistrements de la table **ZTRAVEL** mais avec un filtre sur les champs **CITY_FROM** et **COUNTRY_FROM**.

```ABAP
CONSTANTS: lc_city_from TYPE ztravel-city_from VALUE 'TOULOUSE', 
           lc_ctry_from TYPE ztravel-country_from VALUE 'FR'. 
 
SELECT city_from, 
       country_from, 
       city_to, 
       country_to, 
       date_travel, 
       hour_travel 
  FROM ztravel 
  INTO TABLE @DATA(lt_travel) 
  WHERE city_from    = @lc_city_from 
    AND country_from = @lc_ctry_from.
```

Comme la sélection s’effectue sur des champs non clés de la table, il est possible, avec l’augmentation du nombre des données, que cette requête prenne du temps. Un index va donc être créé.

Pour ceci, il faut :

-> Exécuter la transaction **SE11**.

-> Choisir l’option Table base données, renseigner le champ avec **ZTRAVEL** puis cliquer sur **Afficher** ou **Modifier** (pas d’importance).

 [Schéma - Dictionnaire ABAP :  écran initial](https://drive.google.com/file/d/1m1L89MwZJ9KSo8mt4hUXXcOI2ha7i4tg/view?usp=share_link)

-> Dans la barre d’outils, cliquer sur le bouton **Index**...

[Schéma - Barre d'outil](https://drive.google.com/file/d/1U248oqu5VrAWWbHN0NazWPDLcxl1FSk4/view?usp=share_link)

Une nouvelle fenêtre s’ouvre. Elle est composée d’une barre d’outils dont les trois dernières options sont les plus importantes : 

+ créer un index (icône de la feuille blanche)
+ corbeille pour le supprimer 
+ deux flèches pour rafraîchir la liste.

[](https://drive.google.com/file/d/1-20aau01C9Lo6smtrJHaVZKCzs1kBzWq/view?usp=share_link)

En cliquant sur l’icône de la feuille blanche, deux options sont possibles : 

+ Créer **index**
+ Créer **index d’extension**.

[Schéma - Barre d'outil](https://drive.google.com/file/d/1DWeUWXONcNSs-NknRNx139KEeNCPhzZP/view?usp=share_link)

Techniquement, il n’y a aucune différence entre ces deux options, et il est possible de choisir aussi bien l’une que l’autre. Cependant, avec la première option, l’index créé sur une table standard, est considéré comme une modification et sera éliminé durant une mise à jour de la version **SAP** (upgrade) alors qu’un index d’extension sera préservé.

Dans l’exemple de la table **ZTRAVEL**, comme il ne s’agit pas d’une table standard, un index simple sera donc créé (première option).

-> Cliquer sur Créer **index**.

-> Définir un **code d’indexation** (champ alphanumérique de trois positions), par exemple ’Z01’.

[Schéma - Créer index](https://drive.google.com/file/d/1gcycIPLRh7L4Y9oMhMfYiBS8OaYE3Gu8/view?usp=share_link)

-> Insérer une description, par exemple ’Index secondaire CITY_FROM’.

Viennent ensuite quelques options :

+ Index non unique (par défaut) / Index unique : comme pour les tables internes, définit si les valeurs des données contenant cet index peuvent être dupliquées ou non.

+ Pour les index non uniques, il est possible de définir si l’index doit être créé dans tous les systèmes de BD, ou bien s’il doit être spécifique à certains (pour les systèmes de BD sélectionnés), ou s’il ne doit apparaître dans aucun. En réalité, un index non unique est une forme détournée pour supprimer des index secondaires standards, créés par **SAP**.

-> Laisser ces options par défaut (Index non unique / Index dans tous les systèmes de **BD**).

-> Cliquer ensuite sur le bouton Zones de table. La liste des champs de la table apparaît ; choisir alors les deux nécessaires ; **CITY_FROM** et **COUNTRY_FROM**.

[Schéma - Option de zone de table ZTRAVEL](https://drive.google.com/file/d/1zDIRlWhtDmjAaRb1pXJKutCcl9aTPlPH/view?usp=share_link)

Au final, l’index devra contenir les informations suivantes :

[Schéma - Dictionnaire ABAP : modification de l'index](https://drive.google.com/file/d/15JPde5ZSaKQwGFiOyUTd9PQY7Waquzmk/view?usp=share_link)

-> Sauvegarder (définir la classe de développement puis un **ordre de transport** si nécessaire ou bien le laisser comme objet local).

-> Activer.

Ainsi, sans modifier la requête initiale, la sélection se fera beaucoup plus rapidement.