# **`SORT`**

```JS
SORT itab [ASCENDING|DESCENDING] [AS text] [STABLE]
             BY c1 [ASCENDING|DESCENDING] [AS text]
              ...
                cn [ASCENDING|DESCENDING] [AS text].
```

L'instruction `SORT` permet d'organiser une table interne de type `STANDARD` ou `HASHED itab` selon sa clé primaire ou une liste de composant (`c1` à `cn`). Les options `ASCENDING` et `DESCENDING` définissent un tri par ordre croissant ou décroissant, `AS TEXT` donne la possibilité pour les champs de type chaîne de caractères d'être triés par une `langue définie en local` par l'instruction `SET LOCALE LANGUAGE` (par défaut, la langue utilisée est celle définie par l'utilisateur).

_Exemple_

_Deux `SORT` sont effectués sur une table de type `STANDARD`._

```JS
TYPES: BEGIN OF ty_citizen,
         country TYPE char3,
         name    TYPE char20,
         age     TYPE numc2,
       END OF ty_citizen.

DATA: t_citizen TYPE STANDARD TABLE OF ty_citizen,
      s_citizen  TYPE ty_citizen.

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

SORT t_citizen DESCENDING.
SORT t_citizen BY country ASCENDING age DESCENDING.
```

**T_CITIZEN avant le premier `SORT`**

| **COUNTRY** | **NAME** | **AGE** |
| ----------- | -------- | ------- |
| FR          | Thierry  | 24      |
| ES          | Luis     | 32      |
| BR          | Renata   | 27      |
| FR          | Floriane | 32      |

**T_CITIZEN après le premier `SORT`**

| **COUNTRY** | **NAME** | **AGE** |
| ----------- | -------- | ------- |
| FR          | Thierry  | 24      |
| FR          | Floriane | 32      |
| ES          | Luis     | 32      |
| BR          | Renata   | 27      |

**T_CITIZEN après le second `SORT`**

| **COUNTRY** | **NAME** | **AGE** |
| ----------- | -------- | ------- |
| BR          | Renata   | 27      |
| ES          | Luis     | 32      |
| FR          | Floriane | 32      |
| FR          | Thierry  | 24      |

Lorsque l'ordre de tri n'est pas spécifié par un `BY` et qu'aucune clé primaire n'est définie, le `SORT` va ordonner la table interne d'une manière pouvant être aléatoire et instable, pouvant donner des résultats différents à chaque fois. C'est pour cela que l'option `STABLE` est utilisée, afin de retourner toujours le même résultat et de ne pas avoir de mauvaise surprise.

> Le `SORT` est utilisable uniquement sur les tables internes de type `STANDARD` ou `HASHED`, et donc impossible pour une table interne de type SORTED ayant déjà par définition, un ordre de tri prédéfini et inaltérable.
