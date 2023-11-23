*&---------------------------------------------------------------------*
*& Include          ZJLMF_PROJECT_01_F01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form data_retrieve
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM data_extraction_local.

    DATA: lv_fileline TYPE string.
    lv_fileline = p_lfile.
  
    CALL FUNCTION 'GUI_UPLOAD'
      EXPORTING
        filename = lv_fileline
        filetype = 'ASC'
      TABLES
        data_tab = gt_line.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form data_extraction_server
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM data_extraction_server .
  
    DATA: ls_sfile     LIKE LINE OF gt_sfile,
          lv_filename TYPE rlgrap-filename.
          "lv_string   TYPE string,
  
    IF p_rad2 = 'X'.
      CONCATENATE p_lpath p_lname INTO lv_filename SEPARATED BY '/'.
      TRANSLATE lv_filename TO LOWER CASE.
      OPEN DATASET lv_filename FOR INPUT IN TEXT MODE ENCODING DEFAULT. "variabla a changer en fonction du type i.e ut-8/binary
      IF sy-subrc IS INITIAL.
        DO.
          CLEAR ls_sfile.
          READ DATASET lv_filename INTO ls_sfile-LINE.
          IF sy-subrc = 0.
            APPEND ls_sfile TO gt_sfile.
          ELSE.
            EXIT.
          ENDIF.
        ENDDO.
      ENDIF.
    ENDIF.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form data_prepare
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM data_preparation.
  
    DATA: lr_doc_type TYPE RANGE OF tvarvc-low.
  
    SELECT sign
    opti
    low
    high
    FROM tvarvc
    INTO TABLE lr_doc_type
    WHERE name = 'ZTYPE_DOC_JLMF' AND type = 'S'.
  
    IF lines( gt_line ) > 1.
  
      DELETE gt_line INDEX 1.
  
      LOOP AT gt_line ASSIGNING FIELD-SYMBOL(<fs_line>).
  
        SPLIT <fs_line>-fileline AT ';' INTO TABLE DATA(lt_split_csv).
        SPLIT lt_split_csv[ 1 ] AT 'P' INTO TABLE DATA(lt_split_id).
  
        IF lt_split_csv IS NOT INITIAL AND lines( lt_split_csv ) = 14  AND lt_split_csv[ 2 ] IN lr_doc_type.
  
          APPEND INITIAL LINE TO gt_file ASSIGNING FIELD-SYMBOL(<fs_file>).
  
          IF <fs_file> IS ASSIGNED.
  
            <fs_file>-compteur_commande   = lt_split_csv[ 1 ].
            <fs_file>-doc_type            = lt_split_csv[ 2 ].
            <fs_file>-sales_org           = lt_split_csv[ 3 ].
            <fs_file>-distr_chan          = lt_split_csv[ 4 ].
            <fs_file>-sect_act            = lt_split_csv[ 5 ].
            <fs_file>-partn_role_ag       = lt_split_csv[ 6 ].
            <fs_file>-partn_numb_ag       = lt_split_csv[ 7 ].
            <fs_file>-partn_role_we       = lt_split_csv[ 8 ].
            <fs_file>-partn_num_we        = lt_split_csv[ 9 ].
            <fs_file>-itm_numb            = lt_split_csv[ 10 ].
            <fs_file>-material            = lt_split_csv[ 11 ].
            <fs_file>-plant               = lt_split_csv[ 12 ].
            <fs_file>-quantity            = lt_split_csv[ 13 ].
            <fs_file>-quantity_unit       = lt_split_csv[ 14 ].
            <fs_file>-id_com              = lt_split_id[ 1 ].
            <fs_file>-id_post             = lt_split_id[ 2 ].
  
          ENDIF.
  
        ENDIF.
  
      ENDLOOP.
  
    ENDIF.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form data_verification
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM data_verification.
  
    SELECT vbak~vkorg,
    vbak~vtweg,
    vbak~spart,
    knvp~parvw,
    knvp~kunnr,
    vbap~posnr,
    mara~matnr,
    vbak~bukrs_vf
    FROM vbak
    INNER JOIN vbap ON vbap~vbeln = vbak~vbeln
    INNER JOIN knvp ON knvp~kunnr = vbak~kunnr
    INNER JOIN mara ON mara~matnr = vbap~matnr
    INTO TABLE @DATA(lt_select).
  
    DATA: ls_select LIKE LINE OF lt_select,
          index     TYPE i VALUE '1',
          v         TYPE boolean VALUE 't'.
  
    LOOP AT gt_file ASSIGNING FIELD-SYMBOL(<fs_file>).
      v = 't'.
  
      READ TABLE lt_select TRANSPORTING NO FIELDS
      WITH KEY vkorg = <fs_file>-sales_org.
  
      IF sy-subrc = 0.
        READ TABLE lt_select TRANSPORTING NO FIELDS
        WITH KEY vtweg = <fs_file>-distr_chan.
  
        IF sy-subrc = 0.
          READ TABLE lt_select TRANSPORTING NO FIELDS
          WITH KEY spart = <fs_file>-sect_act.
  
          IF sy-subrc = 0.
            READ TABLE lt_select TRANSPORTING NO FIELDS
            WITH KEY parvw = <fs_file>-partn_role_ag.
  
            IF sy-subrc = 0.
              READ TABLE lt_select TRANSPORTING NO FIELDS
              WITH KEY kunnr = <fs_file>-partn_numb_ag.
  
              IF sy-subrc = 0.
                READ TABLE lt_select TRANSPORTING NO FIELDS
                WITH KEY parvw = <fs_file>-partn_role_we.
  
                IF sy-subrc = 0.
                  READ TABLE lt_select TRANSPORTING NO FIELDS
                  WITH KEY kunnr = <fs_file>-partn_num_we.
  
                  IF sy-subrc = 0.
                    READ TABLE lt_select TRANSPORTING NO FIELDS
                    WITH KEY posnr = <fs_file>-itm_numb.
  
                    IF sy-subrc = 0.
                      READ TABLE lt_select TRANSPORTING NO FIELDS
                      WITH KEY matnr = <fs_file>-material.
  
                      IF sy-subrc = 0.
                        READ TABLE lt_select TRANSPORTING NO FIELDS
                        WITH KEY bukrs_vf = <fs_file>-plant.
  
                        IF sy-subrc = 0.
  
                        ELSE.
                          v = 'f' .
                        ENDIF.
                      ELSE.
                        v = 'f' .
                      ENDIF.
                    ELSE.
                      v = 'f' .
                    ENDIF.
                  ELSE.
                    v = 'f' .
                  ENDIF.
                ELSE.
                  v = 'f' .
                ENDIF.
              ELSE.
                v = 'f' .
              ENDIF.
            ELSE.
              v = 'f' .
            ENDIF.
          ELSE.
            v = 'f' .
          ENDIF.
        ELSE.
          v = 'f' .
        ENDIF.
      ELSE.
        v = 'f' .
      ENDIF.
      IF v = 'f' .
        DELETE gt_file INDEX index.
        index = index - 1.
      ENDIF.
      index = index + 1.
    ENDLOOP.
  
    TRY.
        DATA : lo_alv           TYPE REF TO cl_salv_table,
               lo_alv_functions TYPE REF TO cl_salv_functions,
               lo_columns       TYPE REF TO cl_salv_columns_table,
               message          TYPE REF TO cx_salv_msg.
  
        cl_salv_table=>factory(
        IMPORTING
          r_salv_table = lo_alv
        CHANGING
          t_table      = gt_file ).
  
        lo_alv_functions = lo_alv->get_functions( ).
        lo_alv_functions->set_all( abap_true ).
  
        lo_columns = lo_alv->get_columns( ).
        lo_columns->set_optimize( abap_true ).
  
        lo_alv->display( ).
  
      CATCH cx_salv_msg INTO message.
    ENDTRY.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form client_order_creation
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM client_order_creation.
  
    DATA: ls_file  TYPE zsjlmf_file_01.
  
    DATA: lv_salesdocument   TYPE bapivbeln-vbeln.
  
    DATA: lt_return          TYPE TABLE OF bapiret2,
  
          lt_order_items_in  TYPE TABLE OF bapisditm,
          lt_order_items_inx TYPE TABLE OF bapisditmx,
          lt_order_partners  TYPE TABLE OF bapiparnr,
  
          lt_schedules       TYPE TABLE OF bapischdl,
          lt_schedulesx      TYPE TABLE OF bapischdlx,
  
          lt_conditions      TYPE TABLE OF bapicond,
          lt_conditionsx     TYPE TABLE OF bapicondx.
  
    DATA: ls_return           TYPE bapiret2,
          ls_order_header_in  TYPE bapisdhd1,
          ls_order_header_inx TYPE bapisdhd1x,
  
          ls_order_items_in   TYPE bapisditm,
          ls_order_items_inx  TYPE bapisditmx,
          ls_order_partners   LIKE bapiparnr,
          ls_schedules        TYPE bapischdl,
          ls_schedulesx       TYPE bapischdlx,
          ls_conditions       TYPE bapicond,
          ls_conditionsX      TYPE bapicondx.
  
    ls_order_header_inx-ref_1        = 'X'.
    ls_order_header_inx-doc_type     = 'X'.
    ls_order_header_inx-sales_org    = 'X'.
    ls_order_header_inx-distr_chan   = 'X'.
    ls_order_header_inx-division     = 'X'.
    ls_order_header_inx-req_date_h   = 'X'.
    ls_order_header_inx-updateflag   = 'I'.
  
    ls_order_items_inx-itm_number    = 'X'.
    ls_order_items_inx-material      = 'X'.
    ls_order_items_inx-plant         = 'X'.
    ls_order_items_inx-target_qty    = 'X'.
    ls_order_items_inx-po_unit       = 'X'.
  
    ls_schedulesx-itm_number         = 'X'.
    ls_schedulesx-dlv_date           = 'X'.
  
    LOOP AT gt_file INTO ls_file.
  
      SELECT DISTINCT * FROM @gt_file AS lt_file
      WHERE id_com = @ls_file-id_com
      INTO TABLE @DATA(it_grp).
  
      DATA(lv_count) = lines( it_grp ).
  
      IF lv_count <= 0.
        EXIT.
      ENDIF.
  
      DO lv_count / lv_count TIMES.
  
        CLEAR:
        ls_order_header_in,
        ls_order_items_in,
        ls_schedules,
  
        lt_order_items_in,
        lt_schedules,
        lt_return.
  
        LOOP AT it_grp ASSIGNING FIELD-SYMBOL(<fs_file>).
  
          ls_order_header_in-ref_1       = <fs_file>-compteur_commande.
          ls_order_header_in-doc_type    = <fs_file>-doc_type.
          ls_order_header_in-sales_org   = <fs_file>-sales_org.
          ls_order_header_in-distr_chan  = <fs_file>-distr_chan.
          ls_order_header_in-division    = <fs_file>-sect_act.
          ls_order_header_in-req_date_h  = sy-datum.
  
          ls_order_items_in-itm_number   = <fs_file>-itm_numb.
          ls_order_items_in-material     = <fs_file>-material.
          ls_order_items_in-plant        = <fs_file>-plant.
          ls_order_items_in-target_qty   = <fs_file>-quantity.
  
          APPEND ls_order_items_in TO lt_order_items_in.
          APPEND ls_order_items_inx TO lt_order_items_inx.
  
          ls_order_partners-partn_role   = <fs_file>-partn_role_ag.
          ls_order_partners-partn_numb   = <fs_file>-partn_numb_ag.
  
          APPEND ls_order_partners TO lt_order_partners.
  
          ls_order_partners-partn_role   = <fs_file>-partn_role_we.
          ls_order_partners-partn_numb   = <fs_file>-partn_num_we.
  
          APPEND ls_order_partners TO lt_order_partners.
  
          ls_schedules-itm_number        =  <fs_file>-itm_numb.
          ls_schedules-dlv_date          =  sy-datum + 5.
  
          APPEND ls_schedules TO lt_schedules.
          APPEND ls_schedulesx TO lt_schedulesx.
  
        ENDLOOP.
  
        CALL FUNCTION 'BAPI_SALESORDER_CREATEFROMDAT2'
          EXPORTING
            salesdocumentin     = ''
            order_header_in     = ls_order_header_in
            order_header_inx    = ls_order_header_inx
          IMPORTING
            salesdocument       = lv_salesdocument
          TABLES
            return              = lt_return
            order_items_in      = lt_order_items_in
            order_items_inx     = lt_order_items_inx
            order_partners      = lt_order_partners
            order_schedules_in  = lt_schedules
            order_schedules_inx = lt_schedulesx.
  
        READ TABLE lt_return INTO ls_return WITH KEY type = 'E'.
  
        IF sy-subrc = 0.
          APPEND ls_return TO gt_return.
          CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
        ELSE.
          ls_return-type = 'S'.
          ls_return-message = 'Commande:' && <fs_file>-compteur_commande && ' VBELN:' && lv_salesdocument && ' QUANTITY: ' && ls_order_items_in-target_qty && ' Créé avec succés'.
  
          APPEND ls_return TO gt_return.
          CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
        ENDIF.
  
        DELETE gt_file WHERE id_com = ls_file-id_com.
  
      ENDDO.
  
    ENDLOOP.
  
    TRY.
        DATA : lo_alv           TYPE REF TO cl_salv_table,
               lo_alv_functions TYPE REF TO cl_salv_functions,
               lo_columns       TYPE REF TO cl_salv_columns_table,
               message          TYPE REF TO cx_salv_msg.
  
        cl_salv_table=>factory(
        IMPORTING
          r_salv_table = lo_alv
        CHANGING
          t_table      = gt_return ).
  
        lo_alv_functions = lo_alv->get_functions( ).
        lo_alv_functions->set_all( abap_true ).
  
        lo_columns = lo_alv->get_columns( ).
        lo_columns->set_optimize( abap_true ).
  
        lo_alv->display( ).
  
      CATCH cx_salv_msg INTO message.
    ENDTRY.
  
  ENDFORM.
  
  
  *&---------------------------------------------------------------------*
  *& Form display_client_order
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM display_client_order .
  
    SELECT vbak~ernam, vbak~auart, vbak~vbeln, vbak~erdat, vbap~matnr
      FROM vbak
      INNER JOIN vbap ON vbap~vbeln = vbak~vbeln
      WHERE vbak~ernam IN @s_ernam
      INTO TABLE @DATA(t_ty_final).
  
    TRY.
      DATA : lo_alv           TYPE REF TO cl_salv_table,
            lo_alv_functions TYPE REF TO cl_salv_functions,
            lo_columns       TYPE REF TO cl_salv_columns_table,
            MESSAGE          TYPE REF TO cx_salv_msg.
  
      cl_salv_table=>factory(
      IMPORTING
        r_salv_table = lo_alv
      CHANGING
        t_table      = t_ty_final ).
  
      lo_alv_functions = lo_alv->get_functions( ).
      lo_alv_functions->set_all( abap_true ).
  
      lo_columns = lo_alv->get_columns( ).
      lo_columns->set_optimize( abap_true ).
  
      lo_alv->display( ).
  
    CATCH cx_salv_msg INTO MESSAGE.
    ENDTRY.
  
  ENDFORM.