# **`SELECT ALL`**

L’option `*` signifie `tous les champs` et donc cette requête indique : sélectionner tous les champs du premier enregistrement de la table `ZDRIVER_CAR` et stocker dans la structure `S_DRIVER_CAR`.

> Le symbole `@` défini comme `escape character` en anglais (se traduisant par `caractère d’évasion`) indique simplement que la `variable`, `table interne` ou `structure` fait partie des objets du programme et est donc externe à la `base de données`.

**Résultat - structure S_DRIVER_CAR**

| **CHAMPS**     | **VALEURS** |
| -------------- | ----------- |
| **MANDT**      | 900         |
| **ID_DRIVER**  | C0001       |
| **SURNAME**    | DEBBACHE    |
| **NAME**       | AMINH       |
| **DATE_BIRTH** | 19781216    |
| **CITY**       | TOULOUSE    |
| **COUNTRY**    | FR          |
| **CAR_BRAND**  | PEUGEOT     |
| **CAR_MODEL**  | 307         |
| **CAR_YEAR**   | 2011        |
| **CAR_COLOR**  | NOIR        |
| **CAR_ID**     | FB243TR     |
| **LANG**       | F           |

## STOCKAGE

Il est possible également de stocker cette information dans une ou plusieurs variables en informant directement le ou les noms de colonnes :

### Sélection du nom du conducteur.

_Exemple_

```JS
DATA v_surname TYPE zdriver_car-surname.

SELECT SINGLE surname
    FROM zdriver_car
    INTO @v_surname.
```

Sélectionner le champ `SURNAME` de la table `ZDRIVER_NAME` et le stocker dans la variable `V_SURNAME`. COmme la condition de sélection n'est pas définie, le nom du conducteur de la première ligne de la table sera retourné dans la variable, à savoir la valeur `DEBBACHE`.

### Sélection du nom et du prénom du conducteur

_Exemple_

```JS
DATA: v_surname TYPE zdriver_car-surname,
      v_name    TYPE zdriver_car-name.

SELECT SINGLE surname, name
    FROM zdriver_car
    INTO (@v_surname, @v_name).
```

Sélectionner les champs `SURNAME` et `NAME` de la table `ZDRIVER_CAR` et les stocker respectivement dans les variables `V_SURNAME` et `V_NAME`. Comme la condition de sélection n’est pas définie, le nom et le prénom du conducteur de la première ligne de la table seront retournés dans les variables.

_Résultat - Valeurs des variables_

| **CHAMPS**    | **VALEURS** |
| ------------- | ----------- |
| **V_SURNAME** | DEBBACHE    |
| **V_NAME**    | AMINH       |

> Dans l'ancien code `SQL`, les colonnes étaient séparées par un espace, mais avec le nouveau, elles doivent être séparées par des virgules.
