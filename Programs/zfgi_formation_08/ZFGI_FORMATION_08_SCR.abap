*&---------------------------------------------------------------------*
*& Include          ZFGI_FORMATION_08_SCR
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b000 WITH FRAME TITLE TEXT-000.

*text-001 = 'PO Header' - define as text element
  SELECTION-SCREEN BEGIN OF BLOCK b010 WITH FRAME TITLE TEXT-010.
    PARAMETERS : company LIKE gs_header-comp_code DEFAULT '122',
                 doctyp  LIKE gs_header-doc_type DEFAULT 'NB',
                 cdate   LIKE gs_header-creat_date DEFAULT sy-datum,
                 vendor  LIKE gs_header-vendor DEFAULT '2000000012',
                 pur_org LIKE gs_header-purch_org DEFAULT 'PU01',
                 pur_grp LIKE gs_header-pur_group DEFAULT '005'.
    "sociedad LIKE header-comp_code default '122' ,
    "vendedor LIKE header-sales_pers default 'sale person'.
  SELECTION-SCREEN END OF BLOCK b010.

  SELECTION-SCREEN BEGIN OF BLOCK b020 WITH FRAME TITLE TEXT-002.
    PARAMETERS : item_num LIKE gt_item-po_item DEFAULT '00010',
                 material LIKE gt_item-material DEFAULT '12000000',
                 tipo_imp LIKE gt_item-acctasscat DEFAULT 'K',
                 "pos_doc like ITEM-ITEM_CAT default 'F' ,
                 shorttxt LIKE gt_item-short_text DEFAULT 'PRUEBA BAPI',
                 grup_art LIKE gt_item-matl_group DEFAULT '817230000',
                 plant    LIKE gt_item-plant DEFAULT '3001',
                 mpe      LIKE gt_item-trackingno DEFAULT '9999',
                 "contrato like ITEM-AGREEMENT default '4904000003' ,
                 "quantity like ITEM-QUANTITY default 1 .
                 po_unit  LIKE gt_item-po_unit DEFAULT 'EA'.
  SELECTION-SCREEN END OF BLOCK b020.

  SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-004.
    PARAMETERS : center  LIKE gs_account-costcenter DEFAULT '1220813150',
                 account LIKE gs_account-gl_account DEFAULT '6631400',
                 num_pos LIKE gs_account-po_item DEFAULT '10',
                 serial  LIKE gs_account-serial_no DEFAULT '01',
                 ind_imp LIKE gs_account-tax_code DEFAULT 'I2'.
  SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN END OF BLOCK b000.