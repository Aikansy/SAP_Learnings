# **`(NOT) BETWEEN`**

## **BETWEEN**

```JS
col [NOT] BETWEEN obj1 AND obj2
```

Vérifie que la colonne `est ou non` (`NOT`) `comprise entre deux objets`, ceux-ci pouvant être une `constante`, une `variable` ou un autre champ de table.

_Exemple_

_Sélectionner toutes les amrques et modèles de voiture compris entre 2013 et 2016._

```JS
CONSTANTS: c_year1 TYPE zcar_brand_mod-model_year VALUE '2013',
           c_year2 TYPE zcar_brand_mod-model_year VALUE '2016'.

SELECT brand,
       model
  FROM zcar_brand_mod
  INTO TABLE @DATA(t_car)
  WHERE model_year BETWEEN @c_year1 AND @c_year2.


DATA s_car LIKE LINE OF t_car.

LOOP AT t_car INTO s_car.
  WRITE:/ s_car-brand, s_car-model.
ENDLOOP.
```

_Résultat de la requête_

| **BRAND**  | **MODEL** | **MODEL_YEAR** |
| ---------- | --------- | -------------- |
| VOLKSWAGEN | GOLF      | 2015           |

_Résultat à l'écran_

![](../../99%20-%20Ressources/09_Instructions_dbtab%20-%2001%20-%2025%20-%2001.png)

> Les paramètres du `WHERE` sont délimités par la syntaxe `AND` (`et`) ou `OR` (`ou`) et peuvent être rergoupés par des parenthèses (surtout lors de l'utilisation du `OR` car sans, le résultat de la requête ne serait pas celui espéré).

## **NOT BETWEEN**

```JS
col [NOT] BETWEEN obj1 AND obj2
```

Vérifie que la colonne est ou non (`NOT`) comprise entre deux objets, ceux-ci pouvant être une constante, une variable ou un autre champ de table.

_Exemple_

_Sélectionner toutes les marques et modèles de voiture compris entre 2013 etr 2016._

```JS
CONSTANTS: c_year1 TYPE zcar_brand_mod-model_year VALUE '2013',
           c_year2 TYPE zcar_brand_mod-model_year VALUE '2016'.

SELECT brand,
       model
  FROM zcar_brand_mod
  INTO TABLE @DATA(t_car)
  WHERE model_year BETWEEN @c_year1 AND @c_year2.


DATA s_car LIKE LINE OF t_car.

LOOP AT t_car INTO s_car.
  WRITE:/ s_car-brand, s_car-model.
ENDLOOP.
```

_Résultat de la requête_

| **BRAND**  | **MODEL** |
| ---------- | --------- |
| AUDI       | A3        |
| FORD       | ESCORT    |
| RENAULT    | MEGANE    |
| VOLKSWAGEN | GOLF      |

_Résultat à l'écran_

![](../../99%20-%20Ressources/09_Instructions_dbtab%20-%2001%20-%2025%20-%2002.png)
