# **`CONSTRUCTEUR DE CLASSE`**

Il existe un autre type de constructeur conçu pour la classe : la `méthode CLASS_CONSTRUCTOR`. Elle ne peut être appelée qu’une seule fois par programme, avant la première utilisation de la classe et donc en général avant une des étapes suivantes :

- Instanciation de la classe (`CREATE OBJECT`).

- Utilisation d’un attribut statique.

- Appel d’une méthode statique.

- Utilisation d’un événement d’une classe.

> Pour rappel, les attributs et méthodes statiques peuvent être appelés directement, nul besoin de générer une instance d’objet.

Quelques règles existent pour une méthode de type constructeur de classe :

1. Une classe ne peut détenir qu’un constructeur de classe.

2. Le constructeur de classe doit être de type public.

3. Le constructeur de classe ne peut pas gérer de paramètres, ni même d’exceptions.

4. Il est impossible de l’appeler explicitement.

Exemple avec la `classe CL_GUI_OBJECT` contenant à la fois une `méthode CONSTRUCTOR` et `CLASS_CONSTRUCTOR`.

![](../../99%20-%20Ressources/11_Classes%20-%2003%20-%2006%20-%2001.png)
