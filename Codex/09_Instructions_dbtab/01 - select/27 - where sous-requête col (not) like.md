# **`WHERE COL (NOT) LIKE`**

```JS
col [NOT] LIKE obj
```

Cette option permet de rechercher une `châine de caractères`. La différence ici est que la chaîne de caractères peut être incomplète et donc les inconnus seront définis par un `%`.

_Exemple_

_Recherche du nom et prénom de tous les passagers dont le nom se termine par "ez"._

```JS
SELECT surname,
       name
  FROM zpassenger
  INTO TABLE @DATA(t_passenger)
  WHERE ( surname LIKE '%EZ' OR surname LIKE '%ez' ).


DATA s_passenger LIKE LINE OF t_passenger.

LOOP AT t_passenger INTO s_passenger.
  WRITE:/ s_passenger-surname, s_passenger-name.
ENDLOOP.
```

_Résultat de la requête_

| **SURNAME** | **NAME** |
| ----------- | -------- |
| PEREZ       | MICHEL   |
| HERNANDEZ   | PATRICIA |

_Résultat à l'écran_

![](../../00_Ressources/09_27_01.png)

> Attention à la casse du texte recherché ! Dans l'exemple, pour être bien sût du résultat, la recherche s'est effectuée sur les caractères en minuscule et majuscules.
