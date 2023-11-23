*&---------------------------------------------------------------------*
*& Include          ZFGI_PROJECT_01_TOP
*&---------------------------------------------------------------------*

TABLES: vbak, vbap.

TYPES: BEGIN OF ty_fileline,
         fileline TYPE string,
       END OF ty_fileline.

TYPES: BEGIN OF ts_line,
    line TYPE string,
  END OF ts_line,
  tt_line TYPE STANDARD TABLE OF ts_line.

DATA: gt_line   TYPE TABLE OF ty_fileline,
      gt_file   TYPE TABLE OF zsjlmf_file_01,
      gt_sfile  TYPE tt_line,
      gt_return TYPE TABLE OF bapiret2.