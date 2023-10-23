# **`WHILE EXIT`**

```JS
DATA: v_month TYPE i.

v_month = sy-datum+4(2).

WHILE sy-index <= 12.
  IF sy-index > v_month.
    EXIT.
  ENDIF.
  WRITE:/'Mois ', sy-index.
ENDWHILE.
```

La boucle a été définie pour être exécutée tant que la variable système [SY-INDEX](../99_Help/02_SY-SYSTEM.md) est inférieure ou égale à `12`. Si la valeur de la variable système [SY-INDEX](../99_Help/02_SY-SYSTEM.md) est strictement supérieure au mois en cours (`V_MONTH` défini au préalable via la date système [SY-INDEX](../99_Help/02_SY-SYSTEM.md)), alors le programme sort de la boucle, sinon il affichera le message `Mois` et la valeur de [SY-INDEX](../99_Help/02_SY-SYSTEM.md).

![](../99%20-%20Ressources/03_Boucles%20-%2006%20-%2001.png)
