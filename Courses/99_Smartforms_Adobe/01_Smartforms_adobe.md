# **SMARTFORMS ADOBE**

Avec ADOBE, il est possible d'avoir plusieurs formulaires créés à partir d'une interface (sur SMARTFORMS: 1 formulaire = 1 interface). Pour les formulaires ADOBE, il est nécessaire que le paramétrage soit effectué (Fonctionnel).

SMARTFORMS ADOBE : `ZADOBE_FORM_KDE`

PROGRAM : `ZFGI_FORMATION_14`

`DYNPRO 9002`

```abap
PROCESS BEFORE OUTPUT.
 MODULE STATUS_9002.
 module display_alv.

PROCESS AFTER INPUT.
 MODULE USER_COMMAND_9002.
```

`MODULE STATUS_9002`

```abap
MODULE status_9002 OUTPUT.
  SET PF-STATUS 'STATUT_GUI_9002'.
  SET TITLEBAR 'ALV'.
ENDMODULE.
```

`MODULE DISPLAY_ALV`

```abap
MODULE display_alv OUTPUT.

  PERFORM select_data.
  PERFORM display_data_dynp.

ENDMODULE.
```

`MODULE SELECT_DATA`

```abap
FORM select_data.

* Select avec jointure sur VBAK VBAP KNA1 MARA MAKT

  DATA : lv_post TYPE ntgew,
         lv_comm TYPE f.

  SELECT vbak~vbeln,                                                               " Numéro de la commande de vente
  vbak~auart,                                                               " Type de doc. De vente
  vbak~erdat,                                                               " Date de création de la commande
  vbak~erzet,                                                               " Heure de création
  vbak~vdatu,                                                               " Date de livraison souhaitée
  vbak~vkorg,                                                               " Organisation commerciale
  vbak~vtweg,                                                               " Canal de distribution
  vbak~spart,                                                               " Secteur d’activité
  vbap~kunnr_ana,                                                           " Client donneur d’ordre
  kna1~name1,                                                               " Nom du donneur d’ordre
  vbap~kunwe_ana,                                                           " Client réceptionnaire
  kna1~name2,                                                               " Nom du client réceptionnaire
  kna1~pstlz && @space && kna1~ort01 && @space && kna1~land1 AS address,    " KNA1 - Adresse du client réceptionnaire (Code postal + Ville + Pays)
  vbap~posnr,                                                               " Numéro de poste Com.
  vbap~matnr,                                                               " Article
  makt~maktx,                                                               " Désignation article
  vbap~werks,                                                               " Division
  vbap~zmeng,                                                               " Quantité commandée
  vbap~zieme,                                                               " Unité de quantité
  mara~ntgew,                                                               " Poids net de l’article
  mara~gewei                                                               " Unité de poids

******************************  Depuis les tables  ****************************************
  FROM vbak
  INNER JOIN vbap ON vbap~vbeln = vbak~vbeln
  LEFT OUTER JOIN kna1 ON kna1~kunnr = vbap~kunnr_ana
  LEFT OUTER JOIN makt ON makt~matnr = vbap~matnr
  AND makt~spras = @sy-langu
  LEFT OUTER JOIN mara ON mara~matnr = makt~matnr
  WHERE vbak~auart IN @s_auart
  AND vbak~vbeln IN @s_vbeln
  AND vbak~vkorg IN @s_vkorg
  AND vbak~vtweg IN @s_vtweg
  AND vbak~spart IN @s_spart
  AND vbap~kunnr_ana IN @s_kunnr
  AND vbap~matnr IN @s_matnr
  AND vbap~werks IN @s_plant
  AND vbak~erdat IN @s_erdat
  ORDER BY vbak~erdat DESCENDING, vbak~erzet DESCENDING
  INTO TABLE @gt_cv.
  IF sy-subrc <> 0.
    MESSAGE e000(zkde_mess).
  ELSE.
    EXPORT data FROM gt_cv TO MEMORY ID 'MEM'.
  ENDIF.

****************************  Calcul poids des postes + poids total de la commande   ******************************************
  LOOP AT gt_cv ASSIGNING FIELD-SYMBOL(<fs_cv>).
    AT NEW vbeln.
      CLEAR <fs_cv>-pds_tot.
    ENDAT.

    LOOP AT gt_cv ASSIGNING FIELD-SYMBOL(<fs_cv2>) WHERE vbeln = <fs_cv>-vbeln.
      <fs_cv2>-pds_post = <fs_cv2>-zmeng * <fs_cv2>-ntgew.
      <fs_cv>-pds_tot =  <fs_cv>-pds_tot  + <fs_cv2>-pds_post.
    ENDLOOP.
  ENDLOOP.

ENDFORM.
```

