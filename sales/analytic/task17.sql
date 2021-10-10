SELECT 
CONCAT(Employees.LastName, ' ', Employees.FirstName) AS name, 
COUNT(DISTINCT Orders.OrderID) AS Nsails 
FROM Orders 
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY Employees.EmployeeID, Employees.LastName, Employees.FirstName