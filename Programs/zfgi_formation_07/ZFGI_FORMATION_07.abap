*&---------------------------------------------------------------------*
*& Report ZFGI_FORMATION_07
*&---------------------------------------------------------------------*
*& Date création    / Auteur            / Motif
*& 08.03.2023         FGI(Alliance4u)     Exercices
*&---------------------------------------------------------------------*
*& Modification     / Auteur            / Motif
*&
*&---------------------------------------------------------------------*

REPORT zfgi_formation_07 NO STANDARD PAGE HEADING.

INCLUDE zfgi_formation_07_top.
INCLUDE zfgi_formation_07_scr.
INCLUDE zfgi_formation_07_f01.

START-OF-SELECTION.

IF s_datet IS INITIAL.
  IF P_radio2 IS NOT INITIAL.
    MESSAGE TEXT-008 TYPE 'E'.
  ENDIF.
ENDIF.

IF P_radio1 = 'X'.
* 1er traitement : insertion dans les tables de la BDD
  PERFORM insert_data.
ENDIF.

IF P_radio2 = 'X'.
* 2eme traitement : selection & affichage dans les tables de la BDD
  PERFORM select_data.
ENDIF.

END-OF-SELECTION.

************************** TITRE D'UN PROGRAMME
* Activer
* Saut
* Propriété
* SVG
*
************************** JOB
* = automatisation du lancer de prog périodiuement en SM36 et visualisation en SM37
*
* Necessite d'avoir créer une transaction pour un programme (clic droit > créer > transaction
* Nécessite d'activer le prog
* Necessite d'executer la transaction
* Nécessite de créer une variante
*
* Autre nom : BATCH (même chose)
*       1. Nom du prog
*       2. Nom de variante
*       3. Nom du Job
*
* Mais comme ca se lance en arriere plan, comment débugger ?
* => nécessite une technique spéciale (pas expliquer)
*       1. Trouver le job
*       2. Trouver le prog
*
************************** CODE INSPECTOR
*
* = Aide à nettoyer son code
*
* Programme > Contrôler > Code Inspector
* Un programme n'est valide pour le client que s'il n'y a pas d'erreur.
*
* TRY ENDTRY CATCH
*
* A definir

* FORM DATA INIT
* FORM DATA SELECT
* FORM DATA OPERATION
* FORM DATA DISPLAY

* AIDE A LA RECHERCHE
* SE11
* Selectionner 'Aide a la recherce'
* Entrée un nom avec Z + description