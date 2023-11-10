# **`TRANSACTIONS`**

## **TRANSACTIONS FONCTIONNELLES**

une `transaction` (code de transaction ou `t-code`) est un identifiant `SAP` pour exécuter divers traitements. Ils peuvent être de l’ordre d’une exécution de programme, de l’ouverture d’un éditeur, de la création d’une facture... Il existe des milliers de transactions et elles sont organisées par catégories correspondant aux modules (`FI`, `SD`, `MM`...) dont voici une toute petite liste des plus utilisées (uniquement les **fonctionnelles**).

| TCODE     | Traitement                            |
| --------- | ------------------------------------- |
| **SPRO**  | (Fonctionnel) Paramétrage             |
| **MM01**  | Création de code Produit              |
| **XD01**  | Création de Client                    |
| **XK01**  | Création de Fournisseur               |
| **VA01**  | Création d'une Commande Client        |
| **ME21N** | Création d'une Commande d'Achat       |
| **VL01N** | Création d'une Livraison              |
| **VF01**  | Création d'une Facture                |
| **MIRO**  | Facture Fournisseur                   |
| **MIGO**  | Mouvement de Stock                    |
| **SCC1**  | Copies des données entre les mandants |

En règle générale, les `transactions` se terminant par :

- `01` signifient création
- `02` modification
- `03` affichage.

Ainsi, la **VA01** va créer une commande client, **VA02** va la modifier et **VA03** l’afficher.

## **TRANSACTIONS TECHNIQUES**

Concernant les `transactions techniques`, il en existe bien évidemment plusieurs et celles qui seront utilisées se situent dans la partie Menu SAP - Outils - ABAP Workbench - Développement.

[Schéma - Chemin d'accès Tcodes Techniques](../99%20-%20Ressources/99_Help%20-%2001%20-%2001.png)

| TCODE     | Traitement                                               |
| --------- | -------------------------------------------------------- |
| **SE01**  | List/Search Ordres de Transports                         |
| **SE11**  | (DDIC) Dictionnaire de Données                           |
| **SE16N** | Table display                                            |
| **SE24**  | Editeur de Classes                                       |
| **SE37**  | Editeur de Fonction                                      |
| **SE38**  | EDITEUR ABAP                                             |
| **SE41**  | Editeur de Menus                                         |
| **SE51**  | Editeur d'Ecrans                                         |
| **SE80**  | Editeur de Programmes                                    |
| **SE91**  | Editeur des Messages                                     |
| **SM04**  | User List                                                |
| **SM12**  | User/Data lock Entries                                   |
| **SM37**  | Executed Job List                                        |
| **SM50**  | Work Process of AS Instance                              |
| **ST05**  | Trace les opérations de DB lors d'exécution de programme |
| **ST22**  | Dumps visual                                             |
| **STMS**  | Gestion des Ordres de Transports                         |
