*&---------------------------------------------------------------------*
*                               .,,,,,,,,,,,,
*                        ,;%%%%uuuuuuuuuuuuu%%%\
*                     /%%%%%uuuu====####uuuuuu%%%%
*                   /%%%%%uuuu.....===###uuuuu%%%%%%
*            , `````\%%%%%uuu....##.===##uuuu%%%%%%%%
*           ,````````)####\%u....../==#/uuu%%%%%%%%%%%
*           ,`````/#########\%mmmmmmmmmmmmm%%%%%%%%%%%;
*           #\``/##########(mmmmmmmmmmmmmmmmnu%%`%%%%%%%
*           ###############(mmmmmmmmmmmmmmmmmnuu%%`%%%%%%;
*           u\###########/ (mmmmmmmmmmmmmmmmmmnuu%%`%%%%%%%%
*          uuuuuEEE         \mmmmmmmmmmmmmmmmmnuuu%%`%%%%%%%%%
*          uuuuuEEE    .:::,#u,mmmmnnmmmmmmmmmnuuu%%;; %%%%%%%%%
*           uuuuuu\##\:::::##uuummmmmmmmmmmmmmnuu%%;;;; :...%%%%%%
*              uuuuu\#######/uuuuuuuuuu,mmmmmmnu%%...;;;  ::...%%%%
*                 \uuuuuuuuuuuuuuuuuuuuuuuu,mmnu/ \...;;;   ::...%%%
*                   >####&&################<%%%%    \;;;/    ::...%%%
*               (#####&&&################%%%%%%%              ::..%%%
*           (######&&&&##############(%%%%%%%%%%                ::%/
*          (####&&&&&&#############(%%%%%%%%%%%%%
*        (#######&&&&&############(%%%%%%%%%%%%%%%%
*       (#########################(%%%%%%%%%%%%%%%%%%
*       (# (######################(%%%%%%%%%%%%%%%%%%%%
*          (#######################(%%%%%%%%%%%%%%%%%%%%%
*         %%%(#####################(%%%%%%%%%%%%%%%%%%%%%%%
*        %%%%%%(####################(%%%%%%%%%%%%%%%%%%%%%%%
*       ;%%%%%%; (#################n`%%%%%%%%`%%%%%%%%%%%%%%%
*      (%%%%%%%(  ;%nn############nn`%%%%%%%%`%%%%%%%%%%%%%%%%
*       ;%%%%%%%  %%%nnnnnnnnnnnnn`%%%%%%%%%`%%%%%%%%%%%%%%%%%%(@@@)
*        \%%%%%;  %%%%nnnnnnnn`%%%%%%%%%`%%`n%%%%%%%%%%%%%%%%%(@@@@@)
*         (%(%/   %%%%%nnnnnn`%%%%%%%%%%%`nnnn%%%%%%%%%%%%%%%%(@@@@@@
*                %%%%%%nnnnnn`%%%%%%%%`nnnnnnnn%%%%%%%%%%%%%%(@@@@@@@
*               %%%%%%%nnnnnnn(%(%)nnnnnnnnnnnn%%%%%%%%%%%%%(@@@@@@@)
*           .,;%%%%%%%%nnnnnnnnnnnnnnnnnnnnnnn%%%%%%%%%%%%%(@@@@@@@@
*    ,nnnnnnn%%%%%%%%%nnnnnn)nnnnnnnnnnnnnnn%%%%%%%%%%%%%%(@@@@@@@)
* /nnnnnnnnnnn%%%%%%nnnnnnnnnnn)nnnnnnnnn%%%%%%%%%%%%%%%/  (@@@@)
*(uu(uuuuuuuuuuuuuuuuuuuuuuuuuuu/   (uu;;;;;;;;;;;uu)
*                                    (uu;;;;;;;;;;uu)
*                                     (uuuuuuuuuuuuu)
*                                       (uu)(uu)(uu)
*
*&---------------------------------------------------------------------*
*& REPORT                : Y_003_ROK
*& VERSION               : 1.00
*& AUTHOR                : EH7MM63  -  EH7MM63
*& FUNCTION / DEPARTMENT :  /
*&---------------------------------------------------------------------*
*& CREATION DATE         : 2023.06.02
*& PURPOSE               :
*&---------------------------------------------------------------------*
*& CORRECTION ON VERSION : 1.00
*& NEW VERSION           : 1.01
*& AUTHOR                :
*& DATE                  :
*& REASON                :
*& CHANGE                :
*&---------------------------------------------------------------------*
*& HISTORY
*&---------------------------------------------------------------------*

REPORT Y_003_ROK NO STANDARD PAGE HEADING.

INCLUDE Y_003_ROK_TOP.
INCLUDE Y_003_ROK_SCR.
INCLUDE Y_003_ROK_F01.

INITIALIZATION.

  PERFORM DATA_INITIALIZATION.

START-OF-SELECTION.

  PERFORM DATA_RETRIEVE.

  IF sy-subrc = 0.
    PERFORM DATA_REGEX.

    IF gv_receiv_email = abap_true AND gv_sender_email = abap_true.
      PERFORM DATA_SEND_API.
    ENDIF.
  ENDIF.

END-OF-SELECTION.