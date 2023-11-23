*&---------------------------------------------------------------------*
*& Include          ZJLMF_PROJECT_01_TOP
*&---------------------------------------------------------------------*

TABLES: vbak, vbap.

TYPES: BEGIN OF ty_fileline,
         fileline TYPE string,
       END OF ty_fileline.

TYPES : BEGIN OF ty_final,
          vbeln    TYPE vbak-vbeln,           " Numéro de la commande de vente
          auart    TYPE vbak-auart,           " Type de doc. De vente
          erdat    TYPE vbak-erdat,           " Date de création de la commande
          erzet    TYPE vbak-erzet,           " Heure de création
          vdatu    TYPE vbak-vdatu,           " Date de livraison souhaitée
          vkorg    TYPE vbak-vkorg,           " Organisation commerciale
          vtweg    TYPE vbak-vtweg,           " Canal de distribution
          spart    TYPE vbak-spart,           " Secteur d’activité
          kunnr    TYPE vbap-kunnr_ana,       " Client donneur d’ordre
          name1    TYPE kna1-name1,           " Nom du donneur d’ordre
          kunwe    TYPE vbap-kunwe_ana,       " Client réceptionnaire
          name2    TYPE kna1-name2,           " Nom du client réceptionnaire
          address  TYPE String,               " KNA1 - Adresse du client réceptionnaire (Code postal + Ville + Pays)
          posnr    TYPE vbap-posnr,           " Numéro de poste Com.
          matnr    TYPE vbap-matnr,           " Article
          maktx    TYPE makt-maktx,           " Désignation article
          werks    TYPE vbap-werks,           " Division
          po_quant TYPE vbap-zmeng,           " Quantité commandée
          po_unit  TYPE vbap-zieme,           " Unité de quantité
          ntgew    TYPE mara-ntgew,           " Poids net de l’article
          gewei    TYPE mara-gewei,           " Unité de poids
          pt_post  TYPE vbap-zmeng,           " Poids total du poste
          pt_comm  TYPE vbap-zmeng,           " Poids total de la commande
        END OF ty_final.

DATA: gt_line   TYPE TABLE OF ty_fileline,
      gt_file   TYPE TABLE OF zsjlmf_file_01,
      gt_return TYPE TABLE OF bapiret2,
      t_ty_final TYPE TABLE OF ty_final.