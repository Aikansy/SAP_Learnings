# **PROGRAMMATION**

## **INNER JOIN**

Il n’existe pas de nombreuses variantes du **FROM** mais une doit particulièrement être étudiée : le **JOIN**.

L’option facultative **OUTER** a été mentionnée pour information mais elle n’apporte absolument rien de plus, donc en résumé **LEFT OUTER JOIN** est exactement la même chose que **LEFT JOIN**, et **RIGHT OUTER JOIN** est exactement la même chose que **RIGHT JOIN**.

```ABAP
. . .FROM table1 INNER JOIN table2. . . ON. . .
. . .FROM table1 LEFT [OUTER] JOIN table2. . . ON. . .
. . .FROM table1 RIGHT [OUTER] JOIN table2. . . ON. . .
```

Il s’agit de sélectionner des données contenues dans deux tables différentes (**JOIN**) associées par un ou plusieurs champs en commun (définis par le **ON**).

Ainsi avec **INNER JOIN**, ne seront sélectionnées que les données communes aux deux tables, **LEFT JOIN **sélectionnera toutes les données de **table1** (située à gauche de la syntaxe) et affichera les données de **table2** ou les affichera vides si elles n’existent pas, et enfin le **RIGHT JOIN** fonctionne exactement de la même façon sauf qu’il s’agira de la table située à droite de l’instruction (ici **table2**).

Pour aider à comprendre cette notion, le schéma suivant illustre les différentes options.

[Schéma - Système Join](https://drive.google.com/file/d/1tTUHBQJi34hXZXkcJ6sgJx1bwLVc8yuW/view?usp=share_link)

_Exemple_

Pour chaque enregistrement contenu dans la table **ZCAR_BRAND_MODEL**, une requête affichera le conducteur. Tout d’abord avec le **INNER JOIN** :

```ABAP
SELECT zcar_brand_mod~brand,
       zcar_brand_mod~model,
       zcar_brand_mod~model_year,
       zdriver_car~surname,
       zdriver_car~name
  FROM zcar_brand_mod INNER JOIN zdriver_car
    ON zcar_brand_mod~brand       = zdriver_car~car_brand
    AND zcar_brand_mod~model      = zdriver_car~car_model
    AND zcar_brand_mod~model_year = zdriver_car~car_year
  INTO TABLE @DATA(lt_car).


DATA ls_car LIKE LINE OF lt_car.

LOOP AT lt_car INTO ls_car.
  WRITE:/ ls_car-brand,   ls_car-model, ls_car-model_year,
          ls_car-surname, ls_car-name.
ENDLOOP.
```

Les champs suivants sont sélectionnés : **BRAND**, **MODEL** et **YEAR** de la table **ZCAR_BRAND_MOD**, et **SURNAME** et **NAME** de la table **ZDRIVER_CAR**. Avec le **FROM**, les noms des tables source sont ensuite définis ainsi que leur modèle de jonction (**INNER JOIN**), et leur jointure basée sur trois champs communs : la marque (**BRAND** / **CAR_BRAND**), le modèle (**MODEL** / **CAR_MODEL**) et l’année (**MODEL_YEAR** / **CAR_YEAR**). La requête stockera le résultat dans la table interne **LT_CAR**.

Comme **OpenSQL** ne peut pas identifier quel champ appartient à quelle table, il est nécessaire dans un **JOIN** de lui indiquer la provenance avec le nom de la table, un tilde (~) et le nom de la colonne.

Cependant, il n’est pas très facile de lire cette requête et comme pour le nom des colonnes, il est possible d’utiliser un alias pour les tables. Ainsi la requête peut se réécrire :

```ABAP
SELECT b~brand,
       b~model,
       b~model_year,
       d~surname,
       d~name
  FROM zcar_brand_mod AS b INNER JOIN zdriver_car AS d
    ON  b~brand      = d~car_brand
    AND b~model      = d~car_model
    AND b~model_year = d~car_year
  INTO TABLE @DATA(lt_car).


DATA ls_car LIKE LINE OF lt_car.

LOOP AT lt_car INTO ls_car.
  WRITE:/ ls_car-brand,   ls_car-model, ls_car-model_year,
          ls_car-surname, ls_car-name.
ENDLOOP.
```

Maintenant la table **ZCAR_BRAND_MOD** utilise l’alias **b** et **ZDRIVER_CAR** utilise **d**, et toutes les références à ces deux tables utiliseront désormais ces alias, rendant donc la requête beaucoup plus lisible.

| **BRAND** | **MODEL** | **MODEL_YEAR** | **SURNAME** | **NAME** |
| --------- | --------- | -------------- | ----------- | -------- |
| PEUGEOT   | 307       | 2011           | DEBBACHE    | AMINH    |
| AUDI      | A3        | 2016           | ALDAI       | PAULA    |
| FORD      | ESCORT    | 2013           | PILON       | BEATRIZ  |
| CITROEN   | C5        | 2012           | OLIVEIRA    | JOSE     |
