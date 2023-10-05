# **PROGRAMMATION**

## **FOR ALL ENTRIES**

Le **FOR ALL ENTRIES IN** utilise les données d’une table interne pour effectuer une nouvelle sélection.

_Exemple_

Pour chaque voiture contenue dans la table **ZCAR_BRAND_MODEL**, une requête affichera le nom et le prénom du conducteur :

```ABAP
SELECT brand,
       model,
       model_year
  FROM zcar_brand_mod
  INTO TABLE @DATA(lt_car).

IF NOT lt_car[] IS INITIAL.

  SELECT car_brand AS brand,
         car_model AS model,
         car_year  AS year,
         surname,
         name
    FROM zdriver_car
    INTO TABLE @DATA(lt_driver)
    FOR ALL ENTRIES IN @lt_car
    WHERE car_brand = @lt_car-brand
      AND car_model = @lt_car-model
      AND car_year  = @lt_car-model_year.

ENDIF.

DATA ls_driver LIKE LINE OF lt_driver.

LOOP AT lt_driver INTO ls_driver.
  WRITE:/ ls_driver-brand,   ls_driver-model, ls_driver-year,
          lS_driver-surname, ls_driver-name.
ENDLOOP.
```

Une première requête va d’abord sélectionner toutes les marques et modèles des voitures existantes dans la table **ZCAR_BRAND_MOD**. Dans une deuxième requête, cette table interne sera utilisée avec un **FOR ALL ENTRIES IN** afin de faire la jonction avec la table **ZDRIVER_CAR** et de sélectionner toutes les données nécessaires.

| **BRAND** | **MODEL** | **YEAR** | **SURNAME** | **NAME** |
| --------- | --------- | -------- | ----------- | -------- |
| PEUGEOT   | 307       | 2011     | DEBBACHE    | AMINH    |
| AUDI      | A3        | 2016     | ALDAIT      | PAULA    |
| FORD      | ESCORT    | 2013     | PILON       | BEATRIZ  |
| CITROEN   | C5        | 2012     | OLIVEIRA    | JOSE     |

## **IS [NOT] INITIAL**

Ainsi, dans l’exemple précédent, la ligne en question signifie : si le contenu de la table interne **LT_CAR** n’est pas vide, alors…

Lors de l’utilisation du **FOR ALL ENTRIES IN**, il est nécessaire de toujours vérifier que la table interne servant à cette fonction ne soit jamais vide avec un **IF NOT... IS INITIAL** au risque de sélectionner tous les registres d’une table de base de données, problématique pour les performances du programme.

L’exemple du **FOR ALL ENTRIES IN**est une adaptation de celui vu dans la partie sur le **INNER JOIN**, et reste bien moins performant que ce dernier (surtout lors de l’utilisation des bases de données **HANA**). Il est donc nécessaire de prioriser l’utilisation du **INNER JOIN** autant que possible.
