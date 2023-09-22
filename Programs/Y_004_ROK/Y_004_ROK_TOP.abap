*&---------------------------------------------------------------------*
*&  Include           Y_004_ROK_TOP
*&---------------------------------------------------------------------*

TABLES sscrfields.

DATA: gt_receivers  TYPE somlreci1 OCCURS 0 WITH HEADER LINE,
      gt_bapirettab TYPE bapirettab,
      go_bitem      TYPE REF TO cl_sobl_bor_item,
      go_container  TYPE REF TO cl_gui_container,
      gt_sood       TYPE STANDARD TABLE OF sood,
      gs_sood       TYPE sood.

DATA: gs_lporb TYPE sibflporb,
      dec_kb   TYPE p.