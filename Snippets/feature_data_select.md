# **DATA SELECT**

`PROGRAM`

```abap
REPORT zfgi_prog NO STANDARD PAGE HEADING.

INCLUDE zfgi_prog_top.
INCLUDE zfgi_prog_scr.
INCLUDE zfgi_prog_f01.

INITIALIZATION.

START-OF-SELECTION.

    PERFORM DATA_SELECT.

END-OF-SELECTION.
```

`INCLUDE TOP`

```abap
TABLES: vbak, vbap.

TYPES:  BEGIN OF ty_so,
    vbeln         TYPE vbak-vbeln,
    auart         TYPE vbak-auart,
    erdat         TYPE vbak-erdat,
    erzet         TYPE vbak-erzet,
    vdatu         TYPE vbak-vdatu, "Formulaire structure EDATU_VBAK
    vkorg         TYPE vbak-vkorg,
    vtweg         TYPE vbak-vtweg,
    spart         TYPE vbak-spart,
    kunnr_ana     TYPE vbap-kunnr_ana,
    name1         TYPE kna1-name1,
    kunwe_ana     TYPE vbap-kunwe_ana,
    name2         TYPE kna1-name1,
    adress        TYPE string,     " Formulaire structure /PM0/ABD_ADRESSE
    posnr         TYPE vbap-posnr,
    matnr         TYPE vbap-matnr,
    maktx         TYPE makt-maktx,
    werks         TYPE vbap-werks, "Formulaire structure werks_D
    zmeng         TYPE vbap-zmeng,
    zieme         TYPE vbap-zieme,
    ntgew         TYPE mara-ntgew,
    gewei         TYPE mara-gewei,
    pds_post      TYPE mara-ntgew,
    pds_tot       TYPE mara-ntgew,
END OF ty_so.

DATA:   gt_cv   TYPE STANDARD TABLE OF ty_so.
```

`INCLUDE SCR`

```abap
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE TEXT-001.

    PARAMETERS : p_crea TYPE xfeld RADIOBUTTON GROUP rb1 USER-COMMAND trait DEFAULT 'X'.

    SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-002.
        PARAMETERS: p_rad1  RADIOBUTTON GROUP rb2 USER-COMMAND fcode MODIF ID g1 DEFAULT 'X',
                    p_fname TYPE localfile MODIF ID g1.
        SELECTION-SCREEN SKIP 1.
        PARAMETERS: p_rad2       RADIOBUTTON GROUP rb2 MODIF ID g1,
                    p_lpath(500) TYPE c MODIF ID g1,
                    p_lname(100) TYPE c MODIF ID g1,
                    p_arch(500)  TYPE c MODIF ID g1.
    SELECTION-SCREEN END OF BLOCK b1.

    PARAMETERS : p_alv TYPE xfeld RADIOBUTTON GROUP rb1.

    SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-003.
        PARAMETERS : p_ernam TYPE vbak-ernam MODIF ID g2 DEFAULT sy-uname.
        SELECT-OPTIONS : s_vbeln FOR vbak-vbeln MODIF ID g2,
                         s_auart FOR vbak-auart MODIF ID g2,
                         s_vkorg FOR vbak-vkorg MODIF ID g2 MATCHCODE OBJECT zkdev_matnr, " SE11
                         s_vtweg FOR vbak-vtweg MODIF ID g2,
                         s_spart FOR vbak-spart MODIF ID g2,
                         s_matnr FOR vbap-matNr MODIF ID g2,
                         s_plant FOR vbap-werks MODIF ID g2,
                         s_kunnr FOR vbap-kunnr_ana MODIF ID g2,
                         s_erdat FOR vbak-erdat MODIF ID g2.
    SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN END OF BLOCK b0.
```

```abap
AT SELECTION-SCREEN OUTPUT.

    FREE MEMORY ID sy-cprog. "  la mémoire allouée par le programme en cours d'exécution sera libérée

    LOOP AT SCREEN.

        IF p_crea IS NOT INITIAL.

            IF screen-group1 = 'G1'.
                screen-active = 1.
            ELSEIF screen-group1 = 'G2'.
                screen-active = 0.
            ENDIF.
            MODIFY SCREEN.

        ELSEIF p_alv IS NOT INITIAL.

            IF screen-group1 = 'G1'.
                screen-active = 0.
            ELSE.
                screen-active = 1.
            ENDIF.
            MODIFY SCREEN.
        ENDIF.
    ENDLOOP.

    LOOP AT SCREEN.

        IF screen-name = 'P_FNAME'.
            IF p_rad1 IS NOT INITIAL.
                screen-input  = 1.
            ELSE.
                screen-input  = 0.
            ENDIF.
            MODIFY SCREEN.

        ELSEIF screen-name = 'P_LPATH' OR screen-name  = 'P_LNAME' OR screen-name  = 'P_ARCH'.
      
            IF p_rad2 IS NOT INITIAL.
                screen-input = 1.
            ELSE.
                screen-input  = 0.
            ENDIF.
            MODIFY SCREEN.
        ENDIF.

    ENDLOOP.
```

`INCLUDE F01`

```
FORM data_select.

    DATA :  lv_post TYPE ntgew,
            lv_comm TYPE f.

    SELECT  vbak~vbeln,
            vbak~auart,
            vbak~erdat,
            vbak~erzet,
            vbak~vdatu,
            vbak~vkorg,
            vbak~vtweg,
            vbak~spart,
            vbap~kunnr_ana,
            kna1~name1,
            vbap~kunwe_ana,
            kna1~name2,
            kna1~pstlz && @space && kna1~ort01 && @space && kna1~land1 AS address,
            vbap~posnr,
            vbap~matnr,
            makt~maktx,
            vbap~werks,
            vbap~zmeng,
            vbap~zieme,
            mara~ntgew,
            mara~gewei
        FROM vbak
        INNER JOIN vbap ON vbap~vbeln = vbak~vbeln
        LEFT OUTER JOIN kna1 ON kna1~kunnr = vbap~kunnr_ana
        LEFT OUTER JOIN makt ON makt~matnr = vbap~matnr AND makt~spras = @sy-langu
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
        MESSAGE e404(ZFGI_MESSAGES).
    ENDIF.

    LOOP AT gt_cv ASSIGNING FIELD-SYMBOL(<fs_cv>).
        AT NEW vbeln.
            CLEAR <fs_cv>-pds_tot.
        ENDAT.

        LOOP AT gt_cv ASSIGNING FIELD-SYMBOL(<fs_cv2>) WHERE vbeln = <fs_cv>-vbeln.
            <fs_cv2>-pds_post = <fs_cv2>-zmeng * <fs_cv2>-ntgew.
            <fs_cv>-pds_tot   = <fs_cv>-pds_tot + <fs_cv2>-pds_post.
        ENDLOOP.
    ENDLOOP.
ENDFORM.
```