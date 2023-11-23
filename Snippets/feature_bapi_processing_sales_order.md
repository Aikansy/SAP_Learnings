# **BAPI PROCESSING SALES ORDER**

`PROGRAM`

```abap
REPORT zfgi_prog NO STANDARD PAGE HEADING.

INCLUDE zfgi_prog_top.
INCLUDE zfgi_prog_scr.
INCLUDE zfgi_prog_f01.

INITIALIZATION.

START-OF-SELECTION.

    PERFORM BAPI_PROCESSING.

END-OF-SELECTION.
```

`INCLUDE TOP`

```abap
TYPES: BEGIN OF ty_data,
    id_com        TYPE zid_com_po,
    doc_type      TYPE vbak-auart,
    sales_org     TYPE vbak-vkorg,
    distr_chan    TYPE vbak-vtweg,
    sect_act      TYPE vbak-spart,
    partn_role_ag TYPE parvw,
    partn_numb_ag TYPE vbak-kunnr,
    partn_role_we TYPE parvw,
    partn_numb_we TYPE vbak-kunnr,
    itm_numb      TYPE vbap-posnr,
    material      TYPE vbap-matnr,
    plant         TYPE vbap-werks,
    quantity      TYPE vbap-zmeng,
    quantity_unit TYPE vbap-zieme,
END OF ty_data.

DATA: gt_data             TYPE STANDARD TABLE OF ty_data.
```

`TRANSACTION SLG0 & SLG1`

