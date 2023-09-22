# `INDEX PROGRAMS`

## **PROGRAMME - Y_000_ROK - CLES COMMUNES ENTRE TABLES**

[Program Y_000_ROK](./Y_000_ROK/Y_000_ROK.abap)

> - Vérifier que la chaine de caractère rentrée est un `palindrome`
>
> - Vérifier que la chaine de caractères est typé comme suivant : `AIRCRAFT-XXXYY` avec `XXX` (3 à 5 chiffres quelconques) et `YY` (2 Lettres quelconques)

## **PROGRAMME - Y_001_ROK - PALINDROME**

[Program Y_001_ROK](./Y_001_ROK/Y_001_ROK.abap)

> - Vérifier que la chaine de caractère rentrée est un `palindrome`
>
> - Vérifier que la chaine de caractères est typé comme suivant : `AIRCRAFT-XXXYY` avec `XXX` (3 à 5 chiffres quelconques) et `YY` (2 Lettres quelconques)

## **PROGRAMME - Y_002_ROK - RECUPERATION DE FACTURE**

[Program Y_002_ROK](./Y_002_ROK/Y_002_ROK.abap)

> Récupération des factures `FI` ayant un poste client sur une société donnée créées depuis une date donnée.
>
> - Récupération des `entêtes`
>
> - Récupération des `postes de facture FI`
>
> - Récupération des `données des pièces de référence`
>
> Les pièces de référence peuvent être de 2 types : facture ou pièce FI.
>
> - Récupération des `factures de référence`
>
> - Récupération des `pièces FI de référence`
>
> - Restitution sous `format ALV` des champs avec couleurs
>
> - Ajouter un champ de saisie d'un fichier en `local` pour sauvegarde de l'ALV
>
> - Ajouter un `bouton de traitement` sur l'ALV
>
> - Quand le bouton `Export` est activé, un fichier `CSV` doit être créé avec les données de l'ALV.
>
> - Calcul de la `performance` d'execution du programme

## **PROGRAMME - Y_003_ROK - ENVOI DE FICHIER PAR MAIL**

[Program Y_003_ROK](./Y_003_ROK/Y_003_ROK.abap)

> - Création d'un programme pour envoyer un fichier depuis `AL11` (serveur) par `e-mail`

## **PROGRAMME - Y_004_ROK - AFFICHER UNE PIECE JOINTE D'UNE COMMANDE D'ACHAT**

[Program Y_004_ROK](./Y_004_ROK/Y_004_ROK.abap)

> En `ME23N` il est possible d'afficher les commande d'achat (Table `EKKO`/`EKPO` via `EBELN` etc) -> bouton `Autre commande`.
>
> Dans la partie service objet (bouton jaune tout en haut a gauche de la fiche de commande d'achat), il est possible de voir et enregistrer des pièces jointes liés à une commande d'achat spécifique.
>
> - Dans cet exercice on souhaite à partir d'une saisie d'un ou plusieurs numéro de document d'achat (`EKKO-EBELN`)
> - Afficher la liste des pièces jointes dans un `ALV`
>
> - Pouvoir sélectioner une en double clickant pour l'afficher/la télécharger.

## **PROGRAMME - Y_005_ROK - MISE A JOUR DES COMMANDES CLIENT**

[Program Y_005_ROK](./Y_005_ROK/Y_005_ROK.abap)

> Créer un programme qui permet de mettre à jour un champ spécifique dans une commande client (`VA02`).
>
> - Le bouton `SAVE` permettra de mettre à jour la `SO`.
>
> - Afficher les valeurs mises à jour dans un rapport ALV.
>
> - Dans ce rapport ALV, ajouter un champ `Message` pour indiquer que le `SO` a été mis à jour.

## **PROGRAMME - Y_006_ROK - CREATION DE PATTERN**

[Program Y_006_ROK](./Y_006_ROK/Y_006_ROK.abap)

> On crée un pattern et on écrit `\*$&$MUSTER` pour envoyer au module fonction
>
> - Créer le module fonction sans oublier de mettre dans `TABLES : BUFFER TYPE RSWSOURCET`

## **PROGRAMME - Y_007_ROK - MODIFIER UNE DATE DE SO**

[Program Y_007_ROK](./Y_007_ROK/Y_007_ROK.abap)

> Le but de l’exo est de modifier la delivery date (`ETDAT`), de tous les items d'une `SO` (même objet/bapi que l’exo précédent , tables `VBAK`/`VBAP`)
> `SCR` : Ecran numéro de commande (`VBELN`) , date de delivery (`ETDAT`)
>
> - Exemple : VA03 Pour afficher commande
>
> - SO de test : 17792

## **PROGRAMME - Y_008_ROK - SMARTFORMS**

[Program Y_008_ROK](./Y_008_ROK/Y_008_ROK.abap)

> Créer un smartform d'une commande de vente en affichant
>
> - `adresse`
>
> - `posts`
>
> - `text`
>
> - `total`

## **PROGRAMME - Y_009_ROK - ENVOI DE SMARTFORMS PDF PAR MAIL/VA02**

[Program Y_009_ROK](./Y_009_ROK/Y_009_ROK.abap)

> Envoyer le Smartform créé sur le programme précédent en PDF
>
> - par `mail`
>
> - et/ou l'ajouter dans les pièces attachées de la commande `VA02`
