# **PROGRAMMATION**

## **REPLACE IN TABLE**

```ABAP
REPLACE [ {FIRST OCCURRENCE} | {ALL OCCURRENCES} OF ] pattern
        IN TABLE lt_table WITH newpattern
        [IN {CHARACTER | BYTE} MODE]
        [ {RESPECTING | IGNORING} CASE]
        [REPLACEMENT COUNT rcnt]
        { {[REPLACEMENT LINE rlin] [REPLACEMENT OFFSET roff] [REPLACEMENT LENGTH rlen] } | [RESULTS result_tab|result_wa] } ...
```

L’instruction **REPLACE IN TABLE** possède les mêmes paramètres et se comporte exactement de la même façon que l’instruction **REPLACE** dans une variable (cf. chapitre Instructions basiques **ABAP** - Opérations sur variable texte).

_Exemple_

Chercher toutes les occurrences **’BR’** dans la table **LT_CITIZEN** et les remplacer par la chaîne de caractères **’IT’**.

```ABAP
TYPES: BEGIN OF ty_citizen,
         country TYPE char3,
         name    TYPE char20,
         age     TYPE numc2,
       END OF ty_citizen.

DATA: lt_citizen TYPE STANDARD TABLE OF ty_citizen,
      lt_results TYPE TABLE OF repl_result,
      ls_citizen TYPE ty_citizen,
      ls_results TYPE repl_result.

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

REPLACE all OCCURRENCES OF 'BR' IN TABLE lt_citizen with 'IT'
            IGNORING CASE
            RESULTS lt_results.

IF sy-subrc = 0.

  LOOP AT lt_results INTO ls_results.

    AT FIRST.
      WRITE: 'Liste des enregistrements ayant été modifiés'.
    ENDAT.

    READ TABLE lt_citizen ASSIGNING <fs_citizen> INDEX s_results-line.
    IF sy-subrc = 0.
      WRITE: / <fs_citizen>-country, <fs_citizen>-name, <fs_citizen>-age.
    ENDIF.

  ENDLOOP.

ENDIF.
```

La table interne **LT_RESULTS** va cette fois-ci prendre la référence de la structure **REPL_RESULT**.

LT_RESULTS

| **LINE** | **OFFSET** | **LENGTH** |
| -------- | ---------- | ---------- |
| 3        | 0          | 2          |

Pour rappel, le premier champ liste les index de lignes concernées par la modification, **OFFSET** la position où la chaîne de caractères a été remplacée, **LENGTH**, la longueur de la chaîne de caractères.

Le champ **LINE** sera ensuite utilisé dans le **LOOP** de la table **LT_RESULTS**, pour lire l’index de la table **LT_CITIZEN** et d’en afficher sa ligne.

[Schéma - Fenêtre de résultat](https://drive.google.com/file/d/1M2jLZybLnvnMqPqw4NQb64ddSOOMOlsh/view?usp=share_link)
