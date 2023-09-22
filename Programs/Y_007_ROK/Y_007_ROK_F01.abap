*&---------------------------------------------------------------------*
*&  Include           Y_007_ROK_F01
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

    CLEAR: GT_DATA.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  DATA_RETRIEVAL
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM DATA_RETRIEVAL .
  
    " SELECT DATA -------------------------------------------------------*
  
    SELECT VBEP~VBELN, " Sales Document
           VBEP~POSNR, " Sales Document Item
           VBEP~ETENR, " Delivery Schedule Line Number
           VBEP~EDATU, " Schedule line date
           VBEP~TDDAT, " Transportation Planning Date
           VBEP~MBDAT, " Material Staging/Availability Date
           VBEP~LDDAT, " Loading Date
           VBEP~WADAT  " Goods Issue Date
      FROM VBAP
      INNER JOIN VBEP ON VBEP~VBELN = VBAP~VBELN
      AND VBEP~POSNR = VBAP~POSNR
      INTO TABLE @GT_DATA
      WHERE VBAP~VBELN = @P_VBELN.
  
    " CHECK EXISTING DATA -----------------------------------------------*
  
    IF GT_DATA IS INITIAL.
      MESSAGE 'ERROR: NO DATA FOUND (╬≖_≖)' TYPE 'E' DISPLAY LIKE 'I'.
      LEAVE PROGRAM.
    ENDIF.
  
    GT_BACKUP[] = GT_DATA[].
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  DATA_DISPLAYING
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM DATA_DISPLAYING .
  
    " BUILD FIELDCATALOG ------------------------------------------------*
  
    REFRESH GT_FIELDCAT.
    CLEAR GT_FIELDCAT.
  
    GS_FIELDCAT-COL_POS              = 1.
    GS_FIELDCAT-FIELDNAME            = 'VBELN'.
    GS_FIELDCAT-TABNAME              = 'GT_DATA'.
    GS_FIELDCAT-SELTEXT_M            = 'Sales Document'.
    GS_FIELDCAT-KEY                  = 'X'.
    APPEND GS_FIELDCAT TO GT_FIELDCAT.
    CLEAR: GS_FIELDCAT.
  
    GS_FIELDCAT-COL_POS              = 2.
    GS_FIELDCAT-FIELDNAME            = 'POSNR'.
    GS_FIELDCAT-TABNAME              = 'GT_DATA'.
    GS_FIELDCAT-SELTEXT_M            = 'Sales Document Item'.
    APPEND GS_FIELDCAT TO GT_FIELDCAT.
    CLEAR: GS_FIELDCAT.
  
    GS_FIELDCAT-COL_POS              = 3.
    GS_FIELDCAT-FIELDNAME            = 'ETENR'.
    GS_FIELDCAT-TABNAME              = 'GT_DATA'.
    GS_FIELDCAT-SELTEXT_M            = 'Delivery Schedule Line Number'.
    APPEND GS_FIELDCAT TO GT_FIELDCAT.
    CLEAR: GS_FIELDCAT.
  
    GS_FIELDCAT-COL_POS              = 4.
    GS_FIELDCAT-FIELDNAME            = 'MBDAT'.
    GS_FIELDCAT-TABNAME              = 'GT_DATA'.
    GS_FIELDCAT-SELTEXT_M            = 'Material Staging/Availability Date'.
    APPEND GS_FIELDCAT TO GT_FIELDCAT.
    CLEAR: GS_FIELDCAT.
  
    GS_FIELDCAT-COL_POS              = 5.
    GS_FIELDCAT-FIELDNAME            = 'TDDAT'.
    GS_FIELDCAT-TABNAME              = 'GT_DATA'.
    GS_FIELDCAT-SELTEXT_M            = 'Transportation Planning Date'.
    APPEND GS_FIELDCAT TO GT_FIELDCAT.
    CLEAR: GS_FIELDCAT.
  
    GS_FIELDCAT-COL_POS              = 6.
    GS_FIELDCAT-FIELDNAME            = 'LDDAT'.
    GS_FIELDCAT-TABNAME              = 'GT_DATA'.
    GS_FIELDCAT-SELTEXT_M            = 'Loading Date'.
    APPEND GS_FIELDCAT TO GT_FIELDCAT.
    CLEAR: GS_FIELDCAT.
  
    GS_FIELDCAT-COL_POS              = 7.
    GS_FIELDCAT-FIELDNAME            = 'WADAT'.
    GS_FIELDCAT-TABNAME              = 'GT_DATA'.
    GS_FIELDCAT-SELTEXT_M            = 'Goods Issue Date'.
    APPEND GS_FIELDCAT TO GT_FIELDCAT.
    CLEAR: GS_FIELDCAT.
  
    GS_FIELDCAT-COL_POS              = 8.
    GS_FIELDCAT-FIELDNAME            = 'EDATU'.
    GS_FIELDCAT-TABNAME              = 'GT_DATA'.
    GS_FIELDCAT-SELTEXT_M            = 'Schedule line date'.
    GS_FIELDCAT-INPUT                = 'X'.
    GS_FIELDCAT-EDIT                 = 'X'.
    APPEND GS_FIELDCAT TO GT_FIELDCAT.
    CLEAR: GS_FIELDCAT.
  
    " BUILD LAYOUT ------------------------------------------------------*
  
    GD_LAYOUT-COLWIDTH_OPTIMIZE      = 'X'.
    GD_LAYOUT-TOTALS_TEXT            = 'Totals'(201).
  
    " ALV GRID DISPLAY --------------------------------------------------*
  
    TRY.
        CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
          EXPORTING
            I_CALLBACK_PROGRAM       = SY-REPID
            I_CALLBACK_PF_STATUS_SET = 'SET_PF_STATUS'
            I_CALLBACK_USER_COMMAND  = 'USER_COMMAND'
            I_GRID_TITLE             = 'SALES DOCUMENT: HEADER & ITEM DATA'
            IT_FIELDCAT              = GT_FIELDCAT[]
            IS_LAYOUT                = GD_LAYOUT
            I_SAVE                   = 'A'
          TABLES
            T_OUTTAB                 = GT_DATA
          EXCEPTIONS
            PROGRAM_ERROR            = 1
            OTHERS                   = 2.
        IF SY-SUBRC <> 0.
          MESSAGE '(╬≖_≖) REUSE_ALV_GRID_DISPLAY IS NOT WORKING' TYPE 'E' DISPLAY LIKE 'I'.
          LEAVE PROGRAM.
        ENDIF.
      CATCH CX_SALV_MSG INTO GO_MESSAGE.
    ENDTRY.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  SET_PF_STATUS
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM SET_PF_STATUS USING RT_EXTAB TYPE SLIS_T_EXTAB .
  
    SET PF-STATUS 'STATUS_1000'.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  USER_COMMAND
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM USER_COMMAND USING R_UCOMM LIKE SY-UCOMM
                          RS_SELFIELD TYPE SLIS_SELFIELD.
  
    DATA: REF_GRID TYPE REF TO CL_GUI_ALV_GRID.
  
    IF REF_GRID IS INITIAL.
      CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
        IMPORTING
          E_GRID = REF_GRID.
    ENDIF.
  
    IF NOT REF_GRID IS INITIAL.
      CALL METHOD REF_GRID->CHECK_CHANGED_DATA.
    ENDIF.
  
    CASE R_UCOMM.
      WHEN 'EXIT' OR 'BACK' OR 'CANCEL'.
        MESSAGE 'SAVE' TYPE 'I'.
        LEAVE PROGRAM.
      WHEN '&REF'.
        READ TABLE GT_DATA INDEX RS_SELFIELD-TABINDEX TRANSPORTING NO FIELDS.
        IF SY-SUBRC = 0.
          READ TABLE GT_BACKUP INDEX RS_SELFIELD-TABINDEX TRANSPORTING NO FIELDS.
          IF SY-SUBRC = 0.
            IF GT_DATA <> GT_BACKUP.
              PERFORM DATA_RETRIEVAL.
            ELSE.
              PERFORM DATA_RETRIEVAL.
            ENDIF.
          ENDIF.
        ENDIF.
        RS_SELFIELD-REFRESH = 'X'.
      WHEN '&SAVE'.
        IF GT_DATA[] <> GT_BACKUP[].
          PERFORM DATA_PROCESSING.
        ELSE.
          MESSAGE 'NO CHANGE DETECTED' TYPE 'E' DISPLAY LIKE 'I'.
        ENDIF.
    ENDCASE.
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
  
    DATA:  LO_ALV           TYPE REF TO CL_SALV_TABLE,
           LO_ALV_FUNCTIONS TYPE REF TO CL_SALV_FUNCTIONS,
           LO_COLUMNS       TYPE REF TO CL_SALV_COLUMNS_TABLE,
           LO_MESSAGE       TYPE REF TO CX_SALV_MSG.
  
  *----------------------------------------------------------------------*
  
    LOOP AT GT_DATA ASSIGNING FIELD-SYMBOL(<LFS_DATA>).
  
      READ TABLE GT_BACKUP ASSIGNING FIELD-SYMBOL(<LFS_BACKUP>)
        WITH KEY VBELN = <LFS_DATA>-VBELN
                 POSNR = <LFS_DATA>-POSNR
                 ETENR = <LFS_DATA>-ETENR
                 EDATU = <LFS_DATA>-EDATU.
  
      IF SY-SUBRC = 0.
        CONTINUE.
      ENDIF.
  
      " HEADER ---------------------------------------------------------*
  
      GS_ORDER_HEADER_INX-UPDATEFLAG = 'U'.
  
  *   GS_ORDER_HEADER_IN-REF_DOC     = <LFS_DATA>-VBELN.
      GS_ORDER_HEADER_INX-REF_DOC    = 'X'.
  
      " ITEMS ---------------------------------------------------------*
  
  *   GS_ORDER_ITEMS_IN-REF_DOC      = <LFS_DATA>-VBELN.
  *   GS_ORDER_ITEMS_INX-REF_DOC     = 'X'.
  *
  *   GS_ORDER_ITEMS_IN-ITM_NUMBER   = <LFS_DATA>-POSNR.
  *   GS_ORDER_ITEMS_INX-ITM_NUMBER  = 'X'.
  
      " SCHEDULE_LINES ------------------------------------------------*
  
  *   VBEP    BAPISCHDL   Desc
  *   -------------------------------------------------------
  *   TDDAT   TP_DATE     Transportation Planning Date
  *   MBDAT   MS_DATE     Material Staging/Availability Date
  *   LDDAT   LOAD_DATE   Loading Date
  *   WADAT   GI_DATE     Goods Issue Date
  *   EDATU   DLV_DATE    Schedule line date
  
      GS_SCHEDULE_LINESX-UPDATEFLAG  = 'U'.
  
      GS_SCHEDULE_LINES-ITM_NUMBER   = <LFS_DATA>-POSNR. " Sales Document Item
      GS_SCHEDULE_LINESX-ITM_NUMBER  = <LFS_DATA>-POSNR.
  
      GS_SCHEDULE_LINES-SCHED_LINE   = <LFS_DATA>-ETENR. " Delivery Schedule Line Number
      GS_SCHEDULE_LINESX-SCHED_LINE  = <LFS_DATA>-ETENR.
  
      GS_SCHEDULE_LINES-REQ_DATE     = <LFS_DATA>-EDATU. " Schedule line date
      GS_SCHEDULE_LINESX-REQ_DATE    = 'X'.
  
      GS_SCHEDULE_LINES-DATE_TYPE    = '1'. " Date type (day, week, month, interval)
      GS_SCHEDULE_LINESX-DATE_TYPE   = 'X'.
  
      " MAJOR FIELD TDDAT
      GS_SCHEDULE_LINES-TP_DATE      = <LFS_DATA>-TDDAT. " Transportation Planning Date
      GS_SCHEDULE_LINESX-TP_DATE     = 'X'.
  
      " MAJOR FIELD MBDAT
      GS_SCHEDULE_LINES-MS_DATE      = <LFS_DATA>-MBDAT. " Material Staging/Availability Date
      GS_SCHEDULE_LINESX-MS_DATE     = 'X'.
  
      " MAJOR FIELD LDDAT
      GS_SCHEDULE_LINES-LOAD_DATE    = <LFS_DATA>-LDDAT. " Loading Date
      GS_SCHEDULE_LINESX-LOAD_DATE   = 'X'.
  
      " MAJOR FIELD WADAT
      GS_SCHEDULE_LINES-GI_DATE      = <LFS_DATA>-WADAT. " Goods Issue Date
      GS_SCHEDULE_LINESX-GI_DATE     = 'X'.
  
  *   GS_SCHEDULE_LINES-DLV_DATE     = <LFS_DATA>-EDATU. " Schedule line date
      GS_SCHEDULE_LINESX-DLV_DATE    = 'X'.
  
      " ORDER KEY -----------------------------------------------------*
  
  *   GS_ORDER_KEYS-DOC_NUMBER       = <LFS_DATA>-VBELN.
  *   GS_ORDER_KEYS-ITM_NUMBER       = <LFS_DATA>-POSNR.
  *   GS_ORDER_KEYS-SCHED_LIN        = <LFS_DATA>-ETENR.
  
      " APPEND --------------------------------------------------------*
  
  *   APPEND GS_ORDER_ITEMS_IN       TO GT_ORDER_ITEMS_IN.
      APPEND GS_ORDER_ITEMS_INX      TO GT_ORDER_ITEMS_INX.
  
      APPEND GS_SCHEDULE_LINES       TO GT_SCHEDULE_LINES.
      APPEND GS_SCHEDULE_LINESX      TO GT_SCHEDULE_LINESX.
  
  *   APPEND GS_ORDER_KEYS           TO GT_ORDER_KEYS.
  
    ENDLOOP.
  
  *----------------------------------------------------------------------*
  
    TRY.
        CALL FUNCTION 'BAPI_SALESORDER_CHANGE'
          EXPORTING
            SALESDOCUMENT    = P_VBELN
  *         ORDER_HEADER_IN  = GS_ORDER_HEADER_IN
            ORDER_HEADER_INX = GS_ORDER_HEADER_INX
  *         SIMULATION       =
  *         BEHAVE_WHEN_ERROR     = ' '
  *         INT_NUMBER_ASSIGNMENT = ' '
  *         LOGIC_SWITCH     =
  *         NO_STATUS_BUF_INIT    = ' '
          TABLES
            RETURN           = GT_RETURN
  *         ORDER_ITEM_IN    = GT_ORDER_ITEMS_IN
  *         ORDER_ITEM_INX   = GT_ORDER_ITEMS_INX
  *         PARTNERS         =
  *         PARTNERCHANGES   =
  *         PARTNERADDRESSES =
  *         ORDER_CFGS_REF   =
  *         ORDER_CFGS_INST  =
  *         ORDER_CFGS_PART_OF    =
  *         ORDER_CFGS_VALUE =
  *         ORDER_CFGS_BLOB  =
  *         ORDER_CFGS_VK    =
  *         ORDER_CFGS_REFINST    =
            SCHEDULE_LINES   = GT_SCHEDULE_LINES
            SCHEDULE_LINESX  = GT_SCHEDULE_LINESX
  *         ORDER_TEXT       =
  *         ORDER_KEYS       = GT_ORDER_KEYS
  *         CONDITIONS_IN    =
  *         CONDITIONS_INX   =
  *         EXTENSIONIN      =
  *         EXTENSIONEX      =
          .
  
      CATCH CX_SALV_MSG INTO GO_MESSAGE.
    ENDTRY.
  
    TRY.
        CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
          EXPORTING
            WAIT   = 'X'
          IMPORTING
            RETURN = GS_RETURN.
  
        SKIP.
      CATCH CX_SALV_MSG INTO GO_MESSAGE.
    ENDTRY.
  
    LOOP AT GT_RETURN ASSIGNING FIELD-SYMBOL(<LFS_RETURN>) WHERE TYPE = 'E' OR TYPE = 'A'.
      EXIT.
    ENDLOOP.
  
    IF SY-SUBRC = 0.
  *    MESSAGE 'ERROR BAPI_SALESORDER_CHANGE' TYPE 'E' DISPLAY LIKE 'I'.
  
      TRY.
          CALL METHOD CL_SALV_TABLE=>FACTORY(
            IMPORTING
              R_SALV_TABLE = LO_ALV
            CHANGING
              T_TABLE      = GT_RETURN ).
  
          LO_ALV_FUNCTIONS = LO_ALV->GET_FUNCTIONS( ).
          LO_ALV_FUNCTIONS->SET_ALL( ABAP_TRUE ).
          LO_COLUMNS = LO_ALV->GET_COLUMNS( ).
          LO_COLUMNS->SET_OPTIMIZE( ABAP_TRUE ).
          LO_ALV->DISPLAY( ).
  
        CATCH CX_SALV_MSG INTO LO_MESSAGE.
      ENDTRY.
  
    ELSE.
  *    MESSAGE 'SUCCESS BAPI_SALESORDER_CHANGE' TYPE 'S' DISPLAY LIKE 'I'.
  
      TRY.
          CALL METHOD CL_SALV_TABLE=>FACTORY(
            IMPORTING
              R_SALV_TABLE = LO_ALV
            CHANGING
              T_TABLE      = GT_RETURN ).
  
          LO_ALV_FUNCTIONS = LO_ALV->GET_FUNCTIONS( ).
          LO_ALV_FUNCTIONS->SET_ALL( ABAP_TRUE ).
          LO_COLUMNS = LO_ALV->GET_COLUMNS( ).
          LO_COLUMNS->SET_OPTIMIZE( ABAP_TRUE ).
          LO_ALV->DISPLAY( ).
  
        CATCH CX_SALV_MSG INTO LO_MESSAGE.
      ENDTRY.
  
    ENDIF.
  
    CLEAR: GT_RETURN.
  
  ENDFORM.