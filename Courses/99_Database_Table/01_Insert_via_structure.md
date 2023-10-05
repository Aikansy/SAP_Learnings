# **PROGRAMMATION**

## **INSERT VIA FUNCTION**

Cette requête permet d’ajouter une ou plusieurs lignes à la table de la base de données soit via une structure, soit via une table interne, et de mettre à jour deux variables système :

+ SY-SUBRC pour indiquer l’état de l’opération :

    - 0 - la ou les lignes ont été correctement insérées.
    - 4 - une ou plusieurs erreurs se sont produites pendant le traitement.

+ SY-DBCNT retourne le nombre de lignes insérées

```ABAP
INSERT INTO dbtab VALUES struct.
```

Le système va tout d’abord vérifier que la clé primaire de l’enregistrement contenu dans la structure struct n’existe pas dans la table de base de données dbtab, pour ainsi l’insérer et retourner un code retour à 0. Si la clé primaire existe, l’enregistrement ne sera pas ajouté et le code retour sera égal à 4.

_Exemple_

Insérer un nouveau passager dans la table ZPASSENGER.

```ABAP
DATA: ls_passager TYPE zpassenger. 
 
ls_passager-id_passenger = 'P0005'. 
ls_passager-surname      = 'THIERRY'. 
ls_passager-name         = 'ROMAIN'. 
ls_passager-date_birth   = '19930324'. 
ls_passager-city         = 'MONTPELLIER'. 
ls_passager-country      = 'FR'. 
ls_passager-lang         = 'F'. 
 
INSERT INTO zpassenger VALUES ls_passager. 
 
IF sy-subrc = 0. 
  WRITE 'Nouvel enregistrement créé avec succès'. 
ELSE. 
  WRITE 'Echec lors de la création d''un nouvel enregistrement'. 
ENDIF.
```

Enregistrement inséré

| **ID_PASS** | **SURNAME** | **NAME** | **DATE_BIRTH** | **CITY**    | **COUNTRY** | **LANG** |
|-------------|-------------|----------|----------------|-------------|-------------|----------|
| P0005       | THIERRY     | ROMAOIN  | 19930324       | MONTPELLIER | FR          | F        |