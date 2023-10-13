# **`IS INITIAL`**

Vérifier qu’une table interne n’est pas vide.

```JS
IF NOT itab[] IS INITIAL.
...
ENDIF.
```

ou

```JS
IF itab[] IS NOT INITIAL.
...
ENDIF.
```

> Les crochets `[ ]` après le nom d’une table interne font référence à son contenu et aux nombres de lignes enregistrées.
