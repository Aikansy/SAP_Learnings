# **PROGRAMMATION**

## **COLLECT**

```ABAP
COLLECT ls_table INTO lt_tableB.
```

Avec l’instruction **COLLECT**, le système vérifiera si la clé contenue dans la structure ls_table existe dans la table interne. 

Si elle n’existe pas, une nouvelle ligne est insérée, sinon les valeurs numériques sont additionnées.

Pour une table interne composée uniquement de chaînes de caractères ou de champs numériques NUMC, le **COLLECT** s’avère inutile et il sera préférable d’utiliser **APPEND** ou **INSERT**. 

_Exemple_

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
```

Au final, la table interne T_COUNTRY aura les enregistrements ci-après.

| **LAND** | **AGE** |
|----------|---------|
| FR       | 28      |
| IT       | 75      |