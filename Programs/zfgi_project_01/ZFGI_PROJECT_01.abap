*&-----------------------------------------------------------------------------------------------------*
*& Report ZFGI_PROJECT_01
*&-----------------------------------------------------------------------------------------------------*
*& Date création    / Auteur            / Motif
*& 20.03.2023         FGI                 PROJECT_01
*&-----------------------------------------------------------------------------------------------------*
*& Modification     / Auteur            / Motif
*& ZPROJ_INTER_2023
*&-----------------------------------------------------------------------------------------------------*

REPORT ZFGI_PROJECT_01 NO STANDARD PAGE HEADING.

INCLUDE ZFGI_PROJECT_01_TOP.
INCLUDE ZFGI_PROJECT_01_SCR.
INCLUDE ZFGI_PROJECT_01_F01.

START-OF-SELECTION.

IF p_create = 'X'.

  PERFORM data_extraction_local.
  PERFORM data_extraction_server.
  PERFORM data_preparation.
  PERFORM data_verification.
  PERFORM client_order_creation.

ELSE.

  PERFORM display_client_order.

ENDIF.

END-OF-SELECTION.