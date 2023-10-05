# **PROGRAMMATION**

## **STRUCTURES**

En **SAP ABAP**, une **structure** est un type de données qui peut contenir différents **champs** ou **éléments**. C’est une sorte de squelette qui sera utilisé comme une référence par la table interne plus tard (nommée **lt_nom** en local ou **gt_nom** en global).

Ces **champs** peuvent être de différents types de données, tels que des chaînes de caractères, des nombres entiers ou décimaux, des dates et des heures, et bien d'autres encore.

Une **structure** est souvent utilisée pour regrouper des données connexes qui sont utilisées ensemble dans une application. Par exemple, une structure peut être utilisée pour stocker des informations (**champs**) sur un employé, telles que son nom, son numéro d'identification, son adresse, son salaire, etc.

Une fois qu'une **structure** est définie dans un programme **ABAP**, vous pouvez créer des **variables** basées sur cette structure pour stocker des données (nommée **ls_nom** en local ou **gs_nom** en global). Vous pouvez également accéder aux champs individuels de la structure en utilisant leur nom et l'opérateur "**-**".

Les **structures** sont également souvent utilisées dans **SAP** pour définir les **types de tables** (**ty_t_nom** par exemple), les **types de paramètres de fonction**, les **types de retours de fonction** et les **types de variables de structure** dans les programmes fonctionnels.

_Exemple de déclaration de structure de table_

```ABAP
TYPES: BEGIN OF ty_employee,
         emp_id   TYPE i,
         emp_name TYPE string,
         emp_dob  TYPE d,
         emp_sal  TYPE p DECIMALS 2,
       END OF ty_employee.
```

_Exemple de déclaration de variable de structure basée sur la table déclarée_

```ABAP
DATA: ls_employee TYPE ty_employee.
```

_Exemple d'attribution de valeur aux champs de la variable de structure_

```ABAP
ls_employee-emp_id   = 0007.
ls_employee-emp_name = 'Frédéric GIUSTINI'.
ls_employee-emp_dob  = '19861102'.
ls_employee-emp_sal  = 5000.00.
```
