# **`SELECT SINGLE [FOR UPDATE]`**

Cette option permet de sélectionner une seule ligne de la table déclarée dans le `FROM`. Bien entendu, le stockage défini dans le `INTO` ne peut être une `table interne` et sera nécessairement une `structure` ou une `liste de variables`.

_Exemple_

```JS
DATA s_driver_car TYPE zdriver_car.

SELECT SINGLE *
    FROM zdriver_car
    INTO @s_driver_car.
```

## `*` ALL

L’option `*` signifie `tous les champs` et donc cette requête indique : sélectionner tous les champs du premier enregistrement de la table `ZDRIVER_CAR` et stocker dans la structure `S_DRIVER_CAR`.
