-- 1. Fonction mise à jour auto du statut d'une location
CREATE OR REPLACE FUNCTION update_location_status() -- crée une fonction / remplace si existe déjà pour mettre à jour automatiquement le statut
RETURNS TRIGGER AS $$                               -- renvoie le triger en tant que $$ pour moins de confusion avec exemple: "'mot'"
BEGIN
    IF NEW.heure_fin < CURRENT_TIMESTAMP THEN       -- si heure de fin est < à heure actuelle
        NEW.statut_location := 'Terminée';          -- alors statut de location devient 'Terminée'
    END IF;
    RETURN NEW;                                     -- renvoie nouvelle ligne modif  
END;
$$ LANGUAGE plpgsql;                                -- langage utilisé = plpgsql (pour utiliser 'CURRENT_TimeSTAMP')

CREATE TRIGGER trigger_check_statut_location        -- Déclencheur de la fonction au dessus
BEFORE INSERT OR UPDATE ON LOCATIONS                -- exécute fonction au dessus avant insert ou màj table LOCATIONS sur chaque lignes
FOR EACH ROW                                
EXECUTE FUNCTION update_location_status();         


-- 2. Vue pour places dispo par station
CREATE VIEW vue_capacite_stations AS                -- crée vue pour capacité des stations
SELECT                                              -- selectionne: nom, capacité max, nb véhicules présents, places dispo
    s.Nom, 
    s.capacite_max_vehicules, 
    COUNT(v.id) AS vehicules_presents, 
    (s.capacite_max_vehicules - COUNT(v.id)) AS places_disponibles
FROM STATIONS s
LEFT JOIN VEHICULES v ON s.lieu = v.localisation    -- jointure entre stations et véhicules selon lieu/localisation
GROUP BY s.id_station, s.Nom, s.capacite_max_vehicules, s.lieu;     -- regroupé par id_station, nom, capacité max, lieu


-- 3. Moyenne de prix et de durée par marque de véhicule
SELECT 
    v.marque, 
    v.modele,   
    COALESCE(AVG(l.heure_fin - l.heure_debut), '00:00:00') AS duree_moyenne,    -- moyenne durée location + COALESCE rajoute valeur par defaut si null
    COALESCE(AVG(p.montant_total), 0) AS cout_moyen                         -- moyenne coût location
FROM VEHICULES v
LEFT JOIN LOCATIONS l ON v.id = l.id_vehicule AND l.statut_location = 'Terminée'  -- jointure entre véhicules et locations selon id_vehicule + filtre statut location 'Terminée'
LEFT JOIN PAIEMENTS p ON l.id_location = p.id_location                       -- jointure entre locations et paiements selon id_location
GROUP BY v.marque, v.modele                                     -- regroupé par marque et modèle    
ORDER BY cout_moyen DESC;                                   


-- 4. Nbr de réservations par client
SELECT clients.Nom, clients.Prenom, COUNT(id_reservation) AS reservation_par_clients    -- sélectionne nom, prénom et compte nbr de réservations par client
FROM reservations
JOIN clients ON clients.id_client = reservations.id_client  -- jointure entre clients et réservations selon id_client
GROUP BY clients.id_client, clients.Nom, clients.Prenom;    -- regroupé par id_client, nom et prénom


-- 5. Interventions des techniciens et véhicules concernés
SELECT t.nom, t.prenom, t.statut, COUNT(m.id_maintenance) AS nbr_interventions, STRING_AGG(CAST(m.id_vehicule AS TEXT), ', ') AS vehicules
FROM maintenances m
JOIN techniciens t ON m.id_technicien = t.id_technicien     -- jointure entre maintenances et techniciens selon id_technicien
GROUP BY t.id_technicien, t.nom, t.prenom, t.statut         -- regroupé par id_technicien, nom, prénom et statut
ORDER BY nbr_interventions ASC;


-- 6. Liste des bornes de recharge par station
SELECT * FROM bornes_de_recharge b                          -- sélectionne tout de la table bornes_de_recharge
JOIN stations s ON s.id_station = b.id_station;             -- jointure entre stations et bornes_de_recharge selon id_station


-- 7. Liste des véhicules disponibles
SELECT * FROM vehicules                                     -- sélectionne tout de la table véhicules   
WHERE etat = 'Disponible';                                  -- filtre pour véhicules disponibles


-- 8. Total des paiements encaissés
SELECT SUM(montant_total) AS total_paiements               -- somme des montants totaux des paiements de la table paiements
FROM paiements;                             


--9. Suppression des paiements refusés
CREATE OR REPLACE FUNCTION supprimer_paiement_refuse()  --Créer ou remplacer une fonction pour supprimer les paiements refusés
RETURNS TRIGGER AS $$                                   -- renvoie le triger en tant que $$ pour moins de confusion avec exemple: "'mot'"
BEGIN
    IF NEW.statut_paiement = 'Paiement refusé' THEN      -- si le statut du paiement est 'Paiement refusé'  
        DELETE FROM paiements WHERE id_paiement = NEW.id_paiement; -- alors supprime le paiement de la table paiements selon id_paiement
        RETURN NULL;
    END IF;                 
    RETURN NEW;                                         -- renvoie nouvelle ligne modif
END;
$$ LANGUAGE plpgsql;                                    -- langage utilisé = plpgsql (pour utiliser 'IF ... END IF;')

CREATE TRIGGER trigger_suppr_paiement_errone            -- Execute la fonction au dessus
AFTER INSERT OR UPDATE ON paiements                     -- Execute après insert ou màj table paiements sur chaque lignes 
FOR EACH ROW
EXECUTE FUNCTION supprimer_paiement_refuse();