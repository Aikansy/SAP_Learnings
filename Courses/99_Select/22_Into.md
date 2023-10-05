# **PROGRAMMATION**

## **INTO**

- Données stockées dans une **structure** déclarée auparavant dans un **DATA**.

```ABAP
... INTO ls_table...
```

- Données stockées dans une **table interne** déclarée auparavant dans un **DATA**.

```ABAP
... INTO TABLE lt_table...
```

- Données stockées dans les **variables** obj1, obj2, obj3... déclarées auparavant dans un **DATA**.

```ABAP
... INTO (obj1, obj2, obj3,...)...
```

- Données stockées dans une **structure** déclarée **dynamiquement** directement dans la requête.

```ABAP
... INTO @DATA(ls_table)...
```

- Données stockées dans une **table interne** déclarée **dynamiquement** directement dans la requête.

```ABAP
... INTO TABLE @DATA(lt_table)...
```

- Données stockées dans les **variables** obj1, obj2, obj3... déclarées **dynamiquement** directement dans la requête.

```ABAP
... INTO (@DATA(obj1), @DATA(obj2), @DATA(obj3),...)...
```

- **INTO CORRESPONDING FIELDS OF**

```ABAP
... INTO CORRESPONDING FIELDS OF ls_table...
... INTO CORRESPONDING FIELDS OF lt_table...
```

- **APPENDING**

```ABAP
... APPENDING [CORRESPONDING FIELDS OF] TABLE lt_table...
```

Cette instruction fonctionne uniquement avec une **table interne** et donne la possibilité d’**ajouter** de nouveaux résultats **sans supprimer** les anciens.

Par exemple, avec la requête suivante, la table interne **LT_PASSENGER**, n’aura qu’une fois les enregistrements de la table **ZPASSENGER**.

```ABAP
SELECT surname,
       name,
       date_birth
  FROM zpassenger
  INTO TABLE @DATA(lt_passenger).

SELECT surname,
       name,
       date_birth
  FROM zpassenger
  INTO TABLE @lt_passenger.

DATA ls_passenger LIKE LINE OF lt_passenger.

LOOP AT lt_passenger INTO ls_passenger.
  WRITE:/ ls_passenger-surname, ls_passenger-name,
          ls_passenger-date_birth.
ENDLOOP.
```

| **SURNAME** | **NAME** | **DATE_BIRTH** |
| ----------- | -------- | -------------- |
| PEREZ       | MICHEL   | 19790724       |
| VALE        | SONIA    | 19830220       |
| OLIVEIRA    | JOSE     | 19781106       |
| HERNANDEZ   | PATRICIA | 19841002       |
