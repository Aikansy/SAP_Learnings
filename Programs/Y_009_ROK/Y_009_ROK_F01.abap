*&---------------------------------------------------------------------*
*&  Include           Z_004_UWU_F01
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

    LB1 = ' ٩(◕‿◕)۶   DISPLAY   ٩(◕‿◕)۶'.
    LB2 = 'Upload'.
    LB3 = 'Download'.
    LB4 = 'ヽ(ヅ)ノ'.
    LB5 = 'SMARTFORMS MAILLING'.
    LB6 = 'SMARTFORMS UPLOADING'.
    LB7 = ' ٩(◕‿◕)۶   DISPLAY   ٩(◕‿◕)۶'.
  
    CLEAR: GT_SOOD,
           GT_RECEIVERS,
           GT_BAPIRETTAB,
           GS_SOOD,
           GS_LPORB.
  
    CLEAR: GT_DATA,
           GV_VBELN.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  ATTACHMENTS_DISPLAYING
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM ATTACHMENTS_DISPLAYING .
  
    GS_LPORB-TYPEID = P_TYPE.
    GS_LPORB-INSTID = P_KEY.
    GS_LPORB-CATID  = P_CATID.
  
    IF SY-SUBRC = 0.
  
      CALL METHOD ZCL_OH_MY_GOS_NEW=>GET_BITEM
        EXPORTING
          IS_LPORB = GS_LPORB
        RECEIVING
          RO_BITEM = GO_BITEM.
  
      CALL METHOD ZCL_OH_MY_GOS_NEW=>SET_OBJECT
        EXPORTING
          IS_LPORB = GS_LPORB.
  
      CALL METHOD ZCL_OH_MY_GOS_NEW=>DISPLAY_ATTACHMENTS
        EXPORTING
          IO_CONTAINER = GO_CONTAINER.
  
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  ATTACHMENTS_UPLOADING
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM ATTACHMENTS_UPLOADING .
  
    DATA: LV_FILENAME   TYPE STRING,
          LV_FILELENGTH TYPE WSRM_ERROR-WSRM_DIRECTION,
          LT_CONTENT    LIKE STANDARD TABLE OF SOLI,
          LV_OBJTYP     TYPE SO_OBJ_TP.
  
    LV_OBJTYP = 'EXT'.
    GS_LPORB-TYPEID = P_TYPE.
    GS_LPORB-INSTID = P_KEY.
    GS_LPORB-CATID  = P_CATID.
  
    MOVE P_UPL TO LV_FILENAME.
  
    CALL FUNCTION 'GUI_UPLOAD'
      EXPORTING
        FILENAME   = LV_FILENAME
        FILETYPE   = 'BIN'
      IMPORTING
        FILELENGTH = LV_FILELENGTH
      TABLES
        DATA_TAB   = LT_CONTENT.
  
    IF SY-SUBRC EQ 0.
      CALL METHOD ZCL_OH_MY_GOS_NEW=>GOS_ATTACH_FILE_SOLITAB
        EXPORTING
          IV_NAME            = LV_FILENAME
          IV_CONTENT_SOLITAB = LT_CONTENT
          IS_LPORB           = GS_LPORB
          IV_OBJTP           = LV_OBJTYP
          IV_FILELENGTH      = LV_FILELENGTH
          IV_OBJNAME         = P_NAM
          IV_EXT             = P_EXT
        RECEIVING
          RT_MESSAGES        = GT_BAPIRETTAB.
    ENDIF.
  
    CALL METHOD ZCL_OH_MY_GOS_NEW=>GOS_GET_FILE_LIST
      EXPORTING
        IS_LPORB      = GS_LPORB
      IMPORTING
        T_ATTACHMENTS = GT_SOOD
        RT_MESSAGES   = GT_BAPIRETTAB.
  
    IF GT_BAPIRETTAB[] IS INITIAL.
      WRITE: /.
      LOOP AT GT_SOOD INTO GS_SOOD.
        DEC_KB = GS_SOOD-OBJLEN / 1024.
        IF DEC_KB < 1.
          DEC_KB = 1.
        ENDIF.
  
        MESSAGE GS_SOOD-OBJDES && ' ' && DEC_KB && ',' && 'kb' && ', ' && GS_SOOD-ACNAM TYPE 'I'.
      ENDLOOP.
    ELSE.
      MESSAGE 'Upload fail' TYPE 'E'.
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  ATTACHMENTS_DOWNLOADING
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM ATTACHMENTS_DOWNLOADING .
  
    GS_LPORB-TYPEID = P_TYPE.
    GS_LPORB-INSTID = P_KEY.
    GS_LPORB-CATID  = P_CATID.
  
    CALL METHOD ZCL_OH_MY_GOS_NEW=>GOS_GET_FILE_LIST
      EXPORTING
        IS_LPORB      = GS_LPORB
      IMPORTING
        T_ATTACHMENTS = GT_SOOD
        RT_MESSAGES   = GT_BAPIRETTAB.
  
    IF GT_BAPIRETTAB[] IS INITIAL.
      LOOP AT GT_SOOD INTO GS_SOOD.
        CALL METHOD ZCL_OH_MY_GOS_NEW=>GOS_DOWNLOAD_FILE_TO_GUI
          EXPORTING
            FILE_PATH   = P_DLL
            ATTACHMENT  = GS_SOOD
          IMPORTING
            RT_MESSAGES = GT_BAPIRETTAB.
        IF GT_BAPIRETTAB[] IS INITIAL.
          DEC_KB = GS_SOOD-OBJLEN / 1024.
          IF DEC_KB < 1.
            DEC_KB = 1.
          ENDIF.
          MESSAGE GS_SOOD-OBJDES && ' ' && DEC_KB && ',' && 'kb' && ', ' && GS_SOOD-ACNAM TYPE 'I'.
  *        WRITE: / gs_sood-objdes, dec_kb, 'kb', ' ', gs_sood-acnam.
        ENDIF.
      ENDLOOP.
    ELSE.
      MESSAGE 'Download successful' TYPE 'S'.
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  ATTACHMENTS_EMAILING
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM ATTACHMENTS_EMAILING .
  
    GS_LPORB-TYPEID = P_TYPE.
    GS_LPORB-INSTID = P_KEY.
    GS_LPORB-CATID  = P_CATID.
  
    CALL METHOD ZCL_OH_MY_GOS_NEW=>GOS_GET_FILE_LIST
      EXPORTING
        IS_LPORB      = GS_LPORB
      IMPORTING
        T_ATTACHMENTS = GT_SOOD
        RT_MESSAGES   = GT_BAPIRETTAB.
  
    IF GT_BAPIRETTAB[] IS INITIAL.
      DATA DEC_KB TYPE P.
  
      LOOP AT GT_SOOD INTO GS_SOOD.
        DEC_KB = GS_SOOD-OBJLEN / 1024.
        IF DEC_KB < 1.
          DEC_KB = 1.
        ENDIF.
        WRITE: / GS_SOOD-OBJDES, DEC_KB, 'KB', ' ', GS_SOOD-ACNAM.
  
        CLEAR GT_RECEIVERS.
        GT_RECEIVERS-RECEIVER = P_RECEVR.
        GT_RECEIVERS-REC_TYPE = 'U'.
        APPEND GT_RECEIVERS.
  
        CALL METHOD ZCL_OH_MY_GOS_NEW=>GOS_EMAIL_ATTACHED_FILE
          EXPORTING
            FOLDER_REGION = 'B'
            DOCTP         = GS_SOOD-OBJTP
            DOCYR         = GS_SOOD-OBJYR
            DOCNO         = GS_SOOD-OBJNO
            T_RECEIVERS   = GT_RECEIVERS[]
          IMPORTING
            RT_MESSAGES   = GT_BAPIRETTAB.
        IF GT_BAPIRETTAB[] IS INITIAL.
          WRITE: '(ATTACHMENT HAS BEEN SENT)'.
        ENDIF.
      ENDLOOP.
    ELSE.
      MESSAGE 'Emailing successful' TYPE 'S'.
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  SMARTFORM_SENDING
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM SMARTFORM_SENDING .
  
    PERFORM DATA_RETRIEVAL.
  
    PERFORM LINE_RETRIEVAL.
  
    PERFORM SMARTFORM_FILLING.
  
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
  
    SELECT VBAK~VBELN,  "SALES AND DISTRIBUTION DOCUMENT NUMBER
           VBAK~KUNNR,  "CUSTOMER NUMBER
           KNA1~NAME1,  "NAME
           KNA1~ADRNR,  "NAME
           KNA1~STRAS,  "HOUSE NUMBER AND STREET
           KNA1~PSTLZ,  "POSTAL CODE
           KNA1~ORT01,  "CITY
           KNA1~LAND1,  "COUNTRY KEY
           T005T~LANDX, "COUNTRY NAME
           VBAP~POSNR,  "ITEM NUMBER OF THE SD DOCUMENT
           VBAP~ARKTX,  "SHORT TEXT FOR SALES ORDER ITEM
           VBAP~KWMENG, "CUMULATIVE ORDER QUANTITY IN SALES UNITS
           VBAP~NETWR,  "NET VALUE IN DOCUMENT CURRENCY
           VBAK~CMWAE   "CURRENCY KEY OF CREDIT CONTROL AREA
      FROM VBAK
      INNER JOIN VBAP ON VBAP~VBELN = VBAK~VBELN
      LEFT OUTER JOIN KNA1 ON KNA1~KUNNR = VBAK~KUNNR
      LEFT OUTER JOIN T005T ON T005T~LAND1 = KNA1~LAND1
      INTO TABLE @GT_DATA
      WHERE VBAK~VBELN = @P_VBELN
      AND T005T~SPRAS = 'EN'
      ORDER BY VBAK~VBELN, VBAP~POSNR.
  
    IF GT_DATA[] IS INITIAL.
      MESSAGE 'SMARTFORM_SENDING: ERROR NO DATA FOUND !' TYPE 'E' DISPLAY LIKE 'I'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  LINE_RETRIEVAL
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM LINE_RETRIEVAL .
  
    REFRESH LINES.
  
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
      MESSAGE : 'FUNCTION READ_TEXT: ERROR TEXT' TYPE 'E' DISPLAY LIKE 'I'.
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  ATTACHMENTS_DISPLAYING_SO
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM ATTACHMENTS_DISPLAYING_SO .
  
    GS_LPORB-TYPEID = P_TYPESO.
    GS_LPORB-INSTID = P_VBELN.
    GS_LPORB-CATID  = P_CATIDS.
  
    IF SY-SUBRC = 0.
  
      CALL METHOD ZCL_OH_MY_GOS_NEW=>GET_BITEM
        EXPORTING
          IS_LPORB = GS_LPORB
        RECEIVING
          RO_BITEM = GO_BITEM.
  
      CALL METHOD ZCL_OH_MY_GOS_NEW=>SET_OBJECT
        EXPORTING
          IS_LPORB = GS_LPORB.
  
      CALL METHOD ZCL_OH_MY_GOS_NEW=>DISPLAY_ATTACHMENTS
        EXPORTING
          IO_CONTAINER = GO_CONTAINER.
  
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  SMARTFORM_FILLING
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM SMARTFORM_FILLING .
  
    DATA: LS_JOB_INFO      TYPE SSFCRESCL,
          LT_LINES         TYPE TABLE OF TLINE,
          LV_FILESIZE      TYPE I,
          LV_OTF           TYPE XSTRING,
          LT_PDF_DATA      TYPE SOLIX_TAB,
          LR_DOCUMENT      TYPE REF TO CL_DOCUMENT_BCS,
          LT_EMAIL_CONTENT TYPE BCSY_TEXT,
          LR_RECIPIENT     TYPE REF TO IF_RECIPIENT_BCS,
          LV_SENT_TO_ALL   TYPE OS_BOOLEAN,
          LR_SEND_REQUEST  TYPE REF TO CL_BCS,
          LV_RECEP         TYPE ADR6-SMTP_ADDR VALUE IS INITIAL,
          LT_PDF           LIKE SOLIX OCCURS 0 WITH HEADER LINE,
          LC_FILE          TYPE STRING.
  
    FORMNAME             = 'Y_SMARTFORM_008_ROK'.
    GS_CONTROL-NO_DIALOG = 'X'.
    GS_CONTROL-GETOTF    = 'X'.
    GS_CONTROL-LANGU     = SY-LANGU.
    GS_CONTROL-PREVIEW   = 'X'.
    GS_OUTPUT-TDNOPREV   = ' '.
  
    CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
      EXPORTING
        FORMNAME           = FORMNAME
        VARIANT            = ' '
        DIRECT_CALL        = ' '
      IMPORTING
        FM_NAME            = LV_FNAME
      EXCEPTIONS
        NO_FORM            = 1
        NO_FUNCTION_MODULE = 2
        OTHERS             = 3.
    IF SY-SUBRC <> 0.
      MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
  
  *  Appel du smartform
    CALL FUNCTION LV_FNAME
      EXPORTING
        LINES              = LINES
        IT_INFO            = GT_DATA
        CONTROL_PARAMETERS = GS_CONTROL
        OUTPUT_OPTIONS     = GS_OUTPUT
      IMPORTING
        JOB_OUTPUT_INFO    = LS_JOB_INFO
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
  
    CALL FUNCTION 'CONVERT_OTF'
      EXPORTING
        FORMAT                = 'PDF'
  *     MAX_LINEWIDTH         = 132
  *     ARCHIVE_INDEX         = ' '
  *     COPYNUMBER            = 0
  *     ASCII_BIDI_VIS2LOG    = ' '
  *     PDF_DELETE_OTFTAB     = ' '
  *     PDF_USERNAME          = ' '
  *     PDF_PREVIEW           = ' '
  *     USE_CASCADING         = ' '
      IMPORTING
        BIN_FILESIZE          = LV_FILESIZE
        BIN_FILE              = LV_OTF
      TABLES
        OTF                   = LS_JOB_INFO-OTFDATA
        LINES                 = LT_LINES
      EXCEPTIONS
        ERR_MAX_LINEWIDTH     = 1
        ERR_FORMAT            = 2
        ERR_CONV_NOT_POSSIBLE = 3
        ERR_BAD_OTF           = 4
        OTHERS                = 5.
  
    IF SY-SUBRC <> 0.
      MESSAGE 'FUNCTION CONVERT_OTF: ERROR' TYPE 'E' DISPLAY LIKE 'I'.
    ENDIF.
  
    CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
      EXPORTING
        BUFFER     = LV_OTF
      TABLES
        BINARY_TAB = LT_PDF[].
  
    LC_FILE = 'DIR/SFNAME.PDF'.
  
    " EMAIL SENDING
  
    DATA: SALUTATION TYPE STRING.
    DATA: BODY TYPE STRING.
    DATA: FOOTER TYPE STRING.
  
    DATA: LO_SEND_REQUEST TYPE REF TO CL_BCS,
          LO_DOCUMENT     TYPE REF TO CL_DOCUMENT_BCS,
          LO_SENDER       TYPE REF TO IF_SENDER_BCS,
          LO_RECIPIENT    TYPE REF TO IF_RECIPIENT_BCS VALUE IS INITIAL,LT_MESSAGE_BODY TYPE BCSY_TEXT,
          LX_DOCUMENT_BCS TYPE REF TO CX_DOCUMENT_BCS,
          IN_MAILID       TYPE AD_SMTPADR VALUE 'frederic.giustini@alliance4u.fr'.
  
    "create send request
    LO_SEND_REQUEST = CL_BCS=>CREATE_PERSISTENT( ).
  
    "create message body and subject
    SALUTATION ='Dear Sir/Madam,'.
    APPEND SALUTATION TO LT_MESSAGE_BODY.
    APPEND INITIAL LINE TO LT_MESSAGE_BODY.
  
    BODY = 'Please find the attached the Smartform in PDF format.'.
    APPEND BODY TO LT_MESSAGE_BODY.
    APPEND INITIAL LINE TO LT_MESSAGE_BODY.
  
    FOOTER = 'With Regards,'.
    APPEND FOOTER TO LT_MESSAGE_BODY.
    FOOTER = 'www.sapyard.com.'.
    APPEND FOOTER TO LT_MESSAGE_BODY.
    "put your text into the document
    LO_DOCUMENT = CL_DOCUMENT_BCS=>CREATE_DOCUMENT(
    I_TYPE = 'RAW'
    I_TEXT = LT_MESSAGE_BODY
    I_SUBJECT = 'Smartform in PDF' ).
  
  *DATA: l_size TYPE sood-objlen. " Size of Attachment
  *l_size = l_lines * 255.
    TRY.
        LO_DOCUMENT->ADD_ATTACHMENT(
        EXPORTING
        I_ATTACHMENT_TYPE = 'PDF'
        I_ATTACHMENT_SUBJECT = 'Smartform_fgi'
        I_ATT_CONTENT_HEX = LT_PDF[] ).
      CATCH CX_DOCUMENT_BCS INTO LX_DOCUMENT_BCS.
    ENDTRY.
  
  * Add attachment
  * Pass the document to send request
    LO_SEND_REQUEST->SET_DOCUMENT( LO_DOCUMENT ).
  
    "Create sender
    LO_SENDER = CL_SAPUSER_BCS=>CREATE( SY-UNAME ).
  
    "Set sender
    LO_SEND_REQUEST->SET_SENDER( LO_SENDER ).
  
    "Create recipient
    LO_RECIPIENT = CL_CAM_ADDRESS_BCS=>CREATE_INTERNET_ADDRESS( IN_MAILID ).
  
  *Set recipient
    LO_SEND_REQUEST->ADD_RECIPIENT(
    EXPORTING
    I_RECIPIENT = LO_RECIPIENT
    I_EXPRESS = ABAP_TRUE
    ).
  
    LO_SEND_REQUEST->ADD_RECIPIENT( LO_RECIPIENT ).
  
  * Send email
    LO_SEND_REQUEST->SEND(
    EXPORTING
    I_WITH_ERROR_SCREEN = ABAP_TRUE
    RECEIVING
    RESULT = LV_SENT_TO_ALL ).
  
    CONCATENATE 'Email sent to' IN_MAILID INTO DATA(LV_MSG) SEPARATED BY SPACE.
    WRITE:/ LV_MSG COLOR COL_POSITIVE.
    SKIP.
  * Commit Work to send the email
    COMMIT WORK.
  
    DATA: GS_MAILDATA LIKE SODOCCHGI1.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  UPLOAD_SMARTFORMS
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM UPLOAD_SMARTFORMS .
  
    PERFORM DATA_RETRIEVAL.
  
    PERFORM LINE_RETRIEVAL.
  
    DATA: LS_JOB_INFO      TYPE SSFCRESCL,
          LT_LINES         TYPE TABLE OF TLINE,
          LV_FILESIZE      TYPE I,
          LV_OTF           TYPE XSTRING,
          LT_PDF_DATA      TYPE SOLIX_TAB,
          LR_DOCUMENT      TYPE REF TO CL_DOCUMENT_BCS,
          LT_EMAIL_CONTENT TYPE BCSY_TEXT,
          LR_RECIPIENT     TYPE REF TO IF_RECIPIENT_BCS,
          LV_SENT_TO_ALL   TYPE OS_BOOLEAN,
          LR_SEND_REQUEST  TYPE REF TO CL_BCS,
          LV_RECEP         TYPE ADR6-SMTP_ADDR VALUE IS INITIAL,
          LT_PDF           LIKE SOLIX OCCURS 0 WITH HEADER LINE,
          LC_FILE          TYPE STRING.
  
    FORMNAME             = 'Y_SMARTFORM_008_ROK'.
    GS_CONTROL-NO_DIALOG = 'X'.
    GS_CONTROL-GETOTF    = 'X'.
    GS_CONTROL-LANGU     = SY-LANGU.
    GS_CONTROL-PREVIEW   = 'X'.
    GS_OUTPUT-TDNOPREV   = ' '.
  
    CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
      EXPORTING
        FORMNAME           = FORMNAME
        VARIANT            = ' '
        DIRECT_CALL        = ' '
      IMPORTING
        FM_NAME            = LV_FNAME
      EXCEPTIONS
        NO_FORM            = 1
        NO_FUNCTION_MODULE = 2
        OTHERS             = 3.
    IF SY-SUBRC <> 0.
      MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
  
  *  Appel du smartform
    CALL FUNCTION LV_FNAME
      EXPORTING
        LINES              = LINES
        IT_INFO            = GT_DATA
        CONTROL_PARAMETERS = GS_CONTROL
        OUTPUT_OPTIONS     = GS_OUTPUT
      IMPORTING
        JOB_OUTPUT_INFO    = LS_JOB_INFO
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
  
    CALL FUNCTION 'CONVERT_OTF'
      EXPORTING
        FORMAT                = 'PDF'
  *     MAX_LINEWIDTH         = 132
  *     ARCHIVE_INDEX         = ' '
  *     COPYNUMBER            = 0
  *     ASCII_BIDI_VIS2LOG    = ' '
  *     PDF_DELETE_OTFTAB     = ' '
  *     PDF_USERNAME          = ' '
  *     PDF_PREVIEW           = ' '
  *     USE_CASCADING         = ' '
      IMPORTING
        BIN_FILESIZE          = LV_FILESIZE
        BIN_FILE              = LV_OTF
      TABLES
        OTF                   = LS_JOB_INFO-OTFDATA
        LINES                 = LT_LINES
      EXCEPTIONS
        ERR_MAX_LINEWIDTH     = 1
        ERR_FORMAT            = 2
        ERR_CONV_NOT_POSSIBLE = 3
        ERR_BAD_OTF           = 4
        OTHERS                = 5.
  
    IF SY-SUBRC <> 0.
      MESSAGE 'FUNCTION CONVERT_OTF: ERROR' TYPE 'E' DISPLAY LIKE 'I'.
    ENDIF.
  
    CALL METHOD CL_DOCUMENT_BCS=>XSTRING_TO_SOLIX
      EXPORTING
        IP_XSTRING = LV_OTF
      RECEIVING
        RT_SOLIX   = GT_PDF_DATA.
  
    DATA :      LS_LPORB      TYPE SIBFLPORB,
                LV_OBJTYP     TYPE SO_OBJ_TP,
                LT_BAPIRETTAB TYPE BAPIRETTAB,
                LT_CONT       TYPE SOLI_TAB.
  
    GV_VBELN = P_VBELN.
  
    LV_OBJTYP = 'EXT'.
    LS_LPORB-INSTID = GV_VBELN.
    LS_LPORB-TYPEID = 'BUS2032'.
    LS_LPORB-CATID  = 'BO'.
  
    CALL FUNCTION 'SO_SOLIXTAB_TO_SOLITAB'
      EXPORTING
        IP_SOLIXTAB = GT_PDF_DATA[]
      IMPORTING
        EP_SOLITAB  = LT_CONT[].
  
    CALL METHOD ZCL_OH_MY_GOS_NEW=>GOS_ATTACH_FILE_SOLITAB
      EXPORTING
        IV_NAME            = 'SMARTFORMS'
        IV_CONTENT_SOLITAB = LT_CONT[]
        IS_LPORB           = LS_LPORB
        IV_OBJTP           = LV_OBJTYP
        IV_FILELENGTH      = LV_FILESIZE
        IV_OBJNAME         = 'SMARTFORMS_FGI'
        IV_EXT             = 'PDF'
      RECEIVING
        RT_MESSAGES        = LT_BAPIRETTAB.
  
    IF SY-SUBRC = 0.
      COMMIT WORK.
      MESSAGE : 'SUCCESS' TYPE 'I'.
  
      DATA: LO_BITEM     TYPE REF TO CL_SOBL_BOR_ITEM,
            LO_CONTAINER TYPE REF TO CL_GUI_CONTAINER.
  
      CALL METHOD ZCL_OH_MY_GOS_NEW=>GET_BITEM
        EXPORTING
          IS_LPORB = LS_LPORB
        RECEIVING
          RO_BITEM = LO_BITEM.
  
      CALL METHOD ZCL_OH_MY_GOS_NEW=>SET_OBJECT
        EXPORTING
          IS_LPORB = LS_LPORB.
  
      CALL METHOD ZCL_OH_MY_GOS_NEW=>DISPLAY_ATTACHMENTS
        EXPORTING
          IO_CONTAINER = LO_CONTAINER.
  
    ELSE.
      MESSAGE : 'ERROR' TYPE 'I'.
    ENDIF.
  
  ENDFORM.