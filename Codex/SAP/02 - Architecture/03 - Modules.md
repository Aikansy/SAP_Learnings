# **`MODULES`**

Les modules sont des ensembles d'objets SAP, découpés par domaine fonctionnel. Il est possible de distinguer trois grandes familles : Finance, Logistique et Ressources Humaines.

Des modules dits techniques existent également comme BASIS et bien évidemment ABAP.

![](../99%20-%20Ressources/01%20-%20SAP%20-%2005.png)

La suite de ce chapitre donnera un aperçu des modules principaux. Bien entendu, il en existe beaucoup, mais ceux qui seront évoqués sont les plus communs.

Tout d'abord, la finance. Comme son nom l'indique, elle regroupe toutes les fonctionnalités liées aux capitaux (entrants et sortants)... et est principalement composée des modules suivants :

- FI comme Financial ou Finance :

  Il permet de gérer et de représenter toutes les données de la comptabilité générale, fournisseur, client, bancaire...

- CO pour Controlling ou Contrôle de gestion :

  Ici, il s'agit de comptabilité analytique et budgétaire comme le contrôle des frais généraux, le contrôle des coûts...

- TR pour Treasury :

  Pour gérer la trésorerie et la gestion financière (paiments...)

- IM (Investissements Management) :

  pour mesurer et gérer les investissements financiers de l'entreprise.

La famille logistique quant à elle, rassemble tous les services liés à l'organisation d'une entreprise (transports, ventes, stocks) dont l'essentiel des modules dont :

- SD (Sales and Distribution - administration des ventes) :

  Concerne le secteur de la vente comme la gestion des appels d'offres, les commandes, la facturation, la livraison, et ma détermination des prix.

- MM (Material Management) :

  Gère tout ce qui est en rapport avec le stock et l'approvisionnement : achat, réception de marchandises, inventaires...

- PP (Production Planning) :

  Permet de planifier et de contrôler les activités de la production telles que plannification de la fabrication, vente et production et coput de revient des produits.

- QM (Quality Management) :

  Lié aux modules PP et/ou MM avec contrôle qualité, plannification et plans d'inspection.

- PM (Plan Maintenance) :

  Plannification, traitement, exécution des tâches.

Enfin la partie Ressources Humaines est en vérité un module à lui tout seul, permettant de traiter et gérer les informations liées au domaine RH : données de base du personnel, gestion des salaires, temps de travail, frais de déplacement, etc. Mais aussi gestion des compétences, des séminaires, du recrutement...

> Tous ces modules sont indépendants : ils ont leurs propres programmes, tables, fonctions... et agissent comme des fonctionnalités que l'entrepruse peut ou non installer.

Pour finir, on trouve les modules techniques :

- BASIS :

  Regroupant toutes les fonctions de SAP (installation d'un serveur SAP, gestion de l'espace mémoire, des bases de données...).

- ABAP :

  qui concerne donc toute la partie programmation SAP.

Ce sont en fait des éléments fondateurs de la plateforme technique SAP.

_Exemple d'un système SAP simple_

![](../99%20-%20Ressources/01%20-%20SAP%20-%2006.png)

Ce système est composé d'un serveur d'application avec la solution SAP ERP relié à sa propre base de données et quelques modules comme FI, CO, SD, MM et HR.

Cependant, l'architecture peut très vitre devenir beaucoup plus complexe lorsque plusieurs plateformes techniques sont installées.

_ Exemple d'une architecture plus complexe_

![](../99%20-%20Ressources/01%20-%20SAP%20-%2007.png)

Le serveur d'application est toujours présent sauf que cette fois, il incorpore la solution SAP ERP (avec les modules FI, CO, SD, MM et HR) avec SAP SCM (et le module APO). Deux autres plateformes techniques ont été installées : PI permettant à SAP ERP d'échanger des données avec un système externe (qui peut être basé sur du Java, C++, Delphi...), et BW pouvant communiquer avec SAP ERP et SAP SCM.

Chaque système utilise sa propre base de données (principalement Oracle) et ce schéma est encore largement utilisé par une majorité d'entreprises. Sauf que SAP a développé sa propre base de données : HANA.

HANA est une plateforme de données unique et commune à toutes les solutions SAP, pouvant être installé aussi bien sur site (serveur local) qu'en nuage (cloud). C'est une base de données en mémoire (in-memory) et donc stockée et compressée sur la mémoire vive du système, favorisant ainsi un traitement beaucoup plus rapide des informations et éliminant ainsi l'indexation des données. De plus, cette solution diminue les coûts de maintenance et de gestion.

Ainsi, pour reprandre l'exemple ci-dessus, l'architecture ressemblera à ceci :

![](../99%20-%20Ressources/01%20-%20SAP%20-%2008.png)

La suite de ce cours se basera sur une solution SAP ERP (ou ECC - ERP Central Component) de dernier niveau (Ehp7 plus précisément) liée à une base de données HANA. Il est temps maintenant d'entrer dans le vif du sujet et d'apprendre à programmer en ABAP.
