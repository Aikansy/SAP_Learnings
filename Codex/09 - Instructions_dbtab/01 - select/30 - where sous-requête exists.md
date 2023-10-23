# **`WHERE EXISTS`**

```JS
EXISTS ss_requête
```

Ici, la sélection va vérifier la validité d'un résultat s'il appartient à une sous-requête.

_Exemple_

_Afficher le nom et le prénom de tous les conducteurs utilisant également le coivoiturage en tant que passager._

```JS
SELECT surname,
       name,
       date_birth,
       city,
       country
  FROM zdriver_car AS d
  INTO TABLE @DATA(t_driver)
  WHERE EXISTS ( SELECT * FROM zpassenger
                   WHERE surname = d~surname
                     AND name    = d~name ).


DATA s_driver LIKE LINE OF t_driver.

LOOP AT t_driver INTO s_driver.
  WRITE:/ s_driver-surname, s_driver-name, s_driver-date_birth,
          s_driver-city,    s_driver-country.
ENDLOOP.
```

_Résultat de la requête_

![](../../99%20-%20Ressources/09_Instructions_dbtab%20-%2001%20-%2030%20-%2001.png)

A noter qu'un [`alias`]() pour la table `ZDRIVER_CAR` a été créé afin qu'il n'y ait pas d'ambiguïté dans la sous-requête.
