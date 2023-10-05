# **PROGRAMMATION**

## **DELETE LINES**

```ABAP
DELETE lt_table [FROM idx1] [TO idx2] [WHERE log_exp].
```
Dans ce cas, l’instruction **DELETE** possède deux options : 

+ Suppression de plusieurs lignes à partir d’un index de ligne (**FROM idx1**) et/ou jusqu’à un index de ligne (**TO idx2**)

+ mais peut aussi contenir une clause **WHERE** pour affiner la suppression.

_Exemple_

Suppression des lignes 2 à 3 de la table interne **LT_CITIZEN** où le champ **COUNTRY** est égal à **’BR’**.

```ABAP
TYPES: BEGIN OF ty_citizen, 
         country TYPE char3, 
         name    TYPE char20, 
         age     TYPE numc2, 
       END OF ty_citizen. 
 
DATA: lt_citizen TYPE TABLE OF ty_citizen WITH NON-UNIQUE KEY country, 
      ls_citizen TYPE ty_citizen. 
 
ls_citizen-country = 'FR'. 
ls_citizen-name    = 'Thierry'. 
ls_citizen-age     = '24'. 
APPEND ls_citizen TO lt_citizen. 
 
ls_citizen-country = 'ES'. 
ls_citizen-name    = 'Luis'. 
ls_citizen-age     = '32'. 
APPEND ls_citizen TO lt_citizen. 
 
ls_citizen-country = 'BR'. 
ls_citizen-name    = 'Renata'. 
ls_citizen-age     = '27'. 
APPEND ls_citizen TO lt_citizen. 
 
ls_citizen-country = 'FR'. 
ls_citizen-name    = 'Floriane'. 
ls_citizen-age     = '32'. 
APPEND ls_citizen TO lt_citizen. 
 
DELETE lt_citizen FROM 2 TO 3 WHERE country = 'BR'.
```

LT_CITIZEN avant DELETE :

| **COUNTRY** | **NAME** | **AGE** |
|-------------|----------|---------|
| FR          | Thierry  | 24      |
| ES          | Luis     | 32      |
| BR          | Renata   | 27      |
| FR          | Floriane | 32      |

LT_CITIZEN après DELETE :

| **COUNTRY** | **NAME** | **AGE** |
|-------------|----------|---------|
| FR          | Thierry  | 24      |
| ES          | Luis     | 32      |
| BR          | Renata   | 27      |