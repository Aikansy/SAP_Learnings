# **`AMIS`**

Définir un ami permet de lui donner accès à tous les attributs, méthodes... d’une classe.

_Exemple_

La `classe CL_EVENT_HISTORY` possède comme `ami CL_GUI_ALV_GRID`.

![](../../99%20-%20Ressources/11_Classes%20-%2002%20-%2004%20-%2001.png)

Ainsi, la `classe CL_GUI_ALV_GRID` peut accéder aux données de la `classe CL_EVENT_HISTORY` sans aucune restriction.

Cependant, `"l’amitié n’est ni héritée, ni transitive, ni réciproque"`, ce qui signifie que la ou les `sous-classes amies ne peuvent pas accéder aux attributs de la classe principale ni les amis de la classe amie, et que cela ne donne aucun privilège à la classe principale sur la classe amie`.
