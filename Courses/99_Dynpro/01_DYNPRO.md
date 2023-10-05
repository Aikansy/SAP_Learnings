# **PROGRAMMATION**

## **DYNPRO**

**Dynamisches Programm** (_Programme Dynamique_) qui peut être **spécifique** ou **standard** (SAP Natif), possède un **identifiant** (Nombre à 4 chiffres ; i.e 1000). Le Dynpro est différent d'un Web Dynpro.

Les Dynpros utilisent des **PBO** (Process Before Input), des **PAI** (Process After Input), des variables globales, des fonctions et des modules (nom donné pour les PERFOMS). Il n'est cependant pas possible d'enchainer plus de 9 écrans.

Un Dynpro peut être composé de :

- Zone de texte
- Zone de saisie/édition
- Cases à cocher
- Radios boutons
- Bouton
- Sous-écran/onglet
- Cadre de design
- Sous-écran (imbrication complexe)
- Tableaux
- Containeur d'éléments

Il est nécessaire de : 
- Créer une routine FORM pour chaque élément.
- PF-STATUS (Méta-Actions : Sortie, ...)
- TITLEBAR
- Un nom (ID) et une icone pour chaque bouton

## **CREATION**

1.  [SE80] > [ZFGI_FORMATION_12]

2.  [Create] > [Dynpro]

        N° : 9001
        Description : 'Ecran Dynpro Ex 01'

3.  [Svg]

4.  [Activ]

5.  Add in Main

```ABAP
START-OF-SELECTION.

    CALL SCREEN 9001.

END-OF-SELECTION.
```

6.  [Create] > [Statut GUI]
        
        Statut_GUI_9001
        Désignation : PF-STATUS Ecran Dynpro Ex 01

7.  [Svg]

8.  [Touches de fonction]
        Bouton vert : BACK
        Bouton orange : CANCEL
        Bouton rouge : EXIT

9.  [Svg]

10. [Activ]

11. [Barre d'outils d'app]

        Positions 1 - 7 : MESSAGE 

12. [Enter]

        Descriptif : Afficher un message
        Nom de l'icône : Choisir une icône
        Texte d'information : Message Bonjour

13. [Valider]

14. Attribuer une touche raccourci [F9]

15. [Activ]

16. Create INCLUDE TOP & F01

17. [Dynpros] > [9001]

18. Décommenter les PBO et PAI

19. Double-clic sur STATUS_9001 > F01

20. [Activ]

21. Décommenter SET PF-STATUS 'Nom du statut GUI créé précedemment

        SET PF-STATUS 'STATUT_GUI_9001'.

22. [Activ]

23. Double-clic sur user_command_9001 > F01

sy-ucomm : prise en compte de l'action utilisateur. C'est une variable.

```ABAP
"prise en compte de l'action utilisateur. SY-UCOMM est une variable.
CASE sy-ucomm.
    WHEN 'BACK' OR 'CANCEL' OR 'EXIT'.
        LEAVE PROGRAM.
    WHEN 'MESSAGE'.
        MESSAGE 'Bonjour' TYPE 'I'.
    WHEN OTHERS.
ENDCASE.
```

24. [Dynpros] > [9001] > [Mise en Forme]

25. [Afficher/Modifier]

26. [Créer] > [Traiter éléments] > [Zone de Texte]

