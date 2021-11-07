SELECT CONCAT(Customer.name, ' ', Customer.patronymic, ' ', Customer.surename) AS bad_customer 
FROM Rent 
JOIN CloseRent ON CloseRent.rent_id = Rent.id
JOIN Inspection ON Inspection.id = CloseRent.inspection_id
JOIN Customer ON Customer.id = Rent.customer_id
WHERE Inspection.passed = FALSE
