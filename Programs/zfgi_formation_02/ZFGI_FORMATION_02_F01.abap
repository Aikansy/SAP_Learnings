*&---------------------------------------------------------------------*
*& Include          ZFGI_FORMATION_02_F01
*&---------------------------------------------------------------------*

*select+merge+display
FORM select_data.

    DATA : lt_likp TYPE TABLE OF ty_likp, "livraison : données en-tête
           lt_lips TYPE TABLE OF ty_lips, "Livraison: Données du poste
           lt_marc TYPE TABLE OF ty_marc, "Données division de l'article
           lt_vbrk TYPE TABLE OF ty_vbrk, "Facture : données en-tête
           lt_vbrp TYPE TABLE OF ty_vbrp. "Facture: Données au niveau du poste
  
    SELECT vbeln vstel vkorg erdat
    FROM likp
    INTO TABLE lt_LIKP
    WHERE vbeln IN s_vbelnl.
  
    IF p_del IS INITIAL.
  
      SELECT lips~vbeln lips~posnr lips~matnr lips~werks lips~lfimg lips~meins
      FROM lips
      INNER JOIN mara ON mara~matnr = lips~matnr
      INTO TABLE lt_lips
      FOR ALL ENTRIES       IN LT_likp
      WHERE lips~matnr      IN s_matnr
      AND lips~werks        IN s_werks
      AND lips~vbeln        = lt_likp-vbeln
      AND mara~lvorm        = ''.
  
    ELSE.
  
      SELECT vbeln posnr matnr werks lfimg meins
      FROM lips
      INTO TABLE lt_lips
      FOR ALL ENTRIES       IN LT_likp
      WHERE matnr      IN s_matnr
      AND werks        IN s_werks
      AND vbeln        = lt_likp-vbeln.
  
    ENDIF.
  
    SELECT matnr werks ekgrp
    FROM marc
    INTO TABLE lt_marc
    FOR ALL ENTRIES IN lt_lips
    WHERE matnr = lt_lips-matnr
    AND werks = lt_lips-werks.
  
  * CHECK METHOD --------------------------------------------------------*
  *  CHECK sy-subrc <> 0.
  
  * IF ELSE METHOD ------------------------------------------------------*
    IF
      sy-subrc <> 0.
      MESSAGE TEXT-404 TYPE 'E'.
      EXIT.
    ENDIF.
  
    SELECT vbeln posnr fkimg vrkme ntgew gewei netwr vgbel vgpos
    FROM vbrp
    INTO TABLE lt_vbrp
    FOR ALL ENTRIES IN lt_lips
    WHERE vgpos = lt_lips-posnr
    AND vgbel = lt_lips-vbeln.
  
    SELECT vbeln fkart fkdat waerk
    FROM vbrk
    INTO TABLE lt_vbrk
    FOR ALL ENTRIES IN lt_vbrp
    WHERE vbeln IN s_VBELNv
    AND vbeln = lt_vbrp-vbeln.
  
    PERFORM merge_data USING lt_likp
          lt_lips
          lt_marc
          lt_vbrp
          lt_vbrk.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form merge_data
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *&      --> LT_LIKP
  *&      --> LT_LIPS
  *&      --> LT_MARC
  *&      --> LT_VBRK
  *&      --> LT_VBRP
  *&---------------------------------------------------------------------*
  
  FORM merge_data  USING    ut_likp TYPE ty_t_likp
        ut_lips TYPE ty_t_lips
        ut_marc TYPE ty_t_marc
        ut_vbrp TYPE ty_t_vbrp
        ut_vbrk TYPE ty_t_vbrk.
  
  * STRUCTURE VERSION ---------------------------------------------------*
  
    DATA : ls_final LIKE LINE OF gt_final,
           ls_likp  TYPE ty_likp,
           ls_lips  TYPE ty_lips,
           ls_marc  TYPE ty_marc,
           ls_vbrp  TYPE ty_vbrp,
           ls_vbrk  TYPE ty_vbrk.
  
    LOOP AT ut_likp INTO ls_likp.
  
      CLEAR ls_final.
  
      CONCATENATE: sy-datum+6(2) sy-datum+4(2) sy-datum(4) INTO ls_final-date SEPARATED BY '.'.
  
      ls_final-vbeln = ls_likp-vbeln.
      ls_final-vstel = ls_likp-vstel.
      ls_final-vkorg = ls_likp-vkorg.
      ls_final-erdat = ls_likp-erdat.
  
      If
        sy-subrc <> 0.
        MESSAGE TEXT-404 TYPE 'E'.
        EXIT.
      ENDIF.
  
      LOOP AT ut_lips INTO ls_lips WHERE vbeln = ls_likp-vbeln.
        ls_final-posnr = ls_lips-posnr.
        ls_final-matnr = ls_lips-matnr.
        ls_final-werks = ls_lips-werks.
        ls_final-lfimg = ls_lips-lfimg.
        ls_final-meins = ls_lips-meins.
  
        READ TABLE ut_MARC INTO ls_MARC WITH KEY matnr = ls_lips-matnr
        werks = ls_lips-werks.
        IF sy-subrc = 0.
          ls_final-ekgrp = ls_MARC-ekgrp.
        ENDIF.
  
        READ TABLE ut_VBRP INTO ls_VBRP WITH KEY vgbel = ls_lips-vbeln
        vgpos = ls_lips-posnr.
        IF sy-subrc = 0.
          ls_final-fkimg = ls_VBRP-fkimg.
          ls_final-vrkme = ls_VBRP-vrkme.
          ls_final-ntgew = ls_VBRP-ntgew.
          ls_final-gewei = ls_VBRP-gewei.
          ls_final-netwr = ls_VBRP-netwr.
          ls_final-vgbel = ls_VBRP-vgbel.
          ls_final-vgpos = ls_VBRP-vgpos.
  
          READ TABLE ut_VBRK INTO ls_VBRK WITH KEY vbeln = ls_vbrp-vbeln.
          IF sy-subrc = 0.
            ls_final-fkart = ls_VBRK-fkart.
            ls_final-fkdat = ls_VBRK-fkdat.
            ls_final-waerk = ls_VBRK-waerk.
          ENDIF.
  
        ENDIF.
  
        APPEND ls_final TO gt_final.
  
      ENDLOOP.
  
    ENDLOOP.
  
  * FIELD-SYMBOL VERSION ------------------------------------------------*
  
  *  DATA : ls_final LIKE LINE OF gt_final.
  
  *  LOOP AT ut_likp ASSIGNING FIELD-SYMBOL(<fs_likp>).
  *
  *    CLEAR ls_final.
  *
  *    ls_final-vbeln = <fs_likp>-vbeln.
  *    ls_final-vstel = <fs_likp>-vstel.
  *    ls_final-vkorg = <fs_likp>-vkorg.
  *    ls_final-erdat = <fs_likp>-erdat.
  *
  *        LOOP AT ut_lips ASSIGNING FIELD-SYMBOL(<fs_lips>) WHERE vbeln = <fs_likp>-vbeln.
  *      ls_final-posnr = <fs_lips>-posnr.
  *      ls_final-matnr = <fs_lips>-matnr.
  *      ls_final-werks = <fs_lips>-werks.
  *      ls_final-lfimg = <fs_lips>-lfimg.
  *      ls_final-meins = <fs_lips>-meins.
  *
  *      READ TABLE ut_MARC ASSIGNING FIELD-SYMBOL(<fs_MARC>) WITH KEY matnr = <fs_lips>-matnr
  *                                                                    werks = <fs_lips>-werks.
  *      IF sy-subrc = 0.
  *        ls_final-ekgrp = <fs_MARC>-ekgrp.
  *      ENDIF.
  *
  *      READ TABLE ut_VBRP ASSIGNING FIELD-SYMBOL(<fs_VBRP>) WITH KEY vgbel = <fs_lips>-vbeln
  *                                                                    vgpos = <fs_lips>-posnr.
  *      IF sy-subrc = 0.
  *        ls_final-fkimg = <fs_VBRP>-fkimg.
  *        ls_final-vrkme = <fs_VBRP>-vrkme.
  *        ls_final-ntgew = <fs_VBRP>-ntgew.
  *        ls_final-gewei = <fs_VBRP>-gewei.
  *        ls_final-netwr = <fs_VBRP>-netwr.
  *        ls_final-vgbel = <fs_VBRP>-vgbel.
  *        ls_final-vgpos = <fs_VBRP>-vgpos.
  *
  *        READ TABLE ut_VBRK ASSIGNING FIELD-SYMBOL(<fs_VBRK>) WITH KEY vbeln = <fs_VBRP>-vbeln.
  *        IF sy-subrc = 0.
  *          ls_final-fkart = <fs_VBRK>-fkart.
  *          ls_final-fkdat = <fs_VBRK>-fkdat.
  *          ls_final-waerk = <fs_VBRK>-waerk.
  *        ENDIF.
  *
  *      ENDIF.
  *
  *      APPEND ls_final TO gt_final.
  *
  *    ENDLOOP.
  *
  *  ENDLOOP.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form display
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM display_data.
  
    DATA : lo_alv TYPE REF TO cl_salv_table.
  
    CALL METHOD cl_salv_table=>factory
      IMPORTING
        r_salv_table = lo_alv
      CHANGING
        t_table      = gt_final.
    CALL METHOD lo_alv->display.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form play_data
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM play_data.
  
    LOOP AT gt_final INTO DATA(ls_final2).
      ls_final2-erdat = '20230101'.
      ls_final2-fkart = 'SI'.
      ls_final2-fkimg = '200'.
      MODIFY gt_final FROM ls_final2 TRANSPORTING erdat fkart fkimg WHERE vbeln = ls_final2-vbeln.
    ENDLOOP.
  
    LOOP AT gt_final ASSIGNING FIELD-SYMBOL(<fs_final2>).
      <fs_final2>-erdat = '20230101'.
      <fs_final2>-fkart = 'SI'.
      <fs_final2>-fkimg = '200'.
    ENDLOOP.
  
    READ TABLE gt_final ASSIGNING <fs_final2> WITH KEY vbeln = 'TOTO'.
  
  * 1ere solution
    IF sy-subrc = 0.
      <fs_final2>-matnr = 'TATA'.
    ENDIF.
  
  * 2e solution
  *  IF <fs_final2> is ASSIGNED.
  *    <fs_final2>-matnr = 'TATA'.
  *  ENDIF.
  
  ENDFORM.