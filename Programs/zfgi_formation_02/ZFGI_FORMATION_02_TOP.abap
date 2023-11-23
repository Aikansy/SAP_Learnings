*&---------------------------------------------------------------------*
*& Include          ZFGI_FORMATION_02_TOP
*&---------------------------------------------------------------------*

TABLES : likp,  "Livraison en-tête
         lips, "Livraison poste (détails)
         marc, "Position des articles dans une division
         vbrk, "Facture en-tête
         vbrp. "Facture poste


TYPES: BEGIN OF ty_LIKP,
         vbeln TYPE likp-vbeln, "Numéro de livraison
         vstel TYPE likp-vstel, "
         vkorg TYPE likp-vkorg, "
         erdat TYPE likp-erdat, "
       END OF ty_LIKP,
       ty_t_LIKP TYPE TABLE OF ty_LIKP,

       BEGIN OF ty_LIPS,
         vbeln TYPE lips-vbeln, "Numéro de livraison
         posnr TYPE lips-posnr, "Numéro de poste
         matnr TYPE lips-matnr, "Numéro article
         werks TYPE lips-werks, "Division
         lfimg TYPE lips-lfimg, "Quantité
         meins TYPE lips-meins, "Unité de la quantité
       END OF ty_LIPS,
       ty_t_LIPS TYPE TABLE OF ty_LIPS,

       BEGIN OF ty_MARC,
         matnr TYPE marc-matnr, "Numéro article
         werks TYPE marc-werks, "Division
         ekgrp TYPE marc-ekgrp, "Acheteur
       END OF ty_MARC,
       ty_t_MARC TYPE TABLE OF ty_MARC,

       BEGIN OF ty_VBRK,
         vbeln TYPE vbrk-vbeln, "Numéro de la facture
         fkart TYPE vbrk-fkart, "
         fkdat TYPE vbrk-fkdat, "
         waerk TYPE vbrk-waerk, "Devise
       END OF ty_VBRK,
       ty_t_VBRK TYPE TABLE OF ty_VBRK,

       BEGIN OF ty_VBRP,
         vbeln TYPE vbrp-vbeln, "Numéro de la facture
         posnr TYPE vbrp-posnr, "Poste
         fkimg TYPE vbrp-fkimg, "Qté facturée
         vrkme TYPE vbrp-vrkme, "Unité de vente
         ntgew TYPE vbrp-ntgew, "Poids net
         gewei TYPE vbrp-gewei, "Unité de poids
         netwr TYPE vbrp-netwr, "Valeur nette
         vgbel TYPE vbrp-vgbel, "=vbeln de lips
         vgpos TYPE vbrp-vgpos, "=posnr de lips
       END OF ty_VBRP,
       ty_t_VBRP TYPE TABLE OF ty_VBRP.

DATA: gt_final TYPE TABLE OF zst_livraison.