# **PROGRAMMATION**

Une fonction est un outil technique permettant de traiter des informations selon des paramètres d’entrée, pour en définir de nouvelles dans des paramètres de sortie. Les quatre prochains onglets vont donc lister ces paramètres (**Importation**, **Export**, **Modification** et **Tables**), puis le cinquième (**Exceptions**) va gérer les **messages de la fonction** et enfin **Source** liste le code **ABAP**. Pour ce faire, la fonction **SD_CUSTOMER_MAINTAIN_ALL** (création d’un client) sera choisie, car ayant beaucoup de paramètres, elle mettra bien en évidence les différentes options possibles.

## **IMPORTATION**

[Schéma - Function Builder : SD_CUTOMER_MAINTAIN_ALL](https://drive.google.com/file/d/1Wz-FaDTH4wNi2lzAkoYqJR2t47xozPLL/view?usp=share_link)

C’est ici que les paramètres d’entrée sont listés, définis par les informations suivantes :

+ **Nom paramètre** : libre, mais commence souvent par un **I_** (pour importation) ou **IV_**, **IS_**... (Importation Variable, Importation Structure...).

+ **Catégorisation** : peut prendre les valeurs **LIKE**, **TYPE** et **TYPE REF TO** afin de faire référence à un élément de données de type élémentaire (pour le **LIKE** et **TYPE**) ou ayant un type de référence à une **classe** ou une **interface** lors de l’utilisation de l’**ABAP Objet** (pour le **TYPE REF TO**, cf. chapitre Dictionnaire de données (**DDIC**) - Éléments de données), ou bien à un champ d’une table ou structure, et même faire référence à une structure entière.

+ **Type référence** : champ d’une table ou structure, ou élément de données.

+ **Valeur par défaut** : comme son nom l’indique, précise si le champ doit être renseigné par une valeur prédéfinie.

+ **Facultative** : fixe le paramètre comme optionnel et il n’est donc pas nécessaire de lui attribuer une variable lors de l’appel de la fonction.

+ **Passage par valeur** : permet ici de transférer la valeur du paramètre dans le paramètre appelant ; cependant, en raison de mauvaises performances, SAP préconise de ne plus utiliser cette option sauf dans le cas d’une fonction **RFC** où cette case à cocher est obligatoire.

+ **Désignation** : renseignée automatiquement par la description du champ de la table/structure ou de l’élément de données ou pouvant être mise à jour manuellement.

+ **Texte descriptif** : permet d’éditer une aide pour le paramètre de la fonction.