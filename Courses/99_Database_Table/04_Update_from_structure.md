# **PROGRAMMATION**

## **FROM STRUCTURE**

```ABAP
UPDATE dbtab FROM struct.
```

Cette instruction va mettre à jour la table de la base de données dbtab à partir de la structure wa. Pour cela, le système va chercher dans la table, l’enregistrement avec la même clé primaire définie dans la structure, et s’il ne trouve pas l’enregistrement, il retournera un code retour égal à **’4’**.

_Exemple_

Sélection d’un seul enregistrement de la table **ZTRAVEL** avec le conducteur utilisant l’identifiant **’C0001’**, puis ajout de 5 euros pour le péage et 10 pour l’essence.

```ABAP
CONSTANTS: lc_id_driver TYPE zdriver_id VALUE 'C0001'. 
 
SELECT SINGLE * 
  FROM ztravel 
  INTO @DATA(ls_travel) 
  WHERE id_driver = @lc_id_driver. 
 
IF sy-subrc = 0. 
 
  ls_travel-toll  = ls_travel-toll  + 5. 
  ls_travel-gasol = ls_travel-gasol + 10. 
 
  UPDATE ztravel FROM ls_travel. 
 
  IF sy-subrc = 0. 
    WRITE 'Mide à jour réussie'. 
  ELSE. 
    WRITE 'Echec de la mise à jour'. 
  ENDIF.  
 
ENDIF.
```

La constante **LC_ID_DRIVER** est créée avec le type **ZDRIVER_ID** et contient la valeur **’C0001’**. Le programme va commencer par sélectionner tout d’abord l’enregistrement souhaité avec un **SELECT SINGLE** dont le résultat sera stocké dans la structure **LS_TRAVEL**. Il va ensuite vérifier qu’il n’y a pas eu de problème et que le code retour de la variable système **SY-SUBRC** est bien égal à 0 (pour rappel, 0 tout va bien, 4 aucune donnée n’a été trouvée). Les champs **TOLL** et **GASOL** vont ensuite être calculés, et enfin la table **ZTRAVEL** sera mise à jour avec la structure **LS_TRAVEL**. Le code retour est une fois de plus testé pour vérifier si la mise à jour s’est bien terminée : 0 le programme affichera le texte ’Mise à jour réussie’, sinon le texte ’Echec de la mise à jour’.

Enregistrement avant UPDATE

| **ID_DRIVER** | **TOLL** | **GASOL** |
|---------------|----------|-----------|
| C0001         | 16.00    | 40.21     |

Enregristrement après UPDATE

| **ID_DRIVER** | **TOLL** | **GASOL** |
|---------------|----------|-----------|
| C0001         | 21.00    | 50.21     |
