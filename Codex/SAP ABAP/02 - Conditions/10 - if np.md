# **`NP - BO PATTERN`**

- `NP` :

  `NP` signifie en anglais `No Pattern` et au contraire de `CP`, vérifiera que la chaîne de caractères `oper1` ne respecte pas le modèle contenu dans `oper2`.

  ```JS
  IF oper1 NP oper2.
    ...
  ENDIF.
  ```

  _Exemple_

  ```JS
  DATA: c_oper1 TYPE char9 VALUE 'texte.txt',
        c_oper2 TYPE char5 VALUE '*.png'.

  IF c_oper1 NP c_oper2.
    WRITE:/ 'Le fichier lu n''est pas au format PNG'.
  ELSE.
    WRITE:/ 'Le fichier lu est au format PNG'.
  ENDIF.
  ```

  La constante `C_OPER1` contient la chaîne de caractères `texte.txt` et en utilisant la condition `NP`, le programme va vérifier que celle-ci n’est pas composée du modèle contenu dans `C_OPER2` à savoir `*.png`.

  ![](../99%20-%20Ressources/02_Conditions%20-%2010%20-%2001.png)
