# **PROGRAMMATION**

## **BETWEEN**

Vérifie que la colonne est ou non (**NOT BETWEEN**) comprise entre deux objets, ceux-ci pouvant être une constante, une variable ou un autre champ de table.

_Exemple_

Sélectionner toutes les marques et modèles de voiture compris entre 2013 et 2016.

```ABAP
CONSTANTS: c_year1 TYPE zcar_brand_mod-model_year VALUE '2013',
           c_year2 TYPE zcar_brand_mod-model_year VALUE '2016'.

SELECT brand,
       model
  FROM zcar_brand_mod
  INTO TABLE @DATA(lt_car)
  WHERE model_year BETWEEN @c_year1 AND @c_year2.

DATA ls_car LIKE LINE OF lt_car.

LOOP AT lt_car INTO ls_car.
  WRITE:/ ls_car-brand, ls_car-model.
ENDLOOP.
```

| **BRAND**  | **MODEL** |
| ---------- | --------- |
| AUDI       | A3        |
| FORD       | ESCORT    |
| RENAULT    | MEGANE    |
| VOLKSWAGEN | GOLF      |
