# **PROGRAMMATION**

## **MIN**

Renvoient la valeur minimum de la table selon la colonne sélectionnée.

_Exemple_

Retourner le trajet le plus court dans **LV_MIN**.

```ABAP
DATA: v_min TYPE ztravel-duration.

SELECT MIN( duration )
    FROM ztravel
    INTO @lv_min.
```

La fonctionnalité **DISTINCT** peut être utilisée également mais n’est pas d’une très grande utilité avec le **MIN** et le **MAX**.
