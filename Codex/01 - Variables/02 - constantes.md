# **`CONSTANTES`**

- `Constante` :

  Une constante est un symbole informatique associant un nom à une valeur qui peut varier durant l’exécution du programme. Cette définition s’applique également à une variable, à la différence près que sa valeur n'est pas fixée dès le début et peut changer au cours de l’exécution du programme.

L’instruction commencera par `CONSTANTS` et devra comporter obligatoirement une valeur fixe avec `VALUE`.

## **INTEGER**

```JS
CONSTANTS: c_integer TYPE I VALUE 10.
```

## **FLOAT**

```JS
CONSTANTS: c_float TYPE F VALUE '3.14'.
```

## **DECIMAL**

```JS
CONSTANTS: c_decimal TYPE DECFLOAT34 VALUE '1234567890123456789012345678901234'.
```

## **STRING**

```JS
CONSTANTS: c_string TYPE STRING VALUE 'Hello, World!'.
```

## **CHAR**

```JS
CONSTANTS: c_char TYPE C LENGTH 1 VALUE 'F'.
```

## **BOOLEAN**

```JS
CONSTANTS: c_bool TYPE BOOLEAN VALUE ABAP_TRUE.
CONSTANTS: c_boolean TYPE ABAP_BOOL VALUE ABAP_FALSE.
```

## **DATE** - AAAAMMJJ

```JS
CONSTANTS: c_date TYPE D VALUE SY-DATUM.
CONSTANTS: c_date TYPE D VALUE 1986110.
```

## **TIME** - HHMMSS

```JS
CONSTANTS: c_time TYPE T VALUE SY-UZEIT.
CONSTANTS: c_time TYPE T VALUE 183045.
```

# **DECIMAL NUMBER**

Il est à noter qu’en `ABAP`, le point (.) est utilisé pour les décimales.

> Le type `P` doit être accompagné par l’instruction `DECIMALS` qui va définir le nombre de chiffres après la virgule, sinon la variable associée sera considérée comme un nombre entier.

```JS
CONSTANTS: c_pi TYPE p DECIMALS 2 VALUE '3.14'.
```
