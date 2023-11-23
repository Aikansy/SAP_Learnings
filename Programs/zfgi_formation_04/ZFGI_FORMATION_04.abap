*&---------------------------------------------------------------------*
*& Report ZFGI_FORMATION_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT zfgi_formation_04.

INCLUDE zfgi_formation04_top.
INCLUDE zfgi_formation04_scr.
INCLUDE zfgi_formation04_f01.

START-OF-SELECTION.

PERFORM select_data.
PERFORM display_data.

*&---------------------------------------------------------------------*

*  DATA: lo_alv TYPE REF TO cl_salv_table.
*
*  CALL METHOD cl_salv_table=>factory
*    IMPORTING
*      r_salv_table = lo_alv
*    CHANGING
*      t_table      = lt_fkart.
*  CALL METHOD lo_alv->display.

END-OF-SELECTION.