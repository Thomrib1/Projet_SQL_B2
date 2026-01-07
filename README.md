# clAra Mobility — Système de gestion de flotte électrique 🚗⚡️

Une base de données **PostgreSQL** destinée à la gestion complète d’une flotte de mobilité électrique (voitures, trottinettes, scooters, vélos), incluant les utilisateurs, les bornes de recharge, les réservations et la maintenance.

---

## ✨ Fonctionnalités
- Modélisation **Merise** (MCD / MLD)
- Schéma relationnel PostgreSQL robuste
  - Clés primaires / étrangères
  - Contraintes `CHECK`, `NOT NULL`, `UNIQUE`
- Requêtes SQL avancées
- **Vues**, **triggers** et **fonctions métiers**
- Scripts d’initialisation
- Jeux de données **CSV** pour les tests

---

## 🗂️ Structure du projet
```
.
├── create_tables.sql        # Création des tables + contraintes
├── drop_tables.sql          # Suppression des tables (optionnel)
├── views.sql                # Vues SQL
├── triggers.sql             # Triggers
├── functions.sql            # Fonctions métiers
├── data/
│   ├── utilisateurs.csv
│   ├── vehicules.csv
│   ├── bornes.csv
│   └── reservations.csv
└── README.md
```

---

## 🛠️ Prérequis
- PostgreSQL **15 ou supérieur**
- pgAdmin 4 (recommandé)
---

## 🚀 Installation

1. Créer la base de données :
```sql
CREATE DATABASE clara_mobility;
```

2. Ouvrir **pgAdmin** → *Query Tool*
3. Exécuter le script :
```sql
create_tables.sql
```
4. Importer les fichiers CSV via :
> Clic droit sur la table → *Import / Export Data*

ℹ️ Dans `create_tables.sql`, des lignes `DROP TABLE` sont présentes en **commentaires** afin de pouvoir recréer facilement la base en cas de besoin.

---

## 🧠 Modélisation
- **MCD** : entités Véhicule, Utilisateur, Borne, Réservation, Maintenance
- **MLD** : transformation relationnelle avec gestion des cardinalités

---

## 📊 Exemples de requêtes
- Véhicules disponibles par type
- Historique des réservations par utilisateur
- Taux d’utilisation de la flotte
- Bornes les plus utilisées

---

## ⚙️ Triggers & Fonctions
- Mise à jour automatique de l’état des véhicules
- Vérification de disponibilité lors des réservations
- Calcul de durée et de coût

---

## 🧪 Tests
Les fichiers CSV permettent de :
- Valider la cohérence des contraintes
- Tester les triggers et fonctions
