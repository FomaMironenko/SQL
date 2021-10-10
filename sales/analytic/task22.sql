SELECT Products.ProductName, AVG(CAST(OrderDetails.Quantity AS FLOAT)) AS avg_quantity
FROM Orders
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductID, Products.ProductName
ORDER BY avg_quantity DESC, Products.ProductName ASC