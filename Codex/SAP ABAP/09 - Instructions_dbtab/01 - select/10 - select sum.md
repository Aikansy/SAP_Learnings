# **`SUM`**

Plusieurs fonctions d'agrégats existent sur `SAP` pour les requêtes `SQL`.

`SUM ( [DISTINCT] col )` Cet agrégat fait la somme de toutes les valeurs d’une colonne.

_Exemple_

_Faire le total de tous les péages payés._

```JS
DATA: v_sum TYPE ztravel-toll.

SELECT SUM( toll )
  FROM ztravel
  INTO @v_sum.
```

Selon les valeurs enregistrées dans la table, `V_SUM` aura la valeur `55` (16 + 17 + 16 + 6).

L’option `DISTINCT` peut être utilisée aussi avec cet agrégat et éliminera de nouveau les lignes en double. Ainsi la requête précédente avec le `DISTINCT` donnera :

```JS
DATA: v_sum TYPE ztravel-toll.

SELECT SUM( DISTINCT toll )
  FROM ztravel
  INTO @v_sum.
```

La valeur stockée dans la variable `V_SUM` sera égale à ’39’ (16 + 17 + 6).
