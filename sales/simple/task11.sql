SELECT * FROM Customers
WHERE 
LEFT(LOWER(CustomerName), 7) = 'antonio' OR
RIGHT(LOWER(CustomerName), 7) = 'antonio' OR
LOWER(CustomerName) LIKE '% antonio %'