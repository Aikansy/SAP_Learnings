# **`PARAMETRES`**

Une fonction est un outil technique permettant de traiter des informations selon des paramètres d'entrée, pour définir de nouvelles dans des paramètres de sortie. Les quatre prochains onglets vont donc lister ces paramètres (Importation, Export, Modification et Tables), puis le cinquième (Exceptions) va gérer les messages de la fonction et enfin Source liste le code ABAP. Pour ce faire, la fonction ``SD_CUSTOMER_MAINTAIN_ALL` (création d'un client) sera choisie, car ayant beaucoup de paramètres, elle mettra bien en évidence les différenctes options possibles :

## **IMPORTATION**

![](../99%20-%20Ressources/10_Fonctions%20-%2002%20-%2001.png)

C'est ici que les paramètres d'entrée sont listés, définis par les informations suivantes :

- `Nom paramètre` :

  libre mais commence souvent par un `I_` (pour importation) ou `IV_`, `IS_` ... (Importation Variable, Importation Structure...).

- `Catégorisation`

  Peut prendre les valeurs `LIKE`, `TYPE`, et `TYPE REF TO` afin de faire référence à un élément de données de type élémentaire (pour le `LIKE` et `TYPE`) ou ayant un type de référence à une classe ou une interface lors de l'utilisation de l'ABAP Object (pour le `TYPE REF TO`) ou bien à un champ d'une table ou structure, et même faire référence à une structure entière.

- `Type référence` :

  Champ d'une table ou structure, ou élément de données.

- `Valeur par défaut` :

  comme son nom l'indique, précise si le champ doit être renseigné par une valeur prédéfinie.

- `Facultative` :

  fixe le paramètre comme optionnel et il n'est donc pas nécessaire de lui attribuer une variable lors de l'appel de la fonction.

- `Passage de valeur` :

  permet ici de transférer la valeur du paramètre dans le paramètre appelant ; cependant, en raison de mauvaises performances, SAP préconise de ne plus utiliser cette option sauf dans le cas d'une fonction RFC où cette case à cocher est obligatoire.

- `Désignation` :

  renseignée automatiquement par la description du champ de la table/structure ou de l'élément de données ou pouvant être mise à jour manuellement.

- `Texte descruptif` :

  permet d'éditer une aide pour le paramètre de la fonction.

## **EXPORT**

![](../99%20-%20Ressources/10_Fonctions%20-%2002%20-%2002.png)

Paramètres de sortie regroupant sensiblement les mêmes informations que l'onglet `Importation`.

- `Nom paramètre` :

  Libre, mais commence souvent par un `E_` (pour Export) ou `EV_`, `ES_` ... (Export Variable, Export Struture).

- `Catégorisation`

- `Type référence`

- `Passage par valeur`

- `Désignation`

- `texte descriptif`

## **MODIFICATION**

![](../99%20-%20Ressources/10_Fonctions%20-%2002%20-%2003.png)

Les paramètres de `Modification` quant à eux, sont à la fois des paramètres d'importation et de sortie. Ainsi, leur valeur peut changer pendant l'exécution de la fonction (il n'est pas possible de modifier la valeur des paramètres d'entrée). Concernant les informations du paramètre, ce sont exactement les mêmes que pour l'`Importation` :

- `Nom paramètre` :

  libre, mais commence souvent par un `C_` (pour Changement) ou `CV_`, `CS_` ... (Changement Variable, Changement Structure...).

- `Catégorisation`

- `Type référence`

- `Valeur par défaut`

- `Facultatif`

- `Passage par valeur`

- `Désignation`

- `Texte descriptif`

## **TABLES**

![](../99%20-%20Ressources/10_Fonctions%20-%2002%20-%2004.png)

L'onglet `Tables`, comme son nom l'indique, va contenir la liste des tables à utiliser dans la fonction, cependant un table peut être modifiable, elle peut donc être à la fois un paramètre d'entrée comme de sortie. Elle possède également les mêmes informations que l'onglet `Export` :

- `Nom paramètre` :

  libre, mais commence souvent par un `T_` (pour Table)

- `Catégorisation`

- `Type référence`

- `Facultatif`

- `Désignation`

- `Texte descriptif`

Il est aussi possible d'utiliser la catégorisation `LIKE` avec le nom d'une table, mais l'onglet `Tables` va devenir obsolète dans les prochaines options de SAP, remplacé par celui de `Modifications`. Cependant, comme étant encore présent dans de nombreuses fonctions standards, il était nécessaire de s'y attarder un peu.

