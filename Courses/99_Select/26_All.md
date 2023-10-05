# **PROGRAMMATION**

## **ALL**

l'option **ALL** va peaufiner ce critère de recherche, en vérifiant que toute la condition est respectée pour tous les registres de la sous-requête.

_Exemple_

Importer, dans la table interne T_TRAVEL, les trajets de la table ZTRAVEL dont le champ KMS (kilométrage) est strictement inférieur ou égal à tous les kilométrages de ZTRAVEL définis dans une sous-requête.

```ABAP
SELECT city_from,
       country_from,
       city_to,
       country_to,
       kms
  FROM ztravel
  INTO TABLE @DATA(lt_travel)
  WHERE kms <= ALL ( SELECT kms FROM ztravel ).


DATA ls_travel LIKE LINE OF lt_travel.

LOOP AT lt_travel INTO ls_travel.
  WRITE:/ ls_travel-city_from, ls_travel-country_from,
          ls_travel-city_to,   ls_travel-country_to,
          ls_travel-kms.
ENDLOOP.
```

| **CITY_FROM** | **COUNTRY_FROM** | **CITY_TO** | **COUNTRY_TO** | **KMS** |
| ------------- | ---------------- | ----------- | -------------- | ------- |
| BARCELONE     | ES               | LERIDA      | ES             | 170     |
