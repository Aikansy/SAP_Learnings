# **DATA ALV_DISPLAY**

`PROGRAM`

```abap
REPORT zfgi_prog NO STANDARD PAGE HEADING.

INCLUDE zfgi_prog_top.
INCLUDE zfgi_prog_scr.
INCLUDE zfgi_prog_f01.

INITIALIZATION.

START-OF-SELECTION.

    PERFORM DATA_DISPLAY.

END-OF-SELECTION.
```

`INCLUDE F01`

```
FORM data_alv_display.

    DATA:   lo_alv           TYPE REF TO cl_salv_table,
            lo_alv_functions TYPE REF TO cl_salv_functions,
            lo_columns       TYPE REF TO cl_salv_columns_table,
            lo_message       TYPE REF TO cx_salv_msg.

    TRY.
        CALL METHOD cl_salv_table=>factory(
            IMPORTING
                r_salv_table = lo_alv
            CHANGING
                t_table      = gt_cv ).
        
        lo_alv_functions = lo_alv->get_functions( ).
        lo_alv_functions->set_all( abap_true ).
        lo_columns = lo_alv->get_columns( ).
        lo_columns->set_optimize( abap_true ).
        lo_alv->display( ).

        CATCH cx_salv_msg INTO lo_message.
    ENDTRY.
ENDFORM.
```