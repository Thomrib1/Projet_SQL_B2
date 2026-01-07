
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
    capacite_max_vehicules INT,
    lieu VARCHAR(100)
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

CREATE TABLE TECHNICIENS (
    id_technicien SERIAL PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    email VARCHAR(100),
    telephone VARCHAR(20),
    date_embauche DATE,
    statut VARCHAR(30)
);

CREATE TABLE VEHICULES (
    id INT PRIMARY KEY,
    marque VARCHAR(50) NOT NULL,
    modele VARCHAR(50) NOT NULL,
    annee INT,
    energie VARCHAR(20),
    autonomie_km INT,
    immatriculation VARCHAR(20) UNIQUE,
    etat VARCHAR(30),
    localisation VARCHAR(100)
);

CREATE TABLE BORNES_DE_RECHARGE (
    id_borne SERIAL PRIMARY KEY,
    puissance_kw INT,
    statut_borne VARCHAR(30),
    type_connecteur VARCHAR(30),
    id_station INT,
    FOREIGN KEY (id_station) REFERENCES STATIONS(id_station)
);

CREATE TABLE LOCATIONS (
    id_location SERIAL PRIMARY KEY,
    heure_debut TIMESTAMP,
    heure_fin TIMESTAMP,
    statut_location VARCHAR(30),
    id_client INT,
    id_vehicule INT,
    FOREIGN KEY (id_client) REFERENCES CLIENTS(id_client),
    FOREIGN KEY (id_vehicule) REFERENCES VEHICULES(id)
);

CREATE TABLE RESERVATIONS (
    id_reservation SERIAL PRIMARY KEY,
    date_debut_reservation TIMESTAMP,
    date_fin_reservation TIMESTAMP,
    statut_reservation VARCHAR(30),
    id_client INT,
    id_vehicule INT,
    FOREIGN KEY (id_client) REFERENCES CLIENTS(id_client),
    FOREIGN KEY (id_vehicule) REFERENCES VEHICULES(id)
);

CREATE TABLE MAINTENANCES (
    id_maintenance SERIAL PRIMARY KEY,
    date_demande DATE,
    date_intervention DATE,
    statut_maintenance VARCHAR(30),
    cout_intervention DECIMAL(10,2),
    id_vehicule INT,
    id_technicien INT,
    FOREIGN KEY (id_vehicule) REFERENCES VEHICULES(id),
    FOREIGN KEY (id_technicien) REFERENCES TECHNICIENS(id_technicien)
);

CREATE TABLE PAIEMENTS (
    id_paiement SERIAL PRIMARY KEY,
    montant_total DECIMAL(10,2) NOT NULL,
    statut_paiement VARCHAR(30),
    id_location INT,
    FOREIGN KEY (id_location) REFERENCES LOCATIONS(id_location)
);

CREATE TABLE TRANSACTIONS (
    id_transaction SERIAL PRIMARY KEY,
    montant_transaction DECIMAL(10,2) NOT NULL,
    moyen_paiement VARCHAR(30) NOT NULL,
    statut_transaction VARCHAR(30) NOT NULL,
    id_paiement INT,
    FOREIGN KEY (id_paiement) REFERENCES PAIEMENTS(id_paiement)
);