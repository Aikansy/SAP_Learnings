# **PROGRAMMATION**

## **ORDER BY**

_Exemple_

En reprenant l’exemple précédent mais en triant la sélection par le nom et le prénom par ordre croissant.

```ABAP
SELECT d~surname               AS surname,
       d~name                  AS name,
       COUNT(*)                AS nb_travel,
       SUM( t~kms )            AS kms,
       SUM( t~gasol + t~toll ) AS costs
  FROM ztravel AS t INNER JOIN zdriver_car AS d
  ON t~id_driver = d~id_driver
  INTO TABLE @DATA(lt_travel)
  GROUP BY d~surname, d~name
  ORDER BY d~surname ASCENDING, d~name ASCENDING.

DATA ls_travel LIKE LINE OF lt_travel.

LOOP AT lt_travel INTO ls_travel.
  WRITE:/ ls_travel-surname, ls_travel-name, ls_travel-nb_travel,
          ls_travel-kms,     ls_travel-costs.
ENDLOOP.
```

| **SURNAME** | **NAME** | **NB_TRAVEL** | **KMS** | **COSTS** |
| ----------- | -------- | ------------- | ------- | --------- |
| ALDAIR      | PAULA    | 1             | 170     | 56.50     |
| DEBBACHE    | AMINH    | 1             | 205     | 56.21     |
| PILON       | BEATRIZ  | 2             | 389     | 109.38    |
