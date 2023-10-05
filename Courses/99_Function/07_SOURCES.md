# **PROGRAMMATION**

Une fonction est un outil technique permettant de traiter des informations selon des paramètres d’entrée, pour en définir de nouvelles dans des paramètres de sortie. Les quatre prochains onglets vont donc lister ces paramètres (**Importation**, **Export**, **Modification** et **Tables**), puis le cinquième (**Exceptions**) va gérer les **messages de la fonction** et enfin **Source** liste le code **ABAP**. Pour ce faire, la fonction **SD_CUSTOMER_MAINTAIN_ALL** (création d’un client) sera choisie, car ayant beaucoup de paramètres, elle mettra bien en évidence les différentes options possibles.

## **SOURCE**

Le dernier onglet **Source** contient le code ABAP utilisé par la fonction.

[Schéma - Source](https://drive.google.com/file/d/1Kqo_lM7fcqFabeFP2Ik6_G3u49Szuqku/view?usp=share_link)

Aussi, dans la partie **Source**, il est intéressant de constater que la fonction commence toujours par lister tous les paramètres de celle-ci.

[Schéma - Source](https://drive.google.com/file/d/1qASog_sR2419gobUxvVJR_cLGUJoLn4S/view?usp=share_link)

Cette fonction contenant un nombre très important de paramètres, il est assez difficile de l’utiliser dans un programme. C’est pour cela que l’option **Modèle** dans l’éditeur **ABAP** est une aide considérable. En effet, après avoir exécuté la transaction **SE38** et avoir créé un nouveau programme (ou ouvert, pour modification, un programme existant), il suffira alors de cliquer sur cette option de la barre d’outils, afin de renseigner la fonction souhaitée dans la partie **CALL FUNCTION** :

[Schéma - Insérer modèle](https://drive.google.com/file/d/1nmvwh6ujgwL7WfhVIpjIGpeIaaZl0CPv/view?usp=share_link)

Après avoir validé, **SAP** a importé le **CALL FUNCTION** de la fonction **SD_CUSTOMER_MAINTAIN_ALL** avec tous ses paramètres et ses exceptions. Aussi, tout ce qui est en commentaire (ligne commençant par ’*’) sont des paramètres optionnels. Il est possible de voir qu’ils le sont tous pour cet exemple.

[Schéma - SE80 Program](https://drive.google.com/file/d/1FbilhaUNbiVB59Lexly_Yby89qM8SCS8/view?usp=share_link)

[Schéma - SE80 Program](https://drive.google.com/file/d/1CwAFRnXxRcC692A0ncqpw1Kil7cU9KU1/view?usp=share_link)

Concernant les **exceptions**, chacune est associée à un numéro. Il s’agit en fait de la valeur que prendra la variable système du code retour **SY-SUBRC** après l’exécution de la fonction.

Même si les exceptions sont facultatives, il est recommandé de les gérer, aidant ainsi l’utilisateur à retourner les erreurs rencontrées.

Ainsi, pour cet exemple, une gestion des exceptions pourrait se faire de la sorte :

```ABAP
DATA: lv_kunnr TYPE kunnr. 
 
CALL FUNCTION 'SD_CUSTOMER_MAINTAIN_ALL' 
  IMPORTING 
    e_kunnr                 = lv_kunnr 
  EXCEPTIONS 
    client_error            = 1 
    kna1_incomplete         = 2 
    knb1_incomplete         = 3 
    knb5_incomplete         = 4 
    knvv_incomplete         = 5 
    kunnr_not_unique        = 6 
    sales_area_not_unique   = 7 
    sales_area_not_valid    = 8 
    insert_update_conflict  = 9 
    number_assignment_error = 10 
    number_not_in_range     = 11 
    number_range_not_extern = 12 
    number_range_not_intern = 13 
    account_group_not_valid = 14 
    parnr_invalid           = 15 
    bank_address_invalid    = 16 
    tax_data_not_valid      = 17 
    no_authority            = 18 
    company_code_not_unique = 19 
    dunning_data_not_valid  = 20 
    knb1_reference_invalid  = 21 
    cam_error               = 22 
    OTHERS                  = 23. 
 
CASE sy-subrc. 
  WHEN 0. 
    WRITE: 'Le client nº ', lv_kunnr, ' a été créé avec succès.'. 
  WHEN 1. 
    WRITE 'Erreur de client.'. 
  WHEN 2. 
    WRITE 'La structure en entrée KNA1 est incomplète.'. 
  WHEN 3. 
    WRITE 'La structure en entrée KNB1 est incomplète.'.  
  ... 
  WHEN OTHERS. 
    WRITE 'Une erreur inconnue est survenue durant la création du client.'. 
ENDCASE.
```

Les paramètres facultatifs ont été supprimés pour une meilleure visibilité du programme. Pour information, n’ayant pas de paramètre en entrée, la fonction ne retournera rien.
