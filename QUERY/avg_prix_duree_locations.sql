SELECT 
    v.marque, 
    v.modele,
	-- COALESCE (met une valeur par defaut)
    COALESCE(AVG(l.heure_fin - l.heure_debut), '00:00:00') AS duree_moyenne,
    COALESCE(AVG(p.montant_total), 0) AS cout_moyen
FROM VEHICULES v
LEFT JOIN LOCATIONS l ON v.id = l.id_vehicule AND l.statut_location = 'Terminée'
LEFT JOIN PAIEMENTS p ON l.id_location = p.id_location
GROUP BY v.marque, v.modele
ORDER BY cout_moyen DESC;