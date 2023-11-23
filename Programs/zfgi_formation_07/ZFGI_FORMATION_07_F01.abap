*&---------------------------------------------------------------------*
*& Include          ZFGI_FORMATION_07_F01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form insert_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM insert_data.

    DATA : ls_passenger TYPE zpassenger,
           ls_travel    TYPE ztravel,
           lv_error     TYPE xfeld,
           lv_error2    TYPE xfeld.
  
    CLEAR ls_passenger.
  
    ls_passenger-mandt        = sy-datum.
    ls_passenger-id_passenger = p_id.
    ls_passenger-surname      = p_surnam.
    ls_passenger-name         = p_name.
    ls_passenger-date_birth   = p_dateb.
    ls_passenger-city         = p_city.
    ls_passenger-country      = p_count.
    ls_passenger-lang         = p_lang.
  
    CLEAR ls_travel.
  
    ls_travel-mandt           = sy-mandt.
    ls_travel-date_travel     = p_date.
    ls_travel-hour_travel     = p_hour.
    ls_travel-id_driver       = p_id_d.
    ls_travel-id_passenger1   = p_idp1.
    ls_travel-id_passenger2   = p_idp2.
    ls_travel-id_passenger3   = p_idp3.
    ls_travel-city_from       = p_citf.
    ls_travel-country_from    = p_counf.
    ls_travel-city_to         = p_citt.
    ls_travel-country_to      = p_counto.
    ls_travel-kms             = p_kms.
    ls_travel-kms_unit        = p_kms_u.
    ls_travel-duration        = p_dur.
    ls_travel-toll            = p_toll.
    ls_travel-gasol           = p_gazol.
    ls_travel-unit            = p_unit.
  
    CALL FUNCTION 'ZFI_PROG_07_INSERT_DATA'
      EXPORTING
        i_zpassenger = ls_passenger
        i_ztravel    = ls_travel
      IMPORTING
        ev_error     = lv_error
        ev_error2    = lv_error2.
  
    IF lv_error = 'X' OR lv_error2 = 'X'.
      MESSAGE: 'Error'
      TYPE 'I'
      DISPLAY LIKE 'E'.
    ELSE.
      MESSAGE: 'Success'
      TYPE 'I'.
    ENDIF.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form select_data
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM select_data.
  
    SELECT
      ztravel~date_travel,
      ztravel~city_from,
      ztravel~country_from,
      ztravel~city_to,
      ztravel~country_to,
      zdriver_car_kde~surname && @space && zdriver_car_kde~name AS Conducteur,
      zdriver_car_kde~car_brand,
      zdriver_car_kde~car_model,
      zpassenger1~surname AS id_passenger1,
      zpassenger2~surname AS id_passenger2,
      zpassenger3~surname AS id_passenger3,
      ztravel~kms,
      ztravel~kms_unit,
      ztravel~toll,
      ztravel~gasol,
      ztravel~unit
    FROM ztravel
    INNER JOIN      zdriver_car_kde           ON ztravel~id_driver = zdriver_car_kde~id_driver
    LEFT OUTER JOIN zpassenger AS zpassenger1 ON ztravel~id_passenger1 = zpassenger1~id_passenger
    LEFT OUTER JOIN zpassenger AS zpassenger2 ON ztravel~id_passenger2 = zpassenger2~id_passenger
    LEFT OUTER JOIN zpassenger AS zpassenger3 ON ztravel~id_passenger3 = zpassenger3~id_passenger
    WHERE ztravel~date_travel                 IN @s_datet
    AND  ztravel~city_from                    IN @s_cityf
    AND ztravel~city_to                       IN @s_cityt
    ORDER BY date_travel
  * Paramètres pour utilisation d'une liste déroulante
  *  AND  ztravel~city_from = @P_list1
  *  AND ztravel~city_to = @p_list2
    INTO TABLE @DATA(lt_covoit).
  
    IF lt_covoit IS INITIAL.
      MESSAGE TEXT-009 TYPE 'E'.
    ENDIF.
  
  *&---------------------------------------------------------------------*
  
  * METHODES STATIQUES
  
  * Affichage de L'ALV
    DATA : lo_alv           TYPE REF TO cl_salv_table,
           lo_alv_functions TYPE REF TO cl_salv_functions,
           lo_columns       TYPE REF TO cl_salv_columns_table.
  
  *TRY.
    cl_salv_table=>factory(
    IMPORTING
      r_salv_table = lo_alv
    CHANGING
      t_table      = lt_covoit ).
  *  CATCH.
  *ENDTRY.
  
    lo_alv_functions = lo_alv->get_functions( ).
    lo_alv_functions->set_all( abap_true ).
  
    lo_columns = lo_alv->get_columns( ).
    lo_columns->set_optimize( abap_true ).
  
    lo_alv->display( ).
  
  *&---------------------------------------------------------------------*
  
  ** METHODE INSTANCIEE
  *
  *  DATA: lo_alv TYPE REF TO cl_gui_alv_grid.
  *  CREATE OBJECT lo_alv.
  *
  *  CALL METHOD lo_alv->set_table_for_first_display
  **  EXPORTING
  **    i_buffer_active                =
  **    i_bypassing_buffer             =
  **    i_consistency_check            =
  **    i_structure_name               =
  **    is_variant                     =
  **    i_save                         =
  **    i_default                      = 'X'
  **    is_layout                      =
  **    is_print                       =
  **    it_special_groups              =
  **    it_toolbar_excluding           =
  **    it_hyperlink                   =
  **    it_alv_graphics                =
  **    it_except_qinfo                =
  **    ir_salv_adapter                =
  *    CHANGING
  *      it_outtab                     = lt_covoit
  **     it_fieldcatalog               =
  **     it_sort                       =
  **     it_filter                     =
  **  EXCEPTIONS
  **     invalid_parameter_combination = 1
  **     program_error                 = 2
  **     too_many_lines                = 3
  **     others                        = 4
  *    .
  *  IF sy-subrc <> 0.
  ** Implement suitable error handling here
  *  ENDIF.
  
  ENDFORM.