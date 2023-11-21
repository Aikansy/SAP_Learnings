# **`TESTS UNITAIRES`**

Une fois le développement terminé, il doit être testé de deux manières :

- Techniquement, afin de s'assurer qu'il n'y a pas d'erreurs de syntaxe lors de l'exécution du programme.

  Sur SAP, cette notion s'appelle un `dump` et ne peut pas être détectée lors de la compilation du programme. Par exemple, une division : c = a / b? L'éditeur ne peut rien voir et pour lui, tout est OK. Sauf si b est égale à 0, alors le programme entre une erreur, et arrête subitement l'exécution en retournant un `dump`.

  ![](../99%20-%20Ressources/05_Tests%20-%2001.png)

  > Dans la majorité des cas, les descriptions des dump sont en anglais ou en allemand.

  Il suffira alors de corriger le problème (dans ce cas-ci, ajouter une condition pour s'assurer que b est strictement supérieur à 0).

- Fonctionnellement :

  Ici, il faudra vérifier que les données retournées sont présentes et cohérentes. Il s'agit d'une analyse assez globale respectant le document fonctionnel. Toujours dans l'exemple ci-dessus, il suffira de vérifier que les documents de vente retournés aient bien des clients appartenant au pays de l'écran de sélection et/ou que les produits de ces documents soient ceux sélectionnés dans l'écran de sélection.
