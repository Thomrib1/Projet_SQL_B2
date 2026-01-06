-- 1. Liste véhicules avec localisation
SELECT v.marque, v.modele, v.etat, s.nom AS station_nom
FROM vehicules v
JOIN stations s ON v.localisation = s.nom;

-- 2. Puissance max des bornes + autonomie moyenne véhicules
SELECT MAX(puissance_kw) AS puissance_max, AVG(autonomie_km) AS autonomie_moyenne 
FROM bornes_de_recharge, vehicules;

-- 3. Clients n'ayant jamais réservé
SELECT nom, prenom FROM clients
WHERE id_client NOT IN (SELECT id_client FROM reservations);

-- 4. Vue de l'occupation des stations
CREATE OR REPLACE VIEW vue_stations_capacite AS
SELECT nom, lieu, capacite_max_vehicules FROM stations;

-- 5. Mise à jour auto de l'état véhicule pendant maintenance
CREATE OR REPLACE FUNCTION fn_update_statut_maintenance()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE vehicules SET etat = 'En maintenance' WHERE id = NEW.id_vehicule;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_debut_maintenance
AFTER INSERT ON maintenances
FOR EACH ROW EXECUTE FUNCTION fn_update_statut_maintenance();

-- 6. Calcul montant total avec taxe 20%
CREATE OR REPLACE FUNCTION calculer_montant_ttc(montant_ht DECIMAL)
RETURNS DECIMAL AS $$
BEGIN
    RETURN montant_ht * 1.20;
END;
$$ LANGUAGE plpgsql;

-- 7. Test de la fonction sur  paiements
SELECT id_paiement, montant_total, calculer_montant_ttc(montant_total) AS total_ttc FROM paiements;

-- 8. 5 dernières transactions effectuées
SELECT * FROM transactions ORDER BY id_transaction DESC LIMIT 5;

-- 9. Marquer une borne hors service
UPDATE bornes_de_recharge SET statut_borne = 'Hors service' WHERE id_borne = 1;

-- 10. Effacer paiements échoués
DELETE FROM paiements WHERE statut_paiement = 'Echoué';