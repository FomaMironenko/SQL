SELECT COUNT(DISTINCT Products.ProductID) FROM Orders 
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE Employees.FirstNAme = 'Anne'