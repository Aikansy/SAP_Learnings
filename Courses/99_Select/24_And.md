# **PROGRAMMATION**

## **AND**

_Exemple_

Sélection de toutes les marques et modèles de voitures de marque ’Peugeot’ ou ’Volkswagen’ dont l’année de construction est supérieure ou égale à 2015.

```ABAP
SELECT brand,
       model,
       model_year
  FROM zcar_brand_mod
  INTO TABLE @DATA(lt_car_mod)
  WHERE ( brand    =  'PEUGEOT' OR brand = 'VOLKSWAGEN' )
    AND model_year >= '2015'.

DATA ls_car_mod LIKE LINE OF lt_car_mod.

LOOP AT lt_car_mod INTO ls_car_mod.
  WRITE:/ ls_car_mod-brand, ls_car_mod-model, ls_car_mod-model_year.
ENDLOOP.
```

| **BRAND**  | **MODEL** | **MODEL_YEAR** |
| ---------- | --------- | -------------- |
| VOLKSWAGEN | GOLF      | 2015           |
