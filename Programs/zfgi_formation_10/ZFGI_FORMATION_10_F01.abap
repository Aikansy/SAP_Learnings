*&---------------------------------------------------------------------*
*& Include          ZFGI_FORMATION_10_F01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form create_person
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM create_person_v1.

    "Variable declaration(s)
    DATA: lo_person   TYPE REF TO zcl_person_fgi,
          lv_identity TYPE string.
  
    "Object creation (SE24 Class Creation needed before w/ 2 attributes : mv_firstname, mv_lastname)
    CREATE OBJECT lo_person.
  *    lo_person->mv_firstname = 'BARRACK'.
  *    lo_person->mv_lastname = 'AFRITTE'.
  *    lo_person->mv_id = '59-DK'.
  
    "Value attribution (with concatenate)
    lv_identity = lo_person->mv_firstname && | | && lo_person->mv_lastname.
  
    ULINE.
    WRITE: / '([ IDENTITY ]) '.
    WRITE: / 'Firstname & Lastname : ', lv_identity.
    ULINE.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form create_person2
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM create_person_v2 .
  
    "Variable declaration(s)
    DATA: lo_person   TYPE REF TO zcl_person_fgi,
          lv_identity TYPE string.
  
    "Object creation (SE24 Class Creation needed before w/ GETTER method and 2 attributes : mv_firstname, mv_lastname)
    CREATE OBJECT lo_person.
  *  lo_person->mv_firstname = 'BARRACK'.
  *  lo_person->mv_lastname = 'AFRITTE'.
  *  lo_person->mv_id = '59-DK'.
  
    "Value attribution with getter method (with concatenate)
    lv_identity = lo_person->get_identity( ).
  
    ULINE.
    WRITE: / '([ IDENTITY ]) '.
    WRITE: / 'Firstname & Lastname : ', lv_identity.
    ULINE.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form create_person_v3
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM create_person_v3 .
  
    "Variable declaration(s)
    DATA: lo_person    TYPE REF TO zcl_person_fgi,
          lo_employee  TYPE REF TO zcl_person_fgi,
          lv_identity1 TYPE string,
          lv_identity2 TYPE string.
  
    "Object creation (SE24 Parent class)
    CREATE OBJECT lo_person.
    lo_person->mv_firstname = 'BARRACK'.
    lo_person->mv_lastname = 'AFRITTE'.
  
    lv_identity1 = lo_person->get_identity( ).
  
    "Object creation (SE24 Child class)
    CREATE OBJECT lo_employee.
    lo_employee->mv_firstname = 'DAISY'.
    lo_employee->mv_lastname = 'DRATE'.
  
    lv_identity2 = lo_employee->get_identity( ).
  
    ULINE.
    WRITE: / '([ PERSON ID ]) '.
    WRITE: / 'Firstname & Lastname : ', lv_identity1.
    ULINE.
    WRITE: / '([ EMPLOYEE ID ]) '.
    WRITE: / 'Firstname & Lastname : ', lv_identity2.
    ULINE.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form create_job
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  
  FORM create_job .
  
  *  DATA: lo_consulting TYPE REF TO zcl_employee_consulting_fgi,
  *        lo_manager    TYPE REF TO zcl_employee_manager_fgi,
  *        lv_intitule   TYPE string.
  *
  *  CREATE OBJECT lo_consulting.
  *  lo_consulting->mv_firstname = 'ARNAUD'.
  *  lo_consulting->mv_lastname = 'PARIS'.
  *
  **  lv_intitule = lo_consulting->get_identity( ) && ':' && lo_consulting->get_job_name( ).
  *  lv_intitule = lo_consulting->get_intitule( ).
  *
  *  WRITE: / lv_intitule.
  *
  *  CREATE OBJECT lo_manager.
  *  lo_manager->mv_firstname = 'PIERRE'.
  *  lo_manager->mv_lastname = 'COQUEL'.
  *
  **  lv_intitule = lo_manager->get_identity( ) && ':' && lo_manager->get_job_name( ).
  *  lv_intitule = lo_manager->get_intitule( ).
  *
  *  WRITE: / lv_intitule.
  
  ************** OR **************
  
    DATA: lo_employee TYPE REF TO zcl_employee_fgi,
          lv_intitule TYPE string.
  
    CREATE OBJECT lo_employee TYPE ('zcl_employee_consulting_fgi').
    lo_employee->mv_firstname = 'GORA'.
    lo_employee->mv_lastname = 'DIAW'.
    lv_intitule = lo_employee->get_intitule( ).
  
    WRITE: / lv_intitule.
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form set_hired_person
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM set_hired_person.
  
    DATA: lo_employee TYPE REF TO zcl_employee_fgi,
          lv_intitule TYPE string.
  
    CREATE OBJECT lo_employee TYPE zcl_employee_consulting_fgi.
    lo_employee->mv_firstname = 'Pouet'.
    lo_employee->mv_lastname = 'POUET'.
  
    SET HANDLER lo_employee->handle_employee_hired FOR lo_employee.
  
    lv_intitule = lo_employee->get_intitule( ).
  
    WRITE: / lv_intitule.
  
  ENDFORM.