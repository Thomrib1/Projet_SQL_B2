SELECT clients.Nom, clients.Prenom, COUNT(id_reservation) AS reservation_par_clients
FROM reservations
JOIN clients ON clients.id_client = reservations.id_client
GROUP BY clients.id_client, clients.Nom, clients.Prenom;