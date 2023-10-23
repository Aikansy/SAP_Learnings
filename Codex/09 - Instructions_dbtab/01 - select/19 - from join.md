# **`JOIN`**

```JS
. . .FROM table1 INNER JOIN table2. . . ON. . .
. . .FROM table1 LEFT [OUTER] JOIN table2. . . ON. . .
. . .FROM table1 RIGHT[OUTER] JOIN table2. . . ON. . .
```

> L’option facultative `OUTER` a été mentionnée pour information mais elle n’apporte absolument rien de plus, donc en résumé :
>
> - `LEFT OUTER JOIN` est exactement la même chose que `LEFT JOIN`
> - `RIGHT OUTER JOIN` est exactement la même chose que `RIGHT JOIN`.

Il s'agit de sélectionner des données contenues dans deux tables différentes (`JOIN`) associées par un ou plusieurs champs en commun (définis par le `ON`). Ainsi :

- `INNER JOIN` : ne seront sélectionnées que les données communes aux deux tables
- `LEFT JOIN` : sélectionnera toutes les données de `table1` (située à gauche de la syntaxe) et affichera les données de `table2` ou les affichera `vides` si elles n'existent pas
- `RIGHT JOIN` : fonctionne exactement de la même façon sauf qu'il s'agira de la table située à droite de l'instruction (ici table2).

![](../../99%20-%20Ressources/09_Instructions_dbtab%20-%2001%20-%2019%20-%2001.png)

## **INNER JOIN**

_Exemple_

_Pour chaque enregistrement contenu dans la table `ZCAR_RAND_MODEL`, une requête affichera le conducteur._

```JS
SELECT zcar_brand_mod~brand,
       zcar_brand_mod~model,
       zcar_brand_mod~model_year,
       zdriver_car~surname,
       zdriver_car~name
  FROM zcar_brand_mod INNER JOIN zdriver_car
    ON zcar_brand_mod~brand       = zdriver_car~car_brand
    AND zcar_brand_mod~model      = zdriver_car~car_model
    AND zcar_brand_mod~model_year = zdriver_car~car_year
  INTO TABLE @DATA(t_car).


DATA s_car LIKE LINE OF t_car.

LOOP AT t_car INTO s_car.
  WRITE:/ s_car-brand,   s_car-model, s_car-model_year,
          s_car-surname, s_car-name.
ENDLOOP.
```

Les champs suivants sont sélectionnés : `BRAND`, `MODEL` et `YEAR` de la table `ZCAR_BRAND_MOD`, et `SURNAME` et `NAME` de la table `ZDRIVER_CAR`. Avec le `FROM`, les noms des tables source sont ensuite définis ainsi que leur modèle de jonction (`INNER JOIN`), et leur jointure basée sur trois champs communs : la marque (`BRAND` / `CAR_BRAND`), le modèle (`MODEL` / `CAR_MODEL`) et l'année (`MODEL_YEAR` / `CAR_YEAR`). La requête stockera le résultat dans la table interne `T_CAR`.

Comme `OpenSQL` ne peut pas identifier quel champ appartient à quelle table, il est nécessaire dans un `JOIN` de lui indiquer la provenance avec le nom de la table, un `tilde` (`~`) et le nom de la colonne.

Cependant, il n'est pas très facil de lire cette requête et comme pour le nom des colonnes, il est possible d'utiliser un alias pour les tables. Ainsi la requête peut se réécrire :

```JS
SELECT b~brand,
       b~model,
       b~model_year,
       d~surname,
       d~name
  FROM zcar_brand_mod AS b INNER JOIN zdriver_car AS d
    ON  b~brand      = d~car_brand
    AND b~model      = d~car_model
    AND b~model_year = d~car_year
  INTO TABLE @DATA(t_car).


DATA s_car LIKE LINE OF t_car.

LOOP AT t_car INTO s_car.
  WRITE:/ s_car-brand,   s_car-model, s_car-model_year,
          s_car-surname, s_car-name.
ENDLOOP.
```

Maintenant la table `C+ZCAR_BRAND_MOD` utilise l'alias `b` et `ZDRIVER_CAR` utilise `d`, et toutes les références à ces deux tables utiliseront désormais ces alias, rendant donc la requête beaucoup plus lisible.

_Résultat de la requête_

| **BRAND** | **MODEL** | **MODEL_YEAR** | **SURNAME** | **NAME** |
| --------- | --------- | -------------- | ----------- | -------- |
| PEUGEOT   | 307       | 2011           | DEBBACHE    | AMINH    |
| AUDI      | A3        | 2016           | ALDAIR      | PAULA    |
| FORD      | ESCORT    | 2013           | PILON       | BEATRIZ  |
| CITROEN   | C5        | 2012           | OLIVEIRA    | JOSE     |

_Résultat à l'écran_

![](../../99%20-%20Ressources/09_Instructions_dbtab%20-%2001%20-%2019%20-%2002.png)

## **LEFT JOIN**

_Exemple_

_Pour chaque enregistrement contenu dans la table `ZCAR_RAND_MODEL`, une requête affichera le conducteur._

```JS
SELECT b~brand,
       b~model,
       b~model_year,
       d~surname,
       d~name
  FROM zcar_brand_mod AS b LEFT JOIN zdriver_car AS d
    ON  b~brand      = d~car_brand
    AND b~model      = d~car_model
    AND b~model_year = d~car_year
  INTO TABLE @DATA(t_car_left).


DATA s_car_left LIKE LINE OF t_car_left.

LOOP AT t_car_left INTO s_car_left.
  WRITE:/ s_car_left-brand,      s_car_left-model,
          s_car_left-model_year, s_car_left-surname,
          s_car_left-name.
ENDLOOP.
```

