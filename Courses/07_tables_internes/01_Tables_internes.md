# **`TABLES INTERNES`**

Une `table interne` est un `objet` dans un programme permettant de stocker des données le temps de l’exécution dudit programme.

Elle se déclare de la façon suivante :

```JS
TYPES: BEGIN OF ty_tab,
         obj1 TYPE dtel1,
         obj2 TYPE dtel2,
         obj3 TYPE dtel3,
         . . .
       END OF ty_tab.

DATA: it_tab_types TYPE TABLE OF ty_tab,
      wa_tab_types TYPE ty_tab.
```

Un `type de structure` est tout d’abord créé, c’est une sorte de squelette qui sera utilisé comme une référence par la table interne `IT_TAB_TYPES` avec l’instruction `TYPE TABLE OF`, et la `structure WA_TAB_TYPES` avec `TYPE`.

L’instruction commence par la commande `TYPES` puis `BEGIN OF` indiquant qu’un type de structure va être créé. Les champs qui la composent sont ensuite listés et référencés. Cette référence à une spécificité technique, peut se faire de plusieurs manières.

Il n'y a pas vraiment de grandes différences aussi bien techniques que pour l’optimisation du programme.

## **REFERENCE DIRECT à un TYPz de champ et une LONGUEUR**

```JS
. . .
  obj1(5) TYPE c,
  obj2(4) TYPE n,
. . .
```

## **REFERENCE DIRECT à un ELEMENT DE DONNEES**

```JS
. . .
  obj1 TYPE char5,
  Obj2 TYPE numc4,
. . .
```

## **REFERENCE INDIRECT à un ELEMENT DE DONNEES via le nom d’une table et son champ**

```JS
. . .
  obj1 TYPE zdriver_car-driver_id,
  Obj2 TYPE zdriver_car-car_year,
. . .
```

## **REFERENCE INDIRECT avec le LIKE**

```JS
. . .
  obj1 LIKE char5,
  Obj2 LIKE numc4,
. . .
```

```JS
. . .
  obj1 LIKE zdriver_car-driver_id,
  Obj2 LIKE zdriver_car-car_year,
. . .
```

## **DECLARATION DE VARIABLE**

Pour faire une petite parenthèse, une `variable` et une `constante` peuvent se déclarer exactement de la même façon. Cette notion n’a pas été évoquée dans le chapitre adéquat (Instructions basiques ABAP - Variables et constantes), car certaines connaissances primordiales, comme les éléments de données devaient être détaillées avant. Ainsi, pour reprendre un exemple dudit chapitre, les variables peuvent se déclarer de cette manière :

```JS
DATA: v_name  TYPE char20,
      v_date  TYPE datum,
      v_hour  TYPE uzeit,
      v_year  TYPE numc4.
```

_ou..._

```JS
DATA: v_name  TYPE zdriver_car-name,
      v_date  TYPE sy-datum,
      v_hour  TYPE sy-uzeit,
      v_year  TYPE zdriver_car-car_year.
```

_etc..._

Le problème avec cette déclaration est que la table interne ne possède pas d’en-tête. Un en-tête stocke temporairement une ligne de la table interne lorsque celle-ci est lue ligne par ligne dans une boucle. Cependant, la notion d’en-tête est aujourd’hui obsolète sur SAP et il faudra toujours stocker ces informations temporaires dans un objet de résultat (voir sections suivantes).

À noter, dans les anciennes versions de SAP, il est possible de trouver les déclarations suivantes (obsolètes aujourd’hui dans les nouvelles versions) :

```JS
DATA: BEGIN OF ty_tab OCCURS 0,
        obj1 TYPE dtel1,
        obj2 TYPE dtel2,
        obj3 TYPE dtel3,
        . . .
      END OF ty_tab.
```

```JS
TYPES: BEGIN OF ty_tab,
         obj1 TYPE dtel1,
         obj2 TYPE dtel2,
         obj3 TYPE dtel3,
         . . .
       END OF ty_tab.

DATA: it_tab_types TYPE TABLE OF ty_tab WITH HEADER LINE.
```

Ces tables internes possèdent dès leur déclaration une ligne d’`en-tête`, il est donc inutile de créer une structure associée car lors de la `lecture` de la table ou durant une `boucle`, le programme utilisera cet `en-tête` pour stocker et manier les données.
