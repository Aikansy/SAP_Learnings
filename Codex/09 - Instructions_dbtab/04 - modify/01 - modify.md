# **`MODIFY`**

Cette requête permet de modifier une ou plusieurs lignes de la table de base de données soit via une structure, soit via une table interne, et de mettre à jour deux variables système :

- [SY-SUBRC](../../99%20-%20Help/02%20-%20SY-SYSTEM.md) indique l'état de l'opération
- [SY-DBCNT](../../99%20-%20Help/02%20-%20SY-SYSTEM.md) retourne le nombre de lignes modifiées

```JS
MODIFY dbtab FROM struct.
MODIFY dbtab FROM TABLE itab.
```

Elle se comporte de la même manière qu'un `INSERT` et un `UPDATE` : le système va vérifier si la ou les clé(s) primaire(s) définie(s) dans la struture `struct` ou la table interne `itab` existe(nt) dans la table de la base de données `sbtab`. Si celle-ci existe, alors la ligne sera modifiée (`UPDATE`), sinon, elle sera créée (`INSERT`). Dans la majorité des cas, la variable système [SY-SUBRC](../../99%20-%20Help/02%20-%20SY-SYSTEM.md) sera égale à `0`.
