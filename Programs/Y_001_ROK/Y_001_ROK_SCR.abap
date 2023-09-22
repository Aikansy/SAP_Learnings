*&---------------------------------------------------------------------*
*&  Include           Y_001_ROK_SCR
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK B000 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_input TYPE string.

  PARAMETERS: p_rad1 RADIOBUTTON GROUP rb1,
              p_rad2 RADIOBUTTON GROUP rb1.

SELECTION-SCREEN END OF BLOCK B000.