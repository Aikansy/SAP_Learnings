# **`CONDENSE`**

```JS
CONDENSE text [NO-GAPS].
```

- `CONDENSE`

  Cette instruction est très souvent utilisée avec le `CONCATENATE` car elle sépare chaque chaîne de caractères par un `[SPACE]`, en supprimant tous ceux en trop.

  Paramètre(s) supplémentaire(s) optionnel(s) :

  - `NO-GAPS` qui supprime absolument tous les espaces et va donc regrouper tous les mots de la chaîne de caractères.

_L’exemple suivant permet d’éclaircir le rôle du `CONDENSE`._

```JS
CONSTANTS: c_txt1(20) TYPE c VALUE 'Hello    ',
           c_txt2(20) TYPE c VALUE '    World    ',
           c_txt3(20) TYPE c VALUE '    Bienvenue    ',
           c_txt4(20) TYPE c VALUE '    sur    ',
           c_txt5(20) TYPE c VALUE '    SAP    '.

DATA:      v_result(50)   TYPE c .

CONCATENATE c_txt1 c_txt2 c_txt3 c_txt4 c_txt5
  INTO v_result.

WRITE:/ 'Sans CONDENSE :         ', v_result.

CONDENSE v_result.
WRITE:/ 'Avec CONDENSE :         ', v_result.

CONDENSE v_result NO-GAPS.
WRITE:/ 'Avec CONDENSE NO GAPS : ', v_result.
```

Les cinq variables du programme précédent sont reprises sauf que pour l’exercice, des espaces ont été rajoutés. Dans un premier temps, l’instruction `CONCATENATE` va être utilisée, stockée dans la variable `V_RESULT` et affichée. Ensuite, un `CONDENSE` seul sera effectué sur `V_RESULT` puis affiché et enfin un `CONDENSE...NO-GAPS` sera utilisé pour modifier et afficher la variable. Le résultat est le suivant :

![](../99%20-%20Ressources/01_Variables%20-%2005%20-%2001.png)

Le `CONCATENATE` va grouper les variables `C_TXT*` en laissant des espaces, puis le `CONDENSE` va supprimer tous ceux qui sont en trop en gardant juste celui de séparation, et enfin le `NO-GAPS` va tous les supprimer.
