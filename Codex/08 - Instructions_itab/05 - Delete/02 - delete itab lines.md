# **`DELETE MULTIPLE LINES`**

```JS
DELETE itab [FROM idx1] [TO idx2]
            [WHERE log_exp].
```

Dans ce cas, l'instruction `DELETE` possède deux options ; suppression de plusieurs lignes à partir d'un index de ligne (`FROM idx1`) et/ou jusqu'a un index de ligne (`TO idx2`) ; mais peut aussi contenir une clause `WHERE` pour affiner la suppression.

_Exemple_

Suppression des lignes 2 et 3 de la table interne `T_CITIZEN` où le champ ` COUNTRY` est égal à `BR`.

```JS
TYPES: BEGIN OF ty_citizen,
         country TYPE char3,
         name    TYPE char20,
         age     TYPE numc2,
       END OF ty_citizen.

DATA: t_citizen TYPE TABLE OF ty_citizen WITH NON-UNIQUE KEY country,
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

DELETE t_citizen FROM 2 TO 3 WHERE country = 'BR'.
```

**T_CITIZEN avant DELETE**

| **COUNTRY** | **NAME** | **AGE** |
| ----------- | -------- | ------- |
| FR          | Thierry  | 24      |
| ES          | Luis     | 32      |
| BR          | Renata   | 27      |
| FR          | Floriane | 32      |

**T_CITIZEN après DELETE**

| **COUNTRY** | **NAME** | **AGE** |
| ----------- | -------- | ------- |
| FR          | Thierry  | 24      |
| ES          | Luis     | 32      |
| FR          | Floriane | 32      |

> Il est important de filtrer le `DELETE` par un `INDEX` ou un `WHERE`. Un `DELETE itab` seul retrounera un `dump`.
