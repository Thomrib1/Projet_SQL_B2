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