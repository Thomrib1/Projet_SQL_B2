SELECT * FROM bornes_de_recharge b
JOIN stations s ON s.id_station = b.id_station;