*&---------------------------------------------------------------------*
*&  Include           Y_008_ROK_SCR
*&---------------------------------------------------------------------*

SELECTION-SCREEN : BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.


SELECTION-SCREEN SKIP. "Pour sauter une ligne

PARAMETERS  P_VBELN TYPE VBAK-VBELN DEFAULT '17789' OBLIGATORY.

SELECTION-SCREEN SKIP 2. "Pour sauter une ligne

SELECTION-SCREEN PUSHBUTTON 33(10) LB1 USER-COMMAND PB1.

SELECTION-SCREEN SKIP.

SELECTION-SCREEN : END OF BLOCK B1.

AT SELECTION-SCREEN.

  CASE SSCRFIELDS.
    WHEN 'PB1'.
      PERFORM SELECT_DATA.
    WHEN OTHERS.
  ENDCASE.