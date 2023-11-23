*&---------------------------------------------------------------------*
*& Include          ZFGI_FORMATION_06_SCR
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b00 WITH FRAME TITLE TEXT-000.

  SELECT-OPTIONS: s_ebeln FOR ekpo-ebeln,
                  s_matnr FOR ekpo-matnr.

  PARAMETERS:     p_spras TYPE makt-spras OBLIGATORY DEFAULT 'FR'.

SELECTION-SCREEN END OF BLOCK b00.