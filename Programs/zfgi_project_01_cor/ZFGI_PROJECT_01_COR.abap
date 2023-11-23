*&---------------------------------------------------------------------*
*& Report ZPROJ_INTER_2023
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zfgi_project_01_cor NO STANDARD PAGE HEADING.

INCLUDE zfgi_project_01_cor_top.
INCLUDE zfgi_alv_proj.
INCLUDE zfgi_project_01_cor_scr.
INCLUDE zfgi_project_01_cor_f01.

INITIALIZATION.

  PERFORM init_data.

START-OF-SELECTION.

  IF p_crea = 'X'.

    PERFORM get_data_from_file.
    PERFORM prepare_data.
    PERFORM check_data.
    PERFORM create_sales_order.

  ENDIF.

  IF p_alv = 'X'.

    PERFORM select_data.
    PERFORM display_data.

  ENDIF.