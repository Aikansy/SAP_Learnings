# **`WHERE SOUS-REQUETE (NOT) IN SOUS-REQUETE`**

```JS
col [NOT] IN ss_requête
```

> A distinguer de [`Where Sous-requête (not) in](<../09_SQL_Select/28_where_sous-requête_col_(not)_in.md>)

Cette option permet de contrôler si la valeur d'une colonne fait partie ou non (`NOT`) d'une sous-requête.

_Exemple_

_Afficher la ville et le pays de destination qui n'existent pas dans la table des conducteurs et des passagers._

```JS
SELECT city_to && ', ' && country_to AS city_ctry
  FROM ztravel AS t
  INTO TABLE @DATA(t_city)
  WHERE city_to NOT IN ( SELECT city
                           FROM zdriver_car
                           WHERE city = t~city_to )
    AND city_to NOT IN ( SELECT city
                           FROM zpassenger
                           WHERE city = t~city_to ).


DATA s_city LIKE LINE OF t_city.

LOOP AT t_city INTO s_city.
  WRITE:/ s_city-city_ctry.
ENDLOOP.
```

_Résultat de la requête_

| **CITY_CTRY** |
| ------------- |
| LERIDA,ES     |

_Résultat à l'écran_

![](../00_Ressources/09_31_01.png)
