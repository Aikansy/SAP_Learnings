*&---------------------------------------------------------------------*
*& Include          ZFGI_ALV_PROJ_TOP
*&---------------------------------------------------------------------*

TYPE-POOLS: abap, ICON.

TYPES: BEGIN OF ty_sort_info,
  POSITION   TYPE I,
  sequence   TYPE salv_de_sort_sequence,
  subtotal   TYPE sap_bool,
  GROUP      TYPE salv_de_sort_group,
  obligatory TYPE sap_bool,
END OF ty_sort_info.

TYPES: BEGIN OF ty_header_alv,
  TEXT(250)  TYPE C,
  bold       TYPE xfeld,
  column     TYPE I,
END OF ty_header_alv.

DATA: go_alv        TYPE REF TO cl_salv_table,
      go_function   TYPE REF TO cl_salv_functions_list,
      go_disp       TYPE REF TO cl_salv_display_settings,
      go_layout     TYPE REF TO cl_salv_layout,
      go_cols       TYPE REF TO cl_salv_columns,
      go_sorts      TYPE REF TO cl_salv_sorts,
      go_event      TYPE REF TO cl_salv_events_table,
      go_selections TYPE REF TO cl_salv_selections,
      go_aggr       TYPE REF TO cl_salv_aggregations.

DATA: gt_functions  TYPE salv_t_ui_func,
      gs_functions  LIKE LINE OF gt_functions.

DATA: gs_sort_info  TYPE ty_sort_info.

DATA: gt_rows       TYPE salv_t_row,
      gs_rows       TYPE int4.

DATA: g_x           TYPE sap_bool VALUE ' '.

DATA: gt_header_alv TYPE TABLE OF ty_header_alv,
      gs_header_alv LIKE LINE OF gt_header_alv.

gs_sort_info-sequence   = if_salv_c_sort=>sort_up.
gs_sort_info-subtotal   = if_salv_c_bool_sap=>false.
gs_sort_info-GROUP      = if_salv_c_sort=>group_none.
gs_sort_info-obligatory = if_salv_c_bool_sap=>false.