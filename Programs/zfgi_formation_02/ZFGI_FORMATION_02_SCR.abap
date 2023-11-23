*&---------------------------------------------------------------------*
*& Include          ZFGI_FORMATION_02_SCR
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b00 WITH FRAME TITLE TEXT-001.
* Les champs de renseignement.
  SELECT-OPTIONS : s_vbelnl FOR likp-vbeln. "Le numéro de livraison
  SELECT-OPTIONS : s_matnr  FOR lips-matnr. "Le numéro de livraison
  SELECT-OPTIONS : s_WERKS  FOR lips-werks. "La division
  SELECT-OPTIONS : s_VBELNv FOR vbrk-vbeln. "Le numéro de facture

SELECTION-SCREEN END OF BLOCK b00.

SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME TITLE TEXT-001.

* Gestion d'affichage des articles supprimés.
  PARAMETERS : p_del AS CHECKBOX. "un des champs de la table MARA vous donnera cette information.

SELECTION-SCREEN END OF BLOCK b01.