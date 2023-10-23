# **`CREATION DE TABLE`**

Afin de compléter ce chapitre, il serait intéressant de voir comment créer une table. Elle listera la liste des conducteurs d’un système de covoiturage. Pour ceci, les étapes suivantes sont nécessaires :

- Exécuter la transaction `SE11`.
- Sélectionner l’option `Table base données`, puis insérer le nom `ZDRIVER_CAR`.
- Insérer une `description` comme `Covoiturage` - Table des conducteurs.
- Dans l’onglet `Livraison et gestion`, utilisez la `classe A` pour la première, puis `Affichage/gestion` autorisés comme gestion des données.

![](../99%20-%20Ressources/06_Tables_DB%20-%2009%20-%2001.png)

Dans la partie Zones, les champs suivants seront insérés :

| `Zone`     | `Clé` | `Val.` | `Elément de données`     |
| ---------- | ----- | ------ | ------------------------ |
| MANDT      | X     | X      | MANDT                    |
| ID_DRIVER  | X     | X      | ZDRIVER_ID               |
| SURNAME    |       |        | NAMEF                    |
| NAME       |       |        | SRMFNAME                 |
| DATE_BIRTH |       |        | P06_DATENAISS            |
| CITY       |       |        | CITY                     |
| REGION     |       |        | REGIO                    |
| COUNTRY    |       |        | LAND1                    |
| CAR_BRAND  |       |        | WRF_BRAND_DESCR          |
| CAR_MODEL  |       |        | VLC_MAKTX                |
| CAR_YEAR   |       |        | VLC_YEAR_OF_CONSTRUCTION |
| CAR_COLOR  |       |        | ICL_COLOR                |
| CAR_ID     |       |        | P06_IMMA                 |
| LANG       |       |        | LANG                     |

![](../99%20-%20Ressources/06_Tables_DB%20-%2009%20-%2002.png)

Il va falloir maintenant s’occuper des `clés externes` à commencer par la zone `MANDT`. Il suffit pour cela de sélectionner la ligne puis de cliquer sur le bouton `Clé externe`. À l’invite de confirmation, cliquez sur `Oui`.

![](../99%20-%20Ressources/06_Tables_DB%20-%2009%20-%2003.png)

Automatiquement, SAP génère la clé externe avec la table de contrôle T000. Renseignez le type de zone de clé externe comme candidats/zones clés, puis une cardinalité à 1:CN. Faites de même avec le champ suivant :

| `Table de contrôle` | `Types de zones de clé externe` | `Cardinalité` |
| ------------------- | ------------------------------- | ------------- |
| LAND1               | Aucun candidat/zone clé         | 1:CN          |

-> Vérifiez les tables de contrôle dans l’onglet `Aide/contrôle de saisie` qui devra ressembler à ceci :

![](../99%20-%20Ressources/06_Tables_DB%20-%2009%20-%2004.png)

- Aucune information à renseigner dans l’onglet `Zones devises/quantités` étant donné qu’il n’y a aucune unité de mesure nécessaire.
- `Sauvegarder` la table (la définir comme `objet local`), puis cliquer sur `Options techniques`. Comme il s’agit d’une petite table, elle sera de type `APPL0` et catégorie de `taille 0`. Les autres resteront comme prédéfinies par défaut. `Sauvegarder` et cliquer sur la `flèche verte` de retour arrière pour revenir à l’écran précédent.

![](../99%20-%20Ressources/06_Tables_DB%20-%2009%20-%2005.png)

- De retour à l’écran initial de la gestion du `dictionnaire ABAP`, `activer` la table.
- Il se peut qu’un message de `warning` (avertissement) apparaisse. Il est possible d’afficher le protocole d’activation pour voir une description détaillée.

![](../99%20-%20Ressources/06_Tables_DB%20-%2009%20-%2006.png)

Il est indiqué que la `catégorie d’extension` est manquante pour la table. Elle n’est pas obligatoire mais recommandée car elle définit le type de champs qui composeront la table (extension de la table doit être compris par ajout de champs dans la table directement ou grâce à un append dans le cas de tables standards).

L’`extension de table` s’applique également pour les `structures`.

Cette fonctionnalité se situe dans le menu déroulant `Autres fonctions` - `Catégorie d’extension`... et peut prendre les valeurs suivantes :

![](../99%20-%20Ressources/06_Tables_DB%20-%2009%20-%2007.png)

- `Extensible sans restriction` : pas de règle pour l’extension de la table ou de la structure.
- `Extensible et alphanumérique ou numérique` : tous les champs devront être soit alphanumériques, soit numériques. La différence avec Extensible sans restriction est qu’il ne sera pas possible d’ajouter des champs de type date ou heure (par exemple) dans un append ou un include.
- `Extensible et alphanumérique` : la table ou la structure ne sera composée que de champs alphanumériques et une erreur sera retournée si un champ est défini comme numérique (il sera alors possible de modifier le type d’extension).
- `Non extensible` : il sera possible d’ajouter un champ directement à la table ou la structure initiale, mais impossible via un append. Ainsi, comme l’append est l’unique moyen d’ajouter un champ à une table standard, il n’y aura aucune possibilité pour accomplir cette tâche.
- `Non classifié` (par défaut), aucune extension n’a été définie pour la table ou la structure.

Dans la table `ZDRIVER_CAR`, il n’y aura pas besoin de restriction, l’option `Extensible sans restriction` sera donc choisie.

- `Activer` de nouveau, le message d’avertissement n’apparaît plus et la table est maintenant créée.

- Comme cette table doit être gérée via la `SM30`, exécutez le `générateur de gestion de table` dans le menu `Utilitaires` - `Générateur de gestion de table` puis renseignez les champs de cette façon :

  - `Groupe autorisations` : &NC&
  - `Groupe fonctions` : ZCAR
  - `Type de gestion` : à 1 niv

- Il existe deux possibilités pour définir l’`écran de synthèse` ; le mettre à `1` (comme le groupe de fonctions est nouveau), ou cliquer sur le bouton `Rechercher N° écran` pour que `SAP` lui en attribue un automatiquement.

![](../99%20-%20Ressources/06_Tables_DB%20-%2009%20-%2008.png)

- Cliquer ensuite sur l’option `Créer de la barre d’outils` (![](../99%20-%20Ressources/06_Tables_DB%20-%2009%20-%2009.png)) ou via le menu déroulant suivant : `Objets générés` - `Créer [F6]`
- La gestion des écrans étant indépendante de la définition de table, le `package` devra être renseigné ainsi qu’un autre (package) pour le groupe de fonctions. Pour plus de facilité, l’option `Objet local` sera de nouveau choisie.

Il arrive que des tables aient une `classe de développement` définie mais des écrans de gestion en local. Il s’agit souvent de tables de `customizing` pour les `données de référence`, ne pouvant être mises à jour que sur le système de développement.

La table `ZDRIVER_CAR` est maintenant créée avec une gestion des écrans. Des tests peuvent être exécutés avec la `SM30` pour insérer des données et vérifier que les tables de contrôle fonctionnent.
