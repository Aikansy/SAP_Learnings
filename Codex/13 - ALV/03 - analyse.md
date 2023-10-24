# **`ANALYSE`**

Toutes les informations nécessaires sont renseignées, à savoir le point de départ (détail des zones de l’écran de sélection), le but du développement ainsi que les champs avec leur référence, à afficher dans le `rapport ALV`.

Parfois, apparaissent aussi les liens entre les tables comme :

- Lien des clés de table pour la recherche des nom et prénom du conducteur :

  `ZTRAVEL-ID_DRIVER` = `ZDRIVER_CAR-ID_DRIVER`

- Lien des clés de table pour la recherche des nom et prénom du passager :

  `ZTRAVEL-ID_PASSENGER1` = `ZPASSENGER-ID_PASSENGER`

  `ZTRAVEL-ID_PASSENGER2` = `ZPASSENGER-ID_PASSENGER`

  `ZTRAVEL-ID_PASSENGER3` = `ZPASSENGER-ID_PASSENGER`

Avec cette demande reçue, il faudra créer les objets suivants :

- Un programme qui sera nommé `ZALV_TRAVEL`.

- Une `transaction` pour exécuter le programme, nommée de la même manière.

- Une `structure` qui sera prise comme référence pour la construction du rapport.
