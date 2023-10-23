# **`AT SELECTION-SCREEN ON para | selcrit`**

- `AT SELECTION-SCREEN ON para | selcrit`

  - `Moment d’exécution` : lorsque l’utilisateur appuie sur la touche [Entrée] ou lors de l’exécution du programme.

  - `Rôle` : cible un paramètre para ou une sélection selcrit, pour en vérifier sa valeur...

  _Exemple_

  _Vérifier si le SELECT-OPTIONS S_TRDATE est bien renseigné, sinon afficher un message d’erreur._

  ```JS
  ...

  AT SELECTION-SCREEN ON s_trdate.
  IF s_trdate IS INITIAL.
      MESSAGE e001(00) with 'Le champ doit être renseigné'.
  ENDIF.
  ```

> L’instruction `MESSAGE` fait référence à la classe de message 00, numéro 001 (transaction `SE91`). Ce message sera construit avec le texte `Le champ doit être renseigné`. La lettre `E` devant le numéro est la criticité du message : `E` pour erreur (le programme est alors bloqué jusqu’à résolution de l’erreur), `W` pour Warning (= avertissement, et le programme n’est pas bloqué), et `S` pour Succès (pas de blocage du programme).
