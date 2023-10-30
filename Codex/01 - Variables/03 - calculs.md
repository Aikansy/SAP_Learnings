# **`OPERATIONS ARITHMETIQUES`**

Comme dans tout langage de programmation, les [variables numériques](../01%20-%20Variables/01%20-%20variables.md) (`N`, `I`, `P`...) peuvent être utilisées dans des opérations arithmétiques.

## **MOVE**

Tout d’abord, pour assigner une valeur à une `variable`, les instructions `MOVE` ou égal `=` sont utilisées.

```JS
DATA: v_a(2) TYPE I,
      v_b(2) TYPE I,
      v_c(2) TYPE I,
      v_d(2) TYPE I.

v_a = 3.
v_b = v_a.
MOVE 5   TO v_c.
MOVE v_c TO v_d.

WRITE:/ 'Valeur de v_a : ', v_a,
      / 'Valeur de v_b : ', v_b,
      / 'Valeur de v_c : ', v_c,
      / 'Valeur de v_d : ', v_d.
```

Quatre `variables` ont été créées :

- `V_A`
- `V_B`
- `V_C`
- `V_D`

toutes de type entier `I` avec une longueur d’une seule position. Tout d’abord, la valeur `3` sera assignée par un égal `=` à la variable `V_A`, puis la variable `V_B` prendra la valeur de `V_A`. Dans un deuxième temps, l’instruction `MOVE` va commencer par attribuer la valeur `5` à `V_C`, puis la valeur de `V_C` à `V_D`. Elles sont enfin toutes affichées démontrant ainsi le rôle de chacune de ces instructions.

![](../99%20-%20Ressources/01_Variables%20-%2003%20-%2001.png)

> Avec le `MOVE` aussi, il est possible de simplifier son écriture.

```JS
MOVE: 5   TO v_c,
      v_c TO v_d.
```

## **OPERATEURS ARITHMETIQUES**

_Bien évidemment, d’autres opérations existent :_

| `OPERATIONS`     | `SIGNE` | `MOTS-CLES`            |
| ---------------- | ------- | ---------------------- |
| `EGAL`           | `=`     | `MOVE`                 |
| `ADDITION`       | `+`     | `ADD... TO...`         |
| `SOUSTRACTION`   | `-`     | `SUBSTRACT... FROM...` |
| `MULTIPLICATION` | `\*`    | `MULTIPLY... BY...`    |
| `DIVISION`       | `/`     | `DIVIDE... BY...`      |

Ainsi l’addition se fera avec le signe `+` ou l’instruction `ADD... TO...`, la soustraction avec le signe `-` ou `SUBSTRACT... FROM...`, la multiplication avec `\*` ou `MULTIPLY... BY...` et enfin la division avec `/` ou `DIVIDE... BY...`.

> Les expressions mathématiques sont beaucoup plus utilisées car plus lisibles et beaucoup moins contraignantes que les instructions.

## **ADDITION**

```JS
DATA: v_a(2) TYPE I.

v_a = 5 + 2.
ADD 7 TO v_a.
```

## **SOUSTRACTION**

```JS
DATA: v_a(2) TYPE I,
      v_b(2) TYPE I.

v_a = 5 + 2.
v_b = v_a - 3.
SUBTRACT 3 FROM v_b.
```

## **MULTIPLICATION**

```JS
DATA: v_a(2) TYPE I,
      v_b(2) TYPE I,
      v_c(2) TYPE I.

v_a = 5 + 2.
v_b = v_a - 3.
v_c = v_a * v_b.
MULTIPLY v_c BY 2.
```

## **DIVISION**

```JS
DATA: v_a(2) TYPE I,
      v_b(2) TYPE I,
      v_c(2) TYPE I,
      v_d(2) TYPE I.

v_a = 5 + 2.
v_b = v_a - 3.
v_c = v_a * v_b.
v_d = v_c / 2.
DIVIDE v_d BY 7.
```
