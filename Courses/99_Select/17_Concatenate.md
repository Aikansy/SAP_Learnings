# **PROGRAMMATION**

## **CONCATENATE**

Comme l’instruction **CONCATENATE** (cf. chapitre Instructions basiques **ABAP** - Opérations sur variable texte), cette fonction concatène deux ou plusieurs objets. Ces objets peuvent être une colonne d’une table, une variable…

_Exemple_

Dans la table des conducteurs **ZDRIVER_CAR**, afficher deux colonnes : la première contenant le nom et le prénom du conducteur et la deuxième, la marque et le modèle de la voiture :

```ABAP
SELECT surname   && @space && name      AS driver,
       car_brand && @space && car_model AS car
  FROM zdriver_car
  INTO TABLE @DATA(lt_drivers).

DATA ls_drivers LIKE LINE OF t_drivers.

LOOP AT lt_drivers INTO ls_drivers.
  WRITE:/ ls_drivers-driver, ls_drivers-car.
ENDLOOP.
```

| **DRIVER**     | **CAR**     |
| -------------- | ----------- |
| DEBBACHE AMINH | PEUGEOT 307 |
| ALDAIR PAULA   | AUDI A3     |
| PILON BEATRIZ  | FORD ESCORT |
| OLIVEIRA JOSE  | CITROEN C5  |
