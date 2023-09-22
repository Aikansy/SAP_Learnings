*&---------------------------------------------------------------------*
*&  Include           Y_002_ROK_F01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Form  DATA_INITIALIZATION
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM DATA_INITIALIZATION .

    CLEAR: gt_bkpf,
           gt_bseg,
           gt_bseg_filtered,
           gt_bkpf_key,
           gt_vbrk_key,
           gt_data.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *&      Form  DATA_PROCESSING
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  
  FORM DATA_PROCESSING .
  
    DATA: ls_bkpf_key TYPE ty_bkpf_key,
          ls_vbrk_key TYPE ty_vbrk_key.
  
    " ACCOUNTING DOCUMENT HEADER DATA RETRIEVING
    SELECT bkpf~bukrs, " (bkpf) Company Code
           bkpf~belnr, " (bkpf) Accounting Document Number
           bkpf~gjahr, " (bkpf) Fiscal Year
           bkpf~bldat, " (bkpf) Document Date in Document
           bkpf~awtyp, " (bkpf) Reference Transaction
           bkpf~awkey, " (bkpf) Reference Key (awtyp)
           bkpf~usnam, " (bkpf) User name
           bkpf~waers " (bkpf) Currency Key
      FROM bkpf
      INTO CORRESPONDING FIELDS OF TABLE @gt_bkpf
      WHERE bkpf~bukrs IN @s_bukrs
      AND bkpf~belnr IN @s_belnr
      AND bkpf~bldat >= @p_bldat
      AND ( bkpf~awtyp = 'VBRK' OR bkpf~awtyp = 'BKPF' ).
  *    ORDER BY bkpf~bukrs, bkpf~belnr, bkpf~gjahr. " Not necessary anymore (sorted table)
  
    IF gt_bkpf IS INITIAL.
      MESSAGE 'No data found (BKPF) with the specified criteria.' TYPE 'S' DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  
    SELECT bukrs, " (bkpf) Company Code
           belnr, " (bkpf) Accounting Document Number
           gjahr, " (bkpf) Fiscal Year
           buzei, " (bseg) Line item
           bschl, " (bseg) Posting key
           koart, " (bseg) Account Type
           wrbtr  " (bseg) Amount
      FROM bseg
      INTO CORRESPONDING FIELDS OF TABLE @gt_bseg_filtered
      FOR ALL ENTRIES IN @gt_bkpf
      WHERE bukrs = @gt_bkpf-bukrs
      AND belnr = @gt_bkpf-belnr
      AND gjahr = @gt_bkpf-gjahr
      AND koart = 'D'.
  
    IF gt_bseg_filtered IS INITIAL.
      MESSAGE 'No data found (FILTERED BSEG) with the specified criteria.' TYPE 'S' DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  
    SELECT bukrs, " (bkpf) Company Code
           belnr, " (bkpf) Accounting Document Number
           gjahr, " (bkpf) Fiscal Year
           buzei, " (bseg) Line item
           bschl, " (bseg) Posting key
           koart, " (bseg) Account Type
           wrbtr  " (bseg) Amount
      FROM bseg
      INTO CORRESPONDING FIELDS OF TABLE @gt_bseg
      FOR ALL ENTRIES IN @gt_bseg_filtered
      WHERE bukrs = @gt_bseg_filtered-bukrs
      AND belnr = @gt_bseg_filtered-belnr
      AND gjahr = @gt_bseg_filtered-gjahr.
  
    IF gt_bseg IS INITIAL.
      MESSAGE 'No data found (BSEG) with the specified criteria.' TYPE 'S' DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  
    SORT gt_bseg_filtered BY bukrs belnr gjahr.
    DELETE ADJACENT DUPLICATES FROM gt_bseg_filtered COMPARING bukrs belnr gjahr.
  
    LOOP AT gt_bseg_filtered ASSIGNING FIELD-SYMBOL(<lfs_bseg_filtered>).
      CLEAR: gs_data.
      READ TABLE gt_bkpf ASSIGNING FIELD-SYMBOL(<lfs_bkpf>) WITH KEY bukrs = <lfs_bseg_filtered>-bukrs belnr = <lfs_bseg_filtered>-belnr gjahr = <lfs_bseg_filtered>-gjahr.
  
      gs_data-bukrs = <lfs_bkpf>-bukrs.
      gs_data-belnr = <lfs_bkpf>-belnr.
      gs_data-gjahr = <lfs_bkpf>-gjahr.
      gs_data-bldat  = <lfs_bkpf>-bldat.
      gs_data-awtyp  = <lfs_bkpf>-awtyp.
      gs_data-waers  = <lfs_bkpf>-waers.
  
      CASE <lfs_bkpf>-awtyp.
        WHEN 'BKPF'.
          ls_bkpf_key    = <lfs_bkpf>-awkey.
  
          gs_data-awkey1 = ls_bkpf_key-bukrs.
          gs_data-awkey2 = ls_bkpf_key-belnr.
          gs_data-awkey3 = ls_bkpf_key-gjahr.
          gs_data-awkey4 = ' '.
  
          APPEND ls_bkpf_key TO gt_bkpf_key.
          CLEAR: ls_bkpf_key.
        WHEN 'VBRK'.
          ls_vbrk_key    = <lfs_bkpf>-awkey.
  
          gs_data-awkey1 = ' '.
          gs_data-awkey2 = ' '.
          gs_data-awkey3 = ' '.
          gs_data-awkey4 = <lfs_bkpf>-awkey.
  
          APPEND ls_vbrk_key TO gt_vbrk_key.
          CLEAR: ls_vbrk_key.
        WHEN OTHERS.
          CONTINUE.
      ENDCASE.
  
      LOOP AT gt_bseg ASSIGNING FIELD-SYMBOL(<lfs_bseg>) WHERE bukrs = <lfs_bseg_filtered>-bukrs AND belnr = <lfs_bseg_filtered>-belnr AND gjahr = <lfs_bseg_filtered>-gjahr.
        gs_data-buzei = <lfs_bseg>-buzei.
        gs_data-bschl = <lfs_bseg>-bschl.
        gs_data-koart = <lfs_bseg>-koart.
        gs_data-wrbtr = <lfs_bseg>-wrbtr.
        APPEND gs_data TO gt_data.
      ENDLOOP.
    ENDLOOP.
  
    IF gt_bkpf_key IS NOT INITIAL.
      SELECT bukrs,
             belnr,
             gjahr,
             usnam
        FROM bkpf
        INTO TABLE @DATA(lt_bkpf_ref)
        FOR ALL ENTRIES IN @gt_bkpf_key
        WHERE bukrs = @gt_bkpf_key-bukrs
        AND belnr = @gt_bkpf_key-belnr
        AND gjahr = @gt_bkpf_key-gjahr.
  
      IF sy-subrc = 0.
        SORT lt_bkpf_ref BY bukrs belnr gjahr.
      ENDIF.
    ENDIF.
  
    IF gt_vbrk_key IS NOT INITIAL.
      SELECT vbeln,
             ernam
        FROM vbrk
        INTO TABLE @DATA(lt_vbrk_ref)
        FOR ALL ENTRIES IN @gt_vbrk_key
        WHERE vbeln = @gt_vbrk_key-vbeln.
  
      IF sy-subrc = 0.
        SORT lt_vbrk_ref BY vbeln ernam.
      ENDIF.
    ENDIF.
  
    LOOP AT gt_data ASSIGNING FIELD-SYMBOL(<lfs_data>).
      CASE <lfs_data>-awtyp.
        WHEN 'VBRK'.
          READ TABLE lt_vbrk_ref ASSIGNING FIELD-SYMBOL(<lfs_vbrk_ref>) WITH KEY vbeln = <lfs_data>-awkey4 BINARY SEARCH.
          IF sy-subrc = 0.
            <lfs_data>-usnam = <lfs_vbrk_ref>-ernam.
          ENDIF.
        WHEN 'BKPF'.
          READ TABLE lt_bkpf_ref ASSIGNING FIELD-SYMBOL(<lfs_bkpf_ref>) WITH KEY bukrs = <lfs_data>-awkey1 belnr = <lfs_data>-awkey2 gjahr = <lfs_data>-awkey3 BINARY SEARCH.
          IF sy-subrc = 0.
            <lfs_data>-usnam = <lfs_bkpf_ref>-usnam.
          ENDIF.
        WHEN OTHERS.
      ENDCASE.
    ENDLOOP.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *&      Form  DATA_DISPLAY
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  
  FORM DATA_DISPLAY .
  
    TRY.
        CALL METHOD cl_salv_table=>factory
          IMPORTING
            r_salv_table = go_alv
          CHANGING
            t_table      = gt_data.
  
        CALL METHOD go_alv->set_screen_status
          EXPORTING
            report        = sy-repid
            pfstatus      = 'SALV_STANDARD'
            set_functions = cl_salv_table=>c_functions_all.
  
        go_alv_functions = go_alv->get_functions( ).
        go_alv_functions->set_all( abap_true ).
  
        go_columns = go_alv->get_columns( ).
        go_columns->set_optimize( abap_true ).
  
        " COLORIZATION
        gs_color_red-col  = 7.
        gs_color_red-int  = 1.
        gs_color_blue-col = 4.
        gs_color_blue-int = 1.
  
        go_column ?= go_columns->get_column( 'BUKRS' ).
        go_column->set_color( gs_color_red ).
        go_column ?= go_columns->get_column( 'BELNR' ).
        go_column->set_color( gs_color_red ).
        go_column ?= go_columns->get_column( 'GJAHR' ).
        go_column->set_color( gs_color_red ).
        go_column ?= go_columns->get_column( 'BLDAT' ).
        go_column->set_color( gs_color_red ).
        go_column ?= go_columns->get_column( 'AWTYP' ).
        go_column->set_color( gs_color_red ).
        go_column ?= go_columns->get_column( 'AWKEY1' ).
        go_column->set_color( gs_color_red ).
        go_column ?= go_columns->get_column( 'AWKEY2' ).
        go_column->set_color( gs_color_red ).
        go_column ?= go_columns->get_column( 'AWKEY3' ).
        go_column->set_color( gs_color_red ).
        go_column ?= go_columns->get_column( 'AWKEY4' ).
        go_column->set_color( gs_color_red ).
        go_column ?= go_columns->get_column( 'USNAM' ).
        go_column->set_color( gs_color_red ).
        go_column ?= go_columns->get_column( 'BUZEI' ).
        go_column->set_color( gs_color_blue ).
        go_column ?= go_columns->get_column( 'BSCHL' ).
        go_column->set_color( gs_color_blue ).
        go_column ?= go_columns->get_column( 'KOART' ).
        go_column->set_color( gs_color_blue ).
        go_column ?= go_columns->get_column( 'WAERS' ).
        go_column->set_color( gs_color_blue ).
        go_column ?= go_columns->get_column( 'WRBTR' ).
        go_column->set_color( gs_color_blue ).
  
        gr_events = go_alv->get_event( ).
        CREATE OBJECT go_events.
        SET HANDLER go_events->on_user_command FOR gr_events.
        SET HANDLER lcl_alv_handler=>double_click FOR gr_events.
  
        go_alv->display( ).
  
      CATCH cx_root.
        MESSAGE 'Error in Creating Table' TYPE 'E'.
    ENDTRY.
  
  ENDFORM.
  
  
  *&---------------------------------------------------------------------*
  *&      Form  DOUBLE_CLICK_EVENT
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  
  FORM DOUBLE_CLICK_EVENT USING lv_row    TYPE i
                                lv_column TYPE lvc_fname.
  
    DATA: ls_data LIKE LINE OF gt_data.
  
    READ TABLE gt_data INTO ls_data INDEX lv_row.
  
    IF sy-subrc = 0 AND ls_data IS NOT INITIAL.
      MESSAGE 'Ref. KEY :' && ls_data-awkey4 TYPE 'I'.
    ENDIF.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *&      Form  DATA_DOWNLOAD
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  
  FORM DATA_DOWNLOAD .
  
    DATA: lv_file_path TYPE string.
    lv_file_path = p_file.
  
    CALL FUNCTION 'GUI_DOWNLOAD'
      EXPORTING
        filename              = lv_file_path
        filetype              = 'ASC'
        write_field_separator = ';'
      TABLES
        data_tab              = gt_data
  *     FIELDNAMES            =
      EXCEPTIONS
        OTHERS                = 22.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *&      Form  SHOW_FUNCTION_INFO
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *      -->P_E_SALV_FUNCTION  text
  *      -->P_TEXT_I08  text
  *----------------------------------------------------------------------*
  
  FORM DATA_EXPORT_HANDLER USING i_function TYPE salv_de_function
                                 i_text     TYPE string.
  
    CASE i_function.
      WHEN 'EXPORT'.
        PERFORM DATA_DOWNLOAD.
    ENDCASE.
  
  ENDFORM.