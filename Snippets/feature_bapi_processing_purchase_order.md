# **BAPI PROCESSING PURCHASE ORDER**

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
    po_id         TYPE ekko-ebeln,
    society       TYPE ekko-bukrs,
    doctype       TYPE ekko-bsart,
    seller        TYPE ekko-lifnr,
    purchase_org  TYPE ekko-ekorg,
    purchase_grp  TYPE ekko-ekgrp,
    currency      TYPE ekko-waers,
    post_num      TYPE ekpo-ebelp,
    article_num   TYPE ekpo-matnr,
    division      TYPE ekpo-werks,
    order_qty     TYPE ekpo-menge,
    purchase_unit TYPE ekpo-meins,
    net_price     TYPE ekpo-netpr,
END OF ty_data.

DATA: gt_data             TYPE STANDARD TABLE OF ty_data.
```

`TRANSACTION SLG0 & SLG1`

[STVARV_Options_sélection](https://blogs.sap.com/2012/04/18/create-and-view-log-using-slg0-and-slg1-transaction/)

[STVARV_Options_sélection](http://quelquepart.free.fr/?tag=slg1)

`INCLUDE F01`

```abap
FORM bapi_processing.
    DATA:   lv_ebeln      LIKE ekko-ebeln,
            ls_headerx    LIKE bapimepoheaderx,
            ls_header     TYPE bapimepoheader,
            lt_item       TYPE STANDARD TABLE OF bapimepoitem,
            lt_itemx      TYPE STANDARD TABLE OF bapimepoitemx,
            lv_temp_id    TYPE zid_purchase_order. " Elément de donnée spécifique TYPE char5,

            lt_return     TYPE STANDARD TABLE OF bapiret2.
            ls_item       LIKE LINE OF lt_item,
            ls_itemx      LIKE LINE OF lt_itemx,

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
               lt_item,
               lt_itemx,
               lt_return, 
               lv_ebeln.

        IF <fs_data>-po_id = lv_temp_id.
            CONTINUE.
        ENDIF.
        lv_temp_id = <fs_data>-po_id.

        ls_header-comp_code  = <fs_data>-society.
        ls_header-doc_type   = <fs_data>-doc_type.
        ls_header-vendor     = <fs_data>-vendor.
        ls_header-purch_org  = <fs_data>-purch_org.
        ls_header-pur_group  = <fs_data>-pur_group.
        ls_header-currency   = <fs_data>-currency.

        ls_headerx-comp_code = 'X'.
        ls_headerx-doc_type  = 'X'.
        ls_headerx-vendor    = 'X'.
        ls_headerx-purch_org = 'X'.
        ls_headerx-pur_group = 'X'.
        ls_headerx-currency  = 'X'.

        LOOP AT GT_data ASSIGNING FIELD-SYMBOL(<fs_data_item>) WHERE po_id = <fs_data>-po_id.
            ls_item-po_item    = <fs_data_item>-post_num.
            ls_item-material   = <fs_data_item>-article_num.
            ls_item-plant      = <fs_data_item>-division.
            ls_item-quantity   = <fs_data_item>-order_qty.
            ls_item-po_unit    = <fs_data_item>-purchase_unit.
            ls_item-net_price  = <fs_data_item>-net_price.
            APPEND ls_item TO lt_item.

            ls_itemx-po_item   = 'X'.
            ls_itemx-material  = 'X'.
            ls_itemx-plant     = 'X'.
            ls_itemx-quantity  = 'X'.
            ls_itemx-po_unit   = 'X'.
            ls_itemx-net_price = 'x'.
            APPEND ls_itemx TO lt_itemx.
        ENDLOOP.

        CALL FUNCTION 'BAPI_PO_CREATE1'
            EXPORTING
                poheader  = ls_header
                poheaderx = ls_headerx
            IMPORTING
                expurchaseorder = lv_ebeln
            TABLES
                return           = lt_return
                sales_items_in   = lt_item
                sales_items_inx  = lt_itemx.

        LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<fs_return>) WHERE type = 'E' OR type = 'A'.
            EXIT.
        ENDLOOP.

        IF sy-subrc = 0.
            ls_msg-msgty = 'E'.
            ls_msg-msgid = 'ZFGI_MESSAGES'.
            ls_msg-msgno = 404.
            ls_msg-msgv1 = <fs_data>-po_id.
            ROLLBACK WORK.
        ELSE.
            ls_msg-msgty = 'S'.
            ls_msg-msgid = 'ZFGI_MESSAGES'.
            ls_msg-msgno = 200.
            ls_msg-msgv1 = lv_ebeln.
            ls_msg-msgv2 = <fs_data>-po_id.
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