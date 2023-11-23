*&---------------------------------------------------------------------*
*& Report ZFGI_FORMATION_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zfgi_formation_05 NO STANDARD PAGE HEADING.

INCLUDE zfgi_formation_05_top.
INCLUDE zfgi_formation_05_scr.
INCLUDE zfgi_formation_05_f01.

START-OF-SELECTION.

PERFORM select_data.
PERFORM select_data2.

END-OF-SELECTION.