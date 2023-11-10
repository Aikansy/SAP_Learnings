# **`PARAMETRES`**

Lorsque la méthode est sélectionnée et après avoir cliqué sur le bouton Paramètre, une liste va apparaître.

![](../../99%20-%20Ressources/11_Classes%20-%2003%20-%2002%20-%2001.png)

Une nouvelle barre d’outils apparaît et l’unique différence qu’elle présente est le bouton de retour vers les méthodes.

![](../../99%20-%20Ressources/11_Classes%20-%2003%20-%2002%20-%2002.png)

Ensuite, les caractéristiques des paramètres de la méthode se présentent de la manière suivante :

- `Paramètre` (nom du paramètre)

- `Catégorie du paramètre` pouvant être :

  - `Importing` (importation = entrée)

  - `Exporting` (exportation = sortie)

  - `Changing` (modifiable = entrée et sortie)

  - `Returning` (retour = sortie) : même chose que l’exportation sauf qu’il ne peut y avoir qu’un seul paramètre de type retour, et que l’option Passage par valeur est obligatoire.

- `Passage par valeur` : comme pour les modules fonctions, lors de l’appel de la méthode, la variable appelante va passer sa valeur à la variable appelée et ainsi allouer un seul espace mémoire.

_Exemple_

```JS
...
CALL METHOD o_grid->set_table_for_first_display
  EXPORTING
    i_save = v_save
...
```

La variable `V_SAVE` va passer sa valeur au paramètre `I_SAVE`. Si l’option n’était pas cochée, SAP allouerait deux espaces mémoire : un pour le paramètre `I_SAVE` et l’autre pour la variable `V_SAVE` et avec la même valeur.

- `Facultatif` détermine si le paramètre est optionnel ou non.

- `Méth. catégor.` définit la catégorisation du paramètre comme pour les attributs de la classe.

- `Type réf.` est la référence utilisée pour le paramètre.

- `Valeur standard` est la valeur par défaut si besoin.

- `Description`
