# **`FOR ALL ENTRIES IN`**

Le `FOR ALL ENTRIES IN` utilise les données d'une table interne pour effectuer une nouvelle sélection.

_Exemple_

_Pour chaque voiture contenue dans la table `ZCAR_BRAND_MODEL`, une requête affichera le nom et le prénom du conducteur :_

```JS
SELECT brand,
       model,
       model_year
  FROM zcar_brand_mod
  INTO TABLE @DATA(t_car).

IF NOT t_car[] IS INITIAL.

  SELECT car_brand AS brand,
         car_model AS model,
         car_year  AS year,
         surname,
         name
    FROM zdriver_car
    INTO TABLE @DATA(t_driver)
    FOR ALL ENTRIES IN @t_car
    WHERE car_brand = @t_car-brand
      AND car_model = @t_car-model
      AND car_year  = @t_car-model_year.

ENDIF.


DATA s_driver LIKE LINE OF t_driver.

LOOP AT t_driver INTO s_driver.
  WRITE:/ s_driver-brand,   s_driver-model, s_driver-year,
          S_driver-surname, s_driver-name.
ENDLOOP.
```

Une première requête va d'abord sélectionner touts les marques et modèles des voitures existantes dans la table `ZCAR_BRAND_MOD`. Dans une deuxième requête, cette table interne sera utilisée avec un `FOR ALL ENTRIES IN` afin de faire la jonction avec la table `ZDRIVER_CAR` et de sélectionner toutes les données nécessaires.

_Résultat de la requête_

| **BRAND** | **MODEL** | **YEAR** | **SURNAME** | **NAME** |
| --------- | --------- | -------- | ----------- | -------- |
| PEUGEOT   | 307       | 2011     | DEBBACHE    | AMINH    |
| AUDI      | A3        | 2016     | ALDAIR      | PAULA    |
| FORD      | ESCORT    | 2013     | PILON       | BEATRIZ  |
| CITROEN   | C5        | 2012     | OLIVEIRA    | JOSE     |

_Résultat à l'écran_

![](../../00_Ressources/09_32_01.png)

L'instruction suivante vérifie si la table interne est vide ou non (l'utilisation des crochets ira vérifier le contenu de la table).

```JS
IF [NOT] itab IS INITIAL.
  . . .
ENDIF.
```

Ainsi, dans l'exemple précédent, la ligne en question signifie : si le contenu de la table interne `T_CAR` n'est pas vide, alors...

> Lors de l'utilisation du `FOR ALL ENTRIES IN`, il est nécessaire de toujours vérifier que la table interne servant à cette fonction ne soit jamais vide avec un `IF NOT... IS INITIAL` au risque de sélectionner touts les registres d'une table de base de données, problématique pour les performances du programme.

L'exemple du `FOR ALL ENTRIES IN` est une adaptation de celui cu dans la partie sur le [`JOIN`](../../09_SQL_Select/19%20-%20from%20join.md), et reste bien moins performant que ce dernier (surtout lors de l'utilisation des bases de données `HANA`). Il est donc nécessaire de prioriser l'utilisation du `INNER JOIN` autant que possible.
