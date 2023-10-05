# **PROGRAMMATION**

## **LEFT JOIN**

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

Pour chaque enregistrement contenu dans la table **ZCAR_BRAND_MODEL**, une requête affichera le conducteur avec l’utilisation du LEFT JOIN.

```ABAP
SELECT b~brand,
       b~model,
       b~model_year,
       d~surname,
       d~name
  FROM zcar_brand_mod AS b LEFT JOIN zdriver_car AS d
    ON  b~brand      = d~car_brand
    AND b~model      = d~car_model
    AND b~model_year = d~car_year
  INTO TABLE @DATA(lt_car_left).


DATA ls_car_left LIKE LINE OF lt_car_left.

LOOP AT lt_car_left INTO ls_car_left.
  WRITE:/ ls_car_left-brand,      ls_car_left-model,
          ls_car_left-model_year, ls_car_left-surname,
          ls_car_left-name.
ENDLOOP.
```

| **BRAND**  | **MODEL** | **MODEL_YEAR** | **SURNAME** | **NAME** |
| ---------- | --------- | -------------- | ----------- | -------- |
| PEUGEOT    | 307       | 2011           | DEBBACHE    | AMINH    |
| AUDI       | A3        | 2016           | ALDAI       | PAULA    |
| FORD       | ESCORT    | 2013           | PILON       | BEATRIZ  |
| CITROEN    | C5        | 2012           | OLIVEIRA    | JOSE     |
| PEUGEOT    | 208       | 2012           |             |          |
| VOLSKWAGEN | GOLF      | 2015           |             |          |
| RENAULT    | MEGANE    | 2013           |             |          |

Toutes les données de la table **ZCAR_BRAND_MOD** sont affichées et dans les cas où aucune donnée n’est trouvée dans la table **ZDRIVER_CAR**, la requête affichera des valeurs nulles.
