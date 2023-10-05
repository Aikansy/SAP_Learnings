# **PROGRAMMATION**

## **RIGHT JOIN**

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

Pour chaque enregistrement contenu dans la table **ZCAR_BRAND_MODEL**, une requête affichera le conducteur avec l’utilisation du RIGHT JOIN.

```ABAP
SELECT d~surname,
       d~name,
       b~brand,
       b~model,
       b~model_year
  FROM zdriver_car AS d RIGHT JOIN zcar_brand_mod AS b
    ON  d~car_brand = b~brand
    AND d~car_model = b~model
    AND d~car_year  = b~model_year
  INTO TABLE @DATA(lt_car_right).


DATA ls_car_right LIKE LINE OF lt_car_right.

LOOP AT lt_car_right INTO ls_car_right.
  WRITE:/ ls_car_right-brand,      ls_car_right-model,
          ls_car_right-model_year, ls_car_right-surname,
          ls_car_right-name.
ENDLOOP.
```

| **BRAND** | **MODEL** | **MODEL_YEAR** | **SURNAME** | **NAME** |
| --------- | --------- | -------------- | ----------- | -------- |
| DEBBACHE  | AMINH     | PEUGEOT        | 307         | 2011     |
| ALDAIT    | PAULA     | AUDI           | A3          | 2016     |
| PILON     | BEATRIZ   | FORD           | ESCORT      | 2013     |
| OLIVEIRA  | JOSE      | CITROEN        | C5          | 2012     |
|           |           | PEUGEOT        | 208         | 2012     |
|           |           | VOLKSWAGEN     | GOLF        | 2015     |
|           |           | RENAULT        | MEGANE      | 2013     |

L’ordre d’affichage des colonnes a été remanié pour que ce soit un peu plus clair ainsi que la jonction des tables (sinon le RIGHT JOIN n’aurait pas fonctionné et agirait comme un INNER JOIN).
