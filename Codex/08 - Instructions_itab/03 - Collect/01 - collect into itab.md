# **`COLLECT`**

```JS
COLLECT wa INTO itab.
```

Avec l’instruction `COLLECT`, le système vérifiera si la clé contenue dans la structure `wa` existe dans la table interne. Si elle n’existe pas, une `nouvelle ligne est insérée`, sinon les `valeurs numériques sont additionnées`.

_Exemple_

Exécuter un `COLLECT`

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
```

Un type de structure est tout d’abord créé contenant deux champs :

- `LAND` utilisant l’élément de données `CHAR3` (alphanumérique de trois positions)
- `AGE` de type `I` de trois positions également.

La table interne `T_COUNTRY` est ensuite déclarée de type `HASHED` avec une `clé primaire` définie par le champ `LAND`. Puis pour chacun des pays `FR` et `IT`, une valeur va être attribuée avec un `COLLECT`. Au final, la table interne `T_COUNTRY` aura les enregistrements ci-après.

**T_COUNTRY**

| **LAND** | **AGE** |
| -------- | ------- |
| FR       | 28      |
| IT       | 75      |

    Pour une table interne composée uniquement de chaînes de caractères ou de numériques NUMC, le COLLECT s’avère inutile et il sera préférable d’utiliser un APPEND ou un INSERT.
