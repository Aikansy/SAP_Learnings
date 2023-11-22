# **STMS**

Anne-Laure Labreuche - Responsable RH & Recrutement
Laurent Peret - Directeur Associé STMS
Frantz Bagneris - Responsable Pôle Technique

Xavier Ayral - Directeur Associé STMS
Frédéric Bellomo - Directeur Associé STMS

## **[ KEY WORDS ]**

- `Programme`

  Ensemble d'**instructions** exécutables et qui permet à ce dernier de répondre à un problème. Il est essentiellement créé à l'aide d'**algorithmes** prenant un ensemble de données en entrée, exécute des **instructions** puis retourne des données en sortie.

- `Algorithme`

  Ensemble de méthodes utilisées (par un ordinateur) pour résoudre un problème donné. Il décrit une suite d'**instruction** permettant d'obtenir un résultat à partir d'éléments fournis en entrée.

  - **Construction** :

    Découper un grand problème en sous-problèmes plus accessibles et plus simples, débutez un raisonnement par un angle permettant d'identifier et de séparer chaque action progressivement et logiquement.

  - **Ecriture** :

    **pseudo-code**, ou **LDA** (Langage de Description Algorithmique) : manière informelle de décrire la programmation, qui ne nécessite **aucune** syntaxe de langage de programmation stricte. Il est utilisé pour créer une ébauche, un brouillon d'un **programme**.

  - **Programmation structurée** :

    Paradigmes de programmation : permet de découper un problème en microtâches indépendantes les unes des autres, et modulaires grâce à ses outils.

- `Domaine`

  Un domaine va définir les caractéristiques techniques de base d’un champ contenu dans une table. Il peut être de plusieurs types dont voici les principaux : CHAR, DATS, NUMC, MATNR, STRING, ...

- `Eléments de données`

  l’élément de données est tout simplement l’objet qui va définir le visuel du champ (titre, nom des colonnes...) et quelques caractéristiques additionnelles (aide à la recherche...) et il n’est pas rare de rencontrer un nom de domaine identique à celui de l’élément de données.

- `Instruction`

  On distingue trois grandes catégories d'instructions :

  - **Opérations de base** : addition, soustraction, multiplication, division
  - **Exécution conditionnelle** : IF (condition), THEN (alors fais ça), ELSE IF (sinon fais ça)
  - **Itération** : répéter une instruction, un nombre de fois déterminé ou non déterminé (FOR, WHILE, DO WHILE)

- `Diagrammes UML` (Unified Modeling Language)

  est un moyen de représenter visuellement l’**architecture**, la **conception** et la **mise en œuvre** de systèmes logiciels complexes. Une application comporte des milliers de lignes de code, ce qui rend difficile la gestion des interactions et des hiérarchies. Les diagrammes UML résolvent ce problème en divisant un système logiciel en **composants** et **sous-composants**.

- `ABAP Objet`

  les **objets** sont des sortes de conteneurs d'informations. En plus de ces informations, les objets offrent des services à partir ou non de ces informations. On dit **classe** afin de catégoriser chaque objet. Un objet (modèle) est défini par des **attributs** et des **méthodes**.

- `Node.js`

  **Node.js** est un environnement d’exécution single-thread, open-source et multi-plateforme permettant de créer des applications rapides et évolutives côté serveur et en réseau.

- `Express.js`

  **Express.js**, parfois aussi appelé « Express », est un **framework backend Node.js minimaliste**, **rapide** et de type Sinatra qui offre des fonctionnalités et des outils robustes pour développer des **applications backend évolutives**. Il vous offre le système de **routage** et des **fonctionnalités** simplifiées pour étendre le framework en développant des composants et des parties plus puissants en fonction des cas d’utilisation de votre application.

  **Express.js** est le **framework backend** le plus populaire pour **Node.js**, et il fait partie intégrante de l’**écosystème JavaScript**. Il est conçu pour construire des applications web monopages, multipages et hybrides, il est également devenu la norme pour le développement d’applications backend avec Node.js, et il constitue la partie backend de ce que l’on appelle la pile **MEVN**.

  La pile **MEVN** est une pile logicielle **JavaScript** gratuite et open source pour la construction de sites et d’applications web dynamiques qui comporte les composants suivants :

  - **MongoDB** :

    MongoDB est la base de données NoSQL standard

  - **Express.js** :

    Le framework d’applications web par défaut pour la création d’applications web

  - **Vue.js** :

    Le framework JavaScript progressif utilisé pour créer des applications web frontend

  - **Node.js** :

    Moteur JavaScript utilisé pour les applications évolutives côté serveur et en réseau.

