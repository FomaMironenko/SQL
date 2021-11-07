SELECT Yacht.name, COUNT(*) AS rent_number
FROM Rent
JOIN Yacht ON Yacht.id = Rent.yacht_id
GROUP BY Yacht.id, Yacht.name
ORDER BY rent_number DESC, name ASC