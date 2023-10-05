# **PROGRAMMATION**

## **READ**

```ABAP
READ TABLE lt_table  
  { FROM ls_tableA } | WITH KEY { comp1 = obj1 comp2 = obj2 ... [BINARY SEARCH] | INDEX idx } 
  { INTO ls_tableB } | {ASSIGNING <fs>} | {TRANSPORTING NO FIELDS }. 
```

Le **READ TABLE** permet de lire une ligne de la table interne lt_table. Cette opération s’effectue :

+ Soit en définissant une structure source contenant les valeurs des champs à lire (**FROM ls_tableA**)

+ Soit en définissant directement des valeurs pour des composants (**WITH KEY comp1 = obj1...**)

+ Soit en lisant directement une ligne via son index (**INDEX idx**).

De plus, le résultat peut :

+ Etre stocké dans une structure (**INTO ls_tableB**)

+ Etre stocké dans un field symbol (**ASSIGNING <fs>**)

+ Ne pas être stocké afin de vérifier seulement si la ligne existe (**TRANSPORTING NO FIELDS**), en mettant à jour les variables système **SY-SUBRC** (code retour) et **SY-TABIX** (index de la table retourné par la recherche). Ces paramètres sont obligatoires pour des tables n’ayant pas d’en-tête (voir plus de détail après l’exemple).

D’une vision très générale, un **field symbol** (appelé **pointeur** en français dans la plupart des cas) est un type de variable faisant référence à la zone mémoire d’une structure, table interne... et qui est déclaré par la commande **FIELD-SYMBOLS**. 

Non seulement son utilisation diminue considérablement le temps de traitement mais en plus, faisant référence directement à une zone mémoire, elle peut modifier directement la valeur de celle-ci (sans utiliser des instructions comme **MODIFY** dans le cas d’une table interne...). L’allocation à une zone mémoire se fait par la commande **ASSIGN** ou **ASSIGNING**.

Lors de l’utilisation du **READ TABLE WITH KEY**, il est fortement recommandé d’utiliser l’option **BINARY SEARCH**, car cela favorisera une recherche binaire de la table améliorant ainsi les performances du programme.

Une recherche binaire répond à l’algorithme suivant :

+ Si elle est égale à la valeur recherchée, alors l’index de la ligne est retourné et la recherche est terminée.

+ Sinon, si elle est supérieure à la valeur recherchée, la moitié inférieure sera isolée, puis de nouveau le programme regardera la valeur du milieu de cette moitié, si elle est égale à la valeur recherchée....

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

ls_citizen-country = 'BR'. 
ls_citizen-name    = 'Renata'. 
ls_citizen-age     = '27'. 
READ TABLE lt_citizen ASSIGNING <fs_citizen> FROM ls_citizen. 
IF sy-subrc = 0. 
  WRITE: 'READ FROM structure :'. 
  WRITE:/ <fs_citizen>-country, <fs_citizen>-name, <fs_citizen>-age. 
ENDIF.

ULINE.

READ TABLE lt_citizen INTO ls_citizen INDEX 4. 
IF sy-subrc = 0. 
  WRITE:/ 'READ INDEX :'. 
  WRITE:/ ls_citizen-country, ls_citizen-name, ls_citizen-age. 
ENDIF.

ULINE.

SORT lt_citizen BY country. 
READ TABLE lt_citizen WITH KEY country = 'ES' BINARY SEARCH TRANSPORTING NO FIELDS. 
IF sy-subrc = 0. 
  WRITE:/ 'READ WITH KEY :'. 
  WRITE:/ 'Il existe un enregistrement avec le champ COUNTRY égal à ''ES'' 
à la ligne :', sy-tabix. 
ENDIF.
```

### **HEADER**

si la table interne **LT_CITIZEN** est déclarée de cette manière :

```ABAP
DATA: t_citizen TYPE STANDARD TABLE OF ty_citizen WITH HEADER LINE, 
```

Et que le **READ TABLE** suivant est exécuté :

```ABAP
DATA: lt_citizen TYPE STANDARD TABLE OF ty_citizen WITH HEADER LINE, 
```

Alors le résultat est automatiquement stocké dans la ligne d’en-tête de la table interne. Les deux schémas suivants montrent la différence entre la table interne LT_CITIZEN avec en-tête et sans en-tête (et utilisation d’une structure en parallèle) :

[Schéma - Table interne avec header](https://drive.google.com/file/d/1rC0rfRWnBmRwtgLvLQBsXTmahKFuzlOI/view?usp=share_link)

[Schéma - Table interne sans header](https://drive.google.com/file/d/1CrvKF5ZAEjmrkL2LFpBTKK4CQ_cuvpkz/view?usp=share_link)