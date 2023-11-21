# **`ALGORITHME`**

L'algorithme est la dernière étape avant le développement. Il s'agit ici de décrire le programme final en étape simple en respectant les problématiques du document fonctionnel sans tenir compte du langage de programmation.

> _Exemple d'un document fonctionnel reçu_
>
> Lister tous les documents de vente de la société selon le pays du client et/ou le produit vendu. Il faudra créer un écran de sélection contenant deux paramètres : le pays d'origine du client ainsi que le produit. Le code pays est obligatoire.
>
> L'algorithme sera alors :
>
> ```
> Écran de sélection
> Sélection multiple CODE_PAYS (obligatoire)        PRODUITS
> Début
> Si CODE_PAYS n'est pas renseigné
>    Alors Message erreur
> Sinon
>    Sélection des clients avec CODE_PAYS
>    Si sélection retourne un résultat
>     Alors sélection des documents de vente avec PRODUIT écran de sélection
>     Si sélection retourne un résultat
>        Boucle sur la table des documents de vente
>               Si la ligne est informée
>                   Si le client du document de vente appartient à la table des clients
>                      Afficher Ligne
>                      Passer à la ligne suivante
>                 Sinon passer à la ligne suivante
>               Sinon passer à la ligne suivante
>        Fin de la boucle
>     Sinon Message Erreur
>    Sinon Message Erreur
> Fin
> ```

Il est possible également de faire un algorithme graphique, beaucoup plus clair et lisible que le littéral.

![](../99%20-%20Ressources/03_Algorithmes%20-%2001.png)