- `Classe` - **[ TCODE SE24 ]**

  Elément technique qui **permet de créer un objet** et d’en **assurer le traitement grâce à des méthodes**. En programmation, on appelle ceci l’**encapsulation**, qui est une notion phare en programmation orientée objet.

  - **Héritage** (mère-filles)

    Une **sous-classe** appartenant à une **surclasse** ou une **super-classe** va hériter/récupérer les **attributs** et **méthodes** de cette dernière.

  - **Instanciation**

    Il s’agit de l’action de **créer un objet**. Dans un programme ABAP, l’instruction **CREATE OBJECT** est utilisée pour effectuer cette tâche. Cependant, les options d’instanciation d’une classe sont les suivantes :

    - Privé : l’objet ne peut être créé que par la classe elle-même.
    - Protégé : C’est la même chose que privé sauf que l’objet peut être appelé par la classe elle-même ou ses sous-classes.

  - **Amis**

    Définir un ami permet de lui donner accès à tous les attributs, méthodes... d’une classe. Cependant, "l’amitié n’est ni héritée, ni transitive, ni réciproque", ce qui signifie que la ou les sous-classes amies ne peuvent pas accéder aux attributs de la classe principale ni les amis de la classe amie, et que cela ne donne aucun privilège à la classe principale sur la classe amie.

  - **Attributs**

    Les attributs regroupent les différentes variables, constantes... de la classe.

