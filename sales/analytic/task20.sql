SELECT 
Orders.OrderID,
SUM(Products.Price * OrderDetails.Quantity) / SUM(OrderDetails.Quantity) AS avg_price
FROM Orders
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Orders.OrderID
ORDER BY avg_price DESC