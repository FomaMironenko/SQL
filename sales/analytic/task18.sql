SELECT Customers.ContactName, COUNT(DISTINCT Orders.OrderID) AS Npurchase
FROM Orders JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerID, Customers.ContactName
ORDER BY Npurchase DESC