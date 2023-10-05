# **PROGRAMMATION**

## **SINGLE**

Cette option permet de sélectionner une seule ligne de la table déclarée dans le **FROM**. Bien entendu, le stockage défini dans le **INTO** ne peut être une table interne et sera nécessairement une structure ou une liste de variables.

_Exemple_

```ABAP
DATA: ls_driver_car TYPE zdriver_car.

SELECT SINGLE *
    FROM zdriver_car
    INTO @s_driver_car.
```

L’option **"\*"** signifie **’tous les champs’** et donc cette requête indique : sélectionner tous les champs du premier enregistrement de la table **ZDRIVER_CAR** et stocker dans la structure **S_DRIVER_CAR**.

Le symbole **’@’** défini comme **escape character** en anglais (se traduisant par **caractère d’évasion**) indique simplement que la variable, table interne ou structure fait partie des objets du programme et est donc externe à la base de données.

Structure S_DRIVER_CAR

| **MANDT**  | **900**  |
| ---------- | -------- |
| ID_DRIVER  | C0001    |
| SURNAME    | DEBBACHE |
| NAME       | AMINH    |
| DATE_BIRTH | 19781216 |
| CITY       | TOULOUSE |
| COUNTRY    | FR       |
| CAR_BRAND  | PEAUGEOT |
| CAR_MODEL  | 307      |
| CAR_YEAR   | 2011     |
| CAR_COLOR  | NOIR     |
| CAR_ID     | FB243TR  |
| LANG       | FR       |

Il est possible également de stocker cette information dans une ou plusieurs variables en informant directement le ou les noms de colonnes :

_Exemple_

Sélection du nom du conducteur.

```ABAP
DATA: lv_surname TYPE zdriver_car-surname.

SELECT SINGLE surname
    FROM zdriver_car
    INTO @lv_surname.
```

Sélectionner le champ SURNAME de la table ZDRIVER_NAME et le stocker dans la variable V_SURNAME. Comme la condition de sélection n’est pas définie, le nom du conducteur de la première ligne de la table sera retourné dans la variable à savoir la valeur ’DEBBACHE’.

_Exemple_

Sélection du nom et du prénom du conducteur.

```ABAP
DATA: lv_surname TYPE zdriver_car-surname,
      lv_name    TYPE zdriver_car-name.

SELECT SINGLE surname, name
    FROM zdriver_car
    INTO (@lv_surname, @lv_name).
```

Sélectionner les champs **SURNAME** et **NAME** de la table **ZDRIVER_CAR** et les stocker respectivement dans les variables **LV_SURNAME** et **LV_NAME**. Comme la condition de sélection n’est pas définie, le nom et le prénom du conducteur de la première ligne de la table seront retournés dans les variables.

Résultat - Valeurs des variables

| **VARIABLE** | **VALEUR** |
| ------------ | ---------- |
| LV_SURNAME   | DEBBACHE   |
| LV_NAME      | AMINH      |
