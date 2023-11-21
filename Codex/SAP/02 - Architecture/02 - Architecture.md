# **`ARCHITECTURE`**

D'un point de vue simplifié, l'architecture SAP peut être représentée de la façon suivante :

![](../99%20-%20Ressources/01%20-%20SAP%20-%2004.png)

Elle est constituée de trois couches :

- La première est le NetWeaver, plateforme technique représentant l'architecture orientée service (SOA en anglais pour Services Oriented Architecture)

- La seconde est la suite utilisée regroupant les services de la solution SAP définis selon le besoin de l'entreprise

- La troisième couche est celle des modules qui est un sous-ensemble indépendant regroupant fonctionnalités, programmes et base de données.

Plusieurs options techniques existent concernant le NetWeaver :

- SAP NetWeaver Process Integration (PI) :

  Composant permettant d'aléliorer les échanges d'informations entre SAP et externes (comme pour les interfaces...)

- SAP NetWeaver Business Warehouse (BW) :

  Est un outil de reporting et d'analyse des informations SAP et externes. Il permet d'intégrer et de consolider les données de l'entreprise, et donc de mettre en avant des décisions stratégiques nécessaires par une meilleure organisation des flux et des processus.

- SAP NetWeaver Mobile :

  offre aux clients et aux collaborateurs, un accès à SAP grâce à des applications spécialement développées pour les technologies mobiles.

- SAP NetWeaver Composition Environment (CE) :

  Il permet de créer et d'exécuter des applications principalement en Java, consultables via un site internet (portal) ou mobile (conjointement avec SAP Mobile)

- SAP Enterprise Portal :

  Grâce à un navigateur web, permet à un utilisateur (collaborateur, client, partenaire...) d'accéder au système SAP après authentification (utilisateur/mot de passe)

- SAP Application Server ou SAP Web Application Server (WebAS)

  qui est le serveur des applications et serveur web pour SAP. C'est le composant central de la solution.

COmme presque la totalité des entreprises utilisent cette dernière option, il serait intéressant d'en détailler sa structure. WebAS, plus communément désigné comme SAP Business Suite, comporte également plusieurs suites :

- SAP CRM (Customer Relationship Management)

  Soit gestion de la relation client, est une solution faite pour les partie commerciale d'une société. Elle met à disposition des équipes vente, par exemple, un outil permettant d'entreprendre, de développer et d'entretenir les relations avec le clients ; le marketing pourra l'utiliser pour aligner les processus marketing sur la stratégie commerciale, et ainsi gérer la demande des clients, et augmenter le retour sur investissement.

- SAP ERP (Enterprise Resource Planning) :

  Comme vu dans la section précédente, permet de centraliser toutes les informations des différens départements d'une entreprise (achats, production...)

- SAP PLM (Product LifeCycle Management) :

  Traduit par Gestion du cycle de vie des produites, permet de créer et suivre un produit tout au long de sa vie, de son cahier des charges/conception jusqu'à son obsolescence/remplacement. Il définit aussi son mode de fébrication, de distribution, de stockage...

- SAP SCM (Supply Chain Management) :

  Ou Gestion de la chaîne logistique, a pour but d'augmenter la réactivité du traitement de la demande client (de la plannification de cette demande à la gestion des stocks) en mettant en place un réseau de distribution complexe, mais rapide.

- SAP SRM (Supplier Relationship Management) :

  est une solution permettant à l'entreprise d'identifier les fournisseurs potentiels selon leur coût, leur capacité de production, les délais de livraison, la garantie de qualité... afin d'optimliser le processus d'approvisionnement.

> L'apprentissage du langage ABAP s'effectuera sur une architecture Web AS avec la solution SAP ERP. Il est temps maintenant de voie la dernière couche de cette architecture : les modules.
