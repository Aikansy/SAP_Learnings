# **`CONCATENATE`**

```JS
CONCATENATE [ {dobj1 dobj2 ...} | {LINES OF itab} ]
            INTO result
            [IN {BYTE|CHARACTER} MODE]
            [SEPARATED BY sep]
            [RESPECTING BLANKS].
```

`CONCATENATE` permet de concaténer plusieurs chaînes de caractères définies par `dobj1`, `dobj2…` ou les lignes d’une table interne `LINES OF itab`, et de stocker le résultat dans une variable cible définie après le `INTO`

_Paramètre(s) supplémentaire(s) optionnel(s) :_

- `IN BYTE MODE` ou `IN CHARACTER MODE`, est un paramètre qui revient assez souvent en `ABAP`. La valeur par défaut sera toujours `IN CHARACTER MODE`. `IN BYTE MODE` est le plus souvent utilisé lors d’un travail avec des variables de type hexadécimal, autant dire assez rarement.
- `SEPARATED BY` renseigne le caractère de séparation entre les chaînes de caractères dans la variable résultat.
- `RESPECTING BLANKS` affiche la chaîne complète y compris les espaces. Par exemple, si la variable de sortie est définie comme une chaîne de caractères de vingt positions, mais que le résultat du `CONCATENATE` est seulement un texte de cinq, le `RESPECTING BLANKS` affichera le texte de cinq caractères puis quinze espaces. Ce procédé est utilisé pour l’envoi de fichiers plats à des banques par exemple et dont le nombre de colonnes de chaque cellule est nécessaire pour être compris et pris en compte par leur système.

_L’exemple suivant démontre bien les différentes possibilités du `CONCATENATE` :_

```JS
CONSTANTS: c_txt1(20) TYPE c VALUE 'Hello',
           c_txt2(20) TYPE c VALUE 'World',
           c_txt3(20) TYPE c VALUE 'Bienvenue',
           c_txt4(20) TYPE c VALUE 'sur',
           c_txt5(20) TYPE c VALUE 'SAP'.

DATA: v_result1(50)  TYPE c,
      v_result2(50)  TYPE c,
      v_result3(100) TYPE c.

CONCATENATE c_txt1 c_txt2 c_txt3 c_txt4 c_txt5
  INTO v_result1.

CONCATENATE c_txt1 c_txt2 c_txt3 c_txt4 c_txt5
  INTO v_result2
  SEPARATED BY ' '.

CONCATENATE c_txt1 c_txt2 c_txt3 c_txt4 c_txt5
  INTO v_result3
  RESPECTING BLANKS.

WRITE:/ 'Sans option :     ', v_result1,
      / 'SEPARATED BY:     ', v_result2,
      / 'RESPECTING BLANKS:', v_result3.
```

Cinq constantes de type chaîne de caractères sont créées avec une longueur de vingt positions à chaque fois. Les textes suivants leur sont attribués : `"Hello"`, `"World"`, `"Bienvenue"`, `"sur"`, et `"SAP"`. Puis trois variables sont à leur tour déclarées, de type chaîne de caractères également avec une longueur de cinquante positions pour `V_RESULT1` et `V_RESULT2` et de cent pour `V_RESULT3`.

Le premier `CONCATENATE` n’utilisera aucune option afin de se rendre compte de ce que cette instruction effectue seule sans paramètre de mise en forme.

Le deuxième fera la même chose sauf qu’un indicateur de séparation `-` sera défini avec l’option `SEPARATED BY`. Le résultat devra donc donner une chaîne de caractères avec des tirets entre chaque mot.

Enfin le troisième `CONCATENATE` utilisera l’option `RESPECTING BLANKS` affichant ainsi un résultat avec tous les mots séparés par de nombreux espaces.

Les `WRITE` en fin de programme pourront confirmer ce qui vient d’être avancé :

![](../99%20-%20Ressources/01_Variables%20-%2004%20-%2001.png)
