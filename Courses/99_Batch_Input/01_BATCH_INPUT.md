# **MIGRATION DES DONNEES**

Ref. ZPROJ_INTER_2023.
Ref. ZBI_KDE.

## **IMPLEMENTATION DES DONNEES**

Migration / Transfert / Intégration des données externes dans la BDD SAP. DIfférentes techniques sont possibles :

- **BAPI** (Création d'un objet métier à partir d'un fichier).
- **BATCH-INPUT** (simulation d'un scenario pré-programmé utilisateur).
- **SHDB** (transaction enregistrant les simulations de transaction : traduction de batch-input).

## **BATCH-INPUT**

Procédé généralement utilisé pour transférer des données dun systeme externe vers une DB SAP en simulant un utilisateur.

### **MISE EN FORME DES DONNEES**

_Ref. ZBI_KDE_TOP._

Création d'une table vide qui va accueuillir les actions (lignes) et les exécutera dans l'ordre.

```ABAP
  DATA: bdcdata LIKE BDCDATA OCCURS 0 WITH HEADER LINE.
    PROGRAM   "Nom du programme
    DYNPRO    "Numéro de l'écran
    DYNBEGIN  "X
    FNAM      "Blanc
    FVAL      "Blanc
```

| **BDCDATA**        |                 |          |          |          |
| ------------------ | --------------- | -------- | -------- | -------- |
| PROGRAM            | DYNPRO          | DYNBEGIN | FNAM     | FVAL     |
| 'Nom du programme' | 'N° de l'écran' | 'X'      | '(vide)' | '(vide)' |

_Ref. ZBI_KDE._

```ABAP
  PERFORM batch_input.
```

_Ref. ZBI_KDE_F01._

```ABAP
FORM batch_input.

  PERFORM bdc_dynpro USING 'SAPLMGMM' '0060'.

  PERFORM bdc_field  USING 'BDCURSOR' 'RMMG1_REF-MBRUSH'.
  PERFORM bdc_field  USING 'RMMG1_REF-MBRUSH' 'M'.

  PERFORM bdc_field  USING 'BDCURSOR' 'RMMG1_REF-MTART'.
  PERFORM bdc_field  USING 'RMMG1_REF-MTART' 'FERT'.

  PERFORM bdc_field  USING 'BDCURSOR' 'RMMG1_REF-MATNR'.
  PERFORM bdc_field  USING 'RMMG1_REF-MATNR' 'MZ_FG_C900'.

  PERFORM bdc_field  USING 'BDC_OKCODE' '=ENTR'.

  CALL TRANSACTION 'MM01' USING bdcdata MODE 'E'.

ENDFORM.
```

> 'BDCURSOR': place le cursor sur
> 'RMMG1_REF-MATNR': nom du champ
> 'MZ_FG_C900': valeur à mettre dans le champ
> 'BDC_OKCODE': Validation
> '=ENTR': Entrer

### **APPEL D'ECRAN BDC_DYNPRO**

_Ref. ZBI_KDE_F01._

```ABAP
FORM bdc_dynpro USING PROGRAM dynpro.

  CLEAR bdcdata.

  bdcdata-program = program.
  bdcdata-dynpro = dynpro.
  bdcdata-dynbegin = 'X'.

  APPEND bdcdata.

ENDFORM.
```

### **APPEND INSTUCTION BDC_FIELD**

_Ref. ZBI_KDE_F01._

1st instruction

```ABAP
FORM bdc_field USING fnam fval.

  CLEAR bdcdata.

  bdcdata-fnam = fnam.
  bdcdata-fval = fval.

  APPEND bdcdata.
```

2nd instruction

```ABAP
FORM bdc_field USING fnam fval.

  CLEAR bdcdata.

  bdcdata-fnam = fnam.
  bdcdata-fval = fval.

  APPEND bdcdata.
```

```ABAP
FORM bdc_field USING fnam fval.

  CLEAR bdcdata.

  bdcdata-fnam = fnam.
  bdcdata-fval = fval.

  APPEND bdcdata.
```

### **EXECUTE**

> _Système/Status > Pour chaque écran, noter :_
>
> - le code de transaction
> - le nom du program (dynpro)
> - le numéro du dynpro
> - la façon de passer à l'écren suivant/terminer la transaction (touche Fn, menus, icônes ...)

_Ref. ZBI_KDE_F01._

```ABAP
CALL TRANSACTION 'MM01' USING bdctab.
```

## **SHDB**

1. Nouvel enreistrement
   - Nommer
   - Code transaction de celle visée
2. Lancer enregistrement (d'un modèle de séquence)
3. Effectuer les actions successives sans actions parasites
