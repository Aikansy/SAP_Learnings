# **PROGRAMMATION**

## **FIND IN TABLE**

```ABAP
FIND [ {FIRST OCCURRENCE} | {ALL OCCURRENCES} OF ] pattern
     IN TABLE lt_table [table_range]
     [IN {CHARACTER | BYTE} MODE]
...  [ {RESPECTING | IGNORING} CASE ]
     [MATCH COUNT  mcnt]
     {
      { [MATCH LINE   mlin] [MATCH OFFSET moff] [MATCH LENGTH mlen] } |
       [RESULTS result_tab | result_wa]
     }.
```

L’instruction **FIND IN TABLE** possède les mêmes paramètres et se comporte exactement de la même façon que l’instruction **FIND** dans une variable (cf. chapitre Instructions basiques ABAP - Opérations sur variable texte).

_Exemple_

Chercher toutes les occurrences **’FR’** dans la table **LT_CITIZEN** et afficher les lignes concernées.

```ABAP
TYPES: BEGIN OF ty_citizen,
         country TYPE char3,
         name    TYPE char20,
         age     TYPE numc2,
       END OF ty_citizen.

DATA: lt_citizen TYPE STANDARD TABLE OF ty_citizen,
      lt_results TYPE TABLE OF match_result,
      ls_citizen TYPE ty_citizen,
      ls_results TYPE match_result.

FIELD-SYMBOLS: <fs_citizen> TYPE ty_citizen.

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

FIND ALL OCCURRENCES OF 'FR' IN TABLE lt_citizen
         IGNORING CASE
         RESULTS lt_results.

IF sy-subrc = 0.

  LOOP AT lt_results INTO ls_results.

    AT FIRST.
      WRITE: 'Liste des enregistrements contenant la chaîne de caractères ''FR'''.
    ENDAT.

    READ TABLE lt_citizen ASSIGNING <fs_citizen> INDEX s_results-line.
    IF sy-subrc = 0.
      WRITE: / <fs_citizen>-country, <fs_citizen>-name, <fs_citizen>-age.
    ENDIF.

  ENDLOOP.

ENDIF.
```

Une nouvelle table interne va être créée (**LT_RESULTS**), de référence **MATCH_RESULT**, structure standard utilisée pour stocker les résultats de l’instruction **FIND**. Après avoir rempli la table interne **LT_CITIZEN**, le **FIND** sera exécuté avec la chaîne de caractères **’FR’** pour la table interne **LT_CITIZEN**, sans prendre en compte la casse et stockant donc le résultat dans la table **LT_RESULTS**.

LT_RESULTS

| **LINE** | **OFFSET** | **LENGTH** | **...\*** |
| -------- | ---------- | ---------- | --------- |
| 1        | 0          | 2          | ...       |
| 2        | 3          | 2          | ...       |
| 4        | 0          | 2          | ...       |

Pour rappel, le premier champ liste les index de lignes concernées par cette recherche, **OFFSET** la position où la chaîne de caractères a été trouvée, **LENGTH**, la longueur de la chaîne de caractères.

Le champ **LINE** sera ensuite utilisé dans le **LOOP** de la table **LT_RESULTS**, pour lire l’index de la table **LT_CITIZEN** et d’en afficher sa ligne.

[Schéma - Fenêtre de résultat](https://drive.google.com/file/d/1UDtJkUxZ3wCkDg8R6RE7xUajHYSph7dy/view?usp=share_link)
