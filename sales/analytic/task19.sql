SELECT 
CONCAT(Employees.LastName, ' ', Employees.FirstName) AS Employee_name,
COUNT(DISTINCT Customers.CustomerID) AS Ncustomers
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Employees.EmployeeID, Employees.LastName, Employees.FirstName