# **DATA SPACE FILTERING**

`PROGRAM`

```abap
REPORT zfgi_prog NO STANDARD PAGE HEADING.

INCLUDE zfgi_prog_top.
INCLUDE zfgi_prog_scr.
INCLUDE zfgi_prog_f01.

INITIALIZATION.

START-OF-SELECTION.

    PERFORM DATA_EMPTY_FILTERING.

END-OF-SELECTION.
```

`INCLUDE TOP`

```abap
TYPES:  BEGIN OF ty_table,
            field1 TYPE char10,
            field2 TYPE char10,
            field3 TYPE char10,
        END OF ty_table.

DATA:   gt_table TYPE STANDARD TABLE OF ty_table,
        gt_valid TYPE STANDARD TABLE OF ty_table,
        gt_invalid TYPE STANDARD TABLE OF ty_table.
```

`INCLUDE F01`

```abap
FORM data_empty_filtering.
    LOOP AT it_table INTO DATA(ls_line).
        IF ls_line-field1 CS ' ' 
        OR ls_line-field2 CS ' ' 
        OR ls_line-field3 CS ' '.
            APPEND ls_line TO gt_invalid.
        ELSE.
            APPEND ls_line TO gt_valid.
        ENDIF.
    ENDLOOP.
ENDFORM.
```