*&-----------------------------------------------------------------------------------------------------*
*& Include          ZFGI_PROJECT_00_SCR
*&-----------------------------------------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK bl000 WITH FRAME TITLE TEXT-000.

  PARAMETERS: p_radio1 RADIOBUTTON GROUP rb1 USER-COMMAND uc1 DEFAULT 'X'.

  SELECTION-SCREEN BEGIN OF BLOCK bl010 WITH FRAME TITLE TEXT-010.

    PARAMETERS: p_radio3 RADIOBUTTON GROUP rb2 USER-COMMAND fcode MODIF ID sc1 DEFAULT 'X'.

    PARAMETERS: p_file1 TYPE localfile MODIF ID sc1.

*    SELECTION-SCREEN SKIP 1.

*    PARAMETERS: p_param1 TYPE table-field MODIF ID sc1 MATCHCODE OBJECT z_matchcode_field,
*                p_param2 TYPE table-field MODIF ID sc1 MATCHCODE OBJECT z_matchcode_field,
*                p_param3 TYPE table-field MODIF ID sc1 MATCHCODE OBJECT z_matchcode_field,
*                p_param4 TYPE table-field MODIF ID sc1 MATCHCODE OBJECT z_matchcode_field.

*    SELECTION-SCREEN SKIP 1.

    PARAMETERS: p_radio4 RADIOBUTTON GROUP rb2 MODIF ID sc1.

    PARAMETERS: p_file2 TYPE localfile MODIF ID sc1.

*    SELECTION-SCREEN SKIP 1.

*    PARAMETERS: p_param5 TYPE table-field MODIF ID sc1 MATCHCODE OBJECT z_matchcode_field,
*                p_param6 TYPE table-field MODIF ID sc1 MATCHCODE OBJECT z_matchcode_field,
*                p_param7 TYPE table-field MODIF ID sc1 MATCHCODE OBJECT z_matchcode_field,
*                p_param8 TYPE table-field MODIF ID sc1 MATCHCODE OBJECT z_matchcode_field.

  SELECTION-SCREEN END OF BLOCK bl010.
*
  PARAMETERS: p_radio2 RADIOBUTTON GROUP rb1.

  SELECTION-SCREEN BEGIN OF BLOCK bl020 WITH FRAME TITLE TEXT-020.

*    SELECT-OPTIONS: s_select1 FOR table-feld MODIF ID sc2,
*                    s_select2 FOR table-feld MODIF ID sc2,
*                    s_select3 FOR table-feld MODIF ID sc2,
*                    s_select4 FOR table-feld MODIF ID sc2.

*    SELECTION-SCREEN SKIP 1.

*    PARAMETERS : p_list1 AS LISTBOX VISIBLE LENGTH 10 MODIF ID sc2,
*                 p_list2 AS LISTBOX VISIBLE LENGTH 10 MODIF ID sc2.

  SELECTION-SCREEN END OF BLOCK bl020.

SELECTION-SCREEN END OF BLOCK bl000.

AT SELECTION-SCREEN OUTPUT.

LOOP AT SCREEN.

  IF p_radio1 = 'X' AND SCREEN-group1 = 'SC2'.
    SCREEN-active = 0.
    MODIFY SCREEN.
ELSEIF p_radio2 = 'X' AND SCREEN-group1 = 'SC1'.
    SCREEN-active = 0.
    MODIFY SCREEN.
  ENDIF.

ENDLOOP.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file1.

IF p_radio3 IS NOT INITIAL.

  CALL FUNCTION 'F4_FILENAME'
  EXPORTING
*        program_name  = syst-cprog
*        dynpro_number = syst-dynnr
    field_name    = 'p_file1'
  IMPORTING
    file_name     = p_file1.

ENDIF.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file2.

IF p_radio4 IS NOT INITIAL.

  CALL FUNCTION 'F4_FILENAME'
  EXPORTING
    program_name  = syst-cprog
    dynpro_number = syst-dynnr
    field_name    = 'p_file2'
  IMPORTING
    file_name     = p_file2.

ENDIF.