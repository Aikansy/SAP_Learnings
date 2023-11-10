# **`RAPPORT ALV`**

Dans le chapitre concernant la programmation objet sur SAP (cf. Les classes), la `classe CL_GUI_ALV_GRID` avait été prise comme exemple, et avait pour but d’afficher des données dans un `rapport ALV`. Bien que cette classe soit très complète, elle reste assez complexe à utiliser dans un premier exemple (beaucoup de méthodes privées...) et de nombreuses fonctionnalités auraient été manquantes ou trop lourdes à manipuler. Cependant, il existe une autre classe beaucoup plus simple.

Dans un premier temps, à la suite de la sélection, deux variables objets vont être créées, faisant référence aux `classes CL_SALV_TABLE` (classe basique pour table simple) et `CL_SALV_FUNCTIONS` (fonctions génériques d’un `rapport ALV`).

```JS
DATA: o_alv           TYPE REF TO cl_salv_table,
      o_alv_functions TYPE REF TO cl_salv_functions.
```

Grâce à la fonction Modèle de l’`éditeur ABAP`, le constructeur (contenu dans la `méthode FACTORY`) va être appelé.

![](../99%20-%20Ressources/13_ALV%20-%2008%20-%2001.png)

Le code suivant est alors importé :

```JS
*TRY.
CALL METHOD cl_salv_table=>factory
*  EXPORTING
*    list_display   = IF_SALV_C_BOOL_SAP=>FALSE
*    r_container    =
*    container_name =
*  IMPORTING
*    r_salv_table   =
  CHANGING
    t_table        =
    .
* CATCH cx_salv_msg .
*ENDTRY.
```

Il est intéressant de constater que l’`instruction CALL METHOD` est encadrée par un `TRY... CATCH`. Il s’agit d’une méthode utilisant une `exception`.

![](../99%20-%20Ressources/13_ALV%20-%2008%20-%2002.png)

L’instruction `TRY... CATCH` permet simplement d’intercepter cette erreur et d’afficher un message correspondant. Après avoir retiré les paramètres qui ne seront pas utilisés, l’appel de la méthode est réécrit de cette manière :

```JS
TRY.
    CALL METHOD cl_salv_table=>factory
      IMPORTING
        r_salv_table = o_alv
      CHANGING
        t_table      = t_data.
  CATCH cx_salv_msg .
    MESSAGE 'Impossible d''afficher le rapport ALV'
             TYPE 'I' DISPLAY LIKE 'E'.
ENDTRY.
```

L’`objet O_ALV` va être créé avec comme paramètre la table `T_DATA`. Si l’`exception CX_SALV_MSG` est retournée, le message Impossible d’afficher le `rapport ALV` est affiché comme étant une erreur (`DISPLAY LIKE ’E’`).

Le `rapport ALV` est maintenant prêt, il suffit alors de mettre en place la barre d’outils et d’autres fonctions grâce à la création de l’`objet O_ALV_FUNCTIONS`, directement à partir de la `méthode GET_FUNCTIONS` de l’objet `O_ALV`. Elles seront activées avec la `méthode SET_ALL`.

```JS
o_alv_functions = o_alv->get_functions( ).
o_alv_functions->set_all( abap_true ).
```

Une option consistant à optimiser la largeur des colonnes grâce à la `classe CL_SALV_COLUMNS_TABLE` va être ajoutée. Une première `méthode GET_COLUMNS` va permettre de créer l’objet contenant toutes les informations des colonnes à partir de celui de l’`ALV (O_ALV)`, puis une deuxième (`SET_OPTIMIZE`) va les adapter automatiquement au contenu.

```JS
DATA: o_columns TYPE REF TO cl_salv_columns_table.

o_columns = o_alv->get_columns( ).
o_columns->set_optimize( abap_true ).
```

Enfin, la méthode DISPLAY affichera le résultat à l’écran.

```JS
o_alv->display( ).
```

Le `rapport ALV` sera alors automatiquement créé avec le nombre de colonnes souhaité comme configuré dans la table `T_DATA`, et leurs libellés seront directement importés des différentes tables de la sélection. Cependant, dans le `SELECT`, quatre colonnes ont été construites : celle du conducteur et celles des passagers. Il va donc falloir leur assigner un libellé et pour cela, une nouvelle classe va être utilisée : `CL_SALV_COLUMN_TABLE`. Un objet va être créé à partir de l’objet de l’ensemble des colonnes (`O_COLUMNS`) et du nom de son champ, et des libellés court, moyen et long vont lui être attribués.

