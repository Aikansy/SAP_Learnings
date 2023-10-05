# **PROGRAMMATION**

## **MODIFY AVEC INDEX**

```ABAP
MODIFY lt_table [INDEX idx] FROM ls_table [TRANSPORTING comp1 comp2 ...].
```

L’instruction **MODIFY** va modifier la table interne **lt_table** à partir de la structure **ls_table**. Il est possible d’indiquer l’index de la ligne à modifier (**INDEX idx**) ainsi que la liste des champs spécifiques à modifier (**TRANSPORTING comp1 comp2...**).

_Exemple_

Pour cet exemple, le type de table a été modifié de **HASHED** à **STANDARD**, car celui-ci n’ayant pas d’index, l’option utilisée dans le **MODIFY** générerait un **dump**.

```ABAP
TYPES: BEGIN OF ty_country, 
         land   TYPE char3, 
         age(3) TYPE i, 
       END OF ty_country. 
 
DATA: lt_country TYPE STANDARD TABLE OF ty_country WITH NON-UNIQUE KEY land, 
      ls_country TYPE ty_country. 
 
ls_country-land = 'FR'. 
ls_country-age  = 23. 
COLLECT ls_country INTO lt_country. 
 
ls_country-land = 'IT'. 
ls_country-age  = 20. 
COLLECT ls_country INTO lt_country. 
 
ls_country-land = 'IT'. 
ls_country-age  = 55. 
COLLECT ls_country INTO lt_country. 
 
ls_country-land = 'FR'. 
ls_country-age  = 5. 
COLLECT ls_country INTO lt_country. 
 
ls_country-land = 'FR'. 
ls_country-age  = 10. 
MODIFY lt_country INDEX 1 FROM ls_country TRANSPORTING age.
```

**LT_COUNTRY** avant le **MODIFY** :

| **LAND** | **AGE** |
|----------|---------|
| FR       | 28      |
| IT       | 75      |

**LT_COUNTRY** après le **MODIFY** :

| **LAND** | **AGE** |
|----------|---------|
| FR       | 10      |
| IT       | 75      |