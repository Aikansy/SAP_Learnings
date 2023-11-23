*&---------------------------------------------------------------------*
*& Include          ZFGI_FORMATION_03_SCR
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b00 WITH FRAME TITLE TEXT-000.

  SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME TITLE TEXT-001.
    PARAMETERS:       p_france AS CHECKBOX USER-COMMAND flag,
                      p_world  AS CHECKBOX USER-COMMAND flag.
  SELECTION-SCREEN END OF BLOCK b01.

  SELECTION-SCREEN BEGIN OF BLOCK b02 WITH FRAME TITLE TEXT-002.
    SELECT-OPTIONS:   s_vbeln FOR vbak-vbeln MODIF ID bl2,
                      s_matnr FOR vbap-matnr MODIF ID bl2,
                      s_charg FOR vbap-charg MODIF ID bl2,
                      s_kunnr FOR vbap-kunnr_ana MODIF ID bl2.
  SELECTION-SCREEN END OF BLOCK b02.

  SELECTION-SCREEN BEGIN OF BLOCK b03 WITH FRAME TITLE TEXT-003.
    SELECT-OPTIONS:   s_vbelnw FOR vbak-vbeln MODIF ID bl3,
                      s_matnrw FOR vbap-matnr MODIF ID bl3,
                      s_chargw FOR vbap-charg MODIF ID bl3,
                      s_kunnrw FOR vbap-kunnr_ana MODIF ID bl3.
  SELECTION-SCREEN END OF BLOCK b03.

SELECTION-SCREEN END OF BLOCK b00.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF
      p_france <> 'X' AND
      screen-group1 = 'BL2'.
      screen-active = '0'.
    ELSEIF
      p_world <> 'X' AND
      screen-group1 = 'BL3'.
      screen-active = '0'.
    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.