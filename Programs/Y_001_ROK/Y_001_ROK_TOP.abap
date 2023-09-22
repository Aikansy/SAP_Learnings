*&---------------------------------------------------------------------*
*&  Include           Y_001_ROK_TOP
*&---------------------------------------------------------------------*

DATA: gv_input(50) TYPE c.
DATA: gv_reverse(50) TYPE c.

DATA: gv_pattern(50) TYPE c VALUE 'AIRCRAFT-\d{3,5}[A-Z]{2}'.