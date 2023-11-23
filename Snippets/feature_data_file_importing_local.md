# **FEATURE DATA FILE IMPORTING FROM LOCAL**

`PROGRAM`

```abap
REPORT zfgi_prog NO STANDARD PAGE HEADING.

INCLUDE zfgi_prog_top.
INCLUDE zfgi_prog_scr.
INCLUDE zfgi_prog_f01.

INITIALIZATION.

START-OF-SELECTION.

    PERFORM DATA_FILE_IMPORTING_FROM_LOCAL.

END-OF-SELECTION.
```

`INCLUDE TOP`

```abap
TYPES:  BEGIN OF ts_line,
            line          TYPE string,
        END OF ts_line,
        tt_line TYPE STANDARD TABLE OF ts_line.

DATA: gt_file             TYPE tt_line.
```

`INCLUDE SCR`

```abap
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE TEXT-001.

    PARAMETERS: p_rad1  RADIOBUTTON GROUP rb2 USER-COMMAND fcode MODIF ID g1 DEFAULT 'X',
                p_fname TYPE localfile MODIF ID g1 OBLIGATORY.

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
FORM data_file_importing_from_local.

    DATA: lv_filename TYPE rlgrap-filename,
          lv_string   TYPE string,
          ls_file     LIKE LINE OF gt_file.

    IF p_rad1 = 'X'.
        lv_string = p_fname.

        CALL FUNCTION 'GUI_UPLOAD'
            EXPORTING
                filename                = lv_string
                filetype                = 'ASC'
            TABLES
                data_tab                = gt_file
            EXCEPTIONS
                file_open_error         = 1
                file_read_error         = 2
                no_batch                = 3
                gui_refuse_filetransfer = 4
                invalid_type            = 5
                no_authority            = 6
                unknown_error           = 7
                bad_data_format         = 8
                header_not_allowed      = 9
                separator_not_allowed   = 10
                header_too_long         = 11
                unknown_dp_error        = 12
                access_denied           = 13
                dp_out_of_memory        = 14
                disk_full               = 15
                dp_timeout              = 16
                OTHERS                  = 17.
    
        IF sy-subrc <> 0.
            CLEAR gt_file.
            MESSAGE e404(zfgi_messages).
        ENDIF.
    ENDIF.
    
ENDFORM.
```