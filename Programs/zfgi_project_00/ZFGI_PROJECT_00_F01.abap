*&-------------------------------------------------------------------------------------------------------*
*& Include          ZFGI_PROJET_00_F01
*&-------------------------------------------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form data_retrieve
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM data_retrieve.

    " Local variable declaration to store file data as string
    DATA: lv_fileline TYPE string.
    lv_fileline = p_file1.
  
    " Retrieve datas from uploaded file into gt_line table
    CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename                = lv_fileline
      filetype                = 'ASC'
      has_field_separator     = ';'
  *     HEADER_LENGTH           = 1
  *     READ_BY_LINE            = 'X'
  *     DAT_MODE                = ' '
  *     CODEPAGE                = ' '
  *     IGNORE_CERR             = ABAP_TRUE
  *     REPLACEMENT             = '#'
  *     CHECK_BOM               = ' '
  *     VIRUS_SCAN_PROFILE      =
  *     NO_AUTH_CHECK           = ' '
  *   IMPORTING
  *     FILELENGTH              =
  *     HEADER                  =
    TABLES
      data_tab                = gt_line
  *   CHANGING
  *     ISSCANPERFORMED         = ' '
    EXCEPTIONS
      file_open_error         = 1
      file_read_error         = 2
      no_batch                = 3
      gui_refuse_filetransfer = 4
      invalid_type            = 5
      no_authority            = 6
      unknown_error           = 7
      bad_data_format         = 8
      header_not_allowed      = 9
      separator_not_allowed   = 10
      header_too_long         = 11
      unknown_dp_error        = 12
      access_denied           = 13
      dp_out_of_memory        = 14
      disk_full               = 15
      dp_timeout              = 16
      OTHERS                  = 17.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form data_entries
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM data_entries.
  
    IF LINES( gt_line ) > 1.
  
      " Delete field-name row
      DELETE gt_line INDEX 1.
  
      " For each value in gt_line...
      LOOP AT gt_line ASSIGNING FIELD-SYMBOL(<fs_line>).
  
        " ...Delete and split value at ';' into lt_splitline table...
        SPLIT <fs_line>-fileline AT ';' INTO TABLE DATA(lt_splitline).
  
        " ...and append value to respecting field in gt_file table
        APPEND INITIAL LINE TO gt_file ASSIGNING FIELD-SYMBOL(<fs_file>).
  
        " IF pointer detect value, assigns values ​​to fields defined by their index
        IF <fs_file> IS ASSIGNED.
          <fs_file>-po_id         = lt_splitline[ 1 ].
          <fs_file>-society       = lt_splitline[ 2 ].
          <fs_file>-doctype       = lt_splitline[ 3 ].
          <fs_file>-seller        = lt_splitline[ 4 ].
          <fs_file>-purchase_org  = lt_splitline[ 5 ].
          <fs_file>-purchase_grp  = lt_splitline[ 6 ].
          <fs_file>-CURRENCY      = lt_splitline[ 7 ].
          <fs_file>-post_num      = lt_splitline[ 8 ].
          <fs_file>-article_num   = lt_splitline[ 9 ].
          <fs_file>-division      = lt_splitline[ 10 ].
          <fs_file>-order_qty     = lt_splitline[ 11 ].
          <fs_file>-purchase_unit = lt_splitline[ 12 ].
          <fs_file>-net_price     = lt_splitline[ 13 ].
        ENDIF.
  
      ENDLOOP.
  
    ENDIF.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form data_display
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM data_display.
  
    DATA : lo_alv           TYPE REF TO cl_salv_table,
          lo_alv_functions TYPE REF TO cl_salv_functions,
          lo_columns       TYPE REF TO cl_salv_columns_table.
  
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
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form po_create
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM purchase_order_creation.
  
    " Table declarations for BAPi
    DATA: lt_poitem    TYPE TABLE OF bapimepoitem,     " it_poitem
          lt_poitemx   TYPE TABLE OF bapimepoitemx,    " it_poitemx
          lt_bapiret2  TYPE TABLE OF bapiret2.         " it_bapiret2
  
    " Structure declarations for BAPi
    DATA: ls_poheader  TYPE bapimepoheader,            " wa_poheader
          ls_poheaderx TYPE bapimepoheaderx,           " wa_poheaderx
          ls_poitem    LIKE LINE OF lt_poitem,         " wa_poitem
          ls_poitemx   LIKE LINE OF lt_poitemx,        " wa_poitemx
          ls_bapiret2  LIKE LINE OF lt_bapiret2.       " wa_bapiret2
  
    " CLear structures avoid repetitions
    CLEAR: ls_poheader,
    ls_poheaderx,
    ls_poitem,
    ls_poitemx.
  
    " Used field indicator
    ls_poheaderx-comp_code = 'X'.
    ls_poheaderx-doc_type  = 'X'.
    ls_poheaderx-vendor    = 'X'.
    ls_poheaderx-purch_org = 'X'.
    ls_poheaderx-pur_group = 'X'.
    ls_poheaderx-CURRENCY  = 'X'.
  
    ls_poitemx-po_item     = 'X'.
    ls_poitemx-material    = 'X'.
    ls_poitemx-plant       = 'X'.
    ls_poitemx-quantity    = 'X'.
    ls_poitemx-po_unit     = 'X'.
    ls_poitemx-net_price   = 'X'.
  
  * VALUE ATTRIBUTIONS --------------------------------------------------*
  
    " For each rows from gt_file...
    LOOP AT gt_file ASSIGNING FIELD-SYMBOL(<fs_data>).
  
      ls_poheader-comp_code  = <fs_data>-society.
      ls_poheader-doc_type   = <fs_data>-doctype.
      ls_poheader-vendor     = <fs_data>-seller.
      ls_poheader-purch_org  = <fs_data>-purchase_org.
      ls_poheader-pur_group  = <fs_data>-purchase_grp.
      ls_poheader-CURRENCY   = <fs_data>-CURRENCY.
  
      ls_poitem-po_item      = <fs_data>-post_num.
      ls_poitem-material     = <fs_data>-article_num.
      ls_poitem-plant        = <fs_data>-division.
      ls_poitem-quantity     = <fs_data>-order_qty.
      ls_poitem-po_unit      = <fs_data>-purchase_unit.
      ls_poitem-net_price    = <fs_data>-net_price.
  
  * APPEND VALUES -------------------------------------------------------*
  
      APPEND ls_poitem TO lt_poitem.
      APPEND ls_poitemx TO lt_poitemx.
  
  * BAPI_PO_CREATE1 -----------------------------------------------------*
  
      CALL FUNCTION 'BAPI_PO_CREATE1'
      EXPORTING
        poheader  = ls_poheader
        poheaderx = ls_poheaderx
  *       POADDRVENDOR                 =
  *       TESTRUN   =
  *       MEMORY_UNCOMPLETE            =
  *       MEMORY_COMPLETE              =
  *       POEXPIMPHEADER               =
  *       POEXPIMPHEADERX              =
  *       VERSIONS  =
  *       NO_MESSAGING                 =
  *       NO_MESSAGE_REQ               =
  *       NO_AUTHORITY                 =
  *       NO_PRICE_FROM_PO             =
  *       PARK_COMPLETE                =
  *       PARK_UNCOMPLETE              =
  * IMPORTING
  *       EXPPURCHASEORDER             =
  *       EXPHEADER =
  *       EXPPOEXPIMPHEADER            =
  * TABLES
        RETURN    = lt_bapiret2
        poitem    = lt_poitem
        poitemx   = lt_poitemx
  *       POADDRDELIVERY               =
  *       POSCHEDULE                   =
  *       POSCHEDULEX                  =
  *       POACCOUNT =
  *       POACCOUNTPROFITSEGMENT       =
  *       POACCOUNTX                   =
  *       POCONDHEADER                 =
  *       POCONDHEADERX                =
  *       POCOND    =
  *       POCONDX   =
  *       POLIMITS  =
  *       POCONTRACTLIMITS             =
  *       POSERVICES                   =
  *       POSRVACCESSVALUES            =
  *       POSERVICESTEXT               =
  *       EXTENSIONIN                  =
  *       EXTENSIONOUT                 =
  *       POEXPIMPITEM                 =
  *       POEXPIMPITEMX                =
  *       POTEXTHEADER                 =
  *       POTEXTITEM                   =
  *       ALLVERSIONS                  =
  *       POPARTNER =
  *       POCOMPONENTS                 =
  *       POCOMPONENTSX                =
  *       POSHIPPING                   =
  *       POSHIPPINGX                  =
  *       POSHIPPINGEXP                =
  *       SERIALNUMBER                 =
  *       SERIALNUMBERX                =
  *       INVPLANHEADER                =
  *       INVPLANHEADERX               =
  *       INVPLANITEM                  =
  *       INVPLANITEMX                 =
  *       NFMETALLITMS                 =
        .
  
    ENDLOOP.
  
    LOOP AT lt_bapiret2 ASSIGNING FIELD-SYMBOL(<fs_bapiret>) WHERE TYPE = 'E' OR TYPE = 'A'.
  
      EXIT.
  
    ENDLOOP.
  
    IF sy-subrc NE 0.
  
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
  
    ELSE.
  
      CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
  
    ENDIF.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form table_display
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM table_display.
  
  
  
  ENDFORM.