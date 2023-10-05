# **WRITE**

> On peut utiliser les deux points `:` avec l’instruction `WRITE` qui contiendra ainsi une série de paramètres. Elle est suivie de la barre `/` signifiant une nouvelle ligne, puis d’un texte lui-même suivi d’une virgule, et enfin une variable. Ainsi, comme pour l’exemple du `DATA`, il aurait été possible d’écrire le code suivant :
>
> ```JS
> CONSTANTS : c_text(11)  TYPE c VALUE 'Hello World'.
>
> WRITE:/ 'Variable système ABAP'.
> WRITE:/ 'Mandant :     ', sy-mandt.
> WRITE:/ 'Utilisateur : ', sy-uname.
> WRITE:/ 'Date :        ', sy-datum.
> WRITE:/ 'Heure :       ', sy-uzeit.
> WRITE / c_text.
> ```
>
> ... de la manière suivante :
>
> ```JS
> CONSTANTS : c_text(11)  TYPE c VALUE 'Hello World'.
>
> WRITE:/ 'Variable système ABAP',
>       / 'Mandant :     ', sy-mandt,
>       / 'Utilisateur : ', sy-uname,
>       / 'Date :        ', sy-datum,
>       / 'Heure :       ', sy-uzeit,
>       / c_text.
> ```
