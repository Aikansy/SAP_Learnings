# **`DELETE ADJACENT DUPLICATES`**

```JS
DELETE ADJACENT DUPLICATES FROM itab
                           [COMPARING {comp1 comp2 ...}.
```

L'instruction `DELETE ADJACENT DUPLICATES` va repérer toutes les lignes en doublon, et les supprimer. Si aucun champ n'est défini par le paramètre `COMPARING`, elle va utiliser la `clé primaire` définie lors de la déclaration de la table.

_Exemple_

_Supprimer tous les doublons d'une table interne de type `SORTED` ayant pour clé primaire le champ `COUNTRY`._

```JS
TYPES: BEGIN OF ty_citizen,
         country TYPE char3,
         name    TYPE char20,
         age     TYPE numc2,
       END OF ty_citizen.

DATA: t_citizen TYPE SORTED TABLE OF ty_citizen WITH NON-UNIQUE KEY country,
      s_citizen TYPE ty_citizen.

s_citizen-country = 'FR'.
s_citizen-name    = 'Thierry'.
s_citizen-age     = '24'.
INSERT s_citizen INTO TABLE t_citizen.

s_citizen-country = 'ES'.
s_citizen-name    = 'Luis'.
s_citizen-age     = '32'.
INSERT s_citizen INTO TABLE t_citizen.

s_citizen-country = 'BR'.
s_citizen-name    = 'Renata'.
s_citizen-age     = '27'.
INSERT s_citizen INTO TABLE t_citizen.

s_citizen-country = 'FR'.
s_citizen-name    = 'Floriane'.
s_citizen-age     = '32'.
INSERT s_citizen INTO TABLE t_citizen.

DELETE ADJACENT DUPLICATES FROM t_citizen.
```

**T_CITIZEN avant DELETE**

| **COUNTRY** | **NAME** | **AGE** |
| ----------- | -------- | ------- |
| BR          | Renata   | 27      |
| ES          | Luis     | 32      |
| FR          | Floriane | 32      |
| FR          | Thierry  | 24      |

**T_CITIZEN après DELETE**

| **COUNTRY** | **NAME** | **AGE** |
| ----------- | -------- | ------- |
| BR          | Renata   | 27      |
| ES          | Luis     | 32      |
| FR          | Floriane | 32      |

> Pour que le `DELETE ADJACENT DUPLICATES` fonctionne, il est impératif que la table soit ordonnée selon une clé primaire ou une liste de champs spécifiés.

\_Même exemple que précédemment, mais avec une table interne de type `STANDARD`.

```JS
TYPES: BEGIN OF ty_citizen,
         country TYPE char3,
         name    TYPE char20,
         age     TYPE numc2,
       END OF ty_citizen.

DATA: t_citizen TYPE TABLE OF ty_citizen,
      s_citizen TYPE ty_citizen.

s_citizen-country = 'FR'.
s_citizen-name    = 'Thierry'.
s_citizen-age     = '24'.
APPEND s_citizen TO t_citizen.

s_citizen-country = 'ES'.
s_citizen-name    = 'Luis'.
s_citizen-age     = '32'.
APPEND s_citizen TO t_citizen.

s_citizen-country = 'BR'.
s_citizen-name    = 'Renata'.
s_citizen-age     = '27'.
APPEND s_citizen TO t_citizen.

s_citizen-country = 'FR'.
s_citizen-name    = 'Floriane'.
s_citizen-age     = '32'.
APPEND s_citizen TO t_citizen.

SORT t_citizen BY country.
DELETE ADJACENT DUPLICATES FROM t_citizen COMPARING country.
```

Lors de l'exemple avec une table interne de type `SORTED`, le tri se faisait automatiquement via l'instruction `INSERT` respecatant la clé primaire. Pour une table interne de type `STANDARD`, le tri doit s'effectuer avec l'instruction `SORT` et le `DELETE ADJACENT DUPLICATES` doit suivre exeactement les mêmes nombre et séquence que le `SORT`.

**T_CITIZEN avant DELETE après le SORT**

| **COUNTRY** | **NAME** | **AGE** |
| ----------- | -------- | ------- |
| BR          | Renata   | 27      |
| ES          | Luis     | 32      |
| FR          | Floriane | 32      |
| FR          | Thierry  | 24      |

**T_CITIZEN après DELETE**

| **COUNTRY** | **NAME** | **AGE** |
| ----------- | -------- | ------- |
| BR          | Renata   | 27      |
| ES          | Luis     | 32      |
| FR          | Floriane | 32      |