- `Méthode`

  Les **méthodes** sont des traitements membres d'une **classe** agissant sur un objet ou non. Les **méthodes** sont listées en suivant toujours la règle : celles en bleu viennent d'un **héritage** et celles en noir sont **spécifiques** à la classe.

  Chaque **méthode** possède des **paramètres** en **entrée**, ainsi qu’en **sortie**. Ainsi, on pourrait penser qu’une méthode dans une classe est la même chose qu’un module fonction dans un groupe de fonctions, sauf que la fonction est un traitement indépendant ne faisant pas partie d’un ensemble comme l’objet. De ce fait, le groupe de fonctions agit comme un conteneur de fonctions, au contraire de la classe.

  - **Type Instance Method**

    Pour ce genre de méthode, il est nécessaire de générer l’instance de la classe via l’instruction CREATE OBJECT et une variable d’objet faisant référence à cette classe.

  - **Type Static Method**

    Pour ce genre de méthode, nul besoin de générer l’instance, la méthode peut être appelée directement.

  - **Constructor**

    Cette méthode va générer l’instance (créer l'objet) de la classe (non privée) via une variable d’objet.

- `Fonction` - **[ TCODE SE37 ]**

  La fonction ou plus exactement le **module fonction** permet d’isoler un traitement spécifique (conversion, récupération d’informations, gestion de données...). Une fonction est un outil technique permettant de **traiter des informations** selon des **paramètres d'entrée**, pour définir de nouvelles dans des **paramètres de sortie**.

- `LSMW` (_Legacy System Migration Workbench_) - **[ TCODE LSMW ]**

  est un **atelier de migration de système** hérité à l'aide duquel nous pouvons importer les données d'un système non-SAP vers un système SAP . Il est spécialement conçu pour les **consultants fonctionnels** qui ne sont pas experts dans le codage et peut être effectué en 14 étapes. Avec la **LSMW** on peut choisir parmi quatre façons d'importer des données dans SAP qui sont : **BDC**, **entrée directe**, **BAPI** (BO) et **IDOC**.

  - `BAPI`

    Création d'un objet métier à partir d'un fichier

  - `Batch input Recording` - **[ TCODE SM35 ]**

    Simulation d'un scenario pré-programmé utilisateur.

    Session d'enregistrement d'entrée de données avec possibilité de supprimer les valeurs par défaut, identifier et mapper les champs

  - `SHDB` - **[ TCODE SHDB ] Transaction Recorder**

    Transaction enregistrant les simulations de transaction

    (Outils standards) Un Transaction Recorder représente tout simplement un outil permettant d’enregistrer une succession de transactions et de vues, les **vues** étant plus communément appelées **Dynpro** ou encore **Screen**.

    Le but étant d’effectuer une fois manuellement, ce que SAP va lui, par la suite, reproduire de manière plus ou moins automatisée via deux procédés différents: **Session Method** ou **Call Transaction**.

- `Dynpro` - **[ TCODE SE80 ]**

  **Dynamisches Programm** (_Programme Dynamique_) qui peut être **spécifique** ou **standard** (SAP Natif), possède un **identifiant** (Nombre à 4 chiffres ; i.e 1000). Le Dynpro est différent d'un Web Dynpro.

  Les Dynpros utilisent des **PBO** (Process Before Input), des **PAI** (Process After Input), des **variables globales**, des **fonctions** et des **modules** (nom donné pour les PERFORMS). Il n'est cependant pas possible d'enchainer plus de 9 écrans.

- `User-Exit`

  - **Type Perform**

    Type spécifique de User-Exit dans SAP qui permet d'exécuter une routine personnalisée pendant l'exécution d'un programme standard SAP.

  - **Type Fonction**

    Type spécifique de User-Exit dans SAP qui permet de remplacer une fonction standard SAP par une fonction personnalisée.

  - **Type Table**

    Type spécifique de User-Exit dans SAP qui permet de personnaliser le contenu d'une table SAP en ajoutant ou en modifiant des données.

  - **Type Ecran**

    Type spécifique de User-Exit dans SAP qui permet de personnaliser l'interface utilisateur SAP en ajoutant ou en modifiant des champs ou des écrans.

  - **BADI** - **[ TCODE SE18 ]**

    La BAdI est une interface object.

    BAdI est l'acronyme de Business Add-In, qui est un mécanisme d'extension de SAP permettant de personnaliser et d'étendre les fonctionnalités des applications SAP standard sans avoir à modifier directement leur code source.

    Un BAdI est un point d'entrée spécifique dans le code SAP standard, qui est conçu pour permettre aux développeurs d'ajouter leur propre code pour personnaliser ou étendre les fonctionnalités d'une application SAP. Les BAdIs sont des interfaces fournies par SAP pour permettre aux développeurs de créer leur propre implémentation de BAdI et de l'attacher à l'application SAP standard.

- `UI5 - Demo Kit`

  https://sapui5.hana.ondemand.com

## **[ MODULES ]**

- MM

  - MM01 - Create Material
  - MM02 - Change Material
  - MM03 - Display Material
  - ME51N - Create Purchase Requisition
  - ME52N - Change Purchase Requisition
  - ME53N - Display Purchase Requisition

- SD

  - VA01 - Create Order
  - VA02 - Change Order
  - VA03 - Display Order

- FI

  - FB01 - Post Document
  - FB02 - Change Document
  - FB03 - Display Document

## **STMS**

- Since 2007

- Sites

  - Toulouse
  - Paris
  - Bordeaux

## **WHY ME ?**

- Equipe
- Entraide / Mutualisation / Capitalisation
- Curieux
- Veille informative
- Adaptation
- Souplesse
- Réactivité
- Gestion du stress

### **Ce que j'aime**

- Diagnostic
- Recherche de solution
- Matérialisation des réponses
- Former
- Numérique
- Nouvelles techologies
- Domaines précis

## **WHY STMS ?**

- Innovation

  - IoT
  - Fiori
  - S/4 Hana
  - Cloud
  - Chatbot

- Suivi de carrière

  - Parrain
  - Suivi personnalisé
  - Formateur

- Cadre

  - Moderne
  - Respectueux
  - Bienveillance
  - Entraide

## **LEXIQUE**

- BTP :

  Business Technology Platform
