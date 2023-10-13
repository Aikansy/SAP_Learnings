# **`MODIDFY WHERE`**

> Pour l’instruction `MODIFY`, il existe trois formes de syntaxe possibles.

```JS
MODIFY itab FROM wa
            TRANSPORTING comp1 comp2 ...
            WHERE cond.
```

Pour cette instruction, le `MODIFY` va utiliser une clause `WHERE` pour spécifier la ligne de la table interne `itab` à modifier à partir de la structure `wa`.

_Exemple_

_Reprendre l’exemple du `COLLECT` et initialiser le champ `AGE` à `10` pour le pays égal à `IT`._

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


CLEAR s_country-land.
s_country-age  = 10.
MODIFY t_country FROM s_country TRANSPORTING age
                 WHERE land = 'IT'.
```

Avant le MODIFY, un CLEAR est effectué sur le champ LAND, montrant ainsi que le système va privilégier la clause WHERE plutôt que la recherche de la clé primaire de la table.

**T_COUNTRY avant le MODIFY**

| **LAND** | **AGE** |
| -------- | ------- |
| FR       | 28      |
| IT       | 75      |

**T_COUNTRY après le MODIFY**

| **LAND** | **AGE** |
| -------- | ------- |
| FR       | 28      |
| IT       | 10      |

> Cette clause `WHER`E est très utile pour sélectionner un type de champ nécessaire et sera beaucoup plus détaillée dans le chapitre sur les requêtes SQL (`SELECT` - `WHERE`).
