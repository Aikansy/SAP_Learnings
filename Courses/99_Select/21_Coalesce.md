# **PROGRAMMATION**

## **COALESCE**

```ABAP
coalesce( obj1, obj2 )
```

Cette fonction permet d’afficher l’objet obj1 (que ce soit la valeur d’un champ, une expression arithmétique...) mais si cette valeur est nulle, elle affichera ce qui est défini dans obj2.

Cependant, pour illustrer cette partie avec un exemple, il est nécessaire de connaître le **INNER JOIN** qui sera développé dans la partie **FROM**.

Maintenant que les jonctions de table avec le **JOIN** ont été vues, il serait intéressant de revenir sur la fonction dite "de remplissage" mentionnée dans la partie des expressions **SQL** du **SELECT**.

En reprenant un des exemples précédents avec le **LEFT JOIN** ou le **RIGHT JOIN**, il serait possible d’utiliser cette fonction pour qu’au lieu d’afficher un champ vide, la valeur **’X’** apparaisse :

```ABAP
SELECT b~brand,
       b~model,
       b~model_year,
       COALESCE( d~surname, 'X' ) AS surname,
       COALESCE( d~name, 'X' )    AS name
  FROM zcar_brand_mod AS b LEFT JOIN zdriver_car AS d
    ON  b~brand      = d~car_brand
    AND b~model      = d~car_model
    AND b~model_year = d~car_year
  INTO TABLE @DATA(lt_car_left).


DATA ls_car_left LIKE LINE OF lt_car_left.

LOOP AT lt_car_left INTO ls_car_left.
  WRITE:/ ls_car_left-brand,      ls_car_left-model,
          ls_car_left-model_year, ls_car_left-surname,
          ls_car_left-name.
ENDLOOP.
```

| **BRAND**  | **MODEL** | **MODEL_YEAR** | **SURNAME** | **NAME** |
| ---------- | --------- | -------------- | ----------- | -------- |
| PEUGEOT    | 307       | 2011           | DEBBACHE    | AMINH    |
| AUDI       | A3        | 2016           | ALDAIR      | PAULA    |
| FORD       | ESCORT    | 2013           | PILON       | BEATRIZ  |
| CITROEN    | C5        | 2012           | OLIVEIRA    | JOSE     |
| PEUGEOT    | 208       | 2012           | X           | X        |
| VOLKSWAGEN | GOLF      | 2015           | X           | X        |
| RENAULT    | MEGANE    | 2013           | X           | X        |
