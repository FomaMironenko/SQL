WITH 
rent_lengths AS (
	SELECT 
		Rent.customer_id AS cust_id,
		CloseRent._date - Rent.init_date AS length
	FROM Rent
	JOIN CloseRent ON CloseRent.rent_id = Rent.id
	UNION
	SELECT 
		Rent.customer_id AS cust_id,
		CURRENT_DATE - Rent.init_date AS length
	FROM Rent
	JOIN ActiveRent ON ActiveRent.rent_id = Rent.id
),
total_lengths AS (
	SELECT
		CONCAT(Customer.name, ' ', Customer.patronymic, ' ', Customer.surename) AS customer,
		SUM(length) AS rent_days
	FROM rent_lengths
	JOIN Customer ON rent_lengths.cust_id = Customer.id
	GROUP BY Customer.id, Customer.name, Customer.patronymic, Customer.surename
)

SELECT * FROM total_lengths
ORDER BY rent_days DESC
FETCH FIRST 1 ROWS WITH TIES
