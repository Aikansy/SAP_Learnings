# **PROGRAMMATION**

## **CAST**

Elle convertit un champ en nombre à virgule flottante (type FLTP).

_Exemple_

Calcul de la vitesse moyenne du véhicule pendant un trajet.

```ABAP
CONSTANTS: c_60(2) TYPE i VALUE '60'.

SELECT city_from,
       city_to,
       kms,
       duration,
       CAST( kms AS FLTP ) * CAST( @c_60 AS FLTP )
/ CAST( duration AS FLTP ) AS vitesse
  FROM ztravel
  INTO TABLE @DATA(lt_cast).

DATA: ls_cast LIKE LINE OF lt_cast.

LOOP AT lt_cast INTO ls_cast.
  WRITE:/ ls_cast-city_from, ls_cast-city_to, ls_cast-kms,
          ls_cast-duration,  ls_cast-vitesse.
ENDLOOP.
```

La constante de type entier d’une longueur de 2 positions a été créée contenant la valeur fixe **’60’**. La sélection va importer les champs **CITY_FROM**, **CITY_TO**, **KMS** et **DURATION** pour ensuite calculer la vitesse du véhicule en convertissant en nombre à virgule flottante, les champs **KMS**, **DURATION** et la variable **C_60** avec le **CAST** dont le résultat sera stocké dans la colonne **VITESSE**.

Une fois de plus, grâce à l’instruction **@DATA**, la table interne sera créée automatiquement et contiendra les valeurs suivantes, qui seront ensuite affichées à l’écran après avoir déclaré une structure :

| **CITY_FROM** | **CITY_TO** | **KMS** | **DURATION** | **VITESSE**            |
| ------------- | ----------- | ------- | ------------ | ---------------------- |
| PERPIGNAN     | BARCELONE   | 195     | 130          | 9.0000000000000000E+01 |
| BARCELONE     | PERPIGNAN   | 194     | 150          | 7.7500000000000000E+01 |
| TOULOUSE      | PERPIGNAN   | 205     | 140          | 8.7857142857142847E+01 |
| BARCELONE     | LERIDA      | 170     | 100          | 1.02000000000000000+02 |

Le résultat sera de type **FLTP** également et devra être retravaillé par la suite pour une meilleure visibilité de la valeur comme par exemple, en la stockant dans une variable à virgule à deux décimales et en l’affichant ensuite dans le **LOOP**.

```ABAP
DATA:      lv_vit   TYPE p DECIMALS 2.
CONSTANTS: c_60(2)  TYPE i VALUE '60'.

SELECT city_from,
       city_to,
       kms,
       duration,
       CAST( kms AS FLTP ) * CAST( @c_60 AS FLTP ) /
CAST( duration AS FLTP ) AS vitesse
  FROM ztravel
  INTO TABLE @DATA(lt_cast).

DATA: ls_cast LIKE LINE OF lt_cast.

LOOP AT lt_cast INTO s_cast.
  CLEAR lv_vit.                "Nettoyage de la variable
  lv_vit = ls_cast-vitesse.    "Transférer la valeur de VITESSE
                               "dans la variable V_VIT

  WRITE:/ ls_cast-city_from, ls_cast-city_to, ls_cast-kms,
          ls_cast-duration,  lv_vit.

ENDLOOP.
```

[Schéma - Résultat](https://drive.google.com/file/d/1b-aB1OndZ9ofhbqFv2V1ufI38ixZJUn3/view?usp=share_link)
