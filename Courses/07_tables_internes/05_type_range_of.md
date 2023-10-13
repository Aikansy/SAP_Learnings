# **`TYPE RANGE OF`**

`TYPE RANGE OF` est une table interne un peu particuluier car elle a déjà une structure définie dont les zones sont les suivantes :

- `SIGN de type C` (alphanumérique) et de longueur d’une seule position, accepte les valeurs I (Inclure) ou E (Exclure).
- `OPTION de type C` (alphanumérique) et de longueur deux positions, contient les valeurs définies dans le chapitre Instructions basiques ABAP - Instructions conditionnelles, à savoir EQ (égal), NE (différent), GT (strictement plus grand que), GE (plus grand ou égal), LE (inférieur ou égal), LT (strictement inférieur), CP (contient le modèle), NP (ne contient pas le modèle). Ce champ peut également prendre comme valeur BT (compris entre), et NB (non compris entre).
- `LOW` intervalle inférieur dont le type et la longueur de champ varient selon la référence attribuée.
- `HIGH` intervalle supérieur dont le type et la longueur de champ varient selon la référence attribuée.

Cette structure est utilisée comme table interne d’intervalles de données, utilisée dans les requêtes SQL (cf. chapitre Les requêtes SQL - SELECT). Aussi les champs d’un écran de sélection sont définis de la même manière (cf. chapitre Création d’un programme ABAP - Écran de sélection).

Exemple

_Création d’une table interne de type RANGE, pouvant contenir un intervalle de données de numéros de produits (éléments de données MATNR)._

```JS
DATA: r_matnr TYPE RANGE OF matnr.
```
