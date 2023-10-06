# **`NA - NOT ANY`**

```JS
IF oper1 NA oper2.
  ...
ENDIF.
```

`NA` signifie en anglais `contains Not Any` et au contraire de `CA`, vérifie que `oper1` ne contient aucun caractère contenu dans `oper2`.

_Exemple_

```JS
DATA: c_oper1 TYPE char5 VALUE 'Hello',
      c_oper2 TYPE char4 VALUE 'abcd'.

IF c_oper1 NA c_oper2.
  WRITE:/ 'C_OPER1 ne contient aucun caractère contenu dans ', c_oper2.
ELSE.
  WRITE:/ 'C_OPER1 contient au moins un caractère contenu dans le texte ', c_oper2.
ENDIF.
```

L’exemple précédent est repris en modifiant la valeur de la constante `C_OPER2` pour `abcd`. Dans ce cas, avec l’opérateur `NA`, le programme vérifie qu’aucun caractère n’est contenu dans la constante `C_OPER2` et retourne le message correspondant.

![](../00_Ressources/02_06_01.png)
