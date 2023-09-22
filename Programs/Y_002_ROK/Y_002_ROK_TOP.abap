*&---------------------------------------------------------------------*
*&  Include           Y_002_ROK_TOP
*&---------------------------------------------------------------------*

TABLES: bkpf.

TYPES: BEGIN OF ty_bkpf,
         bukrs TYPE bkpf-bukrs, " Company Code
         belnr TYPE bkpf-belnr, " Accounting Document Number
         gjahr TYPE bkpf-gjahr, " Fiscal Year
         bldat TYPE bkpf-bldat, " Document Date in Document
         awtyp TYPE bkpf-awtyp, " Reference Transaction
         awkey TYPE bkpf-awkey, " Reference Key (awtyp)
         usnam TYPE bkpf-usnam, " User name
         waers TYPE bkpf-waers, " Currency Key
       END OF ty_bkpf.

TYPES: BEGIN OF ty_bseg,
         bukrs TYPE bseg-bukrs, " Company Code
         belnr TYPE bseg-belnr, " Accounting Document Number
         gjahr TYPE bseg-gjahr, " Fiscal Year
         buzei TYPE bseg-buzei, " Document Number of the Clearing Document
         bschl TYPE bseg-bschl, " Posting Key
         koart TYPE bseg-koart, " Account Type
         wrbtr TYPE bseg-wrbtr, " Amount in document currency
       END OF ty_bseg.

TYPES: BEGIN OF ty_bkpf_key,
         belnr TYPE bkpf-belnr,
         bukrs TYPE bkpf-bukrs,
         gjahr TYPE bkpf-gjahr,
       END OF ty_bkpf_key.

TYPES: BEGIN OF ty_vbrk_key,
         vbeln TYPE vbrk-vbeln,
       END OF ty_vbrk_key.

TYPES: BEGIN OF ty_data,
         bukrs  TYPE bkpf-bukrs, " Company Code (BKPF)
         belnr  TYPE bkpf-belnr, " Document Number (BKPF)
         gjahr  TYPE bkpf-gjahr, " Fiscal Year (BKPF)
         bldat  TYPE bkpf-bldat, " Document Date (BKPF)
         awtyp  TYPE bkpf-awtyp, " Ref. Transaction (BKPF)
         awkey1 TYPE bkpf-bukrs, " Reference Company Code (BKPF)
         awkey2 TYPE bkpf-belnr, " Reference Document Number (BKPF)
         awkey3 TYPE bkpf-gjahr, " Reference Fiscal Year (BKPF)
         awkey4 TYPE bkpf-awkey, " Reference Facture (BKPF)
         usnam  TYPE bkpf-usnam, " Createur Piece Ref (BKPF)
         buzei  TYPE bseg-buzei, " Line Item (BSEG)
         bschl  TYPE bseg-bschl, " Posting Key (BSEG)
         koart  TYPE bseg-koart, " Account Type (BSEG)
         waers  TYPE bkpf-waers, " Currency (BKPF)
         wrbtr  TYPE bseg-wrbtr, " Amount (BSEG)
       END OF ty_data.

DATA: gt_bkpf          TYPE SORTED TABLE OF   ty_bkpf WITH NON-UNIQUE KEY bukrs belnr gjahr, " Accounting Document Header
      gt_bseg          TYPE SORTED TABLE OF   ty_bseg WITH NON-UNIQUE KEY bukrs belnr gjahr, " Accounting Document Segment
      gt_bkpf_key      TYPE STANDARD TABLE OF ty_bkpf_key, " Accounting Document Header (for lf usnam value)
      gt_vbrk_key      TYPE STANDARD TABLE OF ty_vbrk_key, " Accounting Document Segment (for lf ernam value)
      gt_bseg_filtered TYPE STANDARD TABLE OF ty_bseg, " Accounting Document Segment (filtered by koart)
      gt_data          TYPE STANDARD TABLE OF ty_data.     " Custom data table

DATA: gs_data          LIKE LINE OF gt_data.      " Custom data table structure

" ALV BASIC DISPLAY
TYPES: BEGIN OF g_type_s_test,
         amount  TYPE i,
         repid   TYPE syrepid,
         display TYPE i,
         dynamic TYPE sap_bool,
       END OF g_type_s_test.

DATA: go_alv           TYPE REF TO cl_salv_table,
      go_alv_functions TYPE REF TO cl_salv_functions,
      lr_column_list   TYPE REF TO cl_salv_column_list,
      go_columns       TYPE REF TO cl_salv_columns,
      go_column        TYPE REF TO cl_salv_column_list,
      go_event         TYPE REF TO cl_salv_events_table,
      gs_test          TYPE g_type_s_test.

" ALV COLORIZATION
DATA: gs_color_red  TYPE lvc_s_colo,
      gs_color_blue TYPE lvc_s_colo.

" ALV EVENTS
DATA: gr_events TYPE REF TO cl_salv_events_table,
      go_events TYPE REF TO lcl_alv_handler.

" SORTED TABLE (PERFORMANCE)
*
*DATA: gt_bseg TYPE STANDARD TABLE OF ty_bseg WITH NON-UNIQUE SORTED KEY fi COMPONENTS bukrs belnr gjahr.
*
*LOOP AT gt_bseg ASSIGNING FIELD-SYMBOL(<lfs_bseg>) USING KEY fi WHERE bukrs = <lfs_bseg_filtered>-bukrs AND belnr = <lfs_bseg_filtered>-belnr AND gjahr = <lfs_bseg_filtered>-gjahr.
*  <CODE>
*ENDLOOP.
*
*DATA: gt_bseg TYPE STANDARD TABLE OF ty_bseg WITH NON-UNIQUE SORTED KEY fi COMPONENTS koart.
*
*LOOP AT gt_bseg ASSIGNING FIELD-SYMBOL(<lfs_bseg>) USING KEY fi WHERE koart = 'D'.
*  <CODE>
*ENDLOOP.
*
" OR
*
*DATA: gt_bseg TYPE SORTED TABLE OF ty_bseg WITH NON-UNIQUE KEY bukrs belnr gjahr,
*
*LOOP AT gt_bseg ASSIGNING FIELD-SYMBOL(<lfs_bseg>) WHERE bukrs = <lfs_bseg_filtered>-bukrs AND belnr = <lfs_bseg_filtered>-belnr AND gjahr = <lfs_bseg_filtered>-gjahr.
*  <CODE>
*ENDLOOP.