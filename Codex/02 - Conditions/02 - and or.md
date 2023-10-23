# **`AND & OR`**

Plusieurs conditions peuvent également être testées en même temps grâce au `AND` (et) et au `OR` (ou).

_Test sur le mois et le jour pour afficher un texte correspondant :_

```JS
DATA: v_month TYPE i,
      v_day   TYPE i.

v_month = sy-datum+4(2).
v_day   = sy-datum+6(2).

IF v_month = 12 OR v_month = 1 OR v_month = 2.
  WRITE:/'C''est l''hiver'.
ELSEIF v_month = 3 OR v_month = 4 OR v_month = 5.
  WRITE:/'C''est le printemps'.
ELSEIF v_month = 6 OR v_month = 7 OR v_month = 8.
  WRITE:/'C''est l''été'.
ELSEIF v_month = 9 OR v_month = 10 OR v_month = 11.
  WRITE:/'C''est l''automne'.
ENDIF.

IF v_month = 1 AND v_day = 1.
  WRITE:/'Bonne année'.
ElSEIF v_month = 12 AND v_day = 25.
  WRITE:/'Joyeux Noël'.
ELSEIF v_month = 5 and v_day = 1.
  WRITE:/'Bonne fête du travail'.
ELSE.
  WRITE:/'Bonne journée'.
ENDIF.
```

Deux variables `V_MONTH` et `V_DAY` sont créées prenant en compte le mois et le jour de la date système [sy_datum](../99_Help/02_SY-SYSTEM.md). Un premier groupe de conditions va d’abord tester le mois en cours :

- Si le mois est égal à `12`, ou `1` ou `2`, afficher le texte `C’est l’hiver`.
- Sinon s’il s’agit des mois `3`, ou `4` ou `5`, afficher `C’est le printemps`
- Pour `6`, ou `7` ou `8`, afficher `C’est l’été`.
- Et enfin pour les mois `9`, ou `10` ou `11`, afficher le message `C’est l’automne`.

Un deuxième groupe de conditions va tester le mois de l’année et le jour :

- Si le mois est égal à `1` et que le jour est égal à `1` également, afficher `Bonne année`.
- Si le mois de l’année est égal à `12` et le jour à `25`, afficher `Joyeux Noël`.
- Enfin pour le mois `5` et le jour `1`, afficher `Bonne fête du travail`.
- Sinon le programme affichera le texte `Bonne journée`.

Pour la date du test exécuté, le résultat aperçu à l’écran sera le suivant.

![](../99%20-%20Ressources/02_Conditions%20-%2002%20-%2001.png)
