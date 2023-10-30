# **`SPLIT`**

```JS
SPLIT dobj
  AT sep
  INTO { {result1 result2 ...} | {TABLE itab} }
  [IN {BYTE|CHARACTER} MODE].
```

- `SPLIT`

  Un `SPLIT` permet de faire l’inverse du `CONCATENATE` : il va séparer une chaîne de caractères `dobj` selon le code séparateur défini après le `AT` et stocker le résultat dans des variables de sortie (`result1`, `result2...`) ou dans une table interne `itab`.

  _Paramètre(s) supplémentaire(s) optionnel(s) :_

  - `IN BYTE MODE` ou `IN CHARACTER MODE`, est un paramètre qui revient assez souvent en `ABAP`. La valeur par défaut sera toujours `IN CHARACTER MODE`. `IN BYTE MODE` est le plus souvent utilisé lors d’un travail avec des variables de type hexadécimal, autant dire assez rarement.

```JS
DATA: v_txt1(20) TYPE C,
      v_txt2(20) TYPE C,
      v_txt3(20) TYPE C,
      v_txt4(20) TYPE C,
      v_txt5(20) TYPE C.

CONSTANTS: c_string(50) TYPE c VALUE 'Hello World Bienvenue sur SAP'.

SPLIT c_string
  AT space
  INTO v_txt1 v_txt2 v_txt3 v_txt4 v_txt5.

WRITE:/ 'v_txt1 : ', v_txt1,
      / 'v_txt2 : ', v_txt2,
      / 'v_txt3 : ', v_txt3,
      / 'v_txt4 : ', v_txt4,
      / 'v_txt5 : ', v_txt5.
```

Cette fois-ci, la constante `C_STRING` contenant une chaîne de caractères de plusieurs mots séparée par un espace, va être divisée et stockée dans les variables `V_TXT\*`. Après exécution, l’écran affiche le résultat suivant :

![](../99%20-%20Ressources/01_Variables%20-%2006%20-%2001.png)

> Dans la nouvelle version de `SAP`, il est possible de déclarer les variables directement dans l’instruction. Ainsi l’exemple précédent peut être réécrit de la manière suivante :

```JS
CONSTANTS: c_string(50) TYPE c VALUE 'Hello World Bienvenue sur SAP'.

SPLIT c_string AT space
      INTO DATA(v_txt1)
           DATA(v_txt2)
           DATA(v_txt3)
           DATA(v_txt4)
           DATA(v_txt5).
```

`SAP` va automatiquement créer les variables `V_TXT1`, `V_TXT2`, `V_TXT3`, `V_TXT4`, et `V_TXT5` de type `STRING`. De même pour le résultat dans une table, `SAP` va en créer une de type string également.

```JS
CONSTANTS: c_string(50) TYPE C VALUE 'Hello World Bienvenue sur SAP'.

SPLIT c_string AT space INTO TABLE DATA(tab_result).
```

Cette table interne aura une liste de champs de type `STRING`.
