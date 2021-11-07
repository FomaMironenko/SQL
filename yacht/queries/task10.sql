WITH 
rents AS (
	SELECT 
		Rent.customer_id AS cust_id,
		Rent.yacht_id AS yacht_id,
		CloseRent._date - Rent.init_date AS length
	FROM Rent
	JOIN CloseRent ON CloseRent.rent_id = Rent.id
	UNION
	SELECT 
		Rent.customer_id AS cust_id,
		Rent.yacht_id AS yacht_id,
		CURRENT_DATE - Rent.init_date AS length
	FROM Rent
	JOIN ActiveRent ON ActiveRent.rent_id = Rent.id
),
total AS (
	SELECT cust_id, yacht_id, COUNT(*) as rent_number, SUM(length) AS days_number
	FROM rents
	GROUP BY cust_id, yacht_id
),
part AS (
	SELECT *,
	ROW_NUMBER() OVER (
		PARTITION BY cust_id
		ORDER BY rent_number DESC, days_number DESC)
	AS row_n 
	FROM total
),
_result AS (
	SELECT cust_id, yacht_id, rent_number, days_number
	FROM part
	WHERE row_n = 1
)

SELECT
CONCAT(Customer.name, ' ', Customer.patronymic, ' ', Customer.surename),
Yacht.name,
rent_number,
days_number
FROM Customer
LEFT JOIN _result ON _result.cust_id = Customer.id
LEFT JOIN Yacht ON Yacht.id = _result.yacht_id

