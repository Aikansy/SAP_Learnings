*&---------------------------------------------------------------------*
*& Include          ZFGI_FORMATION_09_SCR
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b000 WITH FRAME TITLE TEXT-000.

*  PARAMETERS: p_driver TYPE zdriver_car_kde-id_driver MATCHCODE OBJECT z_id_driver_prog_07,
*              p_citf   TYPE ztravel-city_from MATCHCODE OBJECT z_city_from_prog_07,
*              p_citt   TYPE ztravel-city_to MATCHCODE OBJECT z_city_to_prog_07.

PARAMETERS: p_driver TYPE zdriver_car_kde-id_driver MATCHCODE OBJECT z_id_driver_prog_07,
            p_datet TYPE ztravel-date_travel,
            p_cityf TYPE ztravel-city_from,
            p_cityt TYPE ztravel-city_to.

SELECTION-SCREEN END OF BLOCK b000.