*&---------------------------------------------------------------------*
*&  Include           Z_004_UWU_TOP
*&---------------------------------------------------------------------*

TABLES SSCRFIELDS.

DATA: GT_RECEIVERS  TYPE SOMLRECI1 OCCURS 0 WITH HEADER LINE,
      GT_BAPIRETTAB TYPE BAPIRETTAB,
      GO_BITEM      TYPE REF TO CL_SOBL_BOR_ITEM,
      GO_CONTAINER  TYPE REF TO CL_GUI_CONTAINER,
      GT_SOOD       TYPE STANDARD TABLE OF SOOD,
      GS_SOOD       TYPE SOOD.

DATA: GS_LPORB TYPE SIBFLPORB,
      DEC_KB   TYPE P.

" DATA_RETRIEVAL

DATA : GT_DATA    TYPE ZTT_008_ROK_BIS.

" LINE_RETRIEVAL

DATA:  ID       LIKE THEAD-TDID VALUE '0002',
       LANGUAGE LIKE THEAD-TDSPRAS VALUE 'EN',
       OBJECT   LIKE THEAD-TDOBJECT VALUE 'VBBK',
       LINES    TYPE TABLE OF TLINE.

" SMARTFORM_FILLING

DATA: LV_FNAME   TYPE RS38L_FNAM,
      FORMNAME   TYPE TDSFNAME,
      GS_CONTROL TYPE SSFCTRLOP,
      GS_OUTPUT  TYPE SSFCOMPOP.

" SMARTFORM ATTACHMENT

DATA: GV_VBELN    LIKE  THEAD-TDNAME,
      GS_JOB_INFO TYPE SSFCRESCL,
      GT_PDF_DATA TYPE SOLIX_TAB.