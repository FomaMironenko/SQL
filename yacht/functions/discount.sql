CREATE OR REPLACE FUNCTION discount(cust_id INTEGER) RETURNS DOUBLE PRECISION
LANGUAGE plpgsql AS
$$
DECLARE
    SCALE DOUBLE PRECISION = 0.0001;
    failed_insp BOOLEAN;
    cur_rent_outdated BOOLEAN;
    outdated_ret BOOLEAN;
BEGIN
	IF (cust_id NOT IN (SELECT id FROM Customer)) THEN
        RAISE EXCEPTION 'There is no customer with id %', cust_id;
    END IF;
    --- CHECK FAILED INSPECTIONS
    SELECT NOT BOOL_AND(passed) FROM Rent
    JOIN CloseRent ON CloseRent.rent_id = Rent.id
	JOIN Inspection ON Inspection.id = CloseRent.inspection_id
    WHERE Rent.customer_id = cust_id
    INTO failed_insp;
    IF failed_insp THEN
        RAISE NOTICE 'Customer % has failed an inspection', cust_id;
        RETURN 0.0;
    END IF;
    --- CHECK OUTDATED CURRENT RENTS
	SELECT BOOL_OR(CURRENT_DATE > Rent.init_date + Rent.length) FROM Rent
	RIGHT JOIN ActiveRent ON ActiveRent.rent_id = Rent.id
	WHERE Rent.customer_id = cust_id
    INTO cur_rent_outdated;
    IF cur_rent_outdated THEN
        RAISE NOTICE 'Customer % has outdated a current rent', cust_id;
        RETURN 0.0;
    END IF;
    --- CHECK OUTDATED RETURNS ---
    SELECT BOOL_OR (CloseRent._date > init_date + length) FROM Rent
	RIGHT JOIN CloseRent ON CloseRent.rent_id = Rent.id
	WHERE Rent.customer_id = cust_id
    INTO outdated_ret;
    IF outdated_ret THEN
        RAISE NOTICE 'Customer % has outdated a return', cust_id;
        RETURN 0.0;
    END IF;
    --- COMPUTE A DISCOUNT ---
    RETURN (SELECT LEAST(0.25, SCALE * CAST((
        SELECT SUM(Payment.amount) FROM Rent
        JOIN Payment ON Payment.rent_id = Rent.id
        WHERE Rent.customer_id = cust_id
    ) AS NUMERIC)));
END
$$