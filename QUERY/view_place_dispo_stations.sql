CREATE VIEW vue_capacite_stations AS
SELECT 
    s.Nom, 
    s.capacite_max_vehicules, 
    COUNT(v.id) AS vehicules_presents, 
    (s.capacite_max_vehicules - COUNT(v.id)) AS places_disponibles
FROM STATIONS s
LEFT JOIN VEHICULES v ON s.lieu = v.localisation
GROUP BY s.id_station, s.Nom, s.capacite_max_vehicules, s.lieu;