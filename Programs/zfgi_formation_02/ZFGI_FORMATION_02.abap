*&---------------------------------------------------------------------*
*& Report ZFGI_FORMATION_02
*&---------------------------------------------------------------------*
*& Date création    / Auteur            / Motif
*& 23.02.2023         FGI(Alliance4u)     Création 2nd programme ABAP
*&---------------------------------------------------------------------*

REPORT zfgi_formation_02 NO STANDARD PAGE HEADING.

INCLUDE zfgi_formation_02_top. "Déclaration de mes variables globales
INCLUDE zfgi_formation_02_scr. "Déclaration de notre écran de sélection
INCLUDE zfgi_formation_02_f01. "Traitements effectués sur les données

START-OF-SELECTION.

PERFORM select_data. "sélection des données.
PERFORM display_data.
PERFORM play_data.

*CONCATENATE: sy-datum+6(2) sy-datum+4(2) sy-datum(4) INTO DATA(lv_date) SEPARATED BY '.'.
*REPLACE ALL OCCURRENCES OF '.' IN lv_date WITH '/'.

*WRITE lv_date.

END-OF-SELECTION.