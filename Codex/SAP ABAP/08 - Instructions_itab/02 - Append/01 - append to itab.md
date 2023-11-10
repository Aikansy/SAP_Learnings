# **`APPEND`**

```JS
APPEND   wa
      | {INITIAL LINE}
      | {LINES OF jtab [FROM idx1] [TO idx2]} ...
  TO itab.
```

L’instruction `APPEND` possède les mêmes options que l’instruction `INSERT` à part pour le paramètre de destination, qui sera toujours une table interne avec `TO itab`.

_Exemple_

L’exemple précédent peut être complété par les lignes suivantes :

```JS
. . .
s_citizen-country = 'ES'.
s_citizen-name    = 'Luiza'.
s_citizen-age     = '31'.
APPEND s_citizen TO t_citizen1.

s_citizen-country = 'BR'.
s_citizen-name    = 'Felipe'.
s_citizen-age     = '25'.
APPEND s_citizen TO t_citizen1.
```

T_CITIZEN1

| **COUNTRY** | **NAME**  | **AGE** |
| :---------: | --------- | :-----: |
|     BR      | Renata    |   27    |
|     FR      | Florianne |   32    |
|             |           |         |
|     FR      | Thierry   |   24    |
|     ES      | Luiza     |   31    |
|     BR      | Felipe    |   25    |

L’instruction `APPEND` fonctionne pour les tables de type `STANDARD` et `RANGE`. Pour les tables internes de type `HASHED` et `SORTED`, il est obligatoire d’utiliser l’instruction `INSERT wa INTO TABLE itab`.

> Petite parenthèse, il est possible d’utiliser l’instruction `APPEND` avec les types de tables internes `SORTED` mais comme l’`append` insère toujours une ligne en fin de table, si l’enregistrement inséré modifie l’ordre défini par la clé primaire, alors le programme retournera un `dump`.

_Exemple_

Ajouter les pays `ES` puis `BR` à une table interne de type `SORTED` avec comme clé primaire le champ `LAND`.

```JS
TYPES: BEGIN OF ty_country,
         land TYPE char3,
       END OF ty_country.

DATA: t_country TYPE SORTED TABLE OF ty_country WITH NON-UNIQUE KEY land,
      s_country TYPE ty_country.

s_country-land = 'ES'.
APPEND s_country TO t_country.

s_country-land = 'BR'.
APPEND s_country TO t_country.
```

Selon la clé primaire de la table, la valeur ’BR’ doit être avant ’ES’. Dans ce cas, l’exécution du programme retournera un dump (en allemand).

![](../../99%20-%20Ressources/08_Instructions_itab%20-%2002%20-%2001%20-%2001.png)

_Exemple_

Ajouter les pays `ES` puis `BR` à une table interne de type `SORTED` avec comme `clé primaire` le champ `LAND`.

```JS
TYPES: BEGIN OF ty_country,
         land TYPE char3,
       END OF ty_country.

DATA: t_country TYPE SORTED TABLE OF ty_country WITH NON-UNIQUE KEY land,
      s_country TYPE ty_country.

s_country-land = 'BR'.
APPEND s_country TO t_country.

s_country-land = 'ES'.
APPEND s_country TO t_country.
```

Cette fois-ci l’ordre de la clé primaire est respecté, pas de dump et le programme se termine correctement.