[STVARV_Options_sélection](https://blogs.sap.com/2012/04/18/create-and-view-log-using-slg0-and-slg1-transaction/)

[STVARV_Options_sélection](http://quelquepart.free.fr/?tag=slg1)

`INCLUDE F01`

```abap
FORM bapi_processing.
    DATA:   lv_vbeln      LIKE vbak-vbeln,
            ls_headerx    LIKE bapisdhead1x,
            ls_header     TYPE bapisdhead1,
            lt_item       TYPE STANDARD TABLE OF bapisditem,
            lt_itemx      TYPE STANDARD TABLE OF bapisditemx,
            lt_partner    TYPE STANDARD TABLE OF bapipartnr,
            lv_temp_id    TYPE zid_sales_order. " Elément de donnée spécifique TYPE char5,

            lt_return     TYPE STANDARD TABLE OF bapiret2.
            ls_item       LIKE LINE OF lt_item,
            ls_itemx      LIKE LINE OF lt_itemx,
            ls_partner    LIKE LINE OF lt_partner,

            ls_log        TYPE bal_s_log,
            ls_log_handle TYPE balloghndl,
            lt_log_handle TYPE bal_t_logh,
            ls_msg        TYPE bal_s_msg.

    CONSTANTS : lc_object TYPE balobj_d VALUE 'ZPROJ_CV'.

    CLEAR: ls_log,
           ls_msg.

    ls_log-object     = 'ZLOG_PROJ'.
    ls_log-aldate_del = sy-datum + 7. "effacement apres 30j
    ls_log-aluser     = sy-uname.
    ls_log-alprog     = sy-repid.

    CALL FUNCTION 'BAL_LOG_CREATE'
        EXPORTING
            i_s_log                 = ls_log
        IMPORTING
            e_log_handle            = ls_log_handle
        EXCEPTIONS
            log_header_inconsistent = 1
        OTHERS                      = 2.
    IF sy-subrc <> 0.
        EXIT.
    ENDIF.

    LOOP AT gt_data ASSIGNING FIELD-SYMBOL(<fs_data>).
        CLEAR: ls_header,
               ls_headerx,
               ls_partner, 
               lt_partner, 
               lt_item,
               lt_itemx,
               lt_return, 
               lv_vbeln.

        IF <fs_data>-id_com = lv_temp_id.
            CONTINUE.
        ENDIF.
        lv_temp_id = <fs_data>-id_com.

        ls_header-doc_type    = <fs_data>-doc_type.
        ls_header-sales_org   = <fs_data>-sales_org.
        ls_header-distr_chan  = <fs_data>-distr_chan.
        ls_header-division    = <fs_data>-sect_act.
        ls_header-req_date_h  = sy-datum + 5.

        ls_headerx-doc_type   = 'X'.
        ls_headerx-sales_org  = 'X'.
        ls_headerx-distr_chan = 'X'.
        ls_headerx-division   = 'X'.
        ls_headerx-req_date_h = 'X'.
        ls_headerx-updateflag = 'I'.

        ls_partner-partn_numb = <fs_data>-partn_numb_ag.
        ls_partner-partn_role = <fs_data>-partn_role_ag.
        APPEND ls_partner TO lt_partner.

        ls_partner-partn_numb = <fs_data>-partn_numb_we.
        ls_partner-partn_role = <fs_data>-partn_role_we.
        APPEND ls_partner TO lt_partner.

        LOOP AT GT_data ASSIGNING FIELD-SYMBOL(<fs_data_item>) WHERE id_com = <fs_data>-id_com.
            CALL FUNCTION 'CONVERSION_EXIT_CUNIT_INPUT'
                EXPORTING
                    input           = <fs_data2>-quantity_unit
                    language        = sy-langu
                IMPORTING
                    output          = <fs_data2>-quantity_unit
                EXCEPTIONS
                    unit_not_found  = 1
                    OTHERS          = 2.

            ls_item-itm_number  = <fs_data_item>-itm_numb.
            ls_item-material    = <fs_data_item>-material.
            ls_item-plant       = <fs_data_item>-plant.
            ls_item-target_qty  = <fs_data_item>-quantity.
            ls_item-target_qu   = <fs_data2>-quantity_unit.
            APPEND ls_item TO lt_item.

            ls_itemx-itm_number = 'X'.
            ls_itemx-material   = 'X'.
            ls_itemx-plant      = 'X'.
            ls_itemx-target_qty = 'X'.
            ls_itemx-target_qu  = 'X'.
            ls_itemx-updateflag = 'I'.
            APPEND ls_itemx TO lt_itemx.
        ENDLOOP.

        CALL FUNCTION 'BAPI_SALESDOCU_CREATEFROMDATA1'
            EXPORTING
                sales_header_in  = ls_header
                sales_header_inx = ls_headerx
            IMPORTING
                salesdocument_ex = lv_vbeln
            TABLES
                return           = lt_return
                sales_items_in   = lt_item
                sales_items_inx  = lt_itemx
                sales_partners   = lt_partner.

        LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<fs_return>) WHERE type = 'E' OR type = 'A'.
            EXIT.
        ENDLOOP.

        IF sy-subrc = 0.
            ls_msg-msgty = 'E'.
            ls_msg-msgid = 'ZFGI_MESSAGES'.
            ls_msg-msgno = 404.
            ls_msg-msgv1 = <fs_data>-id_com.
            ROLLBACK WORK.
        ELSE.
            ls_msg-msgty = 'S'.
            ls_msg-msgid = 'ZFGI_MESSAGES'.
            ls_msg-msgno = 200.
            ls_msg-msgv1 = lv_vbeln.
            ls_msg-msgv2 = <fs_data>-id_com.
            COMMIT WORK AND WAIT.
        ENDIF.

        CALL FUNCTION 'BAL_LOG_MSG_ADD'
            EXPORTING
                i_log_handle     = ls_log_handle
                i_s_msg          = ls_msg
            EXCEPTIONS
                log_not_found    = 1
                msg_inconsistent = 2
                log_is_full      = 3
                OTHERS           = 4.
        IF sy-subrc = 0.
            INSERT ls_log_handle INTO TABLE lt_log_handle.
        ENDIF.
    ENDLOOP.

    CALL FUNCTION 'BAL_DB_SAVE'
        EXPORTING
            i_client         = sy-mandt
            i_save_all       = 'X'
            i_t_log_handle   = lt_log_handle
        EXCEPTIONS
            log_not_found    = 1
            save_not_allowed = 2
            numbering_error  = 3
            OTHERS           = 4.
    IF sy-subrc <> 0.
        MESSAGE 'BAL_DB_SAVE' TYPE 'E'.
    ENDIF.

    CALL FUNCTION 'BAL_DSP_LOG_DISPLAY'
        EXPORTING
            I_T_LOG_HANDLE                      = lt_log_handle
        EXCEPTIONS
            PROFILE_INCONSISTENT                = 1
            INTERNAL_ERROR                      = 2
            NO_DATA_AVAILABLE                   = 3
            NO_AUTHORITY                        = 4
            OTHERS                              = 5.
    IF sy-subrc <> 0.
        EXIT.
    ENDIF.
ENDFORM.
```