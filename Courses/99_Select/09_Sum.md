# **PROGRAMMATION**

## **SUM**

Cet agrégat fait la somme de toutes les valeurs d’une colonne.

_Exemple_

Faire le total de tous les péages payés.

```ABAP
DATA: lv_sum TYPE ztravel-toll.

SELECT SUM( toll )
  FROM ztravel
  INTO @lv_sum.
```

Selon les valeurs enregistrées dans la table, **LV_SUM** aura la valeur ’55’ (16 + 17 + 16 + 6).

L’option **DISTINCT** peut être utilisée aussi avec cet agrégat et éliminera de nouveau les lignes en double. Ainsi la requête précédente avec le **DISTINCT** donnera :

```ABAP
DATA: lv_sum TYPE ztravel-toll.

SELECT SUM( DISTINCT toll )
  FROM ztravel
  INTO @lv_sum.
```

La valeur stockée dans la variable **LV_SUM** sera égale à ’39’ (16 + 17 + 6).
