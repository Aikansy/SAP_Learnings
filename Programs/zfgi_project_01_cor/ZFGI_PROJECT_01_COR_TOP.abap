*&---------------------------------------------------------------------*
*& Include          ZPROJ_INTER_2023_TOP
*&---------------------------------------------------------------------*

TABLES: vbak, vbap.

TYPES: BEGIN OF ts_line,
         line TYPE string,
       END OF ts_line,
       tt_line TYPE STANDARD TABLE OF ts_line.

TYPES: BEGIN OF ty_data,
         id_com        TYPE zid_com_po,
         doc_type      TYPE vbak-auart,
         sales_org     TYPE vbak-vkorg,
         distr_chan    TYPE vbak-vtweg,
         sect_act      TYPE vbak-spart,
         partn_role_ag TYPE parvw,
         partn_numb_ag TYPE vbak-kunnr,
         partn_role_we TYPE parvw,
         partn_numb_we TYPE vbak-kunnr,
         itm_numb      TYPE vbap-posnr,
         material      TYPE vbap-matnr,
         plant         TYPE vbap-werks,
         quantity      TYPE vbap-zmeng,
         quantity_unit TYPE vbap-zieme,
       END OF ty_data.

TYPES: BEGIN OF ty_cv,
         vbeln         TYPE vbak-vbeln,
         auart         TYPE vbak-auart,
         erdat         TYPE vbak-erdat,
         erzet         TYPE vbak-erzet,
         vdatu         TYPE vbak-vdatu, "Formulaire structure EDATU_VBAK
         vkorg         TYPE vbak-vkorg,
         vtweg         TYPE vbak-vtweg,
         spart         TYPE vbak-spart,
         kunnr_ana     TYPE vbap-kunnr_ana,
         name1         TYPE kna1-name1,
         kunwe_ana     TYPE vbap-kunwe_ana,
         name2         TYPE kna1-name1,
         adress        TYPE string,     " Formulaire structure /PM0/ABD_ADRESSE
         posnr         TYPE vbap-posnr,
         matnr         TYPE vbap-matnr,
         maktx         TYPE makt-maktx,
         werks         TYPE vbap-werks, "Formulaire structure werks_D
         zmeng         TYPE vbap-zmeng,
         zieme         TYPE vbap-zieme,
         ntgew         TYPE mara-ntgew,
         gewei         TYPE mara-gewei,
         pds_post      TYPE mara-ntgew,
         pds_tot       TYPE mara-ntgew,
       END OF ty_cv.

DATA: gt_file TYPE tt_line,
      gt_data TYPE STANDARD TABLE OF ty_data,
      gt_cv   TYPE STANDARD TABLE OF ty_cv,
      gt_alv  TYPE STANDARD TABLE OF vbap.

DATA: ok_code TYPE sy-ucomm,
      save_ok TYPE sy-ucomm,
      number1(4) TYPE n VALUE '0002'.