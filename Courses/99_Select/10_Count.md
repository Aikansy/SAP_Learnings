# **PROGRAMMATION**

## **COUNT**

Il s’agit ici d’un compteur retournant le nombre d’occurrences d’une colonne donnée. Si pour les autres agrégats, **DISTINCT** était une option, ici c’est un paramètre obligatoire dans le cas où le nom de la colonne a été spécifié. Ainsi, pour savoir combien il existe de villes de destination différentes, la requête suivante peut être utilisée :

_Exemple_

```ABAP
DATA lv_count TYPE i.

SELECT COUNT( DISTINCT city_to )
  FROM ztravel
  INTO @lv_count.
```

Selon les valeurs enregistrées dans le chapitre Dictionnaire de données (**DDIC**), **LV_COUNT** aura la valeur de 3.

## **COUNT( \* )**

Permet de compter tout simplement les lignes d’une table.

_Exemple_

```ABAP
DATA lv_count TYPE i.

SELECT COUNT( * )
  FROM zcar_brand_mod
  INTO @lv_count.
```

Le résultat obtenu sera de sept occurrences dans la table **ZCAR_BRAND_MOD**.

Il est possible aussi d’utiliser plusieurs de ces fonctions d’agrégats dans une requête unique.

_Exemple_

```ABAP
TYPES: BEGIN OF ty_driver_infos,
         id    TYPE zdriver_id,
         total TYPE ztravel_toll,
         moy   TYPE ztravel_toll,
         max   TYPE n1dauer,
         min   TYPE n1dauer,
       END OF ty_driver_infos.

DATA: lt_driver_infos TYPE TABLE OF ty_driver_infos,
      ls_driver_infos TYPE ty_driver_infos.

SELECT id_driver       AS id,
       SUM( toll )     AS total,
       AVG( toll )     AS moy,
       MAX( duration ) AS max,
       MIN( duration ) AS min
  FROM ztravel
  INTO TABLE @lt_driver_infos
  GROUP BY id_driver.

LOOP AT lt_driver_infos INTO ls_driver_infos.
  WRITE:/ ls_driver_infos-id,  ls_driver_infos-total,
          ls_driver_infos-moy, ls_driver_infos-max,
          ls_driver_infos-min.
ENDLOOP.
```

La table interne LT_DRIVER_INFOS aura les informations suivantes :

| **ID** | **TOTAL** | **MOY** | **MAX** | **MIN** |
| ------ | --------- | ------- | ------- | ------- |
| C0002  | 6.00      | 6.00    | 100     | 100     |
| C0003  | 33.00     | 16.50   | 150     | 130     |
| C0001  | 16.00     | 16.00   | 140     | 140     |

[Schéma - Résultat](https://drive.google.com/file/d/1ogVm55FVtYAzq1ugka2RDBTRuGrNNxu5/view?usp=share_link)
