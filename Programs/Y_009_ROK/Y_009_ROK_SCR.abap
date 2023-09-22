*&---------------------------------------------------------------------*
*&  Include           Z_004_UWU_SCR
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK B000 WITH FRAME TITLE TEXT-000.

SELECTION-SCREEN SKIP.

SELECTION-SCREEN BEGIN OF BLOCK B100 WITH FRAME TITLE TEXT-100.

PARAMETERS: P_KEY   TYPE SWO_TYPEID      OBLIGATORY DEFAULT '4500012164' MATCHCODE OBJECT Z_MATCHCODE_EKKO_FGI,
            P_TYPE  TYPE SWO_OBJTYP      OBLIGATORY DEFAULT 'BUS2012',
            P_CATID TYPE SIBFLPORB-CATID OBLIGATORY DEFAULT 'BO'.

SELECTION-SCREEN SKIP 2.
SELECTION-SCREEN PUSHBUTTON 31(33) LB1 USER-COMMAND PB1.
SELECTION-SCREEN SKIP.

PARAMETERS: P_VBELN  TYPE VBAK-VBELN DEFAULT '17792',
            P_TYPESO TYPE SWO_OBJTYP      OBLIGATORY DEFAULT 'BUS2032',
            P_CATIDS TYPE SIBFLPORB-CATID OBLIGATORY DEFAULT 'BO'.

SELECTION-SCREEN SKIP 2.
SELECTION-SCREEN PUSHBUTTON 31(33) LB7 USER-COMMAND PB7.
SELECTION-SCREEN SKIP.
SELECTION-SCREEN PUSHBUTTON 31(33) LB5 USER-COMMAND PB5.
SELECTION-SCREEN SKIP.
SELECTION-SCREEN PUSHBUTTON 31(33) LB6 USER-COMMAND PB6.

SELECTION-SCREEN SKIP 2.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(15) TEXT-001 FOR FIELD P_RAD1.
PARAMETERS: P_RAD1 RADIOBUTTON GROUP RB1 USER-COMMAND FCODE DEFAULT 'X'.
SELECTION-SCREEN COMMENT 31(7) TEXT-002 FOR FIELD P_RAD2.
PARAMETERS: P_RAD2 RADIOBUTTON GROUP RB1.
SELECTION-SCREEN END OF LINE.


SELECTION-SCREEN END OF BLOCK B100.


SELECTION-SCREEN SKIP.


SELECTION-SCREEN BEGIN OF BLOCK B200 WITH FRAME TITLE TEXT-200.


SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(15) TEXT-003 FOR FIELD P_RAD3 MODIF ID SC1.
PARAMETERS: P_RAD3 RADIOBUTTON GROUP RB2 USER-COMMAND FCODE DEFAULT 'X' MODIF ID SC1.
PARAMETERS: P_UPL TYPE RLGRAP-FILENAME OBLIGATORY DEFAULT 'C:\Users\Public\Downloads\data1.csv' MODIF ID SC1.
SELECTION-SCREEN PUSHBUTTON 66(9) LB2 USER-COMMAND PB2 MODIF ID SC1.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(17) TEXT-007 FOR FIELD P_NAM MODIF ID SC1.
PARAMETERS: P_NAM TYPE STRING OBLIGATORY DEFAULT 'data1_fgi' MODIF ID SC1.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(17) TEXT-008 FOR FIELD P_EXT MODIF ID SC1.
PARAMETERS: P_EXT TYPE STRING OBLIGATORY DEFAULT 'CSV' MODIF ID SC1.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(15) TEXT-004 FOR FIELD P_RAD4 MODIF ID SC1.
PARAMETERS: P_RAD4 RADIOBUTTON GROUP RB2 MODIF ID SC1.
PARAMETERS: P_DLL  TYPE CHAR100 OBLIGATORY DEFAULT 'C:\usr\sap\put\' MODIF ID SC1.
SELECTION-SCREEN PUSHBUTTON 66(9) LB3 USER-COMMAND PB3 MODIF ID SC1.
SELECTION-SCREEN END OF LINE.


SELECTION-SCREEN END OF BLOCK B200.


SELECTION-SCREEN BEGIN OF BLOCK B300 WITH FRAME TITLE TEXT-300.


SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(17) TEXT-005 FOR FIELD P_RECEVR MODIF ID SC2.
PARAMETERS: P_RECEVR TYPE SO_RECNAME OBLIGATORY DEFAULT 'lisa.bagues@alliance4u.fr' MODIF ID SC2.
SELECTION-SCREEN PUSHBUTTON 66(9) LB4 USER-COMMAND PB4 MODIF ID SC2.
SELECTION-SCREEN END OF LINE.


SELECTION-SCREEN END OF BLOCK B300.


SELECTION-SCREEN SKIP.


SELECTION-SCREEN END OF BLOCK B000.

AT SELECTION-SCREEN.

  CASE SSCRFIELDS.
    WHEN 'PB1'.
      PERFORM ATTACHMENTS_DISPLAYING.
    WHEN 'PB2'.
      IF P_RAD3 = 'X'.
        PERFORM ATTACHMENTS_UPLOADING.
      ENDIF.
    WHEN 'PB3'.
      IF P_RAD4 = 'X'.
        PERFORM ATTACHMENTS_DOWNLOADING.
      ENDIF.
    WHEN 'PB4'.
      PERFORM ATTACHMENTS_EMAILING.
    WHEN 'PB5'.
      PERFORM SMARTFORM_SENDING.
    WHEN 'PB6'.
      PERFORM UPLOAD_SMARTFORMS.
    WHEN 'PB7'.
      PERFORM ATTACHMENTS_DISPLAYING_SO.
  ENDCASE.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF P_RAD2 = 'X' AND SCREEN-GROUP1 = 'SC1'.
      SCREEN-ACTIVE = 0.
      MODIFY SCREEN.
    ELSEIF P_RAD1 = 'X' AND SCREEN-GROUP1 = 'SC2'.
      SCREEN-ACTIVE = 0.
      MODIFY SCREEN.
    ENDIF.

  ENDLOOP.

  LOOP AT SCREEN.
    IF SCREEN-NAME = 'P_UPL'.
      IF P_RAD3 IS NOT INITIAL.
        SCREEN-INPUT  = 1.
      ELSE.
        SCREEN-INPUT  = 0.
      ENDIF.
      MODIFY SCREEN.
    ELSEIF SCREEN-NAME = 'P_NAM'.
      IF P_RAD3 IS NOT INITIAL.
        SCREEN-INPUT  = 1.
      ELSE.
        SCREEN-INPUT  = 0.
      ENDIF.
      MODIFY SCREEN.
    ELSEIF SCREEN-NAME = 'P_EXT'.
      IF P_RAD3 IS NOT INITIAL.
        SCREEN-INPUT  = 1.
      ELSE.
        SCREEN-INPUT  = 0.
      ENDIF.
      MODIFY SCREEN.
    ELSEIF SCREEN-NAME = 'P_DLL'.
      IF P_RAD4 IS NOT INITIAL.
        SCREEN-INPUT = 1.
      ELSE.
        SCREEN-INPUT  = 0.
      ENDIF.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_UPL.
  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
      PROGRAM_NAME  = SYST-CPROG
      DYNPRO_NUMBER = SYST-DYNNR
      FIELD_NAME    = 'P_UPL'
    IMPORTING
      FILE_NAME     = P_UPL.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_DLL.
  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
      PROGRAM_NAME  = SYST-CPROG
      DYNPRO_NUMBER = SYST-DYNNR
      FIELD_NAME    = 'P_DLL'
    IMPORTING
      FILE_NAME     = P_DLL.