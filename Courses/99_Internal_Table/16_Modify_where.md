# **PROGRAMMATION**

## **MODIFY WHERE**

```ABAP
MODIFY lt_table FROM ls_table TRANSPORTING comp1 comp2 ... WHERE cond.
```

Pour cette instruction, le **MODIFY** va utiliser une clause **WHERE** pour spécifier la ligne de la table interne **lt_table** à modifier à partir de la structure **ls_table**.

```ABAP
TYPES: BEGIN OF ty_country, 
         land   TYPE char3, 
         age(3) TYPE i, 
       END OF ty_country. 
 
DATA: lt_country TYPE HASHED TABLE OF ty_country WITH UNIQUE KEY land, 
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

CLEAR ls_country-land. 
ls_country-age  = 10.

MODIFY lt_country FROM ls_country TRANSPORTING age WHERE land = 'IT'.
```

LT_COUNTRY avant le MODIFY :

| **LAND** | **AGE** |
|----------|---------|
| FR       | 28      |
| IT       | 75      |

LT_COUNTRY après le MODIFY :

| **LAND** | **AGE** |
|----------|---------|
| FR       | 28      |
| IT       | 10      |