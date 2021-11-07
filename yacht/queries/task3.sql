SELECT 	CONCAT(Customer.name, ' ', Customer.patronymic, ' ', Customer.surename) AS customer,
		Yacht.name AS yacht_name,
		STRING_AGG( CONCAT(
			CAST(init_date AS VARCHAR), '/', CAST(init_date + length AS VARCHAR)), ';  '
		) AS dates

FROM Rent
JOIN Customer ON Rent.customer_id = Customer.id
JOIN Yacht ON Rent.yacht_id = Yacht.id

GROUP BY Rent.customer_id, Rent.yacht_id,
Customer.name, Customer.surename, Customer.patronymic,
Yacht.name
HAVING COUNT(*) >= 2