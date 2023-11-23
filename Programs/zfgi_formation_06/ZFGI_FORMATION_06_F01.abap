*&---------------------------------------------------------------------*
*& Include          ZFGI_FORMATION_06_F01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form select_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM select_data.

    CALL FUNCTION 'ZFGI_PROG_06_SELECT_DATA'
      EXPORTING
        i_ebeln  = s_ebeln[]
        i_matnr  = s_matnr[]
        i_spras  = p_spras
      IMPORTING
        et_final = gt_final.
  
    IF
    sy-subrc = 0.
  
      DATA : lo_alv TYPE REF TO cl_salv_table.
  
      CALL METHOD cl_salv_table=>factory
        IMPORTING
          r_salv_table = lo_alv
        CHANGING
          t_table      = gt_final.
      CALL METHOD lo_alv->display.
  
    ENDIF.
  
  * VERSION AVEC JOINTURE -----------------------------------------------*
  
  *  SELECT ekko~ebeln, ekko~aedat, makt~maktx, ekpo~*
  *  FROM ekko
  *  INNER JOIN ekpo ON ekpo~ebeln = ekko~ebeln
  *  INNER JOIN makt ON makt~matnr = ekpo~matnr
  *  INTO TABLE @gt_final
  *  WHERE ekko~ebeln IN @s_ebeln
  *  AND ekpo~matnr IN @s_matnr
  *  AND ekko~spras = @p_spras.
  
  * VERSION FOR ALL ENTRIES ---------------------------------------------*
  
  *  SELECT ebeln, aedat
  *    FROM ekko
  *    INTO TABLE @DATA(lt_ekko)
  *    WHERE ebeln IN @s_ebeln.
  *
  *  SELECT *
  *    FROM ekpo
  *    INTO TABLE @DATA(lt_ekpo)
  *    FOR ALL ENTRIES IN @lt_ekko
  *    WHERE ebeln = @lt_ekko-ebeln
  *    AND ekpo~matnr IN @s_matnr.
  *
  *  SELECT matnr, maktx
  *    FROM makt
  *    INTO TABLE @DATA(lt_makt)
  *    FOR ALL ENTRIES IN @lt_ekpo
  *    WHERE matnr = @lt_ekpo-matnr
  *    AND spras = @p_spras.
  *
  *  DATA: ls_final LIKE LINE OF gt_final.
  *
  *  LOOP AT lt_ekko INTO DATA(ls_ekko).
  *    ls_final-ebeln1 = ls_ekko-ebeln.
  *    ls_final-aedat1 = ls_ekko-aedat.
  *
  *    LOOP AT lt_ekpo
  *      INTO DATA(ls_ekpo)
  *      WHERE ebeln = ls_ekko-ebeln.
  *
  *      MOVE-CORRESPONDING ls_ekpo TO ls_final.
  *      READ TABLE lt_makt
  *      INTO DATA(ls_makt)
  *      WITH KEY matnr = ls_ekpo-matnr.
  *
  *      IF
  *        sy-subrc = 0.
  *        ls_final-maktx = ls_makt-maktx.
  *      ENDIF.
  *
  *      APPEND ls_final TO gt_final.
  *
  *    ENDLOOP.
  *  ENDLOOP.
  
  *&---------------------------------------------------------------------*
  
  * 1/ STRUCTURE DECLARATIONs SE11
  *
  *     ZFGI_EBELN                      Structure s_ebenl
  *     ZFGI_MATNR                      Structure s_matnr
  *     ZFGI_TY_EKKO_EKPO_MAKT          Structure finale
  
  * 2/ TABLE DECLARATIONs SE11
  *
  *     ZFGI_T_EBELN                    Table Range
  *     ZFGI_T_MATNR                    Table Range
  *     ZFGI_T_EKKO_EKPO_MAKT           Table finale
  
  * 3/ FUNCTION DECLARATION
  *
  *     ZFGI_SELECT_DATA                Fonction de sélection des données.
  *     ZKDE_MAINTENANCE                Groupe de fonction
  
  ENDFORM.