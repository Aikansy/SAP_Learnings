# **PROGRAMMATION**

## **MAX**

Renvoient la valeur minimum de la table selon la colonne sélectionnée.

_Exemple_

Retourner le trajet le plus court dans **LV_MAX**.

```ABAP
DATA: v_max TYPE ztravel-duration.

SELECT MAX( duration )
    FROM ztravel
    INTO @lv_max.
```

La fonctionnalité **DISTINCT** peut être utilisée également mais n’est pas d’une très grande utilité avec le **MIN** et le **MAX**.
