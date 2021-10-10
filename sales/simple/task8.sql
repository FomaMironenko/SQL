SELECT TOP 1 * FROM Products 
WHERE Price = (SELECT MAX(Price) FROM Products)