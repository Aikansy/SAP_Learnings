# **PROGRAMMATION**

Une fonction est un outil technique permettant de traiter des informations selon des paramètres d’entrée, pour en définir de nouvelles dans des paramètres de sortie. Les quatre prochains onglets vont donc lister ces paramètres (**Importation**, **Export**, **Modification** et **Tables**), puis le cinquième (**Exceptions**) va gérer les **messages de la fonction** et enfin **Source** liste le code **ABAP**. Pour ce faire, la fonction **SD_CUSTOMER_MAINTAIN_ALL** (création d’un client) sera choisie, car ayant beaucoup de paramètres, elle mettra bien en évidence les différentes options possibles.

## **TABLES**

[Schéma - Function Builder : SD_CUTOMER_MAINTAIN_ALL](https://drive.google.com/file/d/1I_0r7YcVw0ent6fYTeXSw4GeXDfsyOJ0/view?usp=share_link)

L’onglet **Tables**, comme son nom l’indique, va contenir la liste des tables à utiliser dans la fonction, cependant une table peut être modifiable, elle peut donc être à la fois un paramètre d’entrée comme de sortie. Elle possède également les mêmes informations que l’onglet **Export** :

+ **Nom paramètre** : libre, mais commence souvent par un T_ (pour Table)

+ **Catégorisation**

+ **Type référence**

+ **Facultatif**

+ **Désignation**

+ **Texte descriptif**

Il est aussi possible d’utiliser la catégorisation **LIKE** avec le nom d’une table, mais l’onglet Tables va devenir **obsolète** dans les prochaines options de **SAP**, remplacé par celui de **Modifications**. Cependant, comme étant encore présent dans de nombreuses fonctions standards, il était nécessaire de s’y attarder un peu.

Il serait intéressant de faire un petit aparté concernant la catégorisation pour les paramètres de type table. 

Prenons un exemple : une fonction est créée avec comme paramètre de modification, une table **LT_TRAVEL** ayant pour référence la table **ZTRAVEL**. La catégorisation à utiliser peut être **TYPE** ou **TYPE REF TO**. Cependant, si le type de référence est une table (ici **ZTRAVEL**) ou une structure, le paramètre **LT_TRAVEL** sera considéré comme une structure et ne pourra donc pas contenir de données.

[Schéma - Tables SE37](https://drive.google.com/file/d/1OQybLiXQbKI9cKecr2GQ7yjvwhWGYU-6/view?usp=share_link)

Pour que le paramètre **LT_TRAVEL** soit considéré comme une table, il est nécessaire d’utiliser un type de table. Un type de table est une sorte de structure qui va définir la ligne servant de modèle. Par exemple, si on souhaite utiliser la table **ZTRAVEL** dans la fonction, il faudra créer le type de table correspondant comme suit :

-> Dans la transaction **SE11**, insérez le nom du type de table à créer (**ZTT_TRAVEL** par exemple), puis cliquez sur **Créer** :

[Dictionnaire ABAP : écran initial](https://drive.google.com/file/d/1Gt2Hchg8koOyB-rntpr9YsJvJrE-E8D2/view?usp=share_link)

-> Dans la nouvelle fenêtre pop-up, choisissez **Type de table**.

[Schéma - Créer type_ZTT_TRAVEL](https://drive.google.com/file/d/1E-Ba3PQNluvGz_xVsFSG9efgWgJF9OlX/view?usp=share_link)

-> Définissez une description du type de table, puis le type de ligne (ici ZTRAVEL).

[Schéma - Dictionnaire ABAP : gestion du type de table](https://drive.google.com/file/d/1C5Ih5mWXiL3RhsdOrXpISHoq0Gukpd9u/view?usp=share_link)

-> Sauvegardez et activez, le type de table peut maintenant être utilisé dans la fonction.

[Schéma - Function](https://drive.google.com/file/d/1sjiQqgDH7PzLuU64lPnj5yP8ibd1A_Hh/view?usp=share_link)