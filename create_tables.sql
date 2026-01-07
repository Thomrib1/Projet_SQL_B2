/* DROP TABLE IF EXISTS TRANSACTIONS CASCADE;
DROP TABLE IF EXISTS PAIEMENTS CASCADE;
DROP TABLE IF EXISTS MAINTENANCES CASCADE;
DROP TABLE IF EXISTS RESERVATIONS CASCADE;
DROP TABLE IF EXISTS LOCATIONS CASCADE;
DROP TABLE IF EXISTS BORNES_DE_RECHARGE CASCADE;
DROP TABLE IF EXISTS VEHICULES CASCADE;
DROP TABLE IF EXISTS TECHNICIENS CASCADE;
DROP TABLE IF EXISTS CLIENTS CASCADE;
DROP TABLE IF EXISTS STATIONS CASCADE;
Seulemnt dans le cas pour re dl le squelette de la db sur pg admin*/

CREATE TABLE STATIONS (
    id_station SERIAL PRIMARY KEY,
    Nom VARCHAR(50),
    capacite_max_vehicules INT CHECK (capacite_max_vehicules > 0),
    lieu VARCHAR(100)
);

CREATE TABLE CLIENTS (
    id_client SERIAL PRIMARY KEY,
    Nom VARCHAR(50) NOT NULL,
    Prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL CHECK (email LIKE '%@%.%'),
    telephone VARCHAR(20) NOT NULL,
    date_inscription DATE,
    validite_permis DATE,
    CHECK (validite_permis >= date_inscription)
);

CREATE TABLE TECHNICIENS (
    id_technicien SERIAL PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    email VARCHAR(100) CHECK (email LIKE '%@%.%'),
    telephone VARCHAR(20),
    date_embauche DATE,
    statut VARCHAR(30) CHECK (statut IN ('Actif', 'Indisponible'))
);

CREATE TABLE VEHICULES (
    id INT PRIMARY KEY,
    marque VARCHAR(50) NOT NULL,
    modele VARCHAR(50) NOT NULL,
    annee INT CHECK (annee > 1900),
    energie VARCHAR(20),
    autonomie_km INT CHECK (autonomie_km > 0),
    immatriculation VARCHAR(20) UNIQUE,
    etat VARCHAR(30) CHECK (etat IN ('Disponible', 'En maintenance', 'Hors service', 'En service')),
    localisation VARCHAR(100)
);

CREATE TABLE BORNES_DE_RECHARGE (
    id_borne SERIAL PRIMARY KEY,
    puissance_kw INT CHECK (puissance_kw > 0),
    statut_borne VARCHAR(30) CHECK (statut_borne IN ('Disponible', 'En maintenance', 'Hors service')),
    type_connecteur VARCHAR(30) CHECK (type_connecteur IN ('Type 2', 'CCS Combo')),
    id_station INT,
    FOREIGN KEY (id_station) REFERENCES STATIONS(id_station)
);

CREATE TABLE LOCATIONS (
    id_location SERIAL PRIMARY KEY,
    heure_debut TIMESTAMP,
    heure_fin TIMESTAMP,
    statut_location VARCHAR(30) CHECK (statut_location IN ('Terminée', 'En cours', 'Prévue')),
    id_client INT,
    id_vehicule INT,
    FOREIGN KEY (id_client) REFERENCES CLIENTS(id_client),
    FOREIGN KEY (id_vehicule) REFERENCES VEHICULES(id),
    CHECK (heure_fin >= heure_debut)
);

CREATE TABLE RESERVATIONS (
    id_reservation SERIAL PRIMARY KEY,
    date_debut_reservation TIMESTAMP,
    date_fin_reservation TIMESTAMP,
    statut_reservation VARCHAR(30) CHECK (statut_reservation IN ('Terminée', 'Confirmée', 'En attente')),
    id_client INT,
    id_vehicule INT,
    FOREIGN KEY (id_client) REFERENCES CLIENTS(id_client),
    FOREIGN KEY (id_vehicule) REFERENCES VEHICULES(id),
    CHECK (date_fin_reservation >= date_debut_reservation)
);

CREATE TABLE MAINTENANCES (
    id_maintenance SERIAL PRIMARY KEY,
    date_demande DATE,
    date_intervention DATE,
    statut_maintenance VARCHAR(30) CHECK (statut_maintenance IN ('Terminée', 'En cours', 'Planifiée')),
    cout_intervention DECIMAL(10,2) CHECK (cout_intervention >= 0),
    id_vehicule INT,
    id_technicien INT,
    FOREIGN KEY (id_vehicule) REFERENCES VEHICULES(id),
    FOREIGN KEY (id_technicien) REFERENCES TECHNICIENS(id_technicien),
    CHECK (date_intervention >= date_demande OR date_intervention IS NULL)
);

CREATE TABLE PAIEMENTS (
    id_paiement SERIAL PRIMARY KEY,
    montant_total DECIMAL(10,2) NOT NULL CHECK (montant_total >= 0),
    statut_paiement VARCHAR(30) CHECK (statut_paiement IN ('Payé', 'En attente')),
    id_location INT,
    FOREIGN KEY (id_location) REFERENCES LOCATIONS(id_location)
);

CREATE TABLE TRANSACTIONS (
    id_transaction SERIAL PRIMARY KEY,
    montant_transaction DECIMAL(10,2) NOT NULL CHECK (montant_transaction >= 0),
    moyen_paiement VARCHAR(30) NOT NULL CHECK (moyen_paiement IN ('Carte Bancaire', 'PayPal', 'Apple Pay')),
    statut_transaction VARCHAR(30) NOT NULL CHECK (statut_transaction IN ('Succès', 'En attente', 'Échec')),
    id_paiement INT,
    FOREIGN KEY (id_paiement) REFERENCES PAIEMENTS(id_paiement)
);