`MODULE DISPLAY_DATA_DYNP`

```abap
FORM display_data_dynp .

  DATA: site_container TYPE REF TO cl_gui_custom_container,
        html           TYPE REF TO cl_gui_html_viewer.

** Chargement de l'image dans le 1er container

  CREATE OBJECT site_container
    EXPORTING
      container_name = 'CONTAINER_FUN'.
  CREATE OBJECT html
    EXPORTING
      parent = site_container.

  CALL METHOD html->show_url
    EXPORTING
      url = 'https://i.guim.co.uk/img/media/7889fca13a88183f5f1eaf2c0bfa3f3b96bd7373/0_17_2079_1247/master/2079.jpg?width=1300&quality=45&dpr=2&s=none'.
*      url = 'https://www.youtube.com/watch?v=FJ2tzqCl0L4'.

* Création du Custom container en fonction de l'élement (du nom) dans mon Dynpro
  go_custom_container = NEW cl_gui_custom_container( container_name = 'CONTAINER_ALV' ).

  TRY.
      CALL METHOD cl_salv_table=>factory(
        EXPORTING
          r_container    = go_custom_container
          container_name = 'CONTAINER_ALV'
        IMPORTING
          r_salv_table   = go_alv
        CHANGING
          t_table        = gt_cv ).
    CATCH cx_salv_msg INTO lo_message.
  ENDTRY.


  lo_alv_functions = go_alv->get_functions( ).
  lo_alv_functions->set_all( abap_true ).

* Custom Button Function
  lo_alv_functions->add_function( name = 'PRINT_SF'
                                  icon = 'ICON_PRINT'
                                  text = 'IMPRIMEZ UNE COMMANDE DE VENTE SF'
                                  tooltip = 'Imprimer un formulaire smartform'
                                  position = if_salv_c_function_position=>right_of_salv_functions ).

  lo_alv_functions->add_function( name = 'PRINT_ADOBE'
                                  icon = 'ICON_PRINT'
                                  text = 'IMPRIMEZ UNE COMMANDE DE VENTE ADOBE'
                                  tooltip = 'Imprimer un formulaire smartform ADOBE'
                                  position = if_salv_c_function_position=>right_of_salv_functions ).

  lo_columns = go_alv->get_columns( ).
  lo_column ?= lo_columns->get_column('CHECK').
  lo_column->set_cell_type( if_salv_c_cell_type=>checkbox_hotspot ).
  lO_column->set_icon( if_salv_c_bool_sap=>true ).
  lo_columns->set_optimize( abap_true ).

  lr_events = go_alv->get_event( ).


  CREATE OBJECT lo_events.
* Check Box
* SET HANDLER lo_events->click_button FOR lr_events.
* Button Functionality
  SET HANDLER lo_events->m_double_click FOR lr_events.
  SET HANDLER lo_events->m_hotspot      FOR lr_events.
  SET HANDLER lo_events->m_usercommand FOR lr_events.
  SET HANDLER lo_events->m_after_function FOR lr_events.

  go_alv->display( ).

ENDFORM.
```

`MODULE USERCOMMAND_EVENT`

