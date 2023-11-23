# **FEATURE DATA_ASSIGNMENT**

> Need One of the following features (to retrieve data file): 
> - [feature_data_file_importing_local](./feature_retrieve_local_file.md)
> - [feature_data_file_importing_server](./feature_retrieve_server_file.md)

`PROGRAM`

```abap
REPORT zfgi_prog NO STANDARD PAGE HEADING.

INCLUDE zfgi_prog_top.
INCLUDE zfgi_prog_scr.
INCLUDE zfgi_prog_f01.

INITIALIZATION.

START-OF-SELECTION.

    PERFORM DATA_ASSIGNMENT.

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

DATA: gt_file TYPE tt_line,
      gt_data             TYPE STANDARD TABLE OF ty_data.
```

`INCLUDE F01`

```abap
FORM data_assignment.

    DELETE gt_file INDEX 1.

    LOOP AT gt_file ASSIGNING FIELD-SYMBOL(<fs_file>).
        IF lines( lt_split_data ) <> 14.
            CONTINUE.
        ENDIF.

        SPLIT <fs_line>-fileline AT ';' INTO TABLE DATA(lt_split_data).
        SPLIT lt_split_data[ 1 ] AT 'P' INTO TABLE DATA(lt_split_id).

        IF lt_split_data IS NOT INITIAL.
            APPEND INITIAL LINE TO gt_data ASSIGNING FIELD-SYMBOL(<fs_data>).

            IF <fs_data> IS ASSIGNED.
                <fs_file>-id_com              = lt_split_id[ 1 ].
                <fs_file>-id_post             = lt_split_id[ 2 ].
                <fs_file>-compteur_commande   = lt_split_data[ 1 ].
                <fs_file>-doc_type            = lt_split_data[ 2 ].
                <fs_file>-sales_org           = lt_split_data[ 3 ].
                <fs_file>-distr_chan          = lt_split_data[ 4 ].
                <fs_file>-sect_act            = lt_split_data[ 5 ].
                <fs_file>-partn_role_ag       = lt_split_data[ 6 ].
                <fs_file>-partn_numb_ag       = lt_split_data[ 7 ].
                <fs_file>-partn_role_we       = lt_split_data[ 8 ].
                <fs_file>-partn_num_we        = lt_split_data[ 9 ].
                <fs_file>-itm_numb            = lt_split_data[ 10 ].
                <fs_file>-material            = lt_split_data[ 11 ].
                <fs_file>-plant               = lt_split_data[ 12 ].
                <fs_file>-quantity            = lt_split_data[ 13 ].
                <fs_file>-quantity_unit       = lt_split_data[ 14 ].
            ENDIF.
        ENDIF.
    ENDLOOP.
ENDFORM.
```