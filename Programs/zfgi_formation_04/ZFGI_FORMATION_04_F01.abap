*&---------------------------------------------------------------------*
*& Include          ZFGI_FORMATION04_F01
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

    *  DATA: lr_fkart TYPE TABLE OF fkart.
    *
    *  SELECT *
    *    FROM tvarvc
    *    INTO TABLE lr_fkart
    *    WHERE name = 'ZTYPE_FACTURE'.
    *
    *  SELECT vbrk~fkdat, vbrk~fkart, vbrp~*
    *    FROM vbrk
    *    INNER JOIN vbrp ON vbrk~vbeln = vbrp~vbeln
    *    INTO TABLE @gt_vbrkp
    *    WHERE vbrk~fkart IN @lr_fkart.
    
    *  SELECT vbrk~fkdat, vbrk~fkart, vbrp~*
    *    FROM vbrk
    *    INNER JOIN vbrp ON vbrk~vbeln = vbrp~vbeln
    *    APPENDING TABLE @gt_vbrkp
    *    WHERE vbrk~fkart = 'S1'.
    
    *&---------------------------------------------------------------------*
    *
    *  SELECT MAX( netwr )
    *    FROM vbrk
    *    INTO @DATA(lv_max).
    *
    *  SELECT MIN( netwr )
    *    FROM vbrk
    *    INTO @DATA(lv_min).
    *
    *  SELECT AVG( netwr )
    *    FROM vbrk
    *    INTO @DATA(lv_avg).
    *
    *  WRITE:  'Montant maximum :', lv_max, 'Euro'.
    *  SKIP.
    *  WRITE:  'Montant minimum :', lv_min, 'Euro'.
    *  SKIP.
    *  WRITE:  'Montant moyen :',   lv_avg, 'Euro'.
    *  SKIP.
    *
    *&---------------------------------------------------------------------*
    
    *  DATA: lo_alv TYPE REF TO cl_salv_table.
    *
    *  CALL METHOD cl_salv_table=>factory
    *    IMPORTING
    *      r_salv_table = lo_alv
    *    CHANGING
    *      t_table      = lt_fkart.
    *  CALL METHOD lo_alv->display.
    
    *  DATA: lo_alv TYPE REF TO cl_salv_table.
    *
    *  CALL METHOD cl_salv_table=>factory
    *    IMPORTING
    *      r_salv_table = lo_alv
    *    CHANGING
    *      t_table      = gt_vbrkp.
    *  CALL METHOD lo_alv->display.
    
    ENDFORM.
    
    *&---------------------------------------------------------------------*
    *& Form display_data
    *&---------------------------------------------------------------------*
    *& text
    *&---------------------------------------------------------------------*
    *& -->  p1        text
    *& <--  p2        text
    *&---------------------------------------------------------------------*
    
    FORM display_data.
    
    ENDFORM.