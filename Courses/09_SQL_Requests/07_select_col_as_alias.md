# **`COL AS ALIAS`**

Cette option permet de renommer des colonnes pour un titre un peu plus significaif.

_Exemple_

_Reprendre l'exemple précédent du `DISTINCT` en donnant un alias aux colonnes._

```JS
TYPES: BEGIN OF ty_driver_car,
         marque TYPE wrf_brand_descr,
         model  TYPE vlc_maktx,
       END OF ty_driver_car.

DATA: t_driver_car TYPE TABLE OF ty_driver_car,
      s_driver_car TYPE ty_driver_car.

SELECT DISTINCT car_brand AS marque,
                car_model AS model
    FROM zdriver_car
    INTO TABLE @t_driver_car.

LOOP AT t_driver_car INTO s_driver_car.
  WRITE:/ s_driver_car-marque, s_driver_car-model.
ENDLOOP.
```

Le résultat sera le même que celui de l'exemple du `DISTINCT`.
