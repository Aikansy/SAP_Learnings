# **`ATTRIBUTS`**

Les attributs regroupent les différentes variables, constantes... de la classe. Les informations les caractérisant sont les suivantes :

![](../../00_Ressources/11_Classes%20-%2005%20-%2001.png)

- `Attribut` :

  nom de l’attribut.

- `Type` :

  définit le type de l’attribut et peut prendre les valeurs suivantes :

  - `Instance Attribute` :

    (attribut d’instance) correspondant au DATA dans un programme ABAP (cf. chapitre Instructions basiques ABAP - Variables et constantes).

  - `Static Attribute` :

    (attribut statique) permet de déclarer une classe ou une interface comme attribut.

  - `Constant` :

    (constante) correspond au CONSTANTS dans un programme ABAP (cf. chapitre Instructions basiques ABAP - Variables et constantes).

- `Visibilité` :

  définit la visibilité de la variable, à savoir :

  - `Public` :

    (publique) : la variable est visible par tous aussi bien dans la classe même (ainsi que ses amis), que par les héritiers, mais aussi par les objets techniques externes (classes, interfaces programmes ABAP, fonctions...).

  - `Protected` :

    (protégé) : la variable est visible dans la classe même (ainsi que ses amis), par les héritiers, mais pas par les objets techniques externes (classes, interfaces programmes ABAP, fonctions...).

  - `Private` (privé) :

    la variable n’est visible que par la classe même ainsi que ses amis, mais ni par ses héritiers ni par les objets techniques externes (classes, interfaces programmes ABAP, fonctions...).

- `Lecture` :

  définit si la variable est en lecture seule ou peut être modifiable.

- `Catégorisation` :

  là aussi, peut prendre différentes valeurs comme déjà vu dans les chapitres précédents (notamment Instructions basiques ABAP - Variables et constantes et Dictionnaire de données (DDIC) - Structures et Tables) :

  - `Like` :

    fait référence indirectement au type d’une autre variable, constante...

  - `Type` :

    fait référence à un type de données (en général, un élément de données).

  - `Type Ref To` :

    fait référence au type de référence défini dans l’élément de données (cf. chapitre Dictionnaire de données (DDIC) - Éléments de données) ou à une classe ou une interface.

  - `Type... Boxed` :

    même chose que Type sauf que le champ, ayant une valeur initiale définie, aura une mémoire qui lui sera allouée seulement lors d’un changement de cette valeur au contraire d’un champ Type qui, lui, aura une mémoire allouée dès le début du traitement.

- `Type réf.` :

  sera renseigné avec le nom de la référence.

- La `flèche dans la colonne suivante` :

  permettra de renseigner directement les caractéristiques de l’attribut dans un éditeur ABAP.

- `Description`

- `Valeur initiale` :

  obligatoire pour les attributs de type constante.
