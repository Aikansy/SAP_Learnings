*&---------------------------------------------------------------------*
*& Include          ZFGI_FORMATION_08_TOP
*&---------------------------------------------------------------------*

* Constant declaration(s)
CONSTANTS: c_valuex VALUE 'X'.

* Variable declaration(s)
DATA : gv_ponumber  LIKE bapimepoheader-po_number,
       gv_delivery_date LIKE bapimeposchedule-delivery_date,
       gv_header(40) VALUE 'PO Header',
       gv_langu LIKE sy-langu.

* Structure declaration(s) : to hold PO header data
DATA: gs_header  LIKE bapimepoheader,
      gs_headerx LIKE bapimepoheaderx.

*Structures declaration(s) : to hold PO account data
DATA : gs_account  LIKE bapimepoaccount OCCURS 0 WITH HEADER LINE,
       gs_accountx LIKE bapimepoaccountx OCCURS 0 WITH HEADER LINE.

*Internal table declaration(s) : to hold PO item data
DATA : gt_item  LIKE bapimepoitem OCCURS 0 WITH HEADER LINE,
       gt_itemx LIKE bapimepoitemx OCCURS 0 WITH HEADER LINE.

*Internal table declaration(s) : to hold messages from BAPI call
DATA: gt_return LIKE bapiret2 OCCURS 0 WITH HEADER LINE.

*Internal table declaration(s) : to hold messages from BAPI call
DATA: pocontractlimits LIKE bapiesucc OCCURS 0 WITH HEADER LINE.