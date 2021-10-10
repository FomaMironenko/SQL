SELECT COUNT(*) FROM Orders JOIN Employees
ON Orders.EmployeeID = Employees.EmployeeID
WHERE Employees.FirstName = 'Anne'