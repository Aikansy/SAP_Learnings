# **`DELETE DBTAB FROM`**

Cette requête permet de supprimer une ou plusieurs lignes de la table de base de données soit via une structure, soit via une table interne, et de mettre à jour deux variables système :

- [`SY-SUBRC`](../../99_Help/02_SY-SYSTEM.md) pour indiquer l'état de l'opération :
  - 0 - la ou les lignes ont été correctement insérées.
  - 4 - une ou plusieurs erreurs se sont produites pendant le traitement.
- [`SY-DBCNT`](../../99_Help/02_SY-SYSTEM.md) retourne le nombre de ligne insérées

```JS
DELETE dbtab FROM struct.
DELETE dbtab FROM TABLE itab
```

Elle se comporte de la même manière qu'un `INSERT` et un `UPDATE` : le système va vérifier si la ou les clé(s) primaire(s) définie(s) dans la struture `struct` ou la table interne `itab` existe(nt) dans la table de la base de données `dbtab`. Si celle-ci existe, alors la ligne sera supprimée, sinon elle sera mise de côté et retournera la variable système [`SY-SUBRC`](../../99_Help/02_SY-SYSTEM.md) sera égale à `4`.
