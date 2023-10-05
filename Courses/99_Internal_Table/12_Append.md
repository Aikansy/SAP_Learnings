# **PROGRAMMATION**

## **APPEND**

```ABAP
APPEND ls_table | {INITIAL LINE} | {LINES OF lt_tableA [FROM idx1] [TO idx2]} ...  
  TO lt_tableB.
```

L’instruction **APPEND** possède les mêmes options que l’instruction **INSERT** à part pour le paramètre de destination, qui sera toujours une **table interne** avec **TO lt_tableB**.

L’instruction **APPEND** fonctionne pour les tables de type **STANDARD** et **RANGE**.

Il est possible d’utiliser l’instruction **APPEND** avec les types de tables internes **SORTED** mais comme l’append insère toujours une ligne en fin de table, si l’enregistrement inséré modifie l’ordre défini par la clé primaire, alors le programme retournera un **dump**.

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

ls_citizen-country = 'ES'. 
ls_citizen-name    = 'Luiza'. 
ls_citizen-age     = '31'. 
APPEND s_citizen TO lt_citizen1. 
 
ls_citizen-country = 'BR'. 
ls_citizen-name    = 'Felipe'. 
ls_citizen-age     = '25'. 
APPEND s_citizen TO lt_citizen1.
```

| **COUNTRY** | **NAME** | **AGE** |
|-------------|----------|---------|
| BR          | Renata   | 27      |
| FR          | Floriane | 32      |
|             |          |         |
| FR          | Thierry  | 24      |
| ES          | Luiza    | 31      |
| BR          | Felipe   | 25      |