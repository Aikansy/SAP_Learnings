*&---------------------------------------------------------------------*
*&  Include           Y_001_ROK_TOP
*&---------------------------------------------------------------------*

DATA: GV_INPUT(50) TYPE c.
DATA: GV_REVERSE(50) TYPE c.

DATA: GV_PATTERN(50) TYPE c VALUE 'AIRCRAFT-\d{3,5}[A-Z]{2}'.