# **`UPDATE DBTAB`**

Ce type de requête permet de mettre à jour une ou plusieurs lignes de la table de la base de données de trois manières différentes, et mettra à jour deux variables système :

- [SY-SUBRC](../../99%20-%20Help/02%20-%20SY-SYSTEM.md) pour indiquer l'état de l'opération :
  - 0 - la ou les lignes ont été correctement insérées.
  - 4 - une ou plusieurs erreurs se sont produites pendant le traitement.
- [SY-DBCNT](../../99%20-%20Help/02%20-%20SY-SYSTEM.md) retourne le nombre de ligne insérées

```JS
UPDATE dbtab FROM TABLE itab [ACCEPTING DUPLICATE KEYS].
```

Le système va tout d'abord vérifier que les clés primaires des enregistrements contenus dans la table interne `itab` n'existent pas dans la table de base de données `sbtab`, pour ainsi les insérer et retourner un code retour à 0. Si une des clés primaires existe déjà, le programme s'arrêtera et retournera un `dump`. Aucun enregistrement ne sera alors inséré.

Cependant, l'option, `ACCEPTING DUPLICATE KEYS`, permet de mettre de côté le ou les enregistrement(s) déjà existant(s) et d'insérer ceux qui n'existent pas, en retournant toutefois un code retour à 4/

Dans tous les cas, la variable [SY-DBCNT](../../99%20-%20Help/02%20-%20SY-SYSTEM.md) retournera le nombre de lignes insérées dans la table de la base de données.
