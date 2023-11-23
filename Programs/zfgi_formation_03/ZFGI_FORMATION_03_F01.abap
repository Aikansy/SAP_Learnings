*&---------------------------------------------------------------------*
*& Include          ZFGI_FORMATION_03_F01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form select_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

* VBAK            Poste des documents de vente
*   - VBELN_A     Document de vente
*   - ERDAT       Date de création de l'enregistrement
*   - VKORG       Organisation commerciale
*   - VTWEG       Canal de distribution rattachée à cette commande
*   - SPART       Secteur d'activité rattachée à cette commande
*   - NETWR_A     Valeur nette de la commande
*   - WAERK_A     Devise du document commercial

* VBAP
*   - VBELN_B     Document de vente
*   - POSNR       Désignation du poste d'une commande client
*   - MATNR_B     Numéro d'article
*   - PMATN       Prix
*   - CHARG       Numéro de lot
*   - ZMENG       Quantité
*   - KUNNR_B     Donneur d'ordre
*   - NETWR_B     Valeur nette du poste de cde client en devise de la pièce
*   - WAERK_B     Devise du document commercial

* MAKT
*   - MATNR_C
*   - MAKTX       Désignation de l’article

* KNA1
*   - KUNNR_D     Donneur d'ordre
*   - NAME1       Nom 1
*   - NAME2       Nom 2
*   - STRAS       Adresse
*   - PSTLZ       Code postal
*   - ORT01       Ville
*   - LAND1       Pays

* GT_FINAL
*   - CONCA       CHAR255

FORM select_data.

    DATA: lt_vbak TYPE TABLE OF ty_vbak,
          lt_vbap TYPE TABLE OF ty_vbap,
          lt_makt TYPE TABLE OF ty_makt,
          lt_kna1 TYPE TABLE OF ty_kna1.
  
    SELECT vbeln erdat vkorg vtweg spart netwr waerk
      FROM vbak
      INTO TABLE lt_vbak
      WHERE vbeln IN s_vbeln. "table range
  
    SELECT vbeln posnr matnr charg kunnr_ana netwr waerk
      FROM vbap
      INTO TABLE lt_vbap
      FOR ALL ENTRIES IN lt_vbak
      WHERE vbeln = lt_vbak-vbeln
      AND matnr IN s_matnr
      AND charg IN s_charg
      AND kunnr_ana IN s_kunnr.
  
    SELECT matnr maktx
      FROM makt
      INTO TABLE lt_makt
      FOR ALL ENTRIES IN lt_vbap
      WHERE matnr = lt_vbap-matnr.
  
    SELECT kunnr name1 name2 stras pstlz ort01 land1
      FROM kna1
      INTO TABLE lt_kna1
      FOR ALL ENTRIES IN lt_vbap
      WHERE kunnr = lt_vbap-kunnr_ana.
  
    PERFORM: merge_data USING lt_vbak lt_vbap lt_makt lt_kna1.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form merge_data
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *&      --> LT_VBAK
  *&      --> LT_VBAP
  *&      --> LT_MAKT
  *&      --> LT_KNA1
  *&---------------------------------------------------------------------*
  
  FORM merge_data USING ut_vbak TYPE ty_t_vbak
                        ut_vbap TYPE ty_t_vbap
                        ut_makt TYPE ty_t_makt
                        ut_kna1 TYPE ty_t_kna1.
  
    DATA: ls_final LIKE LINE OF gt_final.
  
    LOOP AT ut_vbak ASSIGNING FIELD-SYMBOL(<fs_vbak>).
      CLEAR ls_final.
  
        ls_final-vbeln_a   = <fs_vbak>-vbeln.
        ls_final-erdat     = <fs_vbak>-erdat.
        ls_final-vkorg     = <fs_vbak>-vkorg.
        ls_final-vtweg     = <fs_vbak>-vtweg.
        ls_final-spart     = <fs_vbak>-spart.
        ls_final-netwr_a   = <fs_vbak>-netwr.
        ls_final-waerk_a   = <fs_vbak>-waerk.
  
        LOOP AT ut_vbap ASSIGNING FIELD-SYMBOL(<fs_vbap>) WHERE vbeln = <fs_vbak>-vbeln.
  
            ls_final-vbeln_b  = <fs_vbap>-vbeln.
            ls_final-posnr    = <fs_vbap>-posnr.
            ls_final-matnr_b  = <fs_vbap>-matnr.
            ls_final-charg    = <fs_vbap>-charg.
            ls_final-kunnr_b 	= <fs_vbap>-kunnr_ana.
            ls_final-netwr_b 	= <fs_vbap>-netwr.
            ls_final-waerk_b 	= <fs_vbap>-waerk.
  
            ls_final-total    = <fs_vbap>-pmatn * <fs_vbap>-zmeng.
  
            READ TABLE ut_makt ASSIGNING FIELD-SYMBOL(<fs_makt>) WITH KEY matnr = <fs_vbap>-matnr.
  
            IF sy-subrc = 0.
              ls_final-maktx 	  = <fs_makt>-maktx.
            ENDIF.
  
            READ TABLE ut_kna1 ASSIGNING FIELD-SYMBOL(<fs_kna1>) WITH KEY kunnr = <fs_vbap>-kunnr_ana.
  
            IF sy-subrc = 0.
              ls_final-kunnr_d  = <fs_kna1>-kunnr.
              ls_final-name1 	  = <fs_kna1>-name1.
              ls_final-name2 	  = <fs_kna1>-name2.
  
              CONCATENATE <fs_kna1>-stras' ' <fs_kna1>-pstlz' ' <fs_kna1>-ort01' ' <fs_kna1>-land1 INTO ls_final-conca.
            ENDIF.
  
            APPEND ls_final TO gt_final.
  
        ENDLOOP.
  
    ENDLOOP.
  
  ENDFORM.