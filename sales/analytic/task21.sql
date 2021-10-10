SELECT 
CONCAT(Employees.LastName, ' ', Employees.FirstName) AS Employee_name,
SUM(Products.Price * OrderDetails.Quantity) AS Total_profit
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Employees.EmployeeID, Employees.LastName, Employees.FirstName
ORDER BY Total_profit DESC