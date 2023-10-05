# **PROGRAMMATION**

## **KEYS**

```ABAP
DATA: lt_table { TYPE { [STANDARD] | [SORTED] | [HASHED] } TABLE OF ty_table}  
               [ WITH { [UNIQUE | NON-UNIQUE] } primary_key ]  
               [ WITH secondary_key1 ] [ WITH secondary_key2 ].
```

## **PRIMARY KEY**

```ABAP
... [UNIQUE | NON-UNIQUE] KEY ...
```

Deux types de clés primaires peuvent être déclarées : **UNIQUE** et **NON-UNIQUE** et comme leur nom l’indique, elles autorisent ou non les doublons, dans la table interne, de données de même clé.

_Exemple_

```ABAP
TYPES: BEGIN OF ty_citizen, 
         country TYPE char3, 
         name    TYPE char20, 
         age     TYPE numc2, 
       END OF ty_citizen. 
 
DATA: lt_citizen TYPE HASHED TABLE OF ty_citizen 
          WITH UNIQUE KEY country.
```

La référence *TY_CITIZEN* est créée contenant trois champs : **COUNTRY**, de type **CHAR3**, **NAME**, de type **CHAR20**, et **AGE**, de type **NUMC2**. La table interne **LT_CITIZEN** est ensuite déclarée de type **HASHED** ayant une **clé primaire unique** définie par le champ **COUNTRY**. 

Ainsi, lorsque les données seront renseignées, il sera **impossible** d’insérer deux lignes avec la même valeur pour le champ **COUNTRY** (code retour **SY-SUBRC** égal à **4** et la table interne n’est pas mise à jour avec le deuxième enregistrement), alors que le type **NON-UNIQUE** laisse le cas se produire.

Cependant chaque type de table interne a sa règle concernant la clé primaire :

+ **STANDARD** : clé primaire **facultative** et uniquement de type **NON-UNIQUE**.

+ **HASHED** : clé primaire **obligatoire** et uniquement de type **UNIQUE**.

+ **SORTED** : clé primaire **obligatoire** et peut être de type **UNIQUE** ou **NON-UNIQUE**.

## **SECONDARY KEY**

```ABAP
... {UNIQUE HASHED} | {UNIQUE SORTED} | {NON-UNIQUE SORTED} KEY key_name COMPONENTS comp1 comp2 ...
```

Trois types de clés secondaires sont permises :

+ **UNIQUE HASHED** pour une clé secondaire de type **HASHED** et donc de caractéristique unique (enregistrement de doublons impossible) et pour laquelle il n’existera pas d’index.

+ **UNIQUE SORTED** pour une clé secondaire de type **SORTED** avec la possibilité de la déclarer unique (enregistrement de doublons impossible) et pour laquelle un index existe.

+ **NON-UNIQUE SORTED** pour une clé secondaire de type **SORTED** avec la possibilité de la déclarer non unique (enregistrement de doublons possible) et pour laquelle un index existe.

Une fois le type de clé secondaire défini, un nom peut lui être attribué (**key_name**) ainsi que la liste des composants qui la définissent (**comp1**, **comp2**...).

```ABAP
TYPES: BEGIN OF ty_citizen, 
         country TYPE char3, 
         name    TYPE char20, 
         age     TYPE numc2, 
       END OF ty_citizen. 
 
DATA: t_citizen TYPE SORTED TABLE OF ty_citizen
          WITH NON-UNIQUE    KEY country name 
          WITH UNIQUE HASHED KEY key2 COMPONENTS name age.
```

La référence **TY_CITIZEN** est créée contenant trois champs : **COUNTRY**, de type **CHAR3**, **NAME** de type **CHAR20**, et **AGE**, de type **NUMC2**. La table interne **T_CITIZEN** est ensuite déclarée de type **SORTED** ayant une clé primaire non unique définie par les champs **COUNTRY** et **NAME**. Elle possède également une clé secondaire de type **HASHED** et donc unique, de nom **KEY2** et définie par les champs **NAME** et **AGE**.

Ainsi, lorsque les données seront renseignées, il sera possible d’insérer des doublons pour la combinaison de champs **COUNTRY / NAME**, mais doublon impossible pour la combinaison de champs **NAME / AGE**. Individuellement, il n’y a pas de restriction pour les champs **NAME**, **AGE** et **COUNTRY**. Chacun d’eux pourra avoir des données en doublon. C’est essentiellement la combinaison des champs qui est importante ici.