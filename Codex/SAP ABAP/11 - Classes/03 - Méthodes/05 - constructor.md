# **`CONSTRUCTOR`**

Comme indiqué dans ce chapitre, l’objet se crée grâce à l’instruction :

```JS
CREATE OBJECT class...
```

Bien entendu en prenant en compte que la `classe class` n’ait pas une instanciation de type privé.

Lorsque cette instruction est exécutée, une méthode de la `classe class` est obligatoirement appelée : le `CONSTRUCTOR`. Comme son nom l’indique, cette méthode va générer l’instance de la classe via une variable d’objet. Quelques règles existent pour une méthode de type constructeur :

1. Une classe ne peut avoir qu’une seule méthode de type constructeur.

2. Le constructeur doit être de type public.

3. Les paramètres du constructeur ne seront que de type importation.

Exemple avec la `méthode CONSTRUCTOR` de la classe `CL_GUI_ALV_GRID`.

![](../../99%20-%20Ressources/11_Classes%20-%2003%20-%2005%20-%2001.png)

Les paramètres de la `méthode CONSTRUCTOR` vont donc être les suivants (il est intéressant de voir que le type de paramètre (Importation, Exportation...) ne peut pas être spécifié) :

![](../../99%20-%20Ressources/11_Classes%20-%2003%20-%2005%20-%2002.png)

Lorsqu’elle sera appelée, un seul paramètre sera obligatoire.

Bien entendu, dans l’éditeur ABAP, il est également possible d’utiliser la fonctionnalité Modèle pour importer les paramètres obligatoires de n’importe quel constructeur de n’importe quelle classe.

Exemple avec la création de l’objet de la `classe CL_GUI_ALV_GRID`. Tout d’abord, la variable d’objet va être créée.

```JS
DATA: o_alv TYPE REF TO cl_gui_alv_grid.
```

Puis avec l’`option Modèle`, l’`option Modèle objet ABAP` devra être choisie.

![](../../99%20-%20Ressources/11_Classes%20-%2003%20-%2005%20-%2003.png)

L’`option Créer objet` sera sélectionnée avec les champs suivants :

![](../../99%20-%20Ressources/11_Classes%20-%2003%20-%2005%20-%2004.png)

Et comme avec les fonctions, l’instruction est automatiquement importée avec tous les paramètres en entrée (obligatoires ou non), les exceptions...

```JS
DATA: o_alv TYPE REF TO cl_gui_alv_grid.

CREATE OBJECT o_alv
  EXPORTING
*    i_shellstyle      = 0
*    i_lifetime        =
     i_parent          =
*    i_appl_events     = space
*    i_parentdbg       =
*    i_applogparent    =
*    i_graphicsparent  =
*    i_name            =
*    i_fcat_complete   = SPACE
*  EXCEPTIONS
*    error_cntl_create = 1
*    error_cntl_init   = 2
*    error_cntl_link   = 3
*    error_dp_create   = 4
*    others            = 5
    .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.
```
