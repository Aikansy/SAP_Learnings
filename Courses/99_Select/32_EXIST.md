# **PROGRAMMATION**

## **EXISTS**

Ici, la sélection va vérifier la validité d’un résultat s’il appartient à une sous-requête.

_Exemple_

Afficher le nom et le prénom de tous les conducteurs utilisant également le covoiturage en tant que passager.

```ABAP
SELECT surname,
       name,
       date_birth,
       city,
       country
  FROM zdriver_car AS d
  INTO TABLE @DATA(lt_driver)
  WHERE EXISTS ( SELECT * FROM zpassenger
                   WHERE surname = d~surname
                     AND name    = d~name ).

DATA ls_driver LIKE LINE OF lt_driver.

LOOP AT lt_driver INTO ls_driver.
  WRITE:/ ls_driver-surname, ls_driver-name, ls_driver-date_birth,
          ls_driver-city,    ls_driver-country.
ENDLOOP.
```

| **SURNAME** | **NAME** | **DATE_BIRTH** | **CITY**  | **COUNTRY** |
| ----------- | -------- | -------------- | --------- | ----------- |
| OLIVEIRA    | JOSE     | 19781106       | BARCELONE | ES          |

## **IN SS_REQUETE**

À noter qu’un alias pour la table **ZDRIVER_CAR** a été créé afin qu’il n’y ait pas d’ambiguïté dans la sous-requête.

Cette option permet de contrôler si la valeur d’une colonne fait partie (**IN**) ou non (**NOT IN**) d’une sous-requête.

_Exemple_

Afficher la ville et le pays de destination qui n’existent pas dans la table des conducteurs et des passagers.

```ABAP
SELECT city_to && ', ' && country_to AS city_ctry
  FROM ztravel AS t
  INTO TABLE @DATA(lt_city)
  WHERE city_to NOT IN ( SELECT city
                           FROM zdriver_car
                           WHERE city = t~city_to )
    AND city_to NOT IN ( SELECT city
                           FROM zpassenger
                           WHERE city = t~city_to ).

DATA ls_city LIKE LINE OF lt_city.

LOOP AT lt_city INTO ls_city.
  WRITE:/ ls_city-city_ctry.
ENDLOOP.
```

| **CITY_COUNTRY** |
| ---------------- |
| LERIDA,ES        |
