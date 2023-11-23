*&---------------------------------------------------------------------*
*& Include          ZFGI_FORMATION04_TOP
*&---------------------------------------------------------------------*

TYPES: BEGIN OF ty_vbrp,
         vgbel TYPE vbrp-vgbel,
         vgpos TYPE vbrp-vgpos,
         vbeln TYPE vbrp-vbeln,
         posnr TYPE vbrp-posnr,
         meins TYPE vbrp-meins,
         fkimg TYPE vbrp-fkimg,
         ntgew TYPE vbrp-ntgew,
         gewei TYPE vbrp-gewei,
         netwr TYPE vbrp-netwr,
       END OF ty_vbrp.

TYPES : BEGIN OF ty_vbrkp,
          fkdat TYPE vbrk-fkdat,
          fkart TYPE vbrk-fkart.
          INCLUDE STRUCTURE vbrp.
TYPES:  END OF ty_vbrkp.

DATA: gt_vbrkp TYPE TABLE OF ty_vbrkp.