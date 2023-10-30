# **`CA - CONTAINS NOT ONLY`**

```JS
IF oper1 CA oper2.
  ...
ENDIF.
```

`CA` signifie en anglais ` Contains Any` et vérifie que la chaîne de caractères `oper1` contient un quelconque caractère de `oper2`.

_Exemple_

```JS
DATA: c_oper1 TYPE char5 VALUE 'Hello',
      c_oper2 TYPE char3 VALUE 'llo'.

IF c_oper1 CA c_oper2.
  WRITE:/ 'C_OPER1 contient au moins un caractère contenu dans ', c_oper2, '
à la position ', sy-fdpos.
ELSE.
  WRITE:/ 'C_OPER1 ne contient aucun caractère contenu dans ', c_oper2.
ENDIF.
```

L’exemple précédent est repris en modifiant la valeur de la constante `C_OPER2` pour `’llo’`. Dans ce cas, la condition va vérifier qu’au moins un caractère de la chaîne de `C_OPER1` soit contenu dans `C_OPER2` puis en retournera sa première position dans la variable système [SY-FDPOS](../99%20-%20Help/02%20-%20SY-SYSTEM.md), ici égale à 2.

![](../99%20-%20Ressources/02_Conditions%20-%2005%20-%2001.png)
