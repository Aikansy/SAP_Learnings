*&---------------------------------------------------------------------*
*& Include          ZFGI_FORMATION_06_TOP
*&---------------------------------------------------------------------*

* Récupérer les commandes d'achat et les informations des postes.
* - N° de commande achat          EKKO-EBELN
* - N° de l'article               EKPO-MATNR
* - Langue                        EKKO-SPRAS

TABLES: ekko, ekpo, makt.

TYPES: BEGIN OF ty_final,
  ebeln1 TYPE ekko-ebeln,
  aedat1 TYPE ekko-aedat,
  maktx  TYPE makt-maktx.
  INCLUDE STRUCTURE ekpo.
TYPES: END OF ty_final.

DATA: gt_final TYPE TABLE OF ty_final.




* RG 1 :

* PARAMS

*AT SELECTION-SCREEN OUTPUT. "Déclancher quand ecran s'affiche et quand execute
*
*  IF p_car IS INITIAL.
*    MESSAGE TEXT-005 TYPE 'I'.
*  ENDIF.
*
*ENDAT.
*
*AT SELECTION-SCREEN ON p_cat. "On param OR select-option
*
*  IF p_car IS INITIAL.
*    MESSAGE TEXT-005 TYPE 'I'.
*  ENDIF.
*
*ENDAT.
*
*AT SELECTION-SCREEN ON BLOCK b01. "On param OR select-option
*
*  IF p_car IS INITIAL.
*    MESSAGE TEXT-005 TYPE 'I'.
*  ENDIF.
*
*ENDAT.
*
*AT SELECTION-SCREEN ON RADIOBUTTON GROUP B02.
*
*  IF p_car IS INITIAL.
*    MESSAGE TEXT-005 TYPE 'I'.
*  ENDIF.
*
*ENDAT.
*
*AT SELECTION-SCREEN ON VALUE-REQUEST FOR .
*
*  IF p_car IS INITIAL.
*    MESSAGE TEXT-005 TYPE 'I'.
*  ENDIF.
*
*ENDAT.

*&---------------------------------------------------------------------*

* PROCESS BEFORE OUTPUT (PBO)
* Tout ce qui se passe avant l'affichage

*AT SELECTION-SCREEN OUTPUT. "Au chargement de l'écran
*
*  p_cat = 'SCI'.
*
*ENDAT.

*&---------------------------------------------------------------------*

* PROCESS AFTER INPUT (PAI)
* Après entrer une valeur