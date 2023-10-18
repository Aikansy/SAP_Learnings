# **`ORDER BY`**

```JS
. . .ORDER BY PRIMARY KEY. . .
. . .ORDER BY col1 [ASCENDING | DESCENDING],
              col2 [ASCENDING | DESCENDING]. . .
```

_Exemple_

_En reprenant l'exemple précédent mais en triant la sélection par le nom et le prénom par ordre croissant._

```JS
SELECT d~surname               AS surname,
       d~name                  AS name,
       COUNT(*)                AS nb_travel,
       SUM( t~kms )            AS kms,
       SUM( t~gasol + t~toll ) AS costs
  FROM ztravel AS t INNER JOIN zdriver_car AS d
  ON t~id_driver = d~id_driver
  INTO TABLE @DATA(t_travel)
  GROUP BY d~surname, d~name
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
| ALDAIR      | PAULA    | 1             | 170     | 56.50     |
| DEBBACHE    | AMINH    | 1             | 205     | 56.21     |
| PILON       | BEATRIZ  | 2             | 389     | 109.38    |

_Résultat à l'écran_

![](../../00_Ressources/09_34_01.png)
