# **`DEMANDE`**

La demande suivante est parvenue via un document fonctionnel : créer un rapport de type `ALV` listant tous les voyages de la `table ZTRAVEL`. Il devra comporter les champs suivants :

_Zones Rapport ALV_

| **DESIGNATION**             | **TABLE**   | **CHAMP**    |
| --------------------------- | ----------- | ------------ |
| `Date du voyage`            | ZTRAVEL     | DATE_TRAVEL  |
| `Ville de départ`           | ZTRAVEL     | CITY_FROM    |
| `Pays de départ`            | ZTRAVEL     | COUNTRY_FROM |
| `Ville d'arrivée`           | ZTRAVEL     | CITY_TO      |
| `Pays d'arrivée`            | ZTRAVEL     | COUNTRY_TO   |
| `Nom & Prénom conducteur`   | ZDRIVER_CAR | SURNAME NAME |
| `Marque du véhicule`        | ZDRIVER_CAR | CAR_BRAND    |
| `Modèle du véhicule`        | ZDRIVER_CAR | CAR_MODEL    |
| `Nom & Prénom 1er passager` | ZPASSENGER  | SURNAME NAME |
| `Nom & Prénom 2e passager`  | ZPASSENGER  | SURNAME NAME |
| `Nom & Prénom 3e passager`  | ZPASSENGER  | SURNAME NAME |
| `Distance parcourue`        | ZTRAVEL     | KMS          |
| `Unité distance`            | ZTRAVEL     | KMS_UNIT     |
| `Péage`                     | ZTRAVEL     | TOLL         |
| `Essence`                   | ZTRAVEL     | GASOL        |
| `Unité coûts`               | ZTRAVEL     | UNIT         |

L’écran de sélection devra permettre de filtrer la sélection selon :

1. La `date du voyage` (ZTRAVEL-DATE_TRAVEL) - Intervalle de valeurs.

2. La `ville de départ` (ZTRAVEL-CITY_FROM) - Intervalle de valeurs.

3. La `ville d’arrivée` (ZTRAVEL-CITY_TO) - Intervalle de valeurs.

Aucune zone n’est obligatoire.
