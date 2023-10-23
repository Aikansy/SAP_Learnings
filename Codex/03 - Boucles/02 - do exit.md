# **`EXIT`**

Il est très important de toujours définir une sortie à une boucle au risque de créer une `boucle infinie`. Dans cet exemple l’option `n TIMES` a été utilisée, mais il est également possible d’utiliser des instructions comme `EXIT`.

```JS
DO 5 TIMES.
  WRITE:/ sy-index.
ENDDO.
```

Ainsi en reprenant l’exemple ci-dessus, mais sans l’utilisation de **n TIMES** :

```JS
DO.
  IF sy-index > 5.
    EXIT.
  ENDIF.
  WRITE:/ sy-index.
ENDDO.
```

La boucle est appelée mais sans paramètre de sortie défini au préalable, une première condition va vérifier si la variable système [SY-INDEX](../99_Help/02_SY-SYSTEM.md) est strictement supérieure à `5` : si oui alors le programme sortira de la boucle (`EXIT`), sinon, il n’entrera pas dans cette condition et affichera la valeur de [SY-INDEX](../99_Help/02_SY-SYSTEM.md) à l’écran.

À noter qu’il aurait été possible également d’utiliser un `ELSE` sans qu’il n’y ait de changement dans le résultat :

```JS
DO.
  IF sy-index > 5.
    EXIT.
  ELSE.
    WRITE:/ sy-index.
  ENDIF.
ENDDO.
```
