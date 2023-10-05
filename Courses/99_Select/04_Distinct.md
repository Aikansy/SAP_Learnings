# **PROGRAMMATION**

## **DISTINCT**

Avec la fonctionnalité **DISTINCT**, la sélection va éviter tous les doublons dans les valeurs des champs visés.

_Exemple_

Sélectionner toutes les marques et les modèles des voitures enregistrés dans la table des conducteurs :

```ABAP
TYPES: BEGIN OF ty_driver_car,
         car_brand TYPE wrf_brand_descr,
         car_model TYPE vlc_maktx,
       END OF ty_driver_car.

DATA: lt_driver_car TYPE TABLE OF ty_driver_car,
      ls_driver_car TYPE ty_driver_car.

SELECT DISTINCT car_brand, car_model
    FROM zdriver_car
    INTO TABLE @lt_driver_car.

LOOP AT lt_driver_car INTO ls_driver_car.
  WRITE:/ ls_driver_car-car_brand, ls_driver_car-car_model.
ENDLOOP.
```

Grâce au **DISTINCT**, la sélection va importer les champs **CAR_BRAND** et **CAR_MODEL** de la table **ZDRIVER_CAR** sans aucun doublon, obtenant ainsi une liste claire des véhicules disponibles pour le covoiturage. Le résultat de cette requête sera stocké dans la table **LT_DRIVER_CAR** définie par le type **TY_DRIVER_CAR**, contenant les deux champs de la sélection. Une boucle **LOOP** permettra d’afficher le résultat à l’écran.

[Shcéma - Résultat](https://drive.google.com/file/d/18G97CnYVQ6qvh5oJ1eFne5VEW9PAq-Kf/view?usp=share_link)
