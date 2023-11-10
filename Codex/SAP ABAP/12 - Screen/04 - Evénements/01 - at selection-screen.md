# **`AT SELECTION SCREEN`**

Il a été vu dans la section précédente concernant les champs de l’écran de sélection, l’événement `AT SELECTION-SCREEN OUTPUT` exécuté avant l’affichage de l’écran de sélection, permettant ainsi de renseigner un paramètre. Cette section aura donc pour but de lister les principaux événements d’un écran de sélection, utilisés dans un programme ABAP.

```JS
AT SELECTION-SCREEN   { OUTPUT }
                    | { ON {para|selcrit} }
                    | { ON END OF selcrit }
                    | { ON BLOCK block }
                    | { ON RADIOBUTTON GROUP group }
                    | { ON VALUE-REQUEST
                           FOR {para|selcrit-low|selcrit-high} }
                    | { ON EXIT-COMMAND }
                    | (...).
```

Pour la suite de ce chapitre, l’exemple du `BEGIN OF BLOCK` sera repris pour être complété avec les événements.