```JS
DATA: o_column  TYPE REF TO cl_salv_column_table.
o_column ?= o_columns->get_column( 'DRIVER' ).
o_column->set_long_text( 'Conducteur' ).
o_column->set_medium_text( 'Conduct.' ).
o_column->set_short_text( 'Cond.' ).

o_column ?= o_columns->get_column( 'PASSENGER1' ).
o_column->set_long_text( 'Passager 1' ).
o_column->set_medium_text( 'Pass. 1' ).
o_column->set_short_text( 'Pass1' ).

o_column ?= o_columns->get_column( 'PASSENGER2' ).
o_column->set_long_text( 'Passager 2' ).
o_column->set_medium_text( 'Pass. 2' ).
o_column->set_short_text( 'Pass2' ).

o_column ?= o_columns->get_column( 'PASSENGER3' ).
o_column->set_long_text( 'Passager 3' ).
o_column->set_medium_text( 'Pass. 3' ).
o_column->set_short_text( 'Pass3' ).
```

Au final, le code complet du programme sera le suivant :

```JS
*&--------------------------------------------------------------*
*& Rapport  ZALV_TRAVEL
*&
*&--------------------------------------------------------------*
*&
*&
*&--------------------------------------------------------------*
RAPPORT zalv_travel.


TABLES: ztravel.

SELECTION-SCREEN BEGIN OF BLOCK b00 WITH FRAME TITLE text-b00.
SELECT-OPTIONS: s_trdate FOR ztravel-date_travel,
                s_cityfr FOR ztravel-city_from,
                s_cityto FOR ztravel-city_to.
SELECTION-SCREEN END OF BLOCK b00.



SELECT t~date_travel,
       t~city_from,
       t~country_from,
       t~city_to,
       t~country_to,
       d~surname && ' ' && d~name   AS driver,
       d~car_brand,
       d~car_model,
       p1~surname && ' ' && p1~name AS passenger1,
       p2~surname && ' ' && p2~name AS passenger2,
       p3~surname && ' ' && p3~name AS passenger3,
       t~kms,
       t~kms_unit,
       t~toll,
       t~gasol,
       t~unit
  FROM ztravel           AS t
  INNER JOIN zdriver_car AS d
    ON t~id_driver       EQ d~id_driver
  INNER JOIN zpassenger  AS p1
    ON t~id_passenger1   EQ p1~id_passenger
  INNER JOIN zpassenger  AS p2
    ON t~id_passenger2   EQ p2~id_passenger
  INNER JOIN zpassenger  AS p3
    ON t~id_passenger3   EQ p3~id_passenger
  INTO TABLE @DATA(t_data)
  WHERE t~date_travel IN @s_trdate
    AND t~city_from   IN @s_cityfr
    AND t~city_to     IN @s_cityto
  ORDER BY t~date_travel.



DATA: o_alv           TYPE REF TO cl_salv_table,
      o_alv_functions TYPE REF TO cl_salv_functions.

TRY.
    CALL METHOD cl_salv_table=>factory
      IMPORTING
        r_salv_table = o_alv
      CHANGING
        t_table      = t_data.

    o_alv_functions = o_alv->get_functions( ).
    o_alv_functions->set_all( abap_true ).

    DATA: o_columns TYPE REF TO cl_salv_columns_table.
    o_columns = o_alv->get_columns( ).
    o_columns->set_optimize( abap_true ).


    DATA: o_column  TYPE REF TO cl_salv_column_table.
    o_column ?= o_columns->get_column( 'DRIVER' ).
    o_column->set_long_text( 'Conducteur' ).
    o_column->set_medium_text( 'Conduct.' ).
    o_column->set_short_text( 'Cond.' ).

    o_column ?= o_columns->get_column( 'PASSENGER1' ).
    o_column->set_long_text( 'Passager 1' ).
    o_column->set_medium_text( 'Pass. 1' ).
    o_column->set_short_text( 'Pass1' ).

    o_column ?= o_columns->get_column( 'PASSENGER2' ).
    o_column->set_long_text( 'Passager 2' ).
    o_column->set_medium_text( 'Pass. 2' ).
    o_column->set_short_text( 'Pass2' ).

    o_column ?= o_columns->get_column( 'PASSENGER3' ).
    o_column->set_long_text( 'Passager 3' ).
    o_column->set_medium_text( 'Pass. 3' ).
    o_column->set_short_text( 'Pass3' ).

    o_alv->display( ).

  CATCH cx_salv_msg .
    MESSAGE 'Impossible d''afficher le rapport ALV'
            TYPE 'I' DISPLAY LIKE 'E'.
ENDTRY.
```

Il est possible de retrouver le code de ce programme dans le fichier 10_CODE_03.txt.

Le code est assez simple et reste assez clair, cependant lorsqu’il s’agit d’un programme plus complexe, il pourrait devenir illisible et très difficile à maintenir. Il serait intéressant de voir comment l’organiser au mieux afin de pouvoir intégrer sans problème de nouveaux traitements si besoin.