_Résultat de la requête_

| **BRAND**  | **MODEL** | **MODEL_YEAR** | **SURNAME** | **NAME** |
| ---------- | --------- | -------------- | ----------- | -------- |
| PEUGEOT    | 307       | 2011           | DEBBACHE    | AMINH    |
| AUDI       | A3        | 2016           | ALDAIR      | PAULA    |
| FORD       | ESCORT    | 2013           | PILON       | BEATRIZ  |
| CITROEN    | C5        | 2012           | OLIVEIRA    | JOSE     |
| PEUGEOT    | 208       | 2012           |             |          |
| VOLKSWAGEN | GOLD      | 2015           |             |          |
| RENAULT    | MEGANE    | 2013           |             |          |

_Résultat à l'écran_

![](../../99%20-%20Ressources/09_Instructions_dbtab%20-%2001%20-%2019%20-%2002.png)

Toutes les données de la table `ZCAR_BRAND_MOD` sont affichées et dans les cas où aucune données n'est trouvée dans la table `ZDRIVER_CAR`, la requête affichera des valeurs nulles.

## **RIGHT JOIN**

_Exemple_

_Pour chaque enregistrement contenu dans la table `ZCAR_RAND_MODEL`, une requête affichera le conducteur._

```JS
SELECT d~surname,
       d~name,
       b~brand,
       b~model,
       b~model_year
  FROM zdriver_car AS d RIGHT JOIN zcar_brand_mod AS b
    ON  d~car_brand = b~brand
    AND d~car_model = b~model
    AND d~car_year  = b~model_year
  INTO TABLE @DATA(t_car_right).


DATA s_car_right LIKE LINE OF t_car_right.

LOOP AT t_car_right INTO s_car_right.
  WRITE:/ s_car_right-brand,      s_car_right-model,
          s_car_right-model_year, s_car_right-surname,
          s_car_right-name.
ENDLOOP.
```

_Résultat de la requête_

| **BRAND** | **MODEL** | **MODEL_YEAR** | **SURNAME** | **NAME** |
| --------- | --------- | -------------- | ----------- | -------- |
| DEBBACHE  | AMINH     | PEUGEOT        | 307         | 2011     |
| ALDAIR    | PAULA     | AUDI           | 13          | 2016     |
| PILON     | BEATRIZ   | FORD           | ESCORT      | 2013     |
| OLIVEIRA  | JOSE      | CITROEN        | C5          | 2012     |
|           |           | PEUGEOT        | 208         | 2012     |
|           |           | VOLKSWAGEN     | GOLF        | 2015     |
|           |           | RENAULT        | MEGANE      | 2013     |

L'ordre d'affichage des méthodes a été remanié pour que ce soit un peu plus clair ainsi que la jonction des tables (sinon le `RIGHT JOIN` n'aurait pas fonctionné et agirait comme un `INNER JOIN`).

Maintenant que les jonctions de table avec le `JOIN` ont été vues, il serait intéressant de revenir sur la fonction dite "de remplissage" ([`COALESCE`](../../09%20-%20Instructions_dbtab/01%20-%20select/16%20-%20select%20coalesce.md)) mentionnée dans la partie des expressions `SQL` du `SELECT`.

_Pour rappel, l'instruction est définir ainsi :_

```JS
coalesce( obj1, obj2 )
```

Et permet d'afficher l'objet `obj1` (que ce soit la valeur d'un champ, d'une expression arithmétique...) mais si cette valeur est nulle, elle affichera ce qui est défini dans `obj2`.

En reprenant cette fonction pour qu'au lieu d'afficher un champ vide, la valeur `X` apparaisse :

```JS
SELECT b~brand,
       b~model,
       b~model_year,
       COALESCE( d~surname, 'X' ) AS surname,
       COALESCE( d~name, 'X' )    AS name
  FROM zcar_brand_mod AS b LEFT JOIN zdriver_car AS d
    ON  b~brand      = d~car_brand
    AND b~model      = d~car_model
    AND b~model_year = d~car_year
  INTO TABLE @DATA(t_car_left).


DATA s_car_left LIKE LINE OF t_car_left.

LOOP AT t_car_left INTO s_car_left.
  WRITE:/ s_car_left-brand,      s_car_left-model,
          s_car_left-model_year, s_car_left-surname,
          s_car_left-name.
ENDLOOP.
```

_Résultat de la requête_

| **BRAND**  | **MODEL** | **MODEL_YEAR** | **SURNAME** | **NAME** |
| ---------- | --------- | -------------- | ----------- | -------- |
| PEUGEOT    | 307       | 2011           | DEBBACHE    | AMINH    |
| AUDI       | A3        | 2016           | ALDAIR      | PAULA    |
| FORD       | ESCORT    | 2013           | PILON       | BEATRIZ  |
| CITROEN    | C5        | 2012           | OLIVEIRA    | JOSE     |
| PEUGEOT    | 208       | 2012           | X           | X        |
| VOLKSWAGEN | GOLD      | 2015           | X           | X        |
| RENAULT    | MEGANE    | 2013           | X           | X        |

_Résultat à l'écran_

![](../../99%20-%20Ressources/09_Instructions_dbtab%20-%2001%20-%2019%20-%2004.png)
