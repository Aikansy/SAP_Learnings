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
*& REPORT                : Y_009_ROK
*& VERSION               : 1.00
*& AUTHOR                : EH7MM63  -  EH7MM63
*& FUNCTION / DEPARTMENT :  /
*&---------------------------------------------------------------------*
*& CREATION DATE         : 2023.06.28
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

REPORT Y_009_ROK NO STANDARD PAGE HEADING.

INCLUDE Y_009_ROK_TOP.
INCLUDE Y_009_ROK_SCR.
INCLUDE Y_009_ROK_F01.

INITIALIZATION.

  PERFORM DATA_INITIALIZATION.

  IF SY-SUBRC <> 0.
    MESSAGE 'No attachments found.' TYPE 'E'.
  ENDIF.

START-OF-SELECTION.

END-OF-SELECTION.