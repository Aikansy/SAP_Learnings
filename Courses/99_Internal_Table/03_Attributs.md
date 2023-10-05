# **PROGRAMMATION**

## **ATTRIBUTS DE TABLE**

### **TYPES DE TABLES**

```ABAP
DATA: lt_table { TYPE { [STANDARD] | SORTED | HASHED } TABLE OF ty_table}  
               [ WITH primary_key ]  
               [ WITH secondary_key1 ] [ WITH secondary_key2 ].
```

+ **TYPE REF TO** ou **STANDARD TABLE OF**, est le type plus utilisé car il est le plus malléable : la table n’est pas ordonnée et peut l’être de différentes façons au cours du programme, elle peut comporter plusieurs clés, et est plus facile pour gérer les données, cependant c’est aussi celle qui consomme le plus de mémoire système.

+ **TYPE SORTED TABLE** est une table organisée par une clé de la table. Dans ce cas, il est nécessaire de déclarer une clé (instruction **WITH UNIQUE KEY** obligatoire). Elle contient également un **index** (voir plus de détail dans la suite de ce chapitre).

+ **TYPE HASHED TABLE** est une table organisée par une clé de la table (instruction **WITH UNIQUE KEY** obligatoire) mais ne contient pas d’index.

+ **TYPE RANGE OF** est une table interne un peu particulière car elle a déjà une structure définie dont les zones ci-dessous. Cette structure est utilisée comme **table interne d’intervalles de données**, utilisée dans les **requêtes SQL**. Aussi les champs d’un écran de sélection sont définis de la même manière.

    - **SIGN** de type **C** (_alphanumérique_) et de longueur d’une seule position, accepte les valeurs **I** (**Inclure**) ou **E** (**Exclure**).

    - **OPTION** de type **C** (_alphanumérique_) et de **longueur deux positions**, contient les valeurs définies dans le chapitre Instructions basiques ABAP - Instructions conditionnelles, à savoir **EQ** (égal), **NE** (différent), **GT** (strictement plus grand que), **GE** (plus grand ou égal), **LE** (inférieur ou égal), **LT** (strictement inférieur), **CP** (contient le modèle), **NP** (ne contient pas le modèle). Ce champ peut également prendre comme valeur **BT** (compris entre), et **NB** (non compris entre).

    - **LOW** intervalle inférieur dont le type et la longueur de champ varient selon la référence attribuée.

    - **HIGH** intervalle supérieur dont le type et la longueur de champ varient selon la référence attribuée.

```ABAP
DATA: lt_table TYPE STANDARD TABLE OF ty_table.
```

```ABAP
DATA: lt_table TYPE REF TO ty_table.
```

```ABAP
DATA: lt_table TYPE SORTED TABLE OF ty_table WITH UNIQUE KEY champ.
```

```ABAP
DATA: lt_table TYPE HASHED TABLE OF ty_table WITH UNIQUE KEY champ.
```

```ABAP
DATA: lr_table TYPE RANGE OF ty_table.
```