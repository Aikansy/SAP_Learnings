# **PROGRAMMATION**

## **MODIFY**

Cette requête permet de modifier une ou plusieurs lignes de la table de base de données soit via une structure, soit via une table interne, et de mettre à jour deux variables système :

+ **SY-SUBRC** indique l’état de l’opération

+ **SY-DBCNT** retourne le nombre de lignes modifiées

```ABAP
MODIFY dbtab FROM struct.  
MODIFY dbtab FROM TABLE lt_table.
```

Elle se comporte de la même manière qu’un **INSERT** et un **UPDATE** : le système va vérifier si la ou les clé(s) primaire(s) définie(s) dans la structure struct ou la table interne **lt_table** existe(nt) dans la table de la base de données dbtab. Si celle-ci existe, alors la ligne sera modifiée (**UPDATE**), sinon elle sera créée (**INSERT**). Dans la majorité des cas, la variable système **SY-SUBRC** sera égale à 0.