# **`UPDATE DBTAB SET`**

Ce type de requête permet de mettre à jour une ou plusieurs lignes de la table de la base de données de trois manières différentes, et mettra à jour deux variables système :

- [`SY-SUBRC`](../../99_Help/02_SY-SYSTEM.md) pour indiquer l'état de l'opération :
  - 0 - la ou les lignes ont été correctement insérées.
  - 4 - une ou plusieurs erreurs se sont produites pendant le traitement.
- [`SY-DBCNT`](../../99_Help/02_SY-SYSTEM.md) retourne le nombre de ligne insérées

```JS
UPDATE dbtab SET col1 = exp1, SET col2 = exp2,... [WHERE cond]...
```

Cette fonction signifie mettre à jour la table de la base de données `dbtab`, en appliquant la valeur définie par `exp1` à la colonne `col1`, `exp2` à `col2...`(`SET`) pour la condition cond définie (`WHERE`).

Les valeurs des champs sont modifiées directement dans la requête et même si la clause `WHERE` est `optionnelle`, elle est cependant bien `recommandée` au risque de modifier tous les enregistrements de la table.

_Exemple_

_Pour le conducteur dont l'identifiant est `C0003`, rajouter 5 euros pour tous les péages et 10 pour l'essence._

```JS
CONSTANTS: c_id_driver TYPE zdriver_id VALUE 'C0003'.

UPDATE ztravel
      SET toll  = toll  + 5,
          gasol = gasol + 10
      WHERE id_driver = @c_id_driver.

  IF sy-subrc = 0.
    WRITE 'Mise à jour réussie'.
  ELSE.
    WRITE 'Echec de la mise à jour'.
  ENDIF.
```

La constante `C_ID_DRIVER` est créée avec le type `ZDRIVER_ID` et contient la valeur `C0003`. Le programme procédera ensuite à la mise à jour de la table `ZTRAVEL` en ajoutant la valeur de `5` au champ `TOLL`, et `10` à celui de `GASOL`, pour tous les enregistrements dont le champ `ID_DRIVER` est égal à la constante `C_ID_DRIVER`. Si le code retour de la `variable système` est égal à `0`, le programme affichera le texte `Mise à jour réussie`, dans le cas contraire, il affichera `Echec de la mise à jour`.

_Enregistrement avant `UPDATE`_

| **ID_DRIVER** | **TOLL** | **GAZOL** |
| ------------- | -------- | --------- |
| C0003         | 16.00    | 35.40     |
| C0003         | 17.00    | 40.98     |

_Enregistrement après `UPDATE`_

| **ID_DRIVER** | **TOLL** | **GAZOL** |
| ------------- | -------- | --------- |
| C0003         | 21.00    | 45.40     |
| C0003         | 22.00    | 50.98     |

_Résultat à l'écran_

![](../../00_Ressources/10_02_01.png)
