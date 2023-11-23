*&---------------------------------------------------------------------*
*& Report ZPROJ_INTER_2023
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zfgi_batch_input_01.

INCLUDE zfgi_batch_input_01_top.
INCLUDE zfgi_batch_input_01_alv.
INCLUDE zfgi_batch_input_01_scr.
INCLUDE zfgi_batch_input_01_f01.

INITIALIZATION.

  PERFORM init_data.
*  PERFORM generate_output.

START-OF-SELECTION.

  IF p_crea = 'X'.

*    CALL SCREEN 9001.

    PERFORM get_data_from_file.
    PERFORM prepare_data.
    PERFORM check_data.

    IF p_rad3 = 'X'.
      PERFORM create_sales_order.
    ENDIF.

    IF p_rad4 = 'X'.
      PERFORM batch_input.
    ENDIF.

  ENDIF.

  IF p_alv = 'X'.

*    CALL SCREEN 9002.

    PERFORM select_data.
    PERFORM display_data.

  ENDIF.