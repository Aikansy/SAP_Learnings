# **FEATURE DATA INITIALIZATION**

`PROGRAM`

```abap
REPORT zfgi_prog NO STANDARD PAGE HEADING.

INCLUDE zfgi_prog_top.
INCLUDE zfgi_prog_scr.
INCLUDE zfgi_prog_f01.

INITIALIZATION.

  PERFORM DATA_INITIALIZATION.

START-OF-SELECTION.

END-OF-SELECTION.
```

`INCLUDE TOP`

```abap
TYPES:  BEGIN OF ts_line,
                line          TYPE string,
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

TYPES:  BEGIN OF ty_so,
                vbeln         TYPE vbak-vbeln,
                auart         TYPE vbak-auart,
                erdat         TYPE vbak-erdat,
                erzet         TYPE vbak-erzet,
                vdatu         TYPE vbak-vdatu,
                vkorg         TYPE vbak-vkorg,
                vtweg         TYPE vbak-vtweg,
                spart         TYPE vbak-spart,
                kunnr_ana     TYPE vbap-kunnr_ana,
                name1         TYPE kna1-name1,
                kunwe_ana     TYPE vbap-kunwe_ana,
                name2         TYPE kna1-name1,
                adress        TYPE string,
                posnr         TYPE vbap-posnr,
                matnr         TYPE vbap-matnr,
                maktx         TYPE makt-maktx,
                werks         TYPE vbap-werks,
                zmeng         TYPE vbap-zmeng,
                zieme         TYPE vbap-zieme,
                ntgew         TYPE mara-ntgew,
                gewei         TYPE mara-gewei,
                pds_post      TYPE mara-ntgew,
                pds_tot       TYPE mara-ntgew,
        END OF ty_so.

DATA: gt_file             TYPE tt_line,
      gt_data             TYPE STANDARD TABLE OF ty_data,
      gt_data_error       TYPE STANDARD TABLE OF ty_data,
      gt_cv               TYPE STANDARD TABLE OF ty_cv.
```

`INCLUDE F01`

```abap
FORM data_initialization.

  CLEAR : gt_file,
          gt_cv,
          gt_data,
          gt_data_error.

ENDFORM.
```
