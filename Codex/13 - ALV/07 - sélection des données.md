# **`SELECTION DES DONNEES`**

Le but de cette partie est d’importer les données des tables et de les stocker dans une table interne. La requête SQL va donc être utilisée et il serait intéressant de faire un seul `SELECT`, regroupant toutes les sous-requêtes.

Pour bien comprendre la construction de la requête, nous allons la découper selon les sections déjà mentionnées dans le chapitre Les requêtes SQL ([`SELECT, FROM...`](../09%20-%20Instructions_dbtab/01%20-%20select/02%20-%20select.md)).

Tout d’abord le SELECT, où nous allons tout simplement lister les champs qui nous intéressent et leur attribuer un alias pour les rendre plus lisibles si nécessaire :

```JS
SELECT date_travel,
       city_from,
       country_from,
       city_to,
       country_to,
       surname && ' ' && name   AS driver,
       car_brand,
       car_model,
       surname && ' ' && name AS passenger1,
       surname && ' ' && name AS passenger2,
       surname && ' ' && name AS passenger3,
       kms,
       kms_unit,
       toll,
       gasol,
       unit
```

Vient ensuite le `FROM`, qui utilisera les tables suivantes :

- `ZTRAVEL` (table centrale)

- `ZDRIVER_CAR`

- `ZPASSENGER` qui sera utilisée trois fois, correspondant aux trois champs PASSENGER de la table ZTRAVEL.

Pour cela, la jointure [`INNER JOIN`](../09%20-%20Instructions_dbtab/01%20-%20select/19%20-%20from%20join.md) sera utilisée avec pour chaque accès aux tables, le lien à définir comme mentionné dans l’analyse. Un alias sera aussi défini afin de bien différencier les tables, et le [`SELECT, FROM...`](../09%20-%20Instructions_dbtab/01%20-%20select/02%20-%20select.md) sera alors mis à jour avec les alias des tables :

```JS
SELECT t~date_travel,
       t~city_from,
       t~country_from,
       t~city_to,
       t~country_to,
       d~surname && ' ' && d~name   AS driver,
       d~car_brand,
       d~car_model,
       p1~surname && ' ' && p1~name AS passenger1,
       p2~surname && ' ' && p2~name AS passenger2,
       p3~surname && ' ' && p3~name AS passenger3,
       t~kms,
       t~kms_unit,
       t~toll,
       t~gasol,
       t~unit
  FROM ztravel           AS t
  INNER JOIN zdriver_car AS d
    ON t~id_driver       EQ d~id_driver
  INNER JOIN zpassenger  AS p1
    ON t~id_passenger1   EQ p1~id_passenger
  INNER JOIN zpassenger  AS p2
    ON t~id_passenger2   EQ p2~id_passenger
  INNER JOIN zpassenger  AS p3
    ON t~id_passenger3   EQ p3~id_passenger
```

Pas de grandes difficultés pour le [`INTO`](../09%20-%20Instructions_dbtab/01%20-%20select/20%20-%20into.md), car on spécifiera à SAP de créer directement la table interne :

```JS
INTO TABLE @DATA(t_data)
```

La clause [`WHERE`](../09%20-%20Instructions_dbtab/01%20-%20select/21%20-%20where.md) utilisera les zones de l’écran de sélection :

```JS
  WHERE t~date_travel IN @s_trdate
    AND t~city_from   IN @s_cityfr
    AND t~city_to     IN @s_cityto
```

Et enfin, on pourrait utiliser la clause [`ORDER BY`](../09%20-%20Instructions_dbtab/01%20-%20select/34%20-%20order%20by.md) sur le champ `DATE_TRAVEL` pour trier la sélection par date de voyage.

```JS
ORDER BY t~date_travel
```

Au final, la sélection sera de cette forme :

```JS
SELECT t~date_travel,
       t~city_from,
       t~country_from,
       t~city_to,
       t~country_to,
       d~surname && ' ' && d~name   AS driver,
       d~car_brand,
       d~car_model,
       p1~surname && ' ' && p1~name AS passenger1,
       p2~surname && ' ' && p2~name AS passenger2,
       p3~surname && ' ' && p3~name AS passenger3,
       t~kms,
       t~kms_unit,
       t~toll,
       t~gasol,
       t~unit
  FROM ztravel           AS t
  INNER JOIN zdriver_car AS d
    ON t~id_driver       EQ d~id_driver
  INNER JOIN zpassenger  AS p1
    ON t~id_passenger1   EQ p1~id_passenger
  INNER JOIN zpassenger  AS p2
    ON t~id_passenger2   EQ p2~id_passenger
  INNER JOIN zpassenger  AS p3
    ON t~id_passenger3   EQ p3~id_passenger
  INTO TABLE @DATA(t_data)
  WHERE t~date_travel IN @s_trdate
    AND t~city_from   IN @s_cityfr
    AND t~city_to     IN @s_cityto
  ORDER BY t~date_travel.
```

Reste à réaliser la dernière étape : construire le rapport ALV et afficher les données.
