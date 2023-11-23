*&---------------------------------------------------------------------*
*& Include          ZFGI_FORMATION_12_F01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Module STATUS_9001 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

MODULE status_9001 OUTPUT.
  SET PF-STATUS 'STATUT_GUI_9001'.
*  SET TITLEBAR 'RECHERCHE COMMANDE'.

  CREATE OBJECT container
    EXPORTING
      container_name = 'CUSTOM_AREA'.
  CREATE OBJECT html
    EXPORTING
      parent = container.
  CALL METHOD html->show_url
    EXPORTING
      url = 'https://www.sap.com/'.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_9001  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE user_command_9001 INPUT.

  "prise en compte de l'action utilisateur. SY-UCOMM est une variable.
  CASE sy-ucomm.
    WHEN 'BACK' OR 'CANCEL' OR 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'MESSAGE'.
      MESSAGE 'Bonjour' TYPE 'I'.
    WHEN 'EXECUTE'.
      SET PARAMETER ID 'AUN' FIELD gv_vbeln.
      CALL TRANSACTION 'VA03' AND SKIP FIRST SCREEN.
    WHEN 'DISPLAY'.
      IF gv_vbeln IS NOT INITIAL.

        CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
          EXPORTING
            input  = gv_vbeln
          IMPORTING
            output = gv_vbeln.

        SELECT SINGLE vbeln, erdat, auart, erzet, ernam
          FROM vbak
          WHERE vbeln = @gv_vbeln
          INTO @gs_vbak.

        CALL SCREEN 9002.
      ELSE.
        MESSAGE 'Numéro de commande non renseigné' TYPE 'I'.
      ENDIF.
    WHEN 'EXO'.
      CALL SCREEN 9003.
  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_9002 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

MODULE status_9002 OUTPUT.
  SET PF-STATUS 'STATUT_GUI_9002'.
*  SET TITLEBAR 'COMMANDE DE VENTE'.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_9002  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE user_command_9002 INPUT.

  "prise en compte de l'action utilisateur. SY-UCOMM est une variable.
  CASE sy-ucomm.
    WHEN 'BACK' OR 'CANCEL'.
      CALL SCREEN 9001.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'PRECEDENT'.

    WHEN 'SUIVANT'.

    WHEN 'TRANSACTION'.
      SET PARAMETER ID 'AUN' FIELD gs_vbak-vbeln.
      CALL TRANSACTION 'VA03' AND SKIP FIRST SCREEN.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_9003 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

MODULE status_9003 OUTPUT.
  SET PF-STATUS 'STATUT_GUI_9003'.
* SET TITLEBAR 'xxx'.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_9003  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE user_command_9003 INPUT.

  PERFORM user_command.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Form USER_COMMAND
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM user_command.

  SET PARAMETER ID 'MAT' FIELD gv_matnr.

  "prise en compte de l'action utilisateur. SY-UCOMM est une variable.
  CASE sy-ucomm.
    WHEN 'BACK' OR 'CANCEL'.
      CALL SCREEN 9001.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'PRESS'.

      IF gv_matnr_interne = 'X'.

        CALL FUNCTION 'CONVERSION_EXIT_MATN1_INPUT'
          EXPORTING
            input        = gv_matnr
          IMPORTING
            output       = gv_matnr
          EXCEPTIONS
            length_error = 1
            OTHERS       = 2.

      ENDIF.

      SELECT COUNT(*)
      FROM mara
      WHERE matnr = @gv_matnr.

      IF sy-subrc = 0.
        MESSAGE 'Article : ' && gv_matnr && ' trouvé' TYPE 'I'.
      ELSE.
        MESSAGE 'Aucun article trouvé' TYPE 'I'.
      ENDIF.

    WHEN 'FC_LISTE_D'.
      gv_matnr_select = gv_liste_matnr.

    WHEN OTHERS.
  ENDCASE.

ENDFORM.

*&---------------------------------------------------------------------*
*& Module INIT_SCREEN OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

MODULE init_screen OUTPUT.
  SET PF-STATUS 'STATUT_GUI_9003'.
* SET TITLEBAR 'xxx'.

  PERFORM init_screen.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Form init_screen
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM init_screen.

  DATA : lt_valeur_list TYPE STANDARD TABLE OF vrm_value,
         ls_list        LIKE LINE OF lt_valeur_list.

  SELECT mara~matnr, makt~maktx
  FROM mara
  INNER JOIN makt ON makt~matnr = mara~matnr
  WHERE makt~spras = @sy-langu
  INTO TABLE @gt_mara
  UP TO 10 ROWS.

  IF sy-subrc = 0.
    LOOP AT gt_mara ASSIGNING FIELD-SYMBOL(<fs_mara>).
      APPEND VALUE vrm_value( key = <fs_mara>-matnr text = |{ <fs_mara>-matnr }/{ <fs_mara>-maktx }| ) TO lt_valeur_list.
*      ls_list-key = <fs_mara>-matnr.
*      ls_list-text = |{ <fs_mara>-matnr }/{ <fs_mara>-maktx }|.
*      APPEND ls_list TO lt_valeur_list.
    ENDLOOP.
  ENDIF.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = 'GV_LIST_MATNR'
      values          = lt_valeur_list
    EXCEPTIONS
      id_illegal_name = 1.

ENDFORM.