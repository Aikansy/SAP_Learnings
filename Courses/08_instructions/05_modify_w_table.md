# **`MODIDFY WITH TABLE`**

> Pour l’instruction `MODIFY`, il existe trois formes de syntaxe possibles.

```JS
MODIFY TABLE itab FROM wa
            [TRANSPORTING comp1 comp2 ...].
```

Pour ce MODIFY, le système va rechercher dans la table interne itab, la clé égale à celle définie par la structure wa et va actualiser tous les champs ou tous ceux indiqués par le TRANSPORTING.

_Exemple_

_Reprendre l’exemple du `COLLECT` et initialiser le champ `AGE` à `10` pour la clé `LAND` égale à `FR`._

```JS
TYPES: BEGIN OF ty_country,
         land   TYPE char3,
         age(3) TYPE i,
       END OF ty_country.

DATA: t_country TYPE HASHED TABLE OF ty_country
                WITH UNIQUE KEY land,
      s_country TYPE ty_country.

s_country-land = 'FR'.
s_country-age  = 23.
COLLECT s_country INTO t_country.

s_country-land = 'IT'.
s_country-age  = 20.
COLLECT s_country INTO t_country.

s_country-land = 'IT'.
s_country-age  = 55.
COLLECT s_country INTO t_country.

s_country-land = 'FR'.
s_country-age  = 5.
COLLECT s_country INTO t_country.


s_country-land = 'FR'.
s_country-age  = 10.
MODIFY TABLE t_country FROM s_country TRANSPORTING age.
```

**T_COUNTRY avant le MODIFY**

| **LAND** | **AGE** |
| -------- | ------- |
| FR       | 28      |
| IT       | 75      |

**T_COUNTRY après le MODIFY**

| **LAND** | **AGE** |
| -------- | ------- |
| FR       | 10      |
| IT       | 75      |
