# **FEATURE DATA FILE IMPORTING FROM SERVER**

`PROGRAM`

```abap
REPORT zfgi_prog NO STANDARD PAGE HEADING.

INCLUDE zfgi_prog_top.
INCLUDE zfgi_prog_scr.
INCLUDE zfgi_prog_f01.

INITIALIZATION.

START-OF-SELECTION.

    PERFORM DATA_FILE_IMPORTING_FROM_SERVER.

END-OF-SELECTION.
```

`INCLUDE TOP`

```abap
TYPES:  BEGIN OF ts_line,
            line TYPE string,
        END OF ts_line,
        tt_line TYPE STANDARD TABLE OF ts_line.

DATA:   gt_file TYPE tt_line.
```

`INCLUDE SCR`

```abap
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE TEXT-001.

    PARAMETERS: p_rad2       RADIOBUTTON GROUP rb2 MODIF ID g1,
                p_lpath(500) TYPE c MODIF ID g1 OBLIGATORY, "Chemin du fichier
                p_lname(100) TYPE c MODIF ID g1 OBLIGATORY, "Nom du fichier
                p_arch(500)  TYPE c MODIF ID g1. "Répertoire archivage

SELECTION-SCREEN END OF BLOCK b0.
```

```abap
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_fname.

    IF p_rad1 IS NOT INITIAL.
        CALL FUNCTION 'F4_FILENAME'
            EXPORTING
                program_name  = syst-cprog
                dynpro_number = syst-dynnr
                field_name    = 'P_FNAME'
            IMPORTING
                file_name     = p_fname.
    ENDIF.
```

`INCLUDE F01`

```abap
FORM data_file_importing_from_server.

    DATA: lv_filename TYPE rlgrap-filename,
          lv_string   TYPE string,
          ls_file     LIKE LINE OF gt_file.

    IF p_rad2 = 'X'.

        CONCATENATE p_lpath p_lname INTO lv_filename SEPARATED BY '/'.
        TRANSLATE lv_filename TO LOWER CASE.
        OPEN DATASET lv_filename FOR INPUT IN TEXT MODE ENCODING DEFAULT.
    
        IF sy-subrc IS INITIAL.
            DO.
                CLEAR ls_file.
                READ DATASET lv_filename INTO ls_file-line.
                IF sy-subrc = 0.
                    APPEND ls_file TO gt_file.
                ELSE.
                    EXIT.
                ENDIF.
            ENDDO.
        ENDIF.
    ENDIF.
ENDFORM.
```