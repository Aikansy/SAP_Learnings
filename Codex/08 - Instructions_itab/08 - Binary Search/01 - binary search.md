# **`BINARY SEARCH`**

> Lors de l'utilisation du `READ TABLE WITH KEY`, il est fortement recommandé d'utiliser l'option `BINARY SEARCH`, car cela favorisa une recherche binaire de la table améliorant ainsi les performances du programme.

Une recherche binaire répond à l'algorithme suivant :

- Si elle est égale à la valeur recherchée, alors l'index de la ligne est retourné et la recherche est terminée.
- Sinon, si elle est supérieure à la valeur recherchée, la moitié inférieure sera isolée, puis de nouveau le programme regardera la valeur du milieu de cette moitié, si elle est égale à la valeur recherchée....

_Exemple_

_Sur une liste de nombres de 1 à 10, on souhaite trouver la position de 4. Suivant l'algorithme précédent, on va donc procéder comme suit :_

![](../../99%20-%20Ressources/08_Instructions_itab%20-%2008%20-%2001%20-%2001.png)

> Pour utiliser le `BINARY SEARCH`, il est obligatoire d'orgnaiser les données avec un `SORT` (sauf dans le cas d'une table interne de type `SORTED`).
