*&---------------------------------------------------------------------*
*& Include          ZJLMF_PROJECT_01_F01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form data_extraction
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM data_extraction.

    DATA: lv_fileline TYPE string.
    lv_fileline = p_lfile.
  
    CALL FUNCTION 'GUI_UPLOAD'
      EXPORTING
        filename = lv_fileline
        filetype = 'ASC'
      TABLES
        data_tab = gt_line.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form data_preparation
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM data_preparation.
  
    DATA: lr_doc_type TYPE RANGE OF tvarvc-low.
  
    SELECT sign opti low high
    FROM tvarvc
    INTO TABLE lr_doc_type
    WHERE name = 'ZTYPE_DOC_JLMF' AND type = 'S'.
  
    IF lines( gt_line ) > 1.
  
      DELETE gt_line INDEX 1.
  
      LOOP AT gt_line ASSIGNING FIELD-SYMBOL(<fs_line>).
  
        SPLIT <fs_line>-fileline AT ';' INTO TABLE DATA(lt_split_csv).
        SPLIT lt_split_csv[ 1 ] AT 'P' INTO TABLE DATA(lt_split_id).
  
        IF lt_split_csv IS NOT INITIAL AND lines( lt_split_csv ) = 14  AND lt_split_csv[ 2 ] IN lr_doc_type.
  
          APPEND INITIAL LINE TO gt_file ASSIGNING FIELD-SYMBOL(<fs_file>).
  
          IF <fs_file> IS ASSIGNED.
  
            <fs_file>-compteur_commande   = lt_split_csv[ 1 ].
            <fs_file>-doc_type            = lt_split_csv[ 2 ].
            <fs_file>-sales_org           = lt_split_csv[ 3 ].
            <fs_file>-distr_chan          = lt_split_csv[ 4 ].
            <fs_file>-sect_act            = lt_split_csv[ 5 ].
            <fs_file>-partn_role_ag       = lt_split_csv[ 6 ].
            <fs_file>-partn_numb_ag       = lt_split_csv[ 7 ].
            <fs_file>-partn_role_we       = lt_split_csv[ 8 ].
            <fs_file>-partn_num_we        = lt_split_csv[ 9 ].
            <fs_file>-itm_numb            = lt_split_csv[ 10 ].
            <fs_file>-material            = lt_split_csv[ 11 ].
            <fs_file>-plant               = lt_split_csv[ 12 ].
            <fs_file>-quantity            = lt_split_csv[ 13 ].
            <fs_file>-quantity_unit       = lt_split_csv[ 14 ].
            <fs_file>-id_com              = lt_split_id[ 1 ].
            <fs_file>-id_post             = lt_split_id[ 2 ].
  
          ENDIF.
  
        ENDIF.
  
      ENDLOOP.
  
    ENDIF.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form data_verification
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM data_verification.
  
    SELECT vbak~vkorg,
           vbak~vtweg,
           vbak~spart,
           knvp~parvw,
           knvp~kunnr,
           vbap~posnr,
           mara~matnr,
           vbak~bukrs_vf
    FROM vbak
    INNER JOIN vbap ON vbap~vbeln = vbak~vbeln
    INNER JOIN knvp ON knvp~kunnr = vbak~kunnr
    INNER JOIN mara ON mara~matnr = vbap~matnr
    INTO TABLE @DATA(lt_select).
  
    DATA: ls_select LIKE LINE OF lt_select,
          index     TYPE i VALUE '1',
          v         TYPE boolean VALUE 't'.
  
    LOOP AT gt_file ASSIGNING FIELD-SYMBOL(<fs_file>).
      v = 't'.
  
      READ TABLE lt_select TRANSPORTING NO FIELDS
      WITH KEY vkorg = <fs_file>-sales_org.
  
      IF sy-subrc = 0.
        READ TABLE lt_select TRANSPORTING NO FIELDS
        WITH KEY vtweg = <fs_file>-distr_chan.
  
        IF sy-subrc = 0.
          READ TABLE lt_select TRANSPORTING NO FIELDS
          WITH KEY spart = <fs_file>-sect_act.
  
          IF sy-subrc = 0.
            READ TABLE lt_select TRANSPORTING NO FIELDS
            WITH KEY parvw = <fs_file>-partn_role_ag.
  
            IF sy-subrc = 0.
              READ TABLE lt_select TRANSPORTING NO FIELDS
              WITH KEY kunnr = <fs_file>-partn_numb_ag.
  
              IF sy-subrc = 0.
                READ TABLE lt_select TRANSPORTING NO FIELDS
                WITH KEY parvw = <fs_file>-partn_role_we.
  
                IF sy-subrc = 0.
                  READ TABLE lt_select TRANSPORTING NO FIELDS
                  WITH KEY kunnr = <fs_file>-partn_num_we.
  
                  IF sy-subrc = 0.
                    READ TABLE lt_select TRANSPORTING NO FIELDS
                    WITH KEY posnr = <fs_file>-itm_numb.
  
                    IF sy-subrc = 0.
                      READ TABLE lt_select TRANSPORTING NO FIELDS
                      WITH KEY matnr = <fs_file>-material.
  
                      IF sy-subrc = 0.
                        READ TABLE lt_select TRANSPORTING NO FIELDS
                        WITH KEY bukrs_vf = <fs_file>-plant.
  
                        IF sy-subrc = 0.
  
                        ELSE.
                          v = 'f' .
                        ENDIF.
                      ELSE.
                        v = 'f' .
                      ENDIF.
                    ELSE.
                      v = 'f' .
                    ENDIF.
                  ELSE.
                    v = 'f' .
                  ENDIF.
                ELSE.
                  v = 'f' .
                ENDIF.
              ELSE.
                v = 'f' .
              ENDIF.
            ELSE.
              v = 'f' .
            ENDIF.
          ELSE.
            v = 'f' .
          ENDIF.
        ELSE.
          v = 'f' .
        ENDIF.
      ELSE.
        v = 'f' .
      ENDIF.
  
      IF v = 'f' .
        DELETE gt_file INDEX index.
        index = index - 1.
      ENDIF.
      index = index + 1.
    ENDLOOP.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form client_order_creation
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM client_order_creation.
  
    DATA: ls_file  TYPE zsjlmf_file_01.
  
    DATA: lv_salesdocument   TYPE bapivbeln-vbeln.
  
    DATA: lt_return          TYPE TABLE OF bapiret2,
  
          lt_order_items_in  TYPE TABLE OF bapisditm,
          lt_order_items_inx TYPE TABLE OF bapisditmx,
          lt_order_partners  TYPE TABLE OF bapiparnr,
  
          lt_schedules       TYPE TABLE OF bapischdl,
          lt_schedulesx      TYPE TABLE OF bapischdlx,
  
          lt_conditions      TYPE TABLE OF bapicond,
          lt_conditionsx     TYPE TABLE OF bapicondx.
  
    DATA: ls_return           TYPE bapiret2,
          ls_order_header_in  TYPE bapisdhd1,
          ls_order_header_inx TYPE bapisdhd1x,
  
          ls_order_items_in   TYPE bapisditm,
          ls_order_items_inx  TYPE bapisditmx,
          ls_order_partners   LIKE bapiparnr,
          ls_schedules        TYPE bapischdl,
          ls_schedulesx       TYPE bapischdlx,
          ls_conditions       TYPE bapicond,
          ls_conditionsX      TYPE bapicondx.
  
    ls_order_header_inx-ref_1        = 'X'.
    ls_order_header_inx-doc_type     = 'X'.
    ls_order_header_inx-sales_org    = 'X'.
    ls_order_header_inx-distr_chan   = 'X'.
    ls_order_header_inx-division     = 'X'.
    ls_order_header_inx-req_date_h   = 'X'.
    ls_order_header_inx-updateflag   = 'I'.
  
    ls_order_items_inx-itm_number    = 'X'.
    ls_order_items_inx-material      = 'X'.
    ls_order_items_inx-plant         = 'X'.
    ls_order_items_inx-target_qty    = 'X'.
    ls_order_items_inx-po_unit       = 'X'.
  
    ls_schedulesx-itm_number         = 'X'.
    ls_schedulesx-dlv_date           = 'X'.
  
    LOOP AT gt_file INTO ls_file.
  
      SELECT DISTINCT * FROM @gt_file AS lt_file
      WHERE id_com = @ls_file-id_com
      INTO TABLE @DATA(it_grp).
  
      DO 1 TIMES.
  
        CLEAR:
        ls_order_header_in,
        ls_order_items_in,
        ls_schedules,
  
        lt_order_items_in,
        lt_schedules,
        lt_return.
  
        LOOP AT it_grp ASSIGNING FIELD-SYMBOL(<fs_file>).
  
          ls_order_header_in-ref_1       = <fs_file>-compteur_commande.
          ls_order_header_in-doc_type    = <fs_file>-doc_type.
          ls_order_header_in-sales_org   = <fs_file>-sales_org.
          ls_order_header_in-distr_chan  = <fs_file>-distr_chan.
          ls_order_header_in-division    = <fs_file>-sect_act.
          ls_order_header_in-req_date_h  = sy-datum.
  
          ls_order_items_in-itm_number   = <fs_file>-itm_numb.
          ls_order_items_in-material     = <fs_file>-material.
          ls_order_items_in-plant        = <fs_file>-plant.
          ls_order_items_in-target_qty   = <fs_file>-quantity.
  
          APPEND ls_order_items_in TO lt_order_items_in.
          APPEND ls_order_items_inx TO lt_order_items_inx.
  
          ls_order_partners-partn_role   = <fs_file>-partn_role_ag.
          ls_order_partners-partn_numb   = <fs_file>-partn_numb_ag.
  
          APPEND ls_order_partners TO lt_order_partners.
  
          ls_order_partners-partn_role   = <fs_file>-partn_role_we.
          ls_order_partners-partn_numb   = <fs_file>-partn_num_we.
  
          APPEND ls_order_partners TO lt_order_partners.
  
          ls_schedules-itm_number        =  <fs_file>-itm_numb.
          ls_schedules-dlv_date          =  sy-datum + 5.
  
          APPEND ls_schedules TO lt_schedules.
          APPEND ls_schedulesx TO lt_schedulesx.
  
        ENDLOOP.
  
        CALL FUNCTION 'BAPI_SALESORDER_CREATEFROMDAT2'
          EXPORTING
            salesdocumentin     = ''
            order_header_in     = ls_order_header_in
            order_header_inx    = ls_order_header_inx
          IMPORTING
            salesdocument       = lv_salesdocument
          TABLES
            return              = lt_return
            order_items_in      = lt_order_items_in
            order_items_inx     = lt_order_items_inx
            order_partners      = lt_order_partners
            order_schedules_in  = lt_schedules
            order_schedules_inx = lt_schedulesx.
  
        READ TABLE lt_return INTO ls_return WITH KEY type = 'E'.
  
        IF sy-subrc = 0.
          APPEND ls_return TO gt_return.
          CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
        ELSE.
          ls_return-type = 'S'.
          ls_return-message = 'Commande:' && <fs_file>-compteur_commande && ' VBELN:' && lv_salesdocument && ' QUANTITY: ' && ls_order_items_in-target_qty && ' Créé avec succés'.
  
          APPEND ls_return TO gt_return.
          CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
        ENDIF.
  
        DELETE gt_file WHERE id_com = ls_file-id_com.
  
      ENDDO.
  
    ENDLOOP.
  
    TRY.
        DATA : lo_alv           TYPE REF TO cl_salv_table,
               lo_alv_functions TYPE REF TO cl_salv_functions,
               lo_columns       TYPE REF TO cl_salv_columns_table,
               message          TYPE REF TO cx_salv_msg.
  
        cl_salv_table=>factory(
        IMPORTING
          r_salv_table = lo_alv
        CHANGING
          t_table      = gt_return ).
  
        lo_alv_functions = lo_alv->get_functions( ).
        lo_alv_functions->set_all( abap_true ).
  
        lo_columns = lo_alv->get_columns( ).
        lo_columns->set_optimize( abap_true ).
  
        lo_alv->display( ).
  
      CATCH cx_salv_msg INTO message.
    ENDTRY.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form display_client_order
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM display_client_order .
  
    DATA : lv_post TYPE ntgew,
           lv_comm TYPE f.
  
    DATA : lt_display TYPE TABLE OF ty_final,
           ls_display LIKE LINE OF lt_display.
  
    SELECT vbak~vbeln,                                                                " Numéro de la commande de vente
           vbak~auart,                                                                " Type de doc. De vente
           vbak~erdat,                                                                " Date de création de la commande
           vbak~erzet,                                                                " Heure de création
           vbak~vdatu,                                                                " Date de livraison souhaitée
           vbak~vkorg,                                                                " Organisation commerciale
           vbak~vtweg,                                                                " Canal de distribution
           vbak~spart,                                                                " Secteur d’activité
           vbap~kunnr_ana,                                                            " Client donneur d’ordre
           kna1~name1,                                                                " Nom du donneur d’ordre
           vbap~kunwe_ana,                                                            " Client réceptionnaire
           kna1~name2,                                                                " Nom du client réceptionnaire
           kna1~pstlz && @space && kna1~ort01 && @space && kna1~land1 AS address,     " KNA1 - Adresse du client réceptionnaire (Code postal + Ville + Pays)
           vbap~posnr,                                                                " Numéro de poste Com.
           vbap~matnr,                                                                " Article
           makt~maktx,                                                                " Désignation article
           vbap~werks,                                                                " Division
           vbap~zmeng,                                                                " Quantité commandée
           vbap~zieme,                                                                " Unité de quantité
           mara~ntgew,                                                                " Poids net de l’article
           mara~gewei                                                                 " Unité de poids
      FROM vbak
      INNER JOIN vbap ON vbap~vbeln = vbak~vbeln
      INNER JOIN kna1 ON kna1~kunnr = vbap~kunnr_ana
      INNER JOIN makt ON makt~matnr = vbap~matnr
      INNER JOIN mara ON mara~matnr = makt~matnr
      WHERE vbak~auart IN @s_auart
        AND vbak~vbeln IN @s_vbeln
        AND vbak~vkorg IN @s_vkorg
        AND vbak~vtweg IN @s_vtweg
        AND vbak~spart IN @s_spart
        AND vbap~kunnr_ana IN @s_kunnr
        AND vbap~matnr IN @s_matnr
        AND vbap~werks IN @s_werks
        AND vbak~erdat IN @s_erdat
      ORDER BY vbak~erdat DESCENDING, vbak~erzet DESCENDING
      INTO TABLE @t_ty_final.
  
    LOOP AT t_ty_final ASSIGNING FIELD-SYMBOL(<fs_final>).
      AT NEW vbeln.
        CLEAR <fs_final>-pt_comm.
      ENDAT.
  
      LOOP AT t_ty_final ASSIGNING FIELD-SYMBOL(<fs_final2>) WHERE vbeln = <fs_final>-vbeln.
        <fs_final2>-pt_post = <fs_final2>-po_quant * <fs_final2>-ntgew.
        <fs_final>-pt_comm  =  <fs_final>-pt_comm  + <fs_final2>-pt_post.
      ENDLOOP.
    ENDLOOP.
  
  *  TRY.
  *      DATA :lo_alv           TYPE REF TO cl_salv_table,
  *            lo_alv_functions TYPE REF TO cl_salv_functions,
  *            lo_columns       TYPE REF TO cl_salv_columns_table,
  *            message          TYPE REF TO cx_salv_msg.
  *
  *      cl_salv_table=>factory(
  *      IMPORTING
  *        r_salv_table = lo_alv
  *      CHANGING
  *        t_table      = t_ty_final ).
  *
  *      lo_alv_functions = lo_alv->get_functions( ).
  *      lo_alv_functions->set_all( abap_true ).
  *
  *      lo_columns = lo_alv->get_columns( ).
  *      lo_columns->set_optimize( abap_true ).
  *
  *      lo_alv->display( ).
  *
  *    CATCH cx_salv_msg INTO message.
  *  ENDTRY.
  
    CALL SCREEN 0001.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Module STATUS_0001 OUTPUT
  *&---------------------------------------------------------------------*
  *&
  *&---------------------------------------------------------------------*
  
  MODULE status_0001 OUTPUT.
    SET PF-STATUS 'STATUT_GUI_0001'.
  * SET TITLEBAR 'xxx'.
  
  *  DATA: BEGIN OF i_alv OCCURS 0,
  *    matnr TYPE mara-matnr,
  *    maktx TYPE makt-maktx,
  *  END OF i_alv.
  
    DATA: alv_container TYPE REF TO cl_gui_custom_container,
          alv_grid      TYPE REF TO cl_gui_alv_grid,
          layout        TYPE lvc_s_layo,
          fieldcat      TYPE lvc_t_fcat,
          variant       TYPE disvariant.
  
    variant-report = sy-repid.
    variant-username = sy-uname.
  
  *  SELECT * INTO CORRESPONDING FIELDS OF TABLE i_alv
  *  FROM mara
  *  INNER JOIN makt
  *  ON mara~matnr = makt~matnr
  *  AND makt~spras = sy-langu.
  *
  *  SORT i_alv ASCENDING BY matnr.
  
    CREATE OBJECT alv_container
      EXPORTING
        container_name = 'ALV_CONTAINER'.
  
    CREATE OBJECT alv_grid
      EXPORTING
        i_parent = alv_container.
  
    PERFORM get_fieldcatalog.
  
    CALL METHOD alv_grid->set_table_for_first_display
    EXPORTING
      is_layout        = layout
      is_variant       = variant
      i_save           = 'U'
      i_structure_name = 'SELLER'
    CHANGING
      it_outtab        = t_ty_final[]
      it_fieldcatalog  = fieldcat[].
  
  ENDMODULE.
  
  *&---------------------------------------------------------------------*
  *&      Module  USER_COMMAND_0001  INPUT
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  
  MODULE user_command_0001 INPUT.
  
    CASE sy-ucomm.
      WHEN 'EXIT' OR 'BACK' OR 'CANCEL'.
        LEAVE PROGRAM.
      WHEN OTHERS.
    ENDCASE.
  
  ENDMODULE.
  
  *&---------------------------------------------------------------------*
  *& Form get_fieldcatalog
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM get_fieldcatalog.
  
    DATA: ls_fcat TYPE lvc_s_fcat.
    REFRESH: fieldcat.
  
    CLEAR: ls_fcat.
    ls_fcat-reptext    = 'N° ARTICLE'.
    ls_fcat-coltext    = 'N° ARTICLE'.
    ls_fcat-fieldname  = 'VBELN'.
    ls_fcat-ref_table  = 't_ty_final'.
    ls_fcat-outputlen  = '15'.
    ls_fcat-col_pos    = 1.
    APPEND ls_fcat TO fieldcat.
  
    CLEAR: ls_fcat.
    ls_fcat-reptext    = 'TYPE DOC'.
    ls_fcat-coltext    = 'TYPE DOC'.
    ls_fcat-fieldname  = 'AUART'.
    ls_fcat-ref_table  = 't_ty_final'.
    ls_fcat-outputlen  = '15'.
    ls_fcat-col_pos    = 2.
    APPEND ls_fcat TO fieldcat.
  
  ENDFORM.