# **PROGRAMMATION**

## **SELECT**

```ABAP
SELECT result
       FROM source
       [FOR ALL ENTRIES IN lt_table]
       WHERE sql_cond
       AND sql_cond
       [GROUP BY group] [HAVING group_cond]
       [ORDER BY sort_key]
       [INTO | APPENDING] target
       [UP TO n ROWS]
       [BYPASSING BUFFER]
       [CONNECTION con|(con_syntax).
```

Le **SELECT** est l’instruction pour la lecture d’une table. Depuis la nouvelle version de **SAP** (pour rappel, de la version Ehp6 à Ehp7), prête pour l’interaction avec les bases de données **HANA**, beaucoup de fonctions sont apparues et il serait intéressant de s’y attarder.

Pour résumer, un **SELECT** a quatre paramètres et cette instruction pourrait se résumer à ceci :

```ABAP
SELECT colonnz
  FROM table
  INTO destination
  WHERE condition.
```
