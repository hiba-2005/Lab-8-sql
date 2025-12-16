# 🧪 TP8 — Sauvegarde, restauration & optimisation (MySQL)

## 🎯 Objectif
Mettre en pratique :
- la **sauvegarde** (complète et partielle) avec `mysqldump`
- la **restauration** via CLI (`mysql < dump.sql`)
- l’**export/import CSV** (`INTO OUTFILE` / `LOAD DATA INFILE`)
- l’**optimisation** avec index, `EXPLAIN`, `ANALYZE`, `OPTIMIZE`

---

## ✅ Prérequis
- Windows 10/11
- MySQL Server 8.x installé
- MySQL Workbench installé (optionnel)
- Accès au terminal **CMD**
- Port utilisé : `3307` (adapter si besoin)

---

# 🧪 TP8 — Sauvegarde, restauration & optimisation (MySQL)

## 🎯 Objectif
Mettre en pratique :
- la **sauvegarde** (complète et partielle) avec `mysqldump`
- la **restauration** via CLI (`mysql < dump.sql`)
- l’**export/import CSV** (`INTO OUTFILE` / `LOAD DATA INFILE`)
- l’**optimisation** avec index, `EXPLAIN`, `ANALYZE`, `OPTIMIZE`

---

## ✅ Prérequis
- Windows 10/11
- MySQL Server 8.x installé
- MySQL Workbench installé (optionnel)
- Accès au terminal **CMD**
- Port utilisé : `3307` (adapter si besoin)

---


## ⚙️ Connexion (CLI)
Chemin des outils (exemple) :
````
C:\Program Files\MySQL\MySQL Server 8.0\bin
````
Connexion MySQL :
```bat
mysql -u root -p -P 3307
````
![WhatsApp Image 2025-12-16 à 20 56 23_2f8f2f17](https://github.com/user-attachments/assets/0454ab8d-a097-4281-a26d-ee7c6e95d285)

![WhatsApp Image 2025-12-16 à 20 55 50_022a82f8](https://github.com/user-attachments/assets/2ed0a9d2-fa93-4397-b265-5f50b7b8cd77)

![WhatsApp Image 2025-12-16 à 20 55 33_45c682e5](https://github.com/user-attachments/assets/e9976d1d-505b-4fcc-af0f-f9e332688b11)

##  ✅ Conclusion

Ce TP montre comment :

sécuriser les données via des sauvegardes

restaurer rapidement une base

transférer des données via CSV

améliorer les performances avec index et analyse du plan d’exécution (EXPLAIN)


