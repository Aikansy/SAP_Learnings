# **`METHODES`**

Les éthodes sont des traitements membres d'une classe agissant sur un objet ou non. Dans l'onlet correspondant de l'éditeur de classe, les méthodes sont listées en suivant toujours la règle : celles en bleu viennent d'un héritage et celles en noir sont spécifiques à la classe.

![](../../99%20-%20Ressources/11_Classes%20-%2003%20-%2001%20-%2001.png)

- `Paramètre` sera détaillé dans la suite de cette section.

- `Exceptions` sera détaillée dans la suite de cette section.

- `Code srce` sera détaillées dans la suite de cette section.

- `Propriétés de la méthode`

- `Documentation` de la méthode

- `Cas d’emploi`

- `Insérer` une méthode

- `Supprimer `une méthode

- `Couper`

- `Copier`

- `Coller`

- `Trier` l’ordre d’affichage des méthodes

- `Rechercher` des noms de méthodes

- `Continuer` la recherche

- `Redéfinir la méthode` permet pour des sous-classes de redéfinir une méthode héritée et de l’adapter à la classe qui a hérité.

- `Supprimer` la redéfinition va annuler la redéfinition de la méthode héritée.

- `Filtre` permet d’afficher (case décochée) ou de masquer (case cochée) les méthodes héritées, assurant ainsi une meilleure visibilité.

Vient ensuite une liste des méthodes de la classe dont les caractéristiques principales se présentent sous cette forme :

![](../../99%20-%20Ressources/11_Classes%20-%2003%20-%2001%20-%2002.png)

- `Méthode` (nom de la méthode)

- `Type` pouvant être :

**INSTANCE METHOD**

`Instance method` (méthode d’instance) : pour ce genre de méthode, il est nécessaire de générer l’instance de la classe via l’instruction CREATE OBJECT et une variable d’objet faisant référence à cette classe.

_Exemple avec la classe CL_GUI_ALV_GRID et l’appel de la méthode SET_TABLE_FOR_FIRST_DISPLAY :_

```JS
DATA: o_alv TYPE REF TO cl_gui_alv_grid.

CREATE OBJECT o_alv...

CALL METHOD o_alv->set_table_for_first_display
  EXPORTING
    ...
  CHANGING
    ...
  EXCEPTIONS
    ...
```

**STATIC METHOD**

`Static method` (méthode statique) pour ce genre de méthode, nul besoin de générer l’instance, la méthode peut être appelée directement.

_Exemple avec la classe CL_GUI_ALV_GRID et la méthode CELL_DISPLAY :_

```JS
CALL METHOD cl_gui_alv_grid=>cell_display
  EXPORTING
    ...
  IMPORTING
    ...
  CHANGING
    ...
```

---

- `Visibilité` : même définition que pour les attributs.

- `Type de méthode` indique pour certaines méthodes s’il s’agit (dans l’ordre) de méthode :

  - `Normale` (vide)

  - `Traitement d’événement`

  - `Type constructeur`, `constructeur de classe` ou `destructeur`

  - `GET`

  - `SET`

  - `Test`

![](../../99%20-%20Ressources/11_Classes%20-%2003%20-%2001%20-%2003.png)

- `Description`

Comme indiqué précédemment, les trois options `Paramètre`, `Exceptions` et `Code Srce` vont permettre de définir la méthode.

Pour la suite de ce chapitre, la méthode `SET_TABLE_FOR_FIRST_DISPLAY` sera utilisée comme exemple. C’est celle-ci qui est appelée pour afficher le `rapport ALV`.