```abap
FORM usercommand_event USING i_ucomm TYPE salv_de_function.

* Déclaration des tables / structures qui seront envoyées aux formulaires
  DATA : ls_header LIKE zscv_header,
         lt_item   TYPE ztcv_item,
         ls_item   LIKE LINE OF lt_item.

* Déclaration de données pour le formulaire smartform
  DATA : ls_control TYPE ssfctrlop,
         ls_output  TYPE ssfcompop,
         lv_fname   TYPE rs38l_fnam,  "Code du module fonction associé au smartform
         lv_sf_name TYPE tdsfname.    "Nom smartform

* Déclaration de données pour le formulaire ADOBE
  DATA : ls_sfpoutputparams TYPE sfpoutputparams,
         ls_docparams       TYPE sfpdocparams,
         ls_pdf_file        TYPE fpformoutput,
         lv_formname        TYPE fpname,
         lv_fmname          TYPE funcname,
         lv_mseg            TYPE string,
         lv_w_cx_root       TYPE REF TO cx_root.  "exception class

* J'alimente les tables d'en-tête et de poste qui seront envoyés aux formulaires
  READ TABLE gt_cv ASSIGNING FIELD-SYMBOL(<fs_cv>) WITH KEY check = 'X'.
  IF sy-subrc = 0.
    ls_header-vbeln = <fs_cv>-vbeln.
    ls_header-auart = <fs_cv>-auart.
    ls_header-erdat = <fs_cv>-erdat.
    ls_header-erzet = <fs_cv>-erzet.
    ls_header-vdatu = <fs_cv>-vdatu.
    ls_header-vkorg = <fs_cv>-vkorg.
    ls_header-vtweg = <fs_cv>-vtweg.
    ls_header-spart = <fs_cv>-spart.
    ls_header-kunnr_ana = <fs_cv>-kunnr_ana.
    ls_header-name1     = <fs_cv>-name1.
    ls_header-kunwe_ana = <fs_cv>-kunwe_ana.
    ls_header-name2     = <fs_cv>-name2.
    ls_header-adress    = <fs_cv>-adress.

    LOOP AT gt_cv ASSIGNING FIELD-SYMBOL(<fs_cv2>) WHERE vbeln = <fs_cv>-vbeln.
      ls_item-posnr    = <fs_cv2>-posnr.
      ls_item-matnr    = <fs_cv2>-matnr.
      ls_item-maktx    = <fs_cv2>-maktx.
      ls_item-werks    = <fs_cv2>-werks.
      ls_item-zmeng    = <fs_cv2>-zmeng.
      ls_item-zieme    = <fs_cv2>-zieme.
      ls_item-ntgew    = <fs_cv2>-ntgew.
      ls_item-gewei    = <fs_cv2>-gewei.
      ls_item-pds_post = <fs_cv2>-pds_post.
      ls_item-pds_tot  = <fs_cv2>-pds_tot.
      APPEND ls_item TO lt_item.
    ENDLOOP.
  ENDIF.

  CASE i_ucomm.
    WHEN 'PRINT_SF'.
      lv_sf_name = 'ZCOMV_KDE'.
      ls_control-preview  = 'X'.
*      ls_control-device   = 'LP01'.
      ls_output-tdnoprev  = ' '.

      CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
        EXPORTING
          formname           = lv_sf_name
          variant            = ' '
          direct_call        = ' '
        IMPORTING
          fm_name            = lv_fname
        EXCEPTIONS
          no_form            = 1
          no_function_module = 2
          OTHERS             = 3.

      "Appel du smartform
      CALL FUNCTION lv_fname
        EXPORTING
          is_header          = ls_header
          it_item            = lt_item
          control_parameters = ls_control
          output_options     = ls_output
        EXCEPTIONS
          formatting_error   = 1
          internal_error     = 2
          send_error         = 3
          user_canceled      = 4
          OTHERS             = 5.

    WHEN 'PRINT_ADOBE'.
      lv_formname                 = 'ZADOBE_FORM_KDE'.
      ls_sfpoutputparams-dest     = 'LP01'.
*      ls_sfpoutputparams-nodialog = 'X'.
      ls_sfpoutputparams-preview  = 'X'.

      CALL FUNCTION 'FP_JOB_OPEN'
        CHANGING
          ie_outputparams = ls_sfpoutputparams
        EXCEPTIONS
          cancel          = 1
          usage_error     = 2
          system_error    = 3
          internal_error  = 4
          OTHERS          = 5.

      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.

      TRY .
          CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
            EXPORTING
              i_name     = lv_formname
            IMPORTING
              e_funcname = lv_fmname.

        CATCH cx_root INTO lv_w_cx_root.
          lv_mseg = lv_w_cx_root->get_text( ).
          MESSAGE lv_mseg TYPE 'E'.

      ENDTRY.

      MOVE: sy-langu TO ls_docparams-langu.


      " Appel du JOB
      CALL FUNCTION lv_fmname
        EXPORTING
          /1bcdwb/docparams = ls_docparams
          is_header         = ls_header
          it_item           = lt_item
*    IMPORTING
*         /1bcdwb/formoutput = ls_pdf_file
        EXCEPTIONS
          usage_error       = 1
          system_error      = 2
          internal_error    = 3
          OTHERS            = 4.

      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.

      " Fermeture du job
      CALL FUNCTION 'FP_JOB_CLOSE'
*   IMPORTING
*     e_result             =
        EXCEPTIONS
          usage_error    = 1
          system_error   = 2
          internal_error = 3
          OTHERS         = 4.

      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.
    WHEN OTHERS.

  ENDCASE.

ENDFORM.
```