SELECT 
Yacht.name AS yacht,
MAX(Inspection._date) AS last_inspection 
FROM Yacht
JOIN Inspection ON Inspection.yacht_id = Yacht.id
GROUP BY Yacht.id
HAVING MAX(Inspection._date) >= CURRENT_DATE - 30