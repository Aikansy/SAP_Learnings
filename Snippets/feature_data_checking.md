# **FEATURE DATA_CHECKING**


`PROGRAM`

```abap
REPORT zfgi_prog NO STANDARD PAGE HEADING.

INCLUDE zfgi_prog_top.
INCLUDE zfgi_prog_scr.
INCLUDE zfgi_prog_f01.

INITIALIZATION.

START-OF-SELECTION.

    PERFORM DATA_CHECKING.

END-OF-SELECTION.
```

`INCLUDE TOP`

```abap
TYPES:  BEGIN OF ts_line,
            line TYPE string,
        END OF ts_line,
        tt_line TYPE STANDARD TABLE OF ts_line.

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

DATA:   gt_file TYPE tt_line,
        gt_data TYPE STANDARD TABLE OF ty_data.
```

`INCLUDE F01`

```abap
FORM data_checking.
    SELECT matnr
        FROM mara
        INTO TABLE @DATA(lt_mara).

    LOOP AT gt_data ASSIGNING FIELD-SYMBOL(<fs_data>).
        READ TABLE lt_mara ASSIGNING FIELD-SYMBOL(<fs_mara>) WITH KEY matnr = <fs_data>-material.
        IF sy-subrc <> 0.
            CLEAR <fs_data>-material.
        ENDIF.
    ENDLOOP.

    DELETE gt_data WHERE material IS INITIAL.
ENDFORM.
```