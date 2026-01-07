# clAra Mobility — Système de gestion de flotte électrique 🚗⚡️

Une base PostgreSQL pour gérer véhicules (voitures, trottinettes, scooters, vélos), utilisateurs, bornes, réservations et maintenance.

✨ Fonctionnalités
- Modélisation Merise (MCD / MLD) 🧭
- Schéma PostgreSQL : PK, FK, CHECK, NOT NULL 🔐
- Requêtes avancées, vues, triggers, fonctions métiers ⚙️
- Scripts d'initialisation + jeux de données CSV pour tests 🧪

🛠️ Prérequis
- PostgreSQL ≥ 15
- pgAdmin 4 (optionnel)
- Accès au dépôt Git

🚀 Installation rapide
1. Créer la base : `clara_mobility`  
2. Ouvrir pgAdmin → Query Tool  
3. Exécuter `create_tables.sql` (F5) pour créer la structure  
4. Importer les CSV via Import/Export Data sur chaque table

Dans create tables il y a des lignes en commentaires "drop table" dans le cas où l'on voudrait re faire la db sur pg Admin !

