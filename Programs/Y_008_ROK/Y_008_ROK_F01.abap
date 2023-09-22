*&---------------------------------------------------------------------*
*&  Include           Y_008_ROK_F01
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

    LB1 = '**PRINT**'.
  
    CLEAR : GV_VBELN,
            GT_INFO.
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *&      Form  SELECT_DATA
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM SELECT_DATA .
  
    SELECT  VBAK~VBELN,            "Sales and Distribution Document Number
            VBAK~KUNNR,            "Customer Number
            KNA1~NAME1,            "Name
            KNA1~ADRNR,            "Name
            KNA1~STRAS,            "House number and street
            KNA1~PSTLZ,            "Postal Code
            KNA1~ORT01,            "City
            KNA1~LAND1,            "Country Key
            T005T~LANDX,           "Country Name
            VBAP~POSNR,            "Item number of the SD document
            VBAP~ARKTX,            "Short text for sales order item
            VBAP~KWMENG,           "Cumulative Order Quantity in Sales Units
            VBAP~NETWR,            "Net Value in Document Currency
            VBAK~CMWAE             "Currency key of credit control area
      FROM VBAK
      INNER JOIN VBAP ON VBAP~VBELN = VBAK~VBELN
      LEFT OUTER JOIN KNA1 ON KNA1~KUNNR = VBAK~KUNNR
      LEFT OUTER JOIN T005T ON T005T~LAND1 = KNA1~LAND1
      INTO TABLE @GT_INFO
      WHERE VBAK~VBELN = @P_VBELN
      AND T005T~SPRAS = 'EN'
      ORDER BY VBAK~VBELN, VBAP~POSNR.
  
    IF SY-SUBRC = 0.
  
      PERFORM SMARTFORM.
  
    ELSE.
  
      MESSAGE : 'No data found' TYPE 'I' DISPLAY LIKE 'E'.
  
    ENDIF.
  
  ENDFORM.
  
  
  *&---------------------------------------------------------------------*
  *&      Form  SMARTFORM
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM SMARTFORM .
  
    GV_VBELN = P_VBELN.
  
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
  *     CLIENT                  = SY-MANDT
        ID                      = ID
        LANGUAGE                = LANGUAGE
        NAME                    = GV_VBELN
        OBJECT                  = OBJECT
  *     ARCHIVE_HANDLE          = 0
  *     LOCAL_CAT               = ' '
  * IMPORTING
  *     HEADER                  =
  *     OLD_LINE_COUNTER        =
      TABLES
        LINES                   = LINES
      EXCEPTIONS
        ID                      = 1
        LANGUAGE                = 2
        NAME                    = 3
        NOT_FOUND               = 4
        OBJECT                  = 5
        REFERENCE_CHECK         = 6
        WRONG_ACCESS_TO_ARCHIVE = 7
        OTHERS                  = 8.
  
  
    IF SY-SUBRC <> 0.
      MESSAGE : 'The text line can not be read' TYPE 'I' DISPLAY LIKE 'E'.
    ENDIF.
  
  
    LV_SF_NAME = 'Z_VBELN_LBA'.
    LS_CONTROL-PREVIEW = 'X'.
    LS_OUTPUT-TDNOPREV = ' '.
  
    CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
      EXPORTING
        FORMNAME           = LV_SF_NAME
        VARIANT            = ' '
        DIRECT_CALL        = ' '
      IMPORTING
        FM_NAME            = LV_FNAME
      EXCEPTIONS
        NO_FORM            = 1
        NO_FUNCTION_MODULE = 2
        OTHERS             = 3.
  
  *  Appel du smartform
    CALL FUNCTION LV_FNAME
      EXPORTING
        LINES              = LINES
        IT_INFO            = GT_INFO
        CONTROL_PARAMETERS = LS_CONTROL
        OUTPUT_OPTIONS     = LS_OUTPUT
      EXCEPTIONS
        FORMATTING_ERROR   = 1
        INTERNAL_ERROR     = 2
        SEND_ERROR         = 3
        USER_CANCELED      = 4
        OTHERS             = 5.
    IF SY-SUBRC <> 0.
      MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
  
  ENDFORM.