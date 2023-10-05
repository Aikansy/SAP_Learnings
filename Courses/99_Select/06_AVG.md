# **PROGRAMMATION**

## **AVG**

Détermine la moyenne de la colonne sélectionnée (AVG pour Average en anglais).

_Exemple_

Connaître la moyenne des coûts de péage payés de tous les voyages de covoiturage effectués :

```ABAP
DATA: lv_toll TYPE ztravel_toll.

SELECT AVG( toll )
    FROM ztravel
    INTO @lv_toll.
```

Selon les valeurs enregistrées dans le chapitre Dictionnaire de données (**DDIC**), **LV_TOLL** aura la valeur de 13.75 : (16 + 17 + 16 + 6) / 4.

L’option **DISTINCT** comme déjà vu sur les tables va supprimer les doublons. Ainsi le code suivant :

```ABAP
DATA: lv_toll TYPE ztravel_toll.

SELECT AVG( DISTINCT toll )
    FROM ztravel
    INTO @lv_toll.
```

Retournera la variable **LV_TOLL** avec la valeur ’13’ : (16 + 17 + 6) / 3. La valeur ’16’ apparaissant deux fois, une des deux valeurs ne sera pas prise en compte.
