# **PROGRAMMATION**

## **DELETE**

Cette requête permet de supprimer une ou plusieurs lignes de la table de base de données soit via une structure, soit via une table interne, et de mettre à jour deux variables système :

**SY-SUBRC** indique l’état de l’opération :

+ 0 - la ou les lignes ont été correctement mises à jour.

+ 4 - une ou plusieurs erreurs se sont produites pendant le traitement.

**SY-DBCNT** retourne le nombre de lignes supprimées

```ABAP
DELETE dbtab FROM struct.  
DELETE dbtab FROM TABLE lt_table.
```

La logique est la même que pour un **INSERT** ou un **UPDATE** : le système va vérifier si la (ou les) clé(s) primaire(s) définie(s) dans la structure struct ou la table interne **lt_table** existe(nt) dans la table de la base de données **dbtab**. Si celle-ci existe, alors la ligne sera supprimée, sinon elle sera mise de côté et retournera la variable de retour **SY-SUBRC** à **4**.

Il existe également une autre manière de procéder à un **DELETE** avec la clause **WHERE**.

```ABAP
DELETE FROM dbtab WHERE...
```

_Exemple_

Supprimer le passager avec l’identifiant **’P0005’** dans la table **ZPASSENGER**.

```ABAP
CONSTANTS: lc_user_id TYPE zpassenger_id VALUE 'P0005'. 
 
DELETE FROM zpassenger WHERE id_passenger = @lc_user_id. 
 
IF sy-subrc = 0. 
  WRITE 'L''enregistrement a été supprimé avec succès'. 
ELSE. 
  WRITE 'Erreur lors de la suppression d''un enregistrement'. 
ENDIF.
```

La constante **LC_USER_ID** de type **ZUSER_ID** et avec comme valeur **’P0005’** est créée. La requête **DELETE** supprimera la ou les lignes de la table **ZPASSENGER** ayant pour champ **ID_PASS** égal à la constante. La variable **SY-SUBRC** étant égale à 0, le texte ’L’enregistrement a été supprimé avec succès’ sera affiché et **SY-DBCNT** sera égal à **’1’**.