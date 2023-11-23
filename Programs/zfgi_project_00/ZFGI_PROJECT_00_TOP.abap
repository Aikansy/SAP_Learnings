*&-----------------------------------------------------------------------------------------------------*
*& Include          ZFGI_PROJECT_00_TOP
*&-----------------------------------------------------------------------------------------------------*

* Structure model declaration for gt_file.
TYPES: BEGIN OF ty_file,
  po_id         TYPE char5,           "Purchase Order ID
  society       TYPE ekko-bukrs,      "Société
  doctype       TYPE ekko-bsart,      "Type de document achat
  seller        TYPE ekko-lifnr,      "Numéro de compte fournisseur
  purchase_org  TYPE ekko-ekorg,      "Organisation d'achats
  purchase_grp  TYPE ekko-ekgrp,      "Groupe d'acheteurs
  CURRENCY      TYPE ekko-waers,      "Clé de devise
  post_num      TYPE ekpo-ebelp,      "Numéro de poste du document d'achat
  article_num   TYPE ekpo-matnr,      "Numéro d'article
  division      TYPE ekpo-werks,      "Division
  order_qty     TYPE ekpo-menge,      "Quantité de commande
  purchase_unit TYPE ekpo-meins,      "Unité d'achat
  net_price     TYPE ekpo-netpr,      "Prix net du document d'achat dans la devise du document
END OF ty_file.

* Structure model declaration for uploaded data line
TYPES: BEGIN OF ty_fileline,                                  "Uploaded file line type
  fileline      TYPE string,                           "String for SPLIT command
END OF ty_fileline.

* Table declarations
DATA: gt_line          TYPE TABLE OF ty_fileline,             "Table containing uploaded file rows
      gt_file          TYPE TABLE OF ty_file.                 "Table containing datas from uploaded file

** Database table(s) for select-options
*TABLES: db_tableA, db_tableB, db_tableC.
*
** Type model declaration(s)
*TYPES: BEGIN OF ts_line,                                    "Uploaded file line type
*         line   TYPE string,                                "
*       END OF ts_line.
*
*TYPES: BEGIN OF ty_modelA,                                  "Type model A
*         field1 TYPE table-field,                           "
*         field2 TYPE table-field,                           "
*         field3 TYPE table-field,                           "
*         field4 TYPE table-field.                           "
*         INCLUDE STRUCTURE tableD.                          "Include structure from table D
*TYPES: END OF ty_modelA.
*
*TYPES: BEGIN OF ty_modelB,                                  "Type model B
*         field1 TYPE table-field,                           "
*         field2 TYPE table-field,                           "
*         field3 TYPE table-field,                           "
*         field4 TYPE table-field.                           "
*         INCLUDE STRUCTURE tableE.                          "Include structure from table E
*TYPES: END OF ty_modelB.
*
*TYPES: BEGIN OF ty_modelC,                                  "Type model C
*         field1 TYPE table-field,                           "
*         field2 TYPE table-field,                           "
*         field3 TYPE table-field,                           "
*         field4 TYPE table-field.                           "
*         INCLUDE STRUCTURE tableF.                          "Include structure from table F
*TYPES: END OF ty_modelC.
*
*TYPES: BEGIN OF ty_data,                                    "Type model Data
*         field1 TYPE table-field,                           "
*         field2 TYPE table-field,                           "
*         field3 TYPE table-field,                           "
*         field4 TYPE table-field,                           "
*       END OF ty_data.
*
** Variable declaration(s)
*DATA: gv_field  TYPE data_element,                          "Variable with the same parameters as a data element
*      gv_field  TYPE table-field,                           "Variable with the same parameters as a table field
*      gv_string TYPE string.                                "
*
** Structure declaration(s)
*DATA: gs_data   TYPE tableA.                                "Structure from/with table fields
*
** Table declaration(s)
*DATA: tt_line   TYPE STANDARD TABLE OF ts_line,             "Table containing the rows of the uploaded file
*      gt_file   TYPE tt_line,                               "Table containing the table tt_line
*      gt_modelA TYPE STANDARD TABLE OF ty_modelA,           "Standard table from ty_modelA
*      gt_modelB TYPE STANDARD TABLE OF ty_modelB,           "Standard table from ty_modelB
*      gt_modelC TYPE STANDARD TABLE OF ty_modelC,           "Standard table from ty_modelC
*      gt_data   TYPE STANDARD TABLE OF ty_data,             "Standard table from ty_data
*      gt_form   TYPE zfgi_tt_form_project_00,               "Table from existed smartform (I guess Tcode SMARTFORMS))
*      gt_occurs TYPE ty_occurs OCCURS 0 WITH HEADER LINE.   "Table from (only batch-input ?) structure with dynamic table size definition (OCCURS 0) and Header line (ligne d'en-tête)