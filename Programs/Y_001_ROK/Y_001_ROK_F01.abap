*&---------------------------------------------------------------------*
*&  Include           Y_001_ROK_F01
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

    CLEAR: GV_INPUT,
           GV_REVERSE.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *&      Form  DATA_CHECK
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  
  FORM DATA_CHECK_PALINDROME .
  
    GV_INPUT = P_INPUT.
    CONDENSE GV_INPUT.
  
    CALL FUNCTION 'STRING_REVERSE'
      EXPORTING
        STRING    = GV_INPUT
        LANG      = SY-LANGU
      IMPORTING
        RSTRING   = GV_REVERSE
      EXCEPTIONS
        TOO_SMALL = 1
        OTHERS    = 2.
    IF SY-SUBRC <> 0.
      MESSAGE 'ERROR' TYPE 'I'.
    ENDIF.
  
    IF GV_INPUT EQ GV_REVERSE.
      MESSAGE 'SUCCESS - The string is a palindrome' TYPE 'I'.
    ELSE.
      MESSAGE 'FAILURE - The string is not a palindrome' TYPE 'I'.
    ENDIF.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *&      Form  DATA_CHECK_TYPE
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  
  FORM DATA_CHECK_PATTERN .
  
    GV_INPUT = P_INPUT.
  
  *  IF matches( val = gv_input regex = gv_pattern ).
  *    MESSAGE 'SUCCESS - The character string matches the specified pattern.' TYPE 'S'.
  *  ELSE.
  *    MESSAGE 'FAILURE - The character string does not match the specified pattern.' TYPE 'S' DISPLAY LIKE 'E'.
  *  ENDIF.
  
    IF CL_ABAP_MATCHER=>MATCHES( PATTERN = GV_PATTERN TEXT = GV_INPUT ).
      MESSAGE 'SUCESS - The character string matches the specified pattern.' TYPE 'S'.
    ELSE.
      MESSAGE 'FAILURE - The character string does not match the specified pattern.' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
  
  ENDFORM.