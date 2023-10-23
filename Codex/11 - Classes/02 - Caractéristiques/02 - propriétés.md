# **`PROPRIETES`**

Tout d’abord, les propriétés de la classe commencent par définir l’héritage de la classe, si elle en possède un, en affichant le nom de sa surclasse. Une notion très importante à savoir sur la programmation orientée objet, et donc des classes, est celle de l’héritage, schématisée de la façon suivante :

la `CLASSE A` contenant des attributs et des traitements, possède une `sous-classe` `CLASSE B`, contenant également des attributs et des traitements. De par l’héritage, cette dernière va également hériter des attributs et des traitements de la `CLASSE A` représentés en bleu.

![](../../99%20-%20Ressources/11_Classes%20-%2002%20-%2002%20-%2001.png)

Avec un exemple un peu plus parlant, il serait possible d’imaginer une classe `TRANSPORT` ayant deux `sous-classes` : `ROUTIER` et `MARITIME`. La première a elle-même deux autres `sous-classes` (`VOITURE` et `CAMION`) et la deuxième trois (`CARGO`, `CHALOUPE` et `PENICHE`). Ainsi en lisant le schéma de bas en haut, `VOITURE` et `CAMION` possèdent la `surclasse` `ROUTIER` qui possède la `surclasse` `TRANSPORT`. Celle-ci n’ayant pas de `surclasse`, elle est définie comme `superclasse`.

![](../../99%20-%20Ressources/11_Classes%20-%2002%20-%2002%20-%2002.png)

Ainsi, chaque `sous-classe` va hériter des attributs et des méthodes de la `surclasse` qui, comme déjà indiqué, vont apparaître en bleu comme dans l’éditeur de classes.

![](../../99%20-%20Ressources/11_Classes%20-%2002%20-%2002%20-%2003.png)

Dans l’exemple, la `classe CL_GUI_ALV_GRID` possède la `surclasse CL_GUI_ALV_GRID_BASE` qui elle-même possède la `surclasse CL_GUI_CONTROL`, qui possède la `surclasse CL_GUI_OBJECT`, qui est enfin la `superclasse` (il suffit de double cliquer à chaque fois sur la surclasse pour arriver à ses propriétés).

![](../../99%20-%20Ressources/11_Classes%20-%2002%20-%2002%20-%2004.png)

Pour revenir à la `classe CL_GUI_ALV_GRID`, il suffit de cliquer plusieurs fois sur le `bouton Retour` (ou raccourci-clavier [F3]) pour revenir en arrière ; dans les propriétés de cette classe, on retrouve une autre notion importante de l’objet : l’`instanciation`.

![](../../99%20-%20Ressources/11_Classes%20-%2002%20-%2002%20-%2005.png)

Il s’agit de l’action d’`instancier`, de créer un objet. Dans un programme ABAP, l’`instruction CREATE OBJECT` est utilisée pour effectuer cette tâche. Cependant, les options d’instanciation d’une classe sont les suivantes :

**Privé** : l’objet ne peut être créé que par la classe elle-même.

_Exemple_

La classe `CL_ADDR_MAIN` possède une option d’instanciation à privé et l’objet est créé dans la méthode `GET_INSTANCE` de cette même classe, il n’est pas possible de le créer directement dans un programme ABAP.

![](../../99%20-%20Ressources/11_Classes%20-%2002%20-%2002%20-%2006.png)

![](../../99%20-%20Ressources/11_Classes%20-%2002%20-%2002%20-%2007.png)

**Protégé** : C’est la même chose que privé sauf que l’objet peut être appelé par la classe elle-même ou ses sous-classes.

_Exemple_

La `classe CL_BS_API_ADDRESS` possède la `sous-classe CL_BS_API_ADDRESS_MDG`. En créant l’objet de la `classe CL_BS_API_ADDRESS_MDG` via sa `méthode CONSTRUCTOR`, l’objet de la `classe CL_BS_API_ADDRESS` sera également créé automatiquement (appel de sa `méthode CONSTRUCTOR` via la `commande super->constructor`, comme illustré ci-dessous).

![](../../99%20-%20Ressources/11_Classes%20-%2002%20-%2002%20-%2008.png)

> La `méthode CONSTRUCTOR` citée plusieurs fois précédemment est l’endroit où se crée et se définit l’objet d’une classe ; elle est appelée automatiquement via l’`instruction CREATE OBJECT`. Cette notion sera un peu plus développée dans la section suivante sur les méthodes.

Dans l’onglet des propriétés se trouvent également toutes les informations sur la classe de développement, la date de création, de modification...
