# **DATA FILE EXPORTING**

`PROGRAM`

```abap
REPORT zfgi_prog NO STANDARD PAGE HEADING.

INCLUDE zfgi_prog_top.
INCLUDE zfgi_prog_scr.
INCLUDE zfgi_prog_f01.

INITIALIZATION.

START-OF-SELECTION.

    PERFORM DATA_FILE_EXPORTING.

END-OF-SELECTION.
```

`INCLUDE TOP`

```abap
TYPES:  BEGIN OF ty_data,
    id_com        TYPE zid_com_po,
    doc_type      TYPE vbak-auart,
    sales_org     TYPE vbak-vkorg,
    distr_chan    TYPE vbak-vtweg,
    sect_act      TYPE vbak-spart,
    partn_role_ag TYPE parvw,
    partn_numb_ag TYPE vbak-kunnr,
    partn_role_we TYPE parvw,
    partn_numb_we TYPE vbak-kunnr,
    itm_numb      TYPE vbap-posnr,
    material      TYPE vbap-matnr,
    plant         TYPE vbap-werks,
    quantity      TYPE vbap-zmeng,
    quantity_unit TYPE vbap-zieme,
END OF ty_data.

DATA: ls_data_error       TYPE ty_data,
      gt_data             TYPE STANDARD TABLE OF ty_data,
      gt_data_error       TYPE STANDARD TABLE OF ty_data.
```

`INCLUDE F01`

```abap
FORM data_file_exporting.

    DATA: lv_csv TYPE string.

    CALL FUNCTION 'SAP_CONVERT_TO_CSV_FORMAT'
        EXPORTING
            I_FIELD_SEPERATOR          = ';'
            I_LINE_HEADER              = 'NOM,PRENOM,AGE'
            I_FILENAME                 = "exclusion_data_file.csv"
*           I_APPL_KEEP                = ' '
        TABLES
            i_tab_sap_data             = gt_data_error
        CHANGING
            I_TAB_CONVERTED_DATA       = lv_csv
        EXCEPTIONS
            CONVERSION_FAILED          = 1
            OTHERS                     = 2.
    IF sy-subrc <> 0.
        EXIT.
    ENDIF.


ENDFORM.
```

```` abap
CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
        filename                        = 'tableau_de_donnees_exclues'
        FILETYPE                        = 'CSV'
    TABLES
        data_tab                        = gt_data_error.
IF sy-subrc <> 0.
    EXIT.
ENDIF.
```