Il serait intéressant de faire un petit aparté concernant la catégorisation pour les paramètres de type table. Prenons un exemple : une fonction est créée avec comme paramètre de modification, une table `T_TRAVEL` ayant pour référence la table `ZTRAVEL`. La catégorisation à utiliser peut être `TYPE` ou `TYPE REF TO`. Cependant, so le type de référence est une table (ici `ZTRAVEL`) ou une structure, le paramètre `T_TRAVEL` sera considéré comme une structure et ne pourra donc pas contenir de données.

![](../99%20-%20Ressources/10_Fonctions%20-%2002%20-%2005.png)

Pour que le paramètre `T_TRAVEL` soit considéré comme une table, il est nécessaire d'utiliser un type de table. Un type de table est une sorte de structure qui va définir la ligne servant de modèle. Par exemple, si on souhaite utiliser la table `ZTRAVEL` dans la fonction, il faudra créer le type de table correspondant comme suit :

1. Dans la transaction SE11, insérez le nom du type de table à créer (`ZTT_TRAVEL` par exemple), puis cliquez sur `Créer` :

   ![](../99%20-%20Ressources/10_Fonctions%20-%2002%20-%2006.png)

2. Dans la nouvelle fenêtre pop-up, choisissez `Type de table`.

   ![](../99%20-%20Ressources/10_Fonctions%20-%2002%20-%2007.png)

3. Définissez une description du type de table, puis le type de ligne (ici `ZTRAVEL`)

   ![](../99%20-%20Ressources/10_Fonctions%20-%2002%20-%2008.png)

4. Sauvegardez et activez, le type de table peut maintenant être utilisé dans la fonction.

   ![](../99%20-%20Ressources/10_Fonctions%20-%2002%20-%2009.png)

## **EXCEPTIONS**

Les exceptions sont une liste d'erreurs que la fonction peut retourner, il serait possible d'utiliser à la place des messages, mais les exceptions donnent la possibilité aux développeurs de les gérer comme ils le souhaitent et sont aussi plus pratiques lorsqu'il s'agit de fonctions de type `RFC`.

![](../99%20-%20Ressources/10_Fonctions%20-%2002%20-%2010.png)

## **SOURCE**

Le dernier onglet `Source` contient le code ABAP utilisé par la fonction.

![](../99%20-%20Ressources/10_Fonctions%20-%2002%20-%2011.png)

Aussi, dans la partie `Source`, il est intéressant de constater que la fonction commence toujours par lister tous les paramètres de celle-ci.

![](../99%20-%20Ressources/10_Fonctions%20-%2002%20-%2012.png)

Cette fonction contenant un nombre très important de paramètres, il est assez difficile de l'utiliser dans un programme. C'est pour cela que l'option `Modèle` dans l'éditeur ABAP estr une aide considérable. En effet, après avoir exécuté la transaction `SE38` et avoir créé un nouveau programme (ou ouvert, pour modification, un programme existant), il suffira alors de cliquer sur cette option de la barre d'outils, afin de renseigner la fonction souhaitée dans la partie `CALL FUNCTION` :

![](../99%20-%20Ressources/10_Fonctions%20-%2002%20-%2013.png)

Après avoir validé, SAP a importé le `CALL FUNCTION` de la fonction `SD_CUSTOMER_MAINTAIN_ALL` avec tous ses paramètres et ses exceptions. Aussi, tout ce qui est en commentaire (ligne commençant par `*`) sont des paramètres optionnels. Il est possible de voir qu'ils le sont tous pour cet exemple.

![](../99%20-%20Ressources/10_Fonctions%20-%2002%20-%2014.png)

![](../99%20-%20Ressources/10_Fonctions%20-%2002%20-%2015.png)

Concernant les exceptions, chacune est associée à un numéro. Il s'agit en fait de la valeur que prendra la variable système du code retour [SY-SUBRC](../99%20-%20Help/02%20-%20SY-SYSTEM.md) après l'exécution de la fonction.

> Même si les exception dont facultatives, il est recommandé de les gérer, aidant ainsi l'utilisateur à retourner les erreurs rencontrées.

Ainsi, pour cet exemple, une gestion des exceptions pourrait se faire de la sorte :

```JS
DATA: v_kunnr TYPE kunnr.

CALL FUNCTION 'SD_CUSTOMER_MAINTAIN_ALL'
  IMPORTING
    e_kunnr                 = v_kunnr
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
    WRITE: 'Le client nº ', v_kunnr, ' a été créé avec succès.'.
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

Les paramètres facultatifs ont été supprimés pour une meilleure visibilité du programme. Pour information, n'ayant pas de paramètre en entrée, la fonction ne retournera rien.

Il est possible de retrouver le code de ce programme dans le fichier 08_CODE_01.txt.
