# **`INSERT`**

> ```JS
> INSERT   wa
>       | {INITIAL LINE}
>       | {LINES OF jtab [FROM idx1] [TO idx2]} ...
>   INTO  {TABLE itab}
>       | {itab INDEX idx } ...
> ```
>
> L’instruction `INSERT` va insérer les données contenues dans une `structure` (`wa`) :
>
> - une ligne vide (INITIAL LINE) ou
> - dans les lignes d’une autre `table interne` (`jtab`) avec comme option la possibilité de spécifier les numéros de ligne à copier (`FROM idx1` / `TO idx2`).
>   Elle va insérer ces enregistrements dans une `table interne` (`TABLE itab`), avec la possibilité d’indiquer leur `ligne de destination`.
>
> Pour tous les exemples de ce chapitre, le programme `06_CODE_CITIZEN.txt` liste tous les champs et les valeurs de la table interne `T_CITIZEN`.
>
> Exemple : Insertion de lignes dans la table interne T_CITIZEN1
>
> ```JS
> TYPES: BEGIN OF ty_citizen,
>          country TYPE char3,
>          name    TYPE char20,
>          age     TYPE numc2,
>        END OF ty_citizen.
>
> DATA: t_citizen1 TYPE TABLE OF ty_citizen,
>       t_citizen2 TYPE TABLE OF ty_citizen,
>       s_citizen  TYPE ty_citizen.
>
>
> s_citizen-country = 'FR'.
> s_citizen-name    = 'Thierry'.
> s_citizen-age     = '24'.
> INSERT s_citizen INTO TABLE t_citizen1.
> *
> s_citizen-country = 'ES'.
> s_citizen-name    = 'Luis'.
> s_citizen-age     = '32'.
> INSERT s_citizen INTO TABLE t_citizen2.
>
> s_citizen-country = 'BR'.
> s_citizen-name    = 'Renata'.
> s_citizen-age     = '27'.
> INSERT s_citizen INTO TABLE t_citizen2.
>
> s_citizen-country = 'FR'.
> s_citizen-name    = 'Floriane'.
> s_citizen-age     = '32'.
> INSERT s_citizen INTO TABLE t_citizen2.
>
> INSERT INITIAL LINE INTO t_citizen1 INDEX 1.
>
> INSERT LINES OF t_citizen2 FROM 2 TO 3 INTO t_citizen1 INDEX 1.
> ```
>
> Un type de structure est tout d’abord créé, contenant les champs :
>
> - `COUNTRY` avec comme spécificité technique l’élément de données `CHAR3`
> - `NAME` avec `CHAR20`
> - `AGE` avec `NUMC2`.
>
> Deux tables internes vont être ensuite créées, utilisant ce type de structure : `T_CITIZEN1` et `T_CITIZEN2`, ainsi que la structure `S_CITIZEN`.
>
> Un premier enregistrement est tout d’abord inséré dans `T_CITIZEN1`, puis trois autres dans `T_CITIZEN2`. Une ligne vide sera ajoutée à l’`index 1` de `T_CITIZEN1` et enfin les enregistrements contenus aux lignes 2 et 3 de `T_CITIZEN2` seront aussi ajoutés à l’`index 1` de `T_CITIZEN1`. Au final, la table interne `T_CITIZEN1` aura les enregistrements suivants :
>
> `T_CITIZEN1`
> | **COUNTRY** | **NAME** | **AGE** |
> |:-----------:|-----------|:-------:|
> | BR | Renata | 27 |
> | FR | Florianne | 32 |
> | | | |
> | FR | Thierry | 24 |
