# **PROGRAMMATION**

## **INSERT VIA TABLE**

```ABAP
UPDATE dbtab FROM TABLE lt_table [ACCEPTING DUPLICATE KEYS].
```

Le système va tout d’abord vérifier que les **clés primaires** des enregistrements contenus dans la table interne **lt_table** n’existent pas dans la table de base de données **dbtab**, pour ainsi les insérer et retourner un code retour à 0. Si une des clés primaires existe déjà, le programme s’arrêtera et retournera un **dump**. Aucun enregistrement ne sera alors inséré. Cependant, l’option **ACCEPTING DUPLICATE KEYS**, permet de mettre de côté le ou les enregistrement(s) déjà existant(s) et d’insérer ceux qui n’existent pas, en retournant toutefois un code retour à 4. Dans tous les cas, la variable **SY-DBCNT** retournera le nombre de lignes insérées dans la table de la base de données.