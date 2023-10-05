# **PROGRAMMATION**

## **SORT**

```ABAP
SORT itab [ASCENDING|DESCENDING] [AS text] [STABLE] 
  BY c1 [ASCENDING|DESCENDING] [AS text] 
  ... 
  cn [ASCENDING|DESCENDING] [AS text].
```

L’instruction **SORT** permet d’organiser une table interne de type **STANDARD** ou **HASHED** **lt_table** selon sa clé primaire ou une liste de composants (**c1** à **cn**). 

+ Les options **ASCENDING** et **DESCENDING** définissent un tri par ordre croissant ou décroissant

+ **AS TEXT** donne la possibilité pour les champs de type chaîne de caractères d’être triés par une langue définie en local par l’instruction **SET LOCALE LANGUAGE** (par défaut, la langue utilisée est celle définie par l’utilisateur).

Lorsque l’ordre de tri n’est pas spécifié par un **BY** et qu’aucune clé primaire n’est définie, le **SORT** va ordonner la table interne d’une manière pouvant être aléatoire et instable, pouvant donner des résultats différents à chaque fois. C’est pour cela que l’option **STABLE** est utilisée, afin de retourner toujours le même résultat et de ne pas avoir de mauvaise surprise.

Le **SORT** est utilisable uniquement sur les tables internes de type **STANDARD** ou **HASHED**, et donc impossible pour une table interne de type **SORTED** ayant déjà par définition, un ordre de tri prédéfini et inaltérable.

### **STANDARD TABLE**

```ABAP
TYPES: BEGIN OF ty_citizen, 
         country TYPE char3, 
         name    TYPE char20, 
         age     TYPE numc2, 
       END OF ty_citizen. 
 
DATA: lt_citizen TYPE STANDARD TABLE OF ty_citizen, 
      ls_citizen  TYPE ty_citizen. 
 
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
 
SORT lt_citizen DESCENDING. 
SORT lt_citizen BY country ASCENDING age DESCENDING.
```

LT_CITIZEN avant le premier SORT :

| **COUNTRY** | **NAME** | **AGE** |
|-------------|----------|---------|
| FR          | Thierry  | 24      |
| ES          | Luis     | 32      |
| BR          | Renate   | 27      |
| FR          | Floriane | 32      |

LT_CITIZEN après le premier SORT :

| **COUNTRY** | **NAME** | **AGE** |
|-------------|----------|---------|
| FR          | Thierry  | 24      |
| FR          | Floriane | 32      |
| ES          | Luis     | 32      |
| BR          | Renate   | 27      |

LT_CITIZEN après le second SORT :

| **COUNTRY** | **NAME** | **AGE** |
|-------------|----------|---------|
| BR          | Renate   | 27      |
| ES          | Luis     | 32      |
| FR          | Floriane | 32      |
| FR          | Thierry  | 24      |