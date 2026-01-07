INSERT INTO STATIONS (Nom, capacite_max_vehicules, lieu) VALUES
('Station Nord Paris', 50, 'Paris'),
('Station Bellecour', 50, 'Lyon'),
('Station Vieux Port', 50, 'Marseille'),
('Station Euralille', 50, 'Lille'),
('Station Quinconces', 50, 'Bordeaux');

INSERT INTO CLIENTS (Nom, Prenom, email, telephone, date_inscription, validite_permis) VALUES
('Dupont', 'Jean', 'j.dupont@email.com', '0601020304', '2024-01-15', '2030-12-31'),
('Martin', 'Marie', 'm.martin@email.com', '0611223344', '2024-02-10', '2028-06-15'),
('Lefebvre', 'Thomas', 't.lefebvre@email.com', '0622334455', '2024-03-05', '2032-01-20'),
('Bernard', 'Sophie', 's.bernard@email.com', '0633445566', '2024-04-12', '2029-09-10'),
('Petit', 'Lucas', 'l.petit@email.com', '0644556677', '2024-05-20', '2031-03-25');

INSERT INTO TECHNICIENS (Nom, Prenom, email, telephone, date_embauche, statut) VALUES
('Durand', 'Paul', 'p.durand@garage.com', '0701020304', '2022-06-01', 'Actif'),
('Leroy', 'Alice', 'a.leroy@garage.com', '0711223344', '2023-01-15', 'Actif'),
('Moreau', 'Kevin', 'k.moreau@garage.com', '0722334455', '2021-09-10', 'Indisponible'),
('Simon', 'Claire', 'c.simon@garage.com', '0733445566', '2023-05-20', 'Actif'),
('Giraud', 'Alain', 'a.giraud@garage.com', '0744556677', '2020-11-30', 'Actif');

INSERT INTO BORNES_DE_RECHARGE (puissance_kw, statut_borne, type_connecteur, id_station) VALUES
(50, 'Disponible', 'Type 2', 1),
(150, 'Disponible', 'CCS Combo', 1),
(22, 'En maintenance', 'Type 2', 2),
(50, 'Disponible', 'Type 2', 3),
(100, 'Hors service', 'CCS Combo', 5);

INSERT INTO RESERVATIONS (date_debut_reservation, date_fin_reservation, statut_reservation, id_client, id_vehicule) VALUES
('2025-01-01 08:00', '2025-01-01 18:00', 'Terminée', 1, 1),
('2025-01-02 09:00', '2025-01-03 09:00', 'Terminée', 2, 2),
('2025-01-05 10:00', '2025-01-05 20:00', 'Confirmée', 3, 5),
('2025-01-10 14:00', '2025-01-12 10:00', 'En attente', 5, 4),
('2025-01-15 07:00', '2025-01-15 19:00', 'Confirmée', 1, 2);

INSERT INTO LOCATIONS (heure_debut, heure_fin, statut_location, id_client, id_vehicule) VALUES
('2025-01-01 08:00:00', '2025-01-01 18:00:00', 'Terminée', 1, 1),
('2025-01-02 09:00:00', '2025-01-03 09:00:00', 'Terminée', 2, 2),
('2025-01-05 10:00:00', '2025-01-05 20:00:00', 'En cours', 3, 5),
('2025-01-10 14:00:00', '2025-01-12 10:00:00', 'Prévue', 5, 4),
('2025-01-15 07:00:00', '2025-01-15 19:00:00', 'Prévue', 1, 2);

INSERT INTO MAINTENANCES (date_demande, date_intervention, statut_maintenance, cout_intervention, id_vehicule, id_technicien) VALUES
('2024-12-20', '2024-12-21', 'Terminée', 120.50, 3, 1),
('2024-12-28', '2024-12-29', 'Terminée', 85.00, 2, 2),
('2025-01-02', NULL, 'En cours', 0.00, 3, 4),
('2025-01-04', '2025-01-05', 'Terminée', 250.00, 1, 5),
('2025-01-06', NULL, 'Planifiée', 0.00, 5, 1);

INSERT INTO PAIEMENTS (montant_total, statut_paiement, id_location) VALUES
(45.00, 'Payé', 1),
(110.00, 'Payé', 2),
(55.00, 'En attente', 3),
(90.00, 'Payé', 4),
(40.00, 'Payé', 5);

INSERT INTO TRANSACTIONS (montant_transaction, moyen_paiement, statut_transaction, id_paiement) VALUES
(45.00, 'Carte Bancaire', 'Succès', 1),
(110.00, 'PayPal', 'Succès', 2),
(55.00, 'Carte Bancaire', 'En attente', 3),
(90.00, 'Carte Bancaire', 'Succès', 4),
(40.00, 'Apple Pay', 'Succès', 5);