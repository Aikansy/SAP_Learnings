# **PROGRAMMATION**

## **LIKE**

Cette option permet de rechercher une chaîne de caractères (**LIKE**) ou pas (**NOT LIKE**). La différence ici est que la chaîne de caractères peut être incomplète et donc les inconnus seront définis par un **’%’**.

Attention à la casse du texte recherché ! Dans l’exemple, pour être bien sûr du résultat, la recherche s’est effectuée sur les caractères en minuscules et majuscules.

_Exemple_

Recherche du nom et prénom de tous les passagers dont le nom se termine par ’ez’.

```ABAP
SELECT surname,
       name
  FROM zpassenger
  INTO TABLE @DATA(lt_passenger)
  WHERE ( surname LIKE '%EZ' OR surname LIKE '%ez' ).


DATA ls_passenger LIKE LINE OF lt_passenger.

LOOP AT lt_passenger INTO ls_passenger.
  WRITE:/ ls_passenger-surname, ls_passenger-name.
ENDLOOP.
```

| **SURNAME** | **NAME** |
| ----------- | -------- |
| PEREZ       | MICHEL   |
| HERNANDEZ   | PATRICIA |
