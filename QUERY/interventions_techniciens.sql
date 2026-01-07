SELECT t.nom, t.prenom, t.statut, COUNT(m.id_maintenance) AS nbr_interventions, STRING_AGG(CAST(m.id_vehicule AS TEXT), ', ') AS vehicules
FROM maintenances m
JOIN techniciens t ON m.id_technicien = t.id_technicien
GROUP BY t.id_technicien, t.nom, t.prenom, t.statut
ORDER BY nbr_interventions ASC;