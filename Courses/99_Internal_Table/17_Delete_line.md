# **PROGRAMMATION**

## **DELETE LINE**

```ABAP
DELETE { 
  TABLE lt_table { FROM ls_table } | 
  { WITH TABLE KEY [keyname COMPONENTS]  
    {comp_name1|(name1)} = operand1 
    {comp_name2|(name2)} = operand2 
    ...} | 
  lt_table INDEX idx }
```

### **FROM LS_TABLE**

Suppression d’une ligne de la table interne lt_table à partir de la structure ls_table. Le système ira rechercher la clé primaire renseignée afin de supprimer les enregistrements souhaités.

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
 
CLEAR ls_citizen. 
ls_citizen-country = 'FR'. 
 
DELETE TABLE lt_citizen FROM ls_citizen.
```

L’instruction supprimera le premier enregistrement rencontré ayant pour clé **COUNTRY** égale à **’FR’**. Un **CLEAR** est effectué avant de renseigner de nouveau le champ afin de bien nettoyer la structure des valeurs renseignées.

### **FROM KEY ONLY**

Suppression d’une ligne de la table interne lt_table en renseignant un ou plusieurs composants.

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
 
CLEAR ls_citizen. 
ls_citizen-country = 'FR'. 
 
DELETE TABLE t_citizen WITH TABLE KEY country = 'FR'.
```

Ici encore, l’instruction supprimera le premier enregistrement rencontré ayant pour clé **COUNTRY** égale à **’FR’**. Il est nécessaire de renseigner la **clé entière** définie pour la table interne. Ici, il s’agit du champ **COUNTRY** uniquement et il n’est pas possible de renseigner plus ou d’autres champs à part ceux définis dans la clé de la table.

Si lors de la déclaration de la table interne, aucune clé n’est définie avec l’instruction **WITH NON-UNIQUE KEY** ou **WITH UNIQUE KEY**, lors du **DELETE** tous les champs doivent être renseignés après **WITH TABLE KEY**.

```ABAP
DELETE TABLE lt_citizen WITH TABLE KEY country = 'FR'  
                                       name    = 'Thierry'  
                                       age     = 24.
```