# **PROGRAMMATION**

## **DESCRIBE IN TABLE**

```ABAP
DESCRIBE TABLE lt_table [KIND knd] [LINES lin].
```

Cette instruction permet de décrire une table interne en retournant les informations suivantes :

- Le type de table interne (**KIND knd**) ayant pour valeur **’T’** (table interne **STANDARD**), **’S’** (**SORTED**), **’H’** (**HASHED**) ou blanc (**indéfini**). Ces valeurs se retrouvent également dans la structure standard **SYDES_KIND**.

- Le nombre de lignes contenues dans la table interne (**LINES lin**).

_Exemple_

Retourner toutes les informations de la table **LT_CITIZEN**.

```ABAP
TYPES: BEGIN OF ty_citizen,
         country TYPE char3,
         name    TYPE char20,
         age     TYPE numc2,
       END OF ty_citizen.

DATA: lt_citizen TYPE STANDARD TABLE OF ty_citizen,
      ls_citizen TYPE ty_citizen.


ls_citizen-country = 'FR'.
ls_citizen-name    = 'Thierry'.
ls_citizen-age     = '24'.
APPEND ls_citizen TO lt_citizen.

ls_citizen-country = 'ES'.
ls_citizen-name    = 'Francisco'.
ls_citizen-age     = '32'.
APPEND ls_citizen TO lt_citizen.

ls_citizen-country = 'BR'.
ls_citizen-name    = 'Renata'.
ls_citizen-age     = '27'.
APPEND ls_citizen TO lt_citizen.

ls_citizen-country = 'FR'.
ls_citizen-name    = 'Floriane'.
ls_citizen-age     = '32'.
APPEND ls_citizen TO lt_citizen.

DESCRIBE TABLE lt_citizen KIND DATA(lv_kind) LINES DATA(lv_lines).

WRITE : /'Informations de la table LT_CITIZEN'.
WRITE : /'Type de la table : ', lv_kind.
WRITE : /'Nombre de lignes : ', lv_lines.
```

[Schéma - Fenêtre de résultat](https://drive.google.com/file/d/17_3UEp1RH-zVxcn_E7WUqJHML6jtZnVy/view?usp=share_link)
