*&-----------------------------------------------------------------------------------------------------*
*& Report ZJLMF_PROJECT_01
*&-----------------------------------------------------------------------------------------------------*
*& Date création    / Auteur            / Motif
*& 20.03.2023         FGI                 PROJECT_01
*&-----------------------------------------------------------------------------------------------------*
*& Modification     / Auteur            / Motif
*&
*&-----------------------------------------------------------------------------------------------------*

REPORT ZFGI_PROJECT_01_DYNPRO NO STANDARD PAGE HEADING.

INCLUDE ZFGI_PROJECT_01_DYNPRO_TOP.
INCLUDE ZFGI_PROJECT_01_DYNPRO_SCR.
INCLUDE ZFGI_PROJECT_01_DYNPRO_F01.

START-OF-SELECTION.

IF p_create = 'X'.
  PERFORM data_extraction.
  PERFORM data_preparation.
  PERFORM data_verification.
  PERFORM client_order_creation.
ELSE.
  PERFORM display_client_order.
ENDIF.

END-OF-SELECTION.