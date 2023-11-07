# **`LOOP`**

```JS
LOOP AT itab { INTO wa }
               | ASSIGNING <fs>
               | TRANSPORTING NO FIELDS
             }
             [FROM idx1] [TO idx2]
             [WHERE log_exp]
  ...
  AT ...
    ...
  ENDAT.
  ...
ENDLOOP.
```

## CARACTERISTIQUES

Deux types de boucles ont été vues : le [DO/ENDDO](../../03%20-%20Boucles/01%20-%20do%20enddo.md) et le [WHILE/ENDWHILE](../../03%20-%20Boucles/05%20-%20while%20endwhile.md). Cependant il existe une troisième plus adaptée aux tables internes : le `LOOP`.

Un `LOOP` va lire ligne par ligne la table interne `itab` et comme pour le `READ TABLE`, le résultat peut être stocké dans une structure (`INTO wa`), ou dans un `field symbol` (`ASSIGNING <fs>`), mais il est également possible de na pas le stocker afin de vérifier seulement si la ligne existe (`TRANSPORTING NO FIELDS`) en mettant à jour les variables système [SY-SUBRC](../../99%20-%20Help/02%20-%20SY-SYSTEM.md) (code retour) et [Sy-TABIX](../../99%20-%20Help/02%20-%20SY-SYSTEM.md) (index de la table lue dans la boucle).

Aussi, deux paramètres optionnels sont disponibles comme pour le [`DELETE`](../../08%20-%20Instructions_itab/05%20-%20Delete/02%20-%20delete%20itab%20lines.md) (suppression de plusieurs lignes) : `FROM idx1` et/ou `TO idx2` permettant de restreindre la oucle à une sélection de lignes, et la clause `WHERE` permettant d'effectuer une sélection d'un ou plusieurs champs.

_Exemple_

_Boucle sur la table `T_CITIZEN` dont le champ `COUNTRY` est égal à `FR`, et affichage de la ligne._

```JS
TYPES: BEGIN OF ty_citizen,
         country TYPE char3,
         name    TYPE char20,
         age     TYPE numc2,
       END OF ty_citizen.

DATA: t_citizen TYPE STANDARD TABLE OF ty_citizen,
      s_citizen TYPE ty_citizen.

FIELD-SYMBOLS: <fs_citizen> TYPE ty_citizen.

s_citizen-country = 'FR'.
s_citizen-name    = 'Thierry'.
s_citizen-age     = '24'.
APPEND s_citizen TO t_citizen.

s_citizen-country = 'ES'.
s_citizen-name    = 'Luis'.
s_citizen-age     = '32'.
APPEND s_citizen TO t_citizen.

s_citizen-country = 'BR'.
s_citizen-name    = 'Renata'.
s_citizen-age     = '27'.
APPEND s_citizen TO t_citizen.

s_citizen-country = 'FR'.
s_citizen-name    = 'Floriane'.
s_citizen-age     = '32'.
APPEND s_citizen TO t_citizen.

LOOP AT t_citizen ASSIGNING <fs_citizen> WHERE country = 'FR'.
  WRITE: / <fs_citizen>-country, <fs_citizen>-name, <fs_citizen>-age.
ENDLOOP.
```

![](../../99%20-%20Ressources/08_Instructions_itab%20-%2009%20-%2001%20-%2001.png)

Petit complément concernant le `field symbol`. Il a été vu qu’il était possible de modifier directement la valeur de la `zone mémoire` référant à une variable, et que dans le cas d’une table interne, il n’était donc pas nécessaire d’utiliser la commande `MODIFY` pour appliquer ces modifications. Pour bien comprendre ce point, l’exemple précédent va être repris, sauf qu’avant la boucle utilisée pour lire les valeurs, une autre va affecter la valeur `IT` au champ COUNTRY.

```JS
. . .

LOOP AT t_citizen ASSIGNING <fs_citizen>.
  <fs_citizen>-country = 'IT'.
ENDLOOP.

LOOP AT t_citizen ASSIGNING <fs_citizen>.
  WRITE: / <fs_citizen>-country, <fs_citizen>-name, <fs_citizen>-age.
ENDLOOP.
```

**T_CITIZEN avant la première boucle**

| **COUNTRY** | **NAME** | **AGE** |
| ----------- | -------- | ------- |
| FR          | Thierry  | 24      |
| ES          | Luis     | 32      |
| BR          | Renata   | 27      |
| FR          | Floriane | 32      |

![](../../99%20-%20Ressources/08_Instructions_itab%20-%2009%20-%2001%20-%2002.png)

Avec le `field symbol`, une simple affectation a suffi pour mettre à jour les champs de la table interne.
