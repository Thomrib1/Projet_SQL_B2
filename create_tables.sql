CREATE TABLE VEHICULES (
    id_vehicule SERIAL PRIMARY KEY,
    marque VARCHAR(50) NOT NULL,
    modele VARCHAR(50) NOT NULL,
    annee INT,
    energie VARCHAR(20),
    autonomie_km INT,
    immatriculation VARCHAR(20) UNIQUE,
    etat VARCHAR(30),
    dernier_controle DATE
);

CREATE TABLE CLIENTS (
    id_client SERIAL PRIMARY KEY,
    Nom VARCHAR(50) NOT NULL,
    Prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telephone VARCHAR(20) NOT NULL,
    date_inscription DATE,
    validite_permis DATE
);

CREATE TABLE LOCATIONS (
    id_location SERIAL PRIMARY KEY,
    heure_debut TIMESTAMP,
    heure_fin TIMESTAMP,
    statut_location VARCHAR(30)
);

CREATE TABLE PAIEMENTS (
    id_paiement SERIAL PRIMARY KEY,
    montant_total DECIMAL(10,2) NOT NULL,
    statut_paiement VARCHAR(30)
);

CREATE TABLE TRANSACTIONS (
    id_transaction SERIAL PRIMARY KEY,
    montant_transaction DECIMAL(10,2) NOT NULL,
    moyen_paiement VARCHAR(30) NOT NULL,
    statut_transaction VARCHAR(30) NOT NULL
);

CREATE TABLE RESERVATIONS (
    id_reservation SERIAL PRIMARY KEY,
    date_debut_reservation TIMESTAMP,
    date_fin_reservation TIMESTAMP,
    statut_reservation VARCHAR(30)
);

CREATE TABLE MAINTENANCES (
    id_maintenance SERIAL PRIMARY KEY,
    date_demande DATE,
    date_intervention DATE,
    statut_maintenance VARCHAR(30),
    cout_intervention DECIMAL(10,2)
);

CREATE TABLE TECHNICIENS (
    id_technicien SERIAL PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    email VARCHAR(100),
    telephone VARCHAR(20),
    date_demande DATE,
    statut VARCHAR(30)
);

CREATE TABLE STATIONS (
    id_station SERIAL PRIMARY KEY,
    Nom VARCHAR(50),
    capacite_max_vehicules INT,
    lieu VARCHAR(100)
);

CREATE TABLE BORNES_DE_RECHARGE (
    id_borne_de_recharge SERIAL PRIMARY KEY,
    puissance_kw INT,
    statut_borne VARCHAR(30),
    type_connecteur VARCHAR(30)
);