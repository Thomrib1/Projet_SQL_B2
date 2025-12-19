CREATE TABLE Vehicule (
    id_vehicule SERIAL PRIMARY KEY,
    marque VARCHAR(50) NOT NULL,
    modele VARCHAR(50) NOT NULL,
    annee INT,
    energie VARCHAR(50),
    autonomie_km INT,
    immatriculation VARCHAR(20) UNIQUE,
    etat VARCHAR(30),
    dernier_controle DATE
);

CREATE TABLE Clients (
    id_client SERIAL PRIMARY KEY,
    Nom VARCHAR(50) NOT NULL,
    Prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telephone VARCHAR(20) NOT NULL,
    date_inscription DATE,
    validite_permis DATE
);

CREATE TABLE Locations (
    id_location SERIAL PRIMARY KEY,
    heure_debut TIMESTAMP,
    heure_fin TIMESTAMP,
    statut_location VARCHAR(30)
);

CREATE TABLE Paiements (
    id_paiement SERIAL PRIMARY KEY,
    montant_total DECIMAL(20) NOT NULL,
    statut_paiement VARCHAR(30)
);

CREATE TABLE transactions (
    id_transaction SERIAL PRIMARY KEY,
    montant_transaction DECIMAL(20) NOT NULL,
    moyen_paiement VARCHAR(30) NOT NULL,
    statut_transaction VARCHAR(30) NOT NULL
);

CREATE TABLE reservations (
    id_reservation SERIAL PRIMARY KEY,
    date_debut_reservation TIMESTAMP,
    date_fin_reservation TIMESTAMP,
    statut_reservation VARCHAR(30)
);

