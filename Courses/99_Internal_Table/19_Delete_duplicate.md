# **PROGRAMMATION**

## **DELETE DUPLICATE LINES**

```ABAP
DELETE ADJACENT DUPLICATES FROM lt_table [COMPARING {comp1 comp2 ...}].
```
L’instruction **DELETE ADJACENT DUPLICATES** va repérer toutes les lignes en doublon, et les supprimer. Si aucun champ n’est défini par le paramètre **COMPARING**, elle va utiliser la clé primaire définie lors de la déclaration de la table.

Pour que le **DELETE ADJACENT DUPLICATES** fonctionne, il est impératif que la table soit ordonnée selon une clé primaire ou une liste de champs spécifiés.

### **SORTED TABLE**

Supprimer tous les doublons d’une table interne de type **SORTED** ayant pour clé primaire le champ **COUNTRY**.

```ABAP
TYPES: BEGIN OF ty_citizen, 
         country TYPE char3, 
         name    TYPE char20, 
         age     TYPE numc2, 
       END OF ty_citizen. 
 
DATA: lt_citizen TYPE SORTED TABLE OF ty_citizen WITH NON-UNIQUE KEY country, 
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
 
DELETE ADJACENT DUPLICATES FROM lt_citizen.
```

LT_CITIZEN avant DELETE :

| **COUNTRY** | **NAME** | **AGE** |
|-------------|----------|---------|
| BR          | Renate   | 27      |
| ES          | Luis     | 32      |
| FR          | Floriane | 32      |
| FR          | Thierry  | 24      |

LT_CITIZEN après DELETE :

| **COUNTRY** | **NAME** | **AGE** |
|-------------|----------|---------|
| BR          | Renate   | 27      |
| ES          | Luis     | 32      |
| FR          | Floriane | 32      |

### **STANDARD TABLE**

```ABAP
TYPES: BEGIN OF ty_citizen, 
         country TYPE char3, 
         name    TYPE char20, 
         age     TYPE numc2, 
       END OF ty_citizen. 
 
DATA: lt_citizen TYPE TABLE OF ty_citizen, 
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
 
SORT lt_citizen BY country. 
DELETE ADJACENT DUPLICATES FROM lt_citizen COMPARING country.
```

Pour une table interne de type **STANDARD**, le tri doit s’effectuer avec l’instruction **SORT** (cf. section suivante Organisation et Lecture) et le **DELETE ADJACENT DUPLICATES** doit suivre exactement les mêmes nombre et séquence que le **SORT**.

LT_CITIZEN avant DELETE :

| **COUNTRY** | **NAME** | **AGE** |
|-------------|----------|---------|
| BR          | Renate   | 27      |
| ES          | Luis     | 32      |
| FR          | Floriane | 32      |
| FR          | Thierry  | 24      |

LT_CITIZEN après DELETE :

| **COUNTRY** | **NAME** | **AGE** |
|-------------|----------|---------|
| BR          | Renate   | 27      |
| ES          | Luis     | 32      |
| FR          | Floriane | 32      |

