*&---------------------------------------------------------------------*
*& Include          ZFGI_FORMATION_12_TOP
*&---------------------------------------------------------------------*

TYPES: BEGIN OF ty_vbak,
         vbeln TYPE vbak-vbeln,
         erdat TYPE vbak-erdat,
         auart TYPE vbak-auart,
         erzet TYPE vbak-erzet,
         ernam TYPE vbak-ernam,
       END OF ty_vbak.

TYPES: BEGIN OF ty_mara,
         matnr TYPE mara-matnr,
         maktx TYPE makt-maktx,
       END OF ty_mara.

DATA: gv_vbeln  TYPE vbak-vbeln,
      gs_vbak   TYPE ty_vbak,
      container TYPE REF TO cl_gui_custom_container,
      html      TYPE REF TO cl_gui_html_viewer.

DATA: gv_matnr         TYPE matnr,
      gv_matnr_interne TYPE bool,
      gv_matnr_externe TYPE bool.

DATA: gv_liste_matnr  TYPE mara-matnr,
      gv_matnr_select TYPE mara-matnr,
      gv_maktx_select TYPE makt-maktx,
      gt_mara         TYPE TABLE OF ty_mara.