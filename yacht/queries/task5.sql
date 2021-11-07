SELECT 
CONCAT(Customer.name, ' ', Customer.patronymic, ' ', Customer.surename) AS customer,
CloseRent._date - (Rent.init_date + Rent.length) AS delay,
'CLOSED' AS status
FROM Rent
JOIN CloseRent ON CloseRent.rent_id = Rent.id
JOIN Customer ON Customer.id = Rent.customer_id
WHERE CloseRent._date > Rent.init_date + Rent.length

UNION

SELECT
CONCAT(Customer.name, ' ', Customer.patronymic, ' ', Customer.surename) AS customer,
CURRENT_DATE - (Rent.init_date + Rent.length) AS delay,
'OPEN' AS status
FROM Rent
JOIN ActiveRent ON ActiveRent.rent_id = Rent.id
JOIN Customer ON Customer.id = Rent.customer_id
WHERE CURRENT_DATE > Rent.init_date + Rent.length

ORDER BY delay DESC