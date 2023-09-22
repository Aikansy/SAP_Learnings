*----------------------------------------------------------------------*
***INCLUDE Y_002_ROK_LCL.
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&       Class lcl_alv_handler
*&---------------------------------------------------------------------*
*        Text
*----------------------------------------------------------------------*

CLASS lcl_alv_handler DEFINITION.

    PUBLIC SECTION.
  
      CLASS-METHODS: double_click FOR EVENT double_click OF cl_salv_events_table
        IMPORTING row column.
  
      METHODS:
        on_user_command FOR EVENT added_function OF cl_salv_events
          IMPORTING e_salv_function.
  
  ENDCLASS.
  
  *&---------------------------------------------------------------------*
  *&       Class (Implementation)  lcl_alv_handler
  *&---------------------------------------------------------------------*
  *        Text
  *----------------------------------------------------------------------*
  
  CLASS lcl_alv_handler IMPLEMENTATION.
  
    METHOD double_click.
      PERFORM double_click_event IN PROGRAM (sy-repid) IF FOUND USING row column.
    ENDMETHOD.
  
    METHOD on_user_command.
      PERFORM DATA_EXPORT_HANDLER USING e_salv_function TEXT-i08.
    ENDMETHOD.
  
  ENDCLASS.               "lcl_alv_handler