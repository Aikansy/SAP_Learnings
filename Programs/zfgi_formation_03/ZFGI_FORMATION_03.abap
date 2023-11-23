*&---------------------------------------------------------------------*
*& Date création    / Auteur            / Motif
*& 27.02.2023         FGI(Alliance4u)     Exercices
*&---------------------------------------------------------------------*
*& Modification     / Auteur            / Motif
*&
*&---------------------------------------------------------------------*

* VBAK            Poste des documents de vente
*   - VBELN       Document de vente
*   - ERDAT       Date de création de l'enregistrement
*   - VKORG       Organisation commerciale
*   - VTWEG       Canal de distribution rattachée à cette commande
*   - SPART       Secteur d'activité rattachée à cette commande
*   - NETWR       Valeur nette de la commande
*   - WAERK       Devise du document commercial

* VBAP
*   - POSNR       Désignation du poste d'une commande client
*   - MATNR       Numéro d'article
*   - CHARG       Numéro de lot
*   - KUNNR_ANA   Donneur d'ordre
*   - NETWR       Valeur nette du poste de cde client en devise de la pièce
*   - WAERK       Devise du document commercial

* MAKT
*   - MAKTX       Désignation de l’article

* KNA1
*   - NAME1       Nom 1
*   - NAME2       Nom 2
*   - STRAS       Adresse
*   - PSTLZ       Code postal
*   - ORT01       Ville
*   - LAND1       Pays

* ZSFGI_COMMAND

REPORT ZFGI_FORMATION_03 NO STANDARD PAGE HEADING.

INCLUDE zfgi_formation_03_top.
INCLUDE zfgi_formation_03_scr.
INCLUDE zfgi_formation_03_f01.

START-OF-SELECTION.

  PERFORM select_data.

END-OF-SELECTION.