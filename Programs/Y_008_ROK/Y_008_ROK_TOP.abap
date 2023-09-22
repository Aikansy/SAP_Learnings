*&---------------------------------------------------------------------*
*&  Include           Y_008_ROK_TOP
*&---------------------------------------------------------------------*

TABLES SSCRFIELDS.


DATA : GT_INFO    TYPE ZT_LBA,
       LV_FNAME   TYPE RS38L_FNAM,         "Code du module fonction associé au smartform
       LV_SF_NAME TYPE TDSFNAME,           "Nom smartform

       LS_CONTROL TYPE SSFCTRLOP,
       LS_OUTPUT  TYPE SSFCOMPOP,

       "FOR READ TEXT
       GV_VBELN   LIKE THEAD-TDNAME,
       LANGUAGE   LIKE THEAD-TDSPRAS VALUE 'P',
       ID         LIKE THEAD-TDID VALUE '0002',
       OBJECT     LIKE THEAD-TDOBJECT VALUE 'VBBK',
       LINES      TYPE TABLE OF TLINE.

*TYPES: BEGIN OF zst_lba,
*        vbeln TYPE zst_lba-vbeln,
*        kunnr TYPE zst_lba-kunnr,
*        name1 TYPE zst_lba-name1,
*        stras TYPE zst_lba-stras,
*        pstlz TYPE zst_lba-pstlz,
*        ort01 TYPE zst_lba-ort01,
*        land1 TYPE zst_lba-land1,
*        landx TYPE zst_lba-landx,
*        posnr TYPE zst_lba-posnr,
*        arktx TYPE zst_lba-arktx,
*        kwmeng TYPE zst_lba-kwmeng,
*        netwr TYPE zst_lba-netwr,
*        cmwae TYPE zst_lba-cmwae,
*        total_netwr TYPE zst_lba-total_netwr,
*      END OF zst_lba.