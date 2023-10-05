# **PROGRAMMATION**

## **UP TO N ROWS**

Restreint la sélection à n lignes où n est un nombre positif.

_Exemple_

Sélectionner les trois dernières lignes de la table ZCAR_BRAND_MOD.

```ABAP
SELECT brand,
       model
  FROM zcar_brand_mod
  UP TO 3 ROWS
  INTO TABLE @DATA(lt_car)
  ORDER BY brand DESCENDING.

DATA ls_car LIKE LINE OF lt_car.

LOOP AT lt_car INTO ls_car.
  WRITE:/ ls_car-brand, ls_car-model.
ENDLOOP.
```

| **BRAND**  | **MODEL** |
| ---------- | --------- |
| VOLKSWAGEN | GOLF      |
| RENAULT    | MEGANE    |
| PEUGEOT    | 307       |

Il est important de respecter la séquence de saisie des différentes clauses et fonctions de la requête, au risque d’avoir une erreur de syntaxe lors du contrôle de cette dernière, et peut-être de perdre du temps à se demander pourquoi le programme ne peut pas s’activer :

1. SELECT ...

2. Pour les clauses/fonctions suivantes, pas d’ordre précis
   FROM + ON (si utilisation du JOIN)
   INTO
   UP TO n ROWS

3. WHERE

4. GROUP BY

5. HAVING

6. ORDER BY
