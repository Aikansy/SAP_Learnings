# **LSMW**

Atelier de migration systeme hérité pour importer des données spécialement dédié aux fonctionnels

4 méthodes d'importation de données depuis un système non SAP :
- Batch Input
- Entrée directe
- Bapi
- iDoc

[ TCODE : LSMW ]

- Project: Nom du projet (zfgi_proj)
- Project: Nom du projet (zfgi_sub_proj)
- Project: Nom du projet (zcom_vente)

[ CREATE ENTRY ]

- Description: a remplir

[ F8 ]

- Select

[ EXECUTE ]

- Batch Input Recording = 'X'.
- [ CLIC ] Bouton recording de la même ligne (dernier bouton)

[ CREATE RECORDING ] ctrl + f1

- Recording: zfgi_va01
- Description: Enregistrement création com. vente en VA01 pour LSMW BI
- Owner: AELION07

- Code transacton: VA01
