# **`HAVING`**

```JS
. . .HAVING condition. . .
```

Cette option permet de rajouter un critère de recherche supplémentaire défini par le `paramètre condition`. Ce terme, assez vague, regroupe en fait plusieurs types comme un [`comparaison`](../../99_Help/03_OPERATORS.md) entre deux objets :

```JS
. . .HAVING obj1 EQ obj2. . .
```

ou

```JS
. . .HAVING obj IN ss_requête. . .
```

Il est vrai que ce sont des critères pouvant très bien s'intégrer dans une clause `WHERE` mais le `HAVING` est intéressant pour des conditions impossibles à effectuer avec le `WHERE` comme ajouter un critère de recherche avec l'utilisation d'expressions `SQL`.

Par exemple, effectuer de nouveau la sélection précédente sauf qu'il sera nécessaire de ne retourner que les conducteurs ayant fait plus d'un seul trajet :

```JS
CONSTANTS: c_nbretraj(2) TYPE i VALUE '2'.

SELECT d~surname               AS surname,
       d~name                  AS name,
       COUNT(*)                AS nb_travel,
       SUM( t~kms )            AS kms,
       SUM( t~gasol + t~toll ) AS costs
  FROM ztravel AS t INNER JOIN zdriver_car AS d
  ON t~id_driver = d~id_driver
  INTO TABLE @DATA(t_travel)
  GROUP BY d~surname, d~name
  HAVING COUNT(*) GE @c_nbretraj
  ORDER BY d~surname ASCENDING, d~name ASCENDING.


DATA s_travel LIKE LINE OF t_travel.

LOOP AT t_travel INTO s_travel.
  WRITE:/ s_travel-surname, s_travel-name, s_travel-nb_travel,
          s_travel-kms,     s_travel-costs.
ENDLOOP.
```

_Résultat de la requête_

| **SURNAME** | **NAME** | **NB_TRAVEL** | **KMS** | **COSTS** |
| ----------- | -------- | ------------- | ------- | --------- |
| PILON       | BEATRIZ  | 2             | 389     | 109.38    |

_Résultat à l'écran_

![](../../99%20-%20Ressources/09_Instructions_dbtab%20-%2001%20-%2035%20-%2001.png)
