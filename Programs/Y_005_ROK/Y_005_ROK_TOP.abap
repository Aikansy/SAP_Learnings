*&---------------------------------------------------------------------*
*&  Include           Y_005_ROK_TOP
*&---------------------------------------------------------------------*

TYPE-POOLS: slis.

TYPES: BEGIN OF ty_data,
         vbeln TYPE vbak-vbeln,
         posnr TYPE vbap-posnr,
         abgru TYPE vbap-abgru,
       END OF ty_data.

TYPES: BEGIN OF ty_toolbar,
         function TYPE sy-ucomm,
       END OF ty_toolbar.

" DATA RETREIVE PERFORM
DATA: gt_data   TYPE STANDARD TABLE OF ty_data,
      gt_backup TYPE SORTED TABLE OF ty_data WITH NON-UNIQUE KEY vbeln posnr abgru,
      gs_data   LIKE LINE OF gt_data,
      gs_backup LIKE LINE OF gt_backup.

" BUILD FIELDCATALOG
DATA: alv_container TYPE REF TO cl_gui_custom_container,
      ref_grid      TYPE REF TO cl_gui_alv_grid,
      gt_fieldcat   TYPE slis_t_fieldcat_alv WITH HEADER LINE,
      gs_fieldcat   TYPE slis_fieldcat_alv,
      gv_repid      LIKE sy-repid.

" BUILD LAYOUT
DATA: gd_layout TYPE slis_layout_alv.

" ALV MODULES
DATA: rt_extab    TYPE slis_t_extab,
      r_ucomm     LIKE sy-ucomm,
      rs_selfield TYPE slis_selfield.

" DATA_PROCESSING
DATA: gt_return TYPE STANDARD TABLE OF bapiret2,
      gs_return LIKE LINE OF gt_return.