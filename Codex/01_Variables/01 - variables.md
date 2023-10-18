# **`VARIABLES`**

`ABAP` contient des `variables` et des `constantes`. Par définition, une `variable` est un symbole informatique associant un nom à une valeur qui peut varier durant l’exécution du programme. Cette définition s’applique également à une constante, à la différence près que sa valeur est fixée dès le début et ne changera jamais au cours de l’exécution du programme.

On retrouve sur `SAP` les types de `variables` suivants :

_Types de `variables ABAP` :_

| **Type**  | **Description**       | **Default length** | **Default value** | **Value**    |
| --------- | --------------------- | ------------------ | ----------------- | ------------ |
| `C`       | _Alphanumeric string_ | 1                  | "                 | `'ABC012'`   |
| `N`       | _Numeric_             | 1                  | 0                 | `5`          |
| `D`       | _Date_                | 8                  | 00000000          | `20090412`   |
| `T`       | _Hour_                | 6                  | 000000            | `134523`     |
| `X`       | _Hexadecimal_         | 1                  | X'0'              | `65AF`       |
| `I`       | _Integer_             | 4                  | 0                 | `5`          |
| `P`       | _Decimal number_      | 8                  | 0                 | `5.6`        |
| `F`       | _Scientific format_   | 8                  | 0                 | `2.2 E+209`  |
| `STRING`  | _Long text_           | Any length         | "                 | `Any string` |
| `XSTRING` | _Hexadecimal string_  | Any length         |                   | `Any string` |

## **TYPE ou LIKE**

l’instruction de référence peut être égale à `TYPE` ou `LIKE`. Pour comprendre la différence entre les deux, voici un exemple :

```JS
DATA: lv_name(10) TYPE c,
      lv_name2    LIKE v_name.
```

La variable `LV_NAME` est déclarée avec un type chaîne de caractères et de longueur `10` et `LV_NAME2` quant à elle prend comme référence la variable `LV_NAME`. Ainsi, `TYPE` va pointer directement vers un type spécifique alors que le `LIKE` va en prendre indirectement une `référence`. Dans une `programmation objet` (cf. chapitre Les classes), le `TYPE` est à `privilégier`.

## **CHAR**

```JS
DATA: lv_char TYPE CHAR255,
      lv_name(10) TYPE C.
* lv_char = 'Frederic'.
* lv_name = 'Frederic GIUSTINI'.              Reverra 'Frederic G' uniquement
```

## **INTEGER & NUMERIC**

Si le type entier I et le type numérique N sont comparés, il apparaît qu’ils sont sensiblement les mêmes :

- le type entier `I` est une chaîne numérique de nombres entiers.
- Le type numérique `N` est aussi une chaîne numérique mais stockée sous forme de caractères, ce qui est pratique lors d’un travail avec des instructions sur des variables texte comme le `CONCATENATE`

```JS
DATA: lv_integer TYPE I,
      lv_year TYPE N.

* lv_integer = 10.
```

## **DATE** - AAAAMMJJ

> Le format date [sy-datum](../99_Help/02_SY-SYSTEM.md) est de type `AnnéeMoisJour` (`AAAAMMJJ`), pour un affichage plus adéquat, il faudra toujours modifier la variable date.

```JS
DATA: lv_date TYPE d.

* lv_date = sy-datum.
* lv_date = 19861102.
```

## **TIME** - HHMMSS

> Le format time [sy-uzeit](../99_Help/02_SY-SYSTEM.md) est de type `HeuresMinutesSecondes` (`AAAAMMJJ`), pour un affichage plus adéquat, il faudra toujours modifier la variable date.

```JS
DATA: lv_time TYPE T.

* lv_time = sy-uzeit.
* lv_time = 183045.
```

## **FLOAT**

```JS
DATA: lv_float TYPE f.

* lv_float = '3.14'.
```

## **PACKED DECIMAL**

```JS
DATA: lv_decimal TYPE p DECIMALS 2.

* lv_decimal = 1234.56.
```

## **STRING**

```JS
DATA: lv_string1 TYPE string.

* lv_string1 = 'Bonjour le monde'.
```

## **BOOLEAN**

```JS
DATA: lv_bool TYPE boolean,
      lv_boolean TYPE abap_bool.

* lv_bool = abap_true.
* lv_boolean = abap_false.
```
