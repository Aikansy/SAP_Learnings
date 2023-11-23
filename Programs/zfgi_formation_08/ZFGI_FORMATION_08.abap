*&---------------------------------------------------------------------*
*& Report ZFGI_FORMATION_08
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT zfgi_formation_08 NO STANDARD PAGE HEADING.

INCLUDE zfgi_formation_08_TOP.
INCLUDE zfgi_formation_08_SCR.
INCLUDE zfgi_formation_08_F01.

START-OF-SELECTION.

gv_langu = sy-langu.

gs_header-doc_type = doctyp.
gs_header-vendor = vendor.
gs_header-creat_date = cdate.
gs_header-created_by = 'TD17191'.
gs_header-purch_org = pur_org.
gs_header-pur_group = pur_grp.
gs_header-comp_code = company.
gs_header-langu = gv_langu.

gs_headerx-comp_code = c_valuex.
gs_headerx-doc_type = c_valuex.
gs_headerx-vendor = c_valuex.
gs_headerx-creat_date = c_valuex.
gs_headerx-created_by = c_valuex.
gs_headerx-purch_org = c_valuex.
gs_headerx-pur_group = c_valuex.
gs_headerx-langu = c_valuex.

*  CALL FUNCTION 'BAPI_PO_CREATE1'
*    EXPORTING
*      poheader               =                        " Obligatoire
*      poheaderx              =                        " Obligatoire
*      poaddrvendor           =                        "
*      testrun                =                        "
*      memory_uncomplete      =                        "
*      memory_complete        =                        "
*      poexpimpheader         =                        "
*      poexpimpheaderx        =                        "
*      versions               =                        "
*      no_messaging           =                        "
*      no_message_req         =                        "
*      no_authority           =                        "
*      no_price_from_po       =                        "
*      park_complete          =                        "
*      park_uncomplete        =                        "
*    IMPORTING
*      exppurchaseorder       =                        " Obligatoire
*      expheader              =                        "
*      exppoexpimpheader      =                        "
*    TABLES
*      return                 =                        " Obligatoire
*      poitem                 =                        " Obligatoire
*      poitemx                =                        " Obligatoire
*      poaddrdelivery         =                        "
*      poschedule             =                        "
*      poschedulex            =                        "
*      poaccount              =                        "
*      poaccountprofitsegment =                        "
*      poaccountx             =                        "
*      pocondheader           =                        "
*      pocondheaderx          =                        "
*      pocond                 =                        "
*      pocondx                =                        "
*      polimits               =                        "
*      pocontractlimits       =                        "
*      poservices             =                        "
*      posrvaccessvalues      =                        "
*      poservicestext         =                        "
*      extensionin            =                        "
*      extensionout           =                        "
*      poexpimpitem           =                        "
*      poexpimpitemx          =                        "
*      potextheader           =                        "
*      potextitem             =                        "
*      allversions            =                        "
*      popartner              =                        "
*      pocomponents           =                        "
*      pocomponentsx          =                        "
*      poshipping             =                        "
*      poshippingx            =                        "
*      poshippingexp          =                        "
*      serialnumber           =                        "
*      serialnumberx          =                        "
*      invplanheader          =                        "
*      invplanheaderx         =                        "
*      invplanitem            =                        "
*      invplanitemx           =                        "
*      nfmetallitms           =.                       "

END-OF-SELECTION.