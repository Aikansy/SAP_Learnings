# **PROGRAMMATION**

## **HAVING**

Cette option permet de rajouter un critère de recherche supplémentaire défini par le paramètre condition. Ce terme, assez vague, regroupe en fait plusieurs types comme une comparaison entre deux objets :

```ABAP
...HAVING obj1 EQ obj2...
```

Ou la vérification de l’existence d’un champ dans une sous-requête :

```ABAP
...HAVING obj IN ss_requête...
```

Il est vrai que ce sont des critères pouvant très bien s’intégrer dans une clause **WHERE** mais le **HAVING** est intéressant pour des conditions impossibles à effectuer avec le **WHERE** comme ajouter un critère de recherche avec l’utilisation d’expressions **SQL**.

Par exemple, effectuer de nouveau la sélection précédente sauf qu’il sera nécessaire de ne retourner que les conducteurs ayant fait plus d’un seul trajet :

_Exemple_

```ABAP
CONSTANTS: lc_nbretraj(2) TYPE i VALUE '2'.

SELECT d~surname               AS surname,
       d~name                  AS name,
       COUNT(*)                AS nb_travel,
       SUM( t~kms )            AS kms,
       SUM( t~gasol + t~toll ) AS costs
  FROM ztravel AS t INNER JOIN zdriver_car AS d
  ON t~id_driver = d~id_driver
  INTO TABLE @DATA(lt_travel)
  GROUP BY d~surname, d~name
  HAVING COUNT(*) GE @lc_nbretraj
  ORDER BY d~surname ASCENDING, d~name ASCENDING.


DATA ls_travel LIKE LINE OF lt_travel.

LOOP AT lt_travel INTO ls_travel.
  WRITE:/ ls_travel-surname, ls_travel-name, ls_travel-nb_travel,
          ls_travel-kms,     ls_travel-costs.
ENDLOOP.
```

| **SURNAME** | **NAME** | **NB_TRAVEL** | **KMS** | **COSTS** |
| ----------- | -------- | ------------- | ------- | --------- |
| PILON       | BEATRIZ  | 2             | 389     | 109.38    |
