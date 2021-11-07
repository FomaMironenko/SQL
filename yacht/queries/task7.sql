WITH
payments AS (
	SELECT 
	CONCAT(Customer.name, ' ', Customer.patronymic, ' ', Customer.surename) AS customer,
	SUM(Payment.amount) AS total_pay
	FROM Rent 
	JOIN Payment ON Payment.rent_id = Rent.id
	JOIN Customer ON Customer.id = Rent.customer_id
	GROUP BY Customer.id, Customer.name, Customer.patronymic, Customer.surename
)

SELECT * FROM payments 
ORDER BY total_pay DESC
FETCH FIRST 1 ROWS WITH TIES
	