# **`CLIENT INTEGRATION`**

Trois `clients` sont disponibles pour accéder à `SAP Fiori` :

- `Navigateur Web`

- `Client professionnel SAP`

- `Démarrage SAP Mobile`

Vous pouvez également intégrer `SAP Fiori` dans d'autres zones du système pour ajouter des valeurs supplémentaires telles que des `fonctionnalités de connexion` ou une `plage de distribution accrue`. Les détails et les avantages de ces options d'intégration sont discutés plus tard ou examinés plus en profondeur dans d'autres formations :

- `Zone de travail de génération SAP`

- `Portail d'entreprise SAP`

- `Services mobiles SAP`

![](../../99%20-%20Ressources/01_Basics%20of%20SAP%20Fiori%20-%2002_SAP%20Fiori%20Launchpad%20-%2005_Client%20Integration%20-%2001.png)

![](../../99%20-%20Ressources/01_Basics%20of%20SAP%20Fiori%20-%2002_SAP%20Fiori%20Launchpad%20-%2005_Client%20Integration%20-%2002.png)

Maintenant, explorons chacun des client en détail.

![](../../99%20-%20Ressources/01_Basics%20of%20SAP%20Fiori%20-%2002_SAP%20Fiori%20Launchpad%20-%2005_Client%20Integration%20-%2003.png)

La façon originale de démarrer un `FLP` consiste à saisir l'URL `https://<host>:<port>/sap/bc/ui5_ui5/ui2/ushell/shells/abap/FioriLaunchpad.html` dans un navigateur compatible `HTML5`. Cette URL est disponible depuis le début de `SAP Fiori`. Au fil du temps, `SAP` a ajouté des options supplémentaires pour démarrer la barre de lancement.

De nombreux `clients` accèdent au logiciel `SA`P via une connexion à un `serveur d'applications ABAP (AS ABAP)`. Par conséquent, la `transaction /UI2/FLP` est ajoutée. Avec cette `transaction`, vous pouvez vous connecter automatiquement avec les identifiants que vous avez utilisés pour vous connecter à l'`AS ABAP`. Cette approche s'adresse aux utilisateurs travaillant dans les deux mondes, les `transactions ABAP` et les `applications Web SAP Fiori`, si aucun client métier n'est disponible.

> Note
>
> Par défaut, la transaction /UI2/FLP démarre le FLP via le processus Internet Communication Manager (ICM) de votre instance de serveur d'applications. Une entrée dans la table de base de données HTTPURLLOC peut être utilisée pour appeler un proxy inverse, tel que SAP Web Dispatcher.

L'`URL` actuelle pour démarrer le `FLP` est `https://<host>:<port>/sap/bc/ui2/flp`. Cette URL est beaucoup plus courte que celle d’origine et est donc plus facile à mémoriser. La fonctionnalité de gestion du cache est encore plus importante. Cette technique amène les navigateurs Web à charger le contenu depuis le serveur plutôt que depuis le cache du navigateur s'il est activé. Le `cache buster` pour `SAP Fiori` utilise des `URL versionnées` contenant des `jetons` pour signaler au navigateur que de nouvelles ressources sont disponibles sur le serveur. Au lieu d'interdire la mise en cache ou de définir une durée de vie pour les ressources, le système invalide le cache uniquement lorsque les ressources sont effectivement mises à jour sur le serveur.

![](../../99%20-%20Ressources/01_Basics%20of%20SAP%20Fiori%20-%2002_SAP%20Fiori%20Launchpad%20-%2005_Client%20Integration%20-%2004.png)

`SAP Business Client` permet d'accéder à `SAP GUI` et aux `applications Web` dans un seul `logiciel client`. Par conséquent, dans `SAP Business Client 6.0`, la possibilité d'ajouter des `connexions système` pour `FLP` a été introduite. L'avantage est que l'utilisateur final n'a besoin que d'un seul outil pour accéder à toutes les fonctions d'un `AS ABAP`. Il est même possible de démarrer des `transactions ABAP` dans le `FLP`, ce qui ouvre un nouvel `onglet SAP GUI` dans `SAP Business Client`. `SAP Logon` est entièrement intégré à `SAP Business Client`.

> Indice
>
> Pour SAP Business Client 6.0, le terme NetWeaver a été supprimé du nom. Les versions précédentes s'appellent toujours SAP NetWeaver Business Client (NWBC).

![](../../99%20-%20Ressources/01_Basics%20of%20SAP%20Fiori%20-%2002_SAP%20Fiori%20Launchpad%20-%2005_Client%20Integration%20-%2005.png)

`SAP Mobile Start` a été introduit en août 2021. Il s'agit d'une `application mobile` pour `Apple iOS` et `Google Android` intégrée à `SAP S/4HANA` et à d'autres `solutions SAP`, tirant parti de `SAP Business Technology Platform (BTP)`. `SAP Build Work Zone`, l'`édition standard`, le `service de notification` et les `services mobiles` de `BTP` fonctionnent ensemble pour fournir des sites Web et des applications destinés à une utilisation mobile. `SAP Mobile Start` s'intègre aux fonctionnalités du système d'exploitation mobile telles que les notifications, la `recherche Spotlight` et les `widgets` fonctionnant sur les smartphones, les montres et les tablettes.
