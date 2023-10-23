# **`INTERFACES`**

La différence entre une classe et une interface est qu’une classe possède une définition et une implémentation (par exemple, elle possède des méthodes avec leurs paramètres en entrée, sortie... et le code ABAP qui va traiter ces paramètres) alors qu’une interface ne possède que la définition (toujours avec le même exemple, elle possède des méthodes avec leurs paramètres en entrée, sortie... mais sans le code ABAP qui va traiter ces paramètres).

L’interface est donc un squelette utilisé par une ou plusieurs classes. Aussi, une classe peut utiliser une à plusieurs interfaces notamment lors de l’héritage.

La `classe CL_GUI_ALV_GRID` possède trois interfaces : `IF_CACHED_PROP`, `IF_CACHED_PROP` (héritées d’une surclasse) et `IF_DRAGDROP`.

![](../../99%20-%20Ressources/11_Classes%20-%2002%20-%2003%20-%2001.png)
