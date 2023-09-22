*&---------------------------------------------------------------------*
*&  Include           Y_004_ROK_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  DATA_INITIALIZATION
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM data_initialization .

    lb1 = ' ٩(◕‿◕)۶   DISPLAY   ٩(◕‿◕)۶'.
    lb2 = 'Upload'.
    lb3 = 'Download'.
    lb4 = 'ヽ(ヅ)ノ'.
    lb5 = '(●´⌓`●)'.
  
    CLEAR: gt_sood,
           gt_receivers,
           gt_bapirettab,
           gs_sood,
           gs_lporb.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  ATTACHMENTS_DISPLAYING
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM attachments_displaying .
  
    gs_lporb-typeid = p_type.
    gs_lporb-instid = p_key.
    gs_lporb-catid  = p_catid.
  
    IF sy-subrc = 0.
  
      CALL METHOD zcl_oh_my_gos_new=>get_bitem
        EXPORTING
          is_lporb = gs_lporb
        RECEIVING
          ro_bitem = go_bitem.
  
      CALL METHOD zcl_oh_my_gos_new=>set_object
        EXPORTING
          is_lporb = gs_lporb.
  
      CALL METHOD zcl_oh_my_gos_new=>display_attachments
        EXPORTING
          io_container = go_container.
  
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  ATTACHMENTS_UPLOADING
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM attachments_uploading .
  
    DATA: lv_filename   TYPE string,
          lv_filelength TYPE wsrm_error-wsrm_direction,
          lt_content    LIKE STANDARD TABLE OF soli,
          lv_objtyp     TYPE so_obj_tp.
  
    lv_objtyp = 'EXT'.
    gs_lporb-typeid = p_type.
    gs_lporb-instid = p_key.
    gs_lporb-catid  = p_catid.
  
    MOVE p_upl TO lv_filename.
  
    CALL FUNCTION 'GUI_UPLOAD'
      EXPORTING
        filename   = lv_filename
        filetype   = 'BIN'
      IMPORTING
        filelength = lv_filelength
      TABLES
        data_tab   = lt_content.
  
    IF sy-subrc EQ 0.
      CALL METHOD zcl_oh_my_gos_new=>gos_attach_file_solitab
        EXPORTING
          iv_name            = lv_filename
          iv_content_solitab = lt_content
          is_lporb           = gs_lporb
          iv_objtp           = lv_objtyp
          iv_filelength      = lv_filelength
          iv_objname         = p_nam
          iv_ext             = p_ext
        RECEIVING
          rt_messages        = gt_bapirettab.
    ENDIF.
  
    CALL METHOD zcl_oh_my_gos_new=>gos_get_file_list
      EXPORTING
        is_lporb      = gs_lporb
      IMPORTING
        t_attachments = gt_sood
        rt_messages   = gt_bapirettab.
  
    IF gt_bapirettab[] IS INITIAL.
      WRITE: /.
      LOOP AT gt_sood INTO gs_sood.
        dec_kb = gs_sood-objlen / 1024.
        IF dec_kb < 1.
          dec_kb = 1.
        ENDIF.
  
        MESSAGE gs_sood-objdes && ' ' && dec_kb && ',' && 'kb' && ', ' && gs_sood-acnam TYPE 'I'.
      ENDLOOP.
    ELSE.
      MESSAGE 'Upload fail' TYPE 'E'.
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  ATTACHMENTS_DOWNLOADING
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM attachments_downloading .
  
    gs_lporb-typeid = p_type.
    gs_lporb-instid = p_key.
    gs_lporb-catid  = p_catid.
  
    CALL METHOD zcl_oh_my_gos_new=>gos_get_file_list
      EXPORTING
        is_lporb      = gs_lporb
      IMPORTING
        t_attachments = gt_sood
        rt_messages   = gt_bapirettab.
  
    IF gt_bapirettab[] IS INITIAL.
      LOOP AT gt_sood INTO gs_sood.
        CALL METHOD zcl_oh_my_gos_new=>gos_download_file_to_gui
          EXPORTING
            file_path   = p_dll
            attachment  = gs_sood
          IMPORTING
            rt_messages = gt_bapirettab.
        IF gt_bapirettab[] IS INITIAL.
          dec_kb = gs_sood-objlen / 1024.
          IF dec_kb < 1.
            dec_kb = 1.
          ENDIF.
          MESSAGE gs_sood-objdes && ' ' && dec_kb && ',' && 'kb' && ', ' && gs_sood-acnam TYPE 'I'.
  *        WRITE: / gs_sood-objdes, dec_kb, 'kb', ' ', gs_sood-acnam.
        ENDIF.
      ENDLOOP.
    ELSE.
      MESSAGE 'Download successful' TYPE 'S'.
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  ATTACHMENTS_EMAILING
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM attachments_emailing .
  
    gs_lporb-typeid = p_type.
    gs_lporb-instid = p_key.
    gs_lporb-catid  = p_catid.
  
    CALL METHOD zcl_oh_my_gos_new=>gos_get_file_list
      EXPORTING
        is_lporb      = gs_lporb
      IMPORTING
        t_attachments = gt_sood
        rt_messages   = gt_bapirettab.
  
    IF gt_bapirettab[] IS INITIAL.
      DATA dec_kb TYPE p.
  
      LOOP AT gt_sood INTO gs_sood.
        dec_kb = gs_sood-objlen / 1024.
        IF dec_kb < 1.
          dec_kb = 1.
        ENDIF.
        WRITE: / gs_sood-objdes, dec_kb, 'KB', ' ', gs_sood-acnam.
  
        CLEAR gt_receivers.
        gt_receivers-receiver = p_recevr.
        gt_receivers-rec_type = 'U'.
        APPEND gt_receivers.
  
        CALL METHOD zcl_oh_my_gos_new=>gos_email_attached_file
          EXPORTING
            folder_region = 'B'
            doctp         = gs_sood-objtp
            docyr         = gs_sood-objyr
            docno         = gs_sood-objno
            t_receivers   = gt_receivers[]
          IMPORTING
            rt_messages   = gt_bapirettab.
        IF gt_bapirettab[] IS INITIAL.
          WRITE: '(ATTACHMENT HAS BEEN SENT)'.
        ENDIF.
      ENDLOOP.
    ELSE.
      MESSAGE 'Emailing successful' TYPE 'S'.
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  ATTACHMENTS_DELETING
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM attachments_deleting .
  
    MESSAGE 'NOPE ! You will not delete attachments !!!               (◕ ᥥ ◕✿)' TYPE 'I'.
  
  ENDFORM.