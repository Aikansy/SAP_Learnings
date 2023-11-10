# **`WHERE COL (NOT) IN`**

> A distinguer de [Where Sous-requête (not) in sous-requête](<../../09%20-%20Instructions_dbtab/01%20-%20select/28%20-%20where%20sous-requête%20col%20(not)%20in.md>)

```JS
col [NOT] IN (obj1, obj2,. . . )
```

Vérifie si la valeur de la colonne fait partie ou non (option `NOT`) des valeurs entre parenthèses.

_Exemple_

_Recherche du nom et du prénom des passagers n'habitant pas les villes de "Toulouse" et "Barcelone"._

```JS
SELECT surname,
       name
  FROM zpassenger
  INTO TABLE @DATA(t_passenger)
  WHERE city NOT IN ('TOULOUSE', 'BARCELONE').


DATA s_passenger LIKE LINE OF t_passenger.

LOOP AT t_passenger INTO s_passenger.
  WRITE:/ s_passenger-surname, s_passenger-name.
ENDLOOP.
```

_Résultat de la requête_

| **SURNAME** | **NAME** |
| ----------- | -------- |
| PEREZ       | MICHEL   |

_Résultat à l'écran_

![](../../99%20-%20Ressources/09_Instructions_dbtab%20-%2001%20-%2028%20-%2001.png)
