# **`DELETE SINGLE LINE`**

```JS
DELETE { TABLE itab   { FROM wa }
                    | { WITH TABLE KEY [keyname COMPONENTS]
                                {comp_name1|(name1)} = operand1
                                {comp_name2|(name2)} = operand2
                                ...}
         | itab INDEX idx }
```

_Pour la suppression d’une seule ligne d’une table interne, il existe trois possibilités :_

## 1. SUPPRESSION D'UNE LIGNE DE LA TABLE INTERNE A PARTIR DE LA STRUCTURE

Le système ira rechercher la `clé primaire` renseignée afin de supprimer les enregistrements souhaités.

_Exemple_

```JS
TYPES: BEGIN OF ty_citizen,
         country TYPE char3,
         name    TYPE char20,
         age     TYPE numc2,
       END OF ty_citizen.

DATA: t_citizen TYPE TABLE OF ty_citizen WITH NON-UNIQUE KEY country,
      s_citizen TYPE ty_citizen.

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

CLEAR s_citizen.
s_citizen-country = 'FR'.

DELETE TABLE t_citizen FROM s_citizen.
```

L’instruction supprimera le premier enregistrement rencontré ayant pour clé `COUNTRY` égale à `FR`. Un CLEAR est effectué avant de renseigner de nouveau le champ afin de bien nettoyer la structure des valeurs renseignées.

## 2. SUPPRESSION D'UNE LIGNE DE LA TABLE INTERNE EN RENSEIGNANT UN OU PLUSIEURS COMPOSANTS

_Exemple_

_Reprendre l’exemple précédent en modifiant uniquement le `DELETE` :_

```JS
. . .

DELETE TABLE t_citizen WITH TABLE KEY country = 'FR'.
```

Ici encore, l’instruction supprimera le premier enregistrement rencontré ayant pour clé COUNTRY égale à ’FR’. Il est nécessaire de renseigner la clé entière définie pour la table interne. Ici, il s’agit du champ COUNTRY uniquement et il n’est pas possible de renseigner plus ou d’autres champs à part ceux définis dans la clé de la table. Ainsi, l’instruction DELETE ne peut s’écrire :

```JS
DELETE TABLE t_citizen WITH TABLE KEY country = 'FR' age = '32'.
```

ou

```JS
DELETE TABLE t_citizen WITH TABLE KEY age = '32'.
```

De plus, si lors de la déclaration de la table interne, aucune clé n’est définie avec l’instruction WITH NON-UNIQUE KEY ou WITH UNIQUE KEY, lors du DELETE tous les champs doivent être renseignés après WITH TABLE KEY.

```JS
. . .

DATA: t_citizen TYPE TABLE OF ty_citizen,
      s_citizen TYPE ty_citizen.

. . .

DELETE TABLE t_citizen WITH TABLE KEY country = 'FR'
                                      name    = 'Thierry'
                                      age     = 24.
```

## 3. SUPPRESSION D'UNE LIGNE DEFINIE PAR UN INDEX DE LA TABLE INTERNE

_Exemple_

_Reprendre l'exemple précédent en modifiant uniquement le `DELETE`._

```JS
. . .

DELETE t_citizen INDEX 1.
```

Pour tous les exemples exécutés ci-dessous, le résultat sera à chaque fois le même.

**T_CITIZEN avant DELETE**

| **COUNTRY** | **NAME** | **AGE** |
| ----------- | -------- | ------- |
| FR          | Thierry  | 24      |
| ES          | Luis     | 32      |
| BR          | Renata   | 27      |
| FR          | Floriane | 32      |

**T_CITIZEN après DELETE**

| **COUNTRY** | **NAME** | **AGE** |
| ----------- | -------- | ------- |
| FR          | Thierry  | 24      |
| ES          | Luis     | 32      |
| FR          | Floriane | 32      |
