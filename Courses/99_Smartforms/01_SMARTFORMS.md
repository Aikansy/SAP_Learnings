# **SMARTFORMS**

DEMO*SMARTFORMS
DEMO*SMARTSTYLES

SMARTFORMS     ZCOMV_FGI
SMARTSTYLES    ZCOMV_FGI_STYLESHEET
SE63           Traduction > Objets ABAP > Autres textes
SE10           Création de Texte standard (i.e CGV/CGU/...)
                  Creer un texte > Type Texte : Texte de l'include > nom du texte standard

PROGRAMME IMPRESSION <->   OBJET METIER   <->   FORMULAIRE
                           (Via la Nace)    
(Dev)                      (Fonctionnel)        (Dev)
=>


3 types de formulaires :

- TCODE: SE71 - SAPSCRIPT (old) 
- TCODE: SMARFORMS
- TCODE: 

## SMARTFORMS

Nécessite de créer une feuille de style (Stylesheet) et de l'activer avant.

* Préférence de SVG plutot qu'activation

0.  [SMARTFORMS] Projet Mi-Parcours ZFGI_PROJECT_01_COR

        [X] FORMULAIRE : ZFGI_COM_VENTE ==> New window
        [DESIGNATION] Formulaire Commande de vente

1. [INTERFACE_DE_FORMULAIRE] (Paramètres, fonctionne comme un module fonction)

       Deux paramètres d'imports obligatoires nécessitent la création de structures et tables Header et Item créés au préalable en [SE11] :

    IT_HEADER (import table non modifiable) dans le form

       [SE11] ZSCV_HEADER_FGI (structure)
       [SE11] ZTCV_HEADER_FGI (table)
       [SMARTFORMS] (onglet interface de formulaire / Import) IT_HEADER TYPE ZTCV_HEADER_FGI

    IT_ITEM (import table non modifiable) dans le form
    
       [SE11] ZSCV_ITEM_FGI (structure)
       [SE11] ZTCV_ITEM_FGI (table)
       [SMARTFORMS] (onglet interface de formulaire / Import) IT_HEADER TYPE ZTCV_HEADER_FGI

2. [PAGES_ET_FENETRES] / [%PAGE_1]

       [CLIC_DROIT] [CREER] [FENETRE] au nom de "WINDOW1" puis redimensionner pour y mettre un titre
       Renommer la fenêtre en "CONTAINER_TITLE"

3. [TITRE] (Fenêtre anciennement "WINDOW1")

       [CLIC_DROIT] [CREER] [TEXTE]
       Renommer la fenêtre en "TITLE"
       Instruire le texte suivant "COMMANDE DE VENTE"

4. [%PAGE_1]

    [CLIC_DROIT] [CREER] [FENETRE]
    
       Renommer la fenêtre en "CONTAINER_LOGO"

    [CLIC_DROIT] [CREER] [GRAPHIQUE]
    
       Renommer la fenêtre en "LOGO"
       Importer logo SE78

5. [%PAGE_1]

    [CLIC_DROIT] [CREER] [FENETRE]
    
       Renommer la fenêtre en "CONTAINER_ADRESS_DELIVERY"

    [CLIC_DROIT] [CREER] [FENETRE]
    
       Renommer la fenêtre en "CONTAINER_ADRESS_FACTURE"

6. [MAIN]

    [CLIC_DROIT] [CREER] [TABLE]
    
       Renommer la fenêtre en "TABLE_1"

    [ONGLET_TABLE] 
    
       Interface graphique de la table

    [ONGLET_DONNEE]
    
       LOOP sur une table interne pour afficher des données dans la table

    [ONGLET_CALCUL] 
    
       CALCUL

    [ONGLET_EDITION] 
    
       FEUILLE DE STYLE

7. [DEFINITION_GLOBALE] / [DONNEES_GLOBALES]

       Déclarer les tables et structures globales du formulaire :
       GT_HEADER   TYPE ZTCV_HEADER_FGI
       GT_ITEM     TYPE ZTCV_ITEM_FGI
       GS_HEADER   TYPE ZSCV_HEADER_FGI
       GS_ITEM     TYPE ZSCV_ITEM_FGI

8. [DEFINITION_GLOBALE] / [INITIALISATION]

       Renseigner les paramètres d'entrée, de sortie et l'égalité

    [PARAMETRES_ENTREE]
    
       IT_HEADER
       IT_ITEM
       GT_HEADER
       GT_ITEM

    [PARAMETRES_SORTIE]
    
       GT_HEADER
       GT_ITEM

    [CODE]
    
       * Transfert des données des paramètres importées dans les tables internes
       GT_HEADER = IT_HEADER.
       GT_ITEM = IT_ITEM.

9.  [TABLE_1] [TABLE]

        Définir les cm de chaque colonne

10. [TABLE_1] [ZONE_ENTETE] [CLIC_DROIT] [CREER] [LIGNE_DE_TABLE]

        Puis [CLIC_DROIT] [CREER] [TEXTE] pour chaque champs et remplir le texte avec les noms des colonnes

11. [TABLE_1] [DOMAINE_PRINCIPAL] [CLIC_DROIT] [CREER] [LIGNE_DE_TABLE]

        Puis [CLIC_DROIT] [CREER] [TEXTE] pour chaque champs et remplir le texte avec les variables
        &gs_header-posnr&

12. [CONTAINER_ADRESS] [CLIC_DROIT] [CREER] [TEXTE]

        Type de commande : &gs_header-adress&
        Date de création : &gs_header-erdat&
        Heure de création : &gs_header-erzet&
        Date de livraison souhaitée : &gs_header-vdatu&
        Organisation commerciale : &gs_header-vkorg&
        Canal de distribution : &gs_header-vtweg&
        Secteur d'activité : &gs_header-spart&
