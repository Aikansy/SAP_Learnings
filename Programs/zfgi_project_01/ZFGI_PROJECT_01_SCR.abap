*&---------------------------------------------------------------------*
*& Include          ZFGI_PROJECT_01_SCR
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b000 WITH FRAME TITLE TEXT-000.

  PARAMETERS: p_create RADIOBUTTON GROUP rb1 USER-COMMAND uc1 DEFAULT 'X'.

  SELECTION-SCREEN BEGIN OF BLOCK b010 WITH FRAME TITLE TEXT-010.

    PARAMETERS: p_rad1 RADIOBUTTON GROUP rb2 USER-COMMAND fcode MODIF ID sc1 DEFAULT 'X',
                p_lfile TYPE localfile MODIF ID sc1.
*   PARAMETERS: p_sfile TYPE localfile MODIF ID sc1.

    PARAMETERS: p_rad2       RADIOBUTTON GROUP rb2 MODIF ID sc1,
                p_lpath(500) TYPE C MODIF ID sc1,                                     " Chemin fichier
                p_lname(100) TYPE C MODIF ID sc1,                                     " Nom du fichier
                p_arch(500)  TYPE C MODIF ID sc1.

  SELECTION-SCREEN END OF BLOCK b010.

  PARAMETERS: p_diplay RADIOBUTTON GROUP rb1.

  SELECTION-SCREEN BEGIN OF BLOCK b020 WITH FRAME TITLE TEXT-010.

    SELECT-OPTIONS : s_ernam FOR vbak-ernam MODIF ID sc2,
                     s_auart FOR vbak-auart MODIF ID sc2,
                     s_vbeln FOR vbak-vbeln MODIF ID sc2,
                     s_vkorg FOR vbak-vkorg MODIF ID sc2,
                     s_vtweg FOR vbak-vtweg MODIF ID sc2,
                     s_spart FOR vbak-spart MODIF ID sc2,
                     s_kunnr FOR vbap-kunnr_ana MODIF ID sc2,
                     s_matnr FOR vbap-matnr MODIF ID sc2,
                     s_werks FOR vbap-werks MODIF ID sc2,
                     s_erdat FOR vbap-erdat MODIF ID sc2 OBLIGATORY DEFAULT sy-datum.

  SELECTION-SCREEN END OF BLOCK b020.

SELECTION-SCREEN END OF BLOCK b000.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF p_create = 'X' AND screen-group1 = 'SC2'.
      screen-active = 0.
      MODIFY SCREEN.
    ELSEIF p_diplay = 'X' AND screen-group1 = 'SC1'.
      screen-active = 0.
      MODIFY SCREEN.
    ENDIF.

  ENDLOOP.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_lfile.

  CALL FUNCTION 'F4_FILENAME' "Local upload
    EXPORTING
      program_name  = syst-cprog
      dynpro_number = syst-dynnr
      field_name    = 'p_file'
    IMPORTING
      file_name     = p_lfile.

*AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_sfile.
*
*  CALL FUNCTION 'F4_FILENAME' "Server upload
*    EXPORTING
*      program_name  = syst-cprog
*      dynpro_number = syst-dynnr
*      field_name    = 'p_file'
*    IMPORTING
*      file_name     = p_sfile.