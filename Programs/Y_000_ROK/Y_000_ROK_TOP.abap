*&---------------------------------------------------------------------*
*&  Include           Y_000_LF_TOP
*&---------------------------------------------------------------------*

" PUSHBUTTON ----------------------------------------------------------*

TABLES SSCRFIELDS.

" SCREEN 1000 ---------------------------------------------------------*

DATA FLAG(1) TYPE C.

" F01 - TAB JOIN ------------------------------------------------------*

TYPES: BEGIN OF TY_COMMON_FIELDS,
         COMMON    TYPE STRING,
         TABNAME   TYPE DD03L-TABNAME,
         FIELDNAME TYPE DD03L-FIELDNAME,
         ROLLNAME  TYPE DD03L-ROLLNAME,
         DOMNAME   TYPE DD03L-DOMNAME,
         DATATYPE  TYPE DD03L-DATATYPE,
         LENG      TYPE DD03L-LENG,
         KEYFLAG   TYPE DD03L-KEYFLAG,
       END OF TY_COMMON_FIELDS.

DATA: GT_TAB1          TYPE STANDARD TABLE OF DD03L,
      GS_TAB1          TYPE DD03L,

      GT_TAB2          TYPE STANDARD TABLE OF DD03L,
      GS_TAB2          TYPE DD03L,

      GT_COMMON_FIELDS TYPE STANDARD TABLE OF TY_COMMON_FIELDS WITH HEADER LINE,
      GS_COMMON_FIELDS TYPE TY_COMMON_FIELDS.

DATA: ALV_CONTAINER_JOIN_1 TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      ALV_CONTAINER_JOIN_2 TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      ALV_GRID_JOIN_1      TYPE REF TO CL_GUI_ALV_GRID,
      ALV_GRID_JOIN_2      TYPE REF TO CL_GUI_ALV_GRID,
      LAYOUT               TYPE LVC_S_LAYO,
      GT_FIELDCAT          TYPE LVC_T_FCAT,
      GS_FIELDCAT          TYPE LVC_S_FCAT,
      VARIANT              TYPE DISVARIANT.