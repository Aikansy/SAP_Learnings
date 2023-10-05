# **PROGRAMMATION**

## **DIV**

Partie entière de la division entre arg1 et arg2.

_Exemple_

```ABAP
SELECT div( arg1,arg2 )
```

_Exemple_

Exemple reprenant les différentes fonctions arithmétiques :

```ABAP
SELECT toll,
       duration,
       gasol,
       ABS( toll - gasol ) AS abs,    "Valeur absolue
       CEIL( gasol )       AS ceil,   "Arrondi inférieur
       FLOOR( gasol )      AS floor,  "Arrondi supérieur
       DIV( duration,60 )  AS div,    "Division
       MOD( duration,60 )  AS mod     "Reste division
  FROM ztravel
  INTO TABLE @DATA(lt_arith).


DATA: ls_arith LIKE LINE OF lt_arith.


LOOP AT lt_arith INTO ls_arith.
  WRITE:/ ls_arith-toll, ls_arith-duration, ls_arith-gasol,
          ls_arith-abs,  ls_arith-ceil,     ls_arith-floor,
          ls_arith-div,  ls_arith-mod.
ENDLOOP.
```

Cette requête va d’abord afficher les champs **TOLL**, **DURATION** et **GASOL**, puis va retourner la **valeur absolue** de la soustraction entre **TOLL** et **GASOL**, **arrondir** la valeur de **GASOL** à l’entier **inférieur**, puis **supérieur** et enfin **compter** le nombre de minutes du champ **DURATION** (**DIV**) et le reste de cette division (**MOD**).
