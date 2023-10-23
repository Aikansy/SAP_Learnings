# **`ECRAN DE SELECTION`**

Dans ce chapitre, un exemple plus complexe sera développé avec l’affichage de données dans un rapport ALV.

Pour commencer, il serait intéressant de connaître l’écran de sélection. Il s’agit de l’écran d’accueil permettant à l’utilisateur d’insérer des données utilisées pour filtrer les sélections qui se feront plus tard dans le programme.

Exemple d’écran de sélection sans mise en forme du `programme DEMO_SELECTION_SCREEN_EVENTS`.

![](../../99%20-%20Ressources/12_Screen%20-%2001%20-%2001%20-%2001.png)

> Il existe des exemples de programmes mis à disposition par SAP et ils commencent en général par DEMO\_. Sur SAP, pour afficher une liste à partir de mots-clés, il suffit d’appuyer sur la touche [F4] une fois ce mot-clé renseigné.

_Exemple_

Connaître la liste de tous les programmes commençant par DEMO\_ :

- Exécutez la transaction SE38 (dans le cas d’une recherche d’un nom de programme).

- Dans la zone Programme, renseignez DEMO*\* signifiant qu’on recherche tous les noms de programmes commençant par DEMO* suivi d’une chaîne de caractères (symbolisée par ’\*’)

![](../../99%20-%20Ressources/12_Screen%20-%2001%20-%2001%20-%2002.png)

- Appuyez ensuite sur [F4] ou le bouton d’aide à la recherche du champ ![](../../99%20-%20Ressources/12_Screen%20-%2001%20-%2001%20-%2003.png).png.

- La liste des programmes va alors s’afficher, il suffira de double cliquer dessus pour pouvoir y accéder.

![](../../99%20-%20Ressources/12_Screen%20-%2001%20-%2001%20-%2004.png)

Pour revenir à l’écran de sélection, il est bien sûr possible de le rendre plus lisible et mieux organisé.

_Exemple_

_Écran de sélection du programme de modification des documents de livraison (transaction VL22)._

![](../../99%20-%20Ressources/12_Screen%20-%2001%20-%2001%20-%2005.png)

Il sera vu dans cette section les principales options utilisées pour la création d’un écran de sélection simple.
