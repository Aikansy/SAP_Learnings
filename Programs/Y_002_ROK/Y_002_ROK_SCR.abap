*&---------------------------------------------------------------------*
*&  Include           Y_002_ROK_SCR
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b100 WITH FRAME TITLE TEXT-100.
*PARAMETERS:     p_bukrs TYPE BKPF-BUKRS.
SELECT-OPTIONS: s_bukrs FOR  BKPF-BUKRS.
SELECT-OPTIONS: s_belnr FOR  BKPF-BELNR.
PARAMETERS:     p_bldat TYPE BKPF-BLDAT DEFAULT '20180101'.
SELECTION-SCREEN END OF BLOCK b100.

SELECTION-SCREEN SKIP.

SELECTION-SCREEN BEGIN OF BLOCK b200 WITH FRAME TITLE TEXT-200.
PARAMETERS:     p_file TYPE string DEFAULT 'C:\Users\Public\Downloads\data.csv'.
SELECTION-SCREEN END OF BLOCK b200.