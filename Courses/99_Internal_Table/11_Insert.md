# **PROGRAMMATION**

## **INSERT**

```ABAP
INSERT ls_table | {INITIAL LINE} | {LINES OF ls_tableA [FROM idx1] [TO idx2]} ...  
  INTO TABLE lt_tableB | {lt_tableB INDEX idx } ... 
```

L’instruction **INSERT** va insérer les données contenues dans une structure (**ls_table**), une ligne vide (**INITIAL LINE**), ou dans les lignes d’une autre table interne (**ls_tableA**), avec comme option la possibilité de spécifier les numéros de ligne à copier (**FROM idx1** / **TO idx2**). Elle va insérer ces enregistrements dans une table interne (**lt_tableB**), avec la possibilité d’indiquer leur ligne de destination.

Pour les tables internes de type **HASHED** et **SORTED**, il est obligatoire d’utiliser l’instruction **INSERT** ls_table **INTO TABLE** lt_tableB.

Pour tous les exemples ci-dessous, le programme 06_CODE_CITIZEN.txt liste tous les champs et les valeurs de la table interne T_CITIZEN.

```ABAP
TYPES: BEGIN OF ty_citizen, 
         country TYPE char3, 
         name    TYPE char20, 
         age     TYPE numc2, 
       END OF ty_citizen. 
 
DATA: lt_citizen1 TYPE TABLE OF ty_citizen, 
      lt_citizen2 TYPE TABLE OF ty_citizen, 
      ls_citizen TYPE ty_citizen. 
 
ls_citizen-country = 'FR'. 
ls_citizen-name    = 'Thierry'. 
ls_citizen-age     = '24'. 
INSERT ls_citizen INTO TABLE lt_citizen1. 

ls_citizen-country = 'ES'. 
ls_citizen-name    = 'Luis'. 
ls_citizen-age     = '32'. 
INSERT ls_citizen INTO TABLE lt_citizen2. 
 
ls_citizen-country = 'BR'. 
ls_citizen-name    = 'Renata'. 
ls_citizen-age     = '27'. 
INSERT ls_citizen INTO TABLE lt_citizen2. 
 
ls_citizen-country = 'FR'. 
ls_citizen-name    = 'Floriane'. 
ls_citizen-age     = '32'. 
INSERT ls_citizen INTO TABLE lt_citizen2. 
 
INSERT INITIAL LINE INTO lt_citizen1 INDEX 1. 
 
INSERT LINES OF lt_citizen2 FROM 2 TO 3 INTO lt_citizen1 INDEX 1.
```

Un premier enregistrement est tout d’abord inséré dans T_CITIZEN1, puis trois autres dans T_CITIZEN2. Une ligne vide sera ajoutée à l’index 1 de T_CITIZEN1 et enfin les enregistrements contenus aux lignes 2 et 3 de T_CITIZEN2 seront aussi ajoutés à l’index 1 de T_CITIZEN1. Au final, la table interne T_CITIZEN1 aura les enregistrements suivants :

| **COUNTRY** | **NAME** | **AGE** |
|-------------|----------|---------|
| BR          | Renata   | 27      |
| FR          | Floriane | 32      |
|             |          |         |
| FR          | Thierry  | 24      |