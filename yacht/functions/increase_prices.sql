CREATE OR REPLACE PROCEDURE increase_prices(pct INTEGER)
LANGUAGE plpgsql AS
$$
DECLARE
    coef DOUBLE PRECISION;
	upd_row ActiveRent%rowtype;
BEGIN
    IF (pct <= -100) THEN
        RAISE EXCEPTION 'Wrong percentage: %', pct;
    END IF;
    ------ update yacht type prices ------
    coef = CAST(pct + 100 AS DOUBLE PRECISION) / 100.0;
    UPDATE YachtType 
    SET price = price * coef;
    ------ update active rents prices ------
    FOR upd_row IN SELECT rent_id FROM ActiveRent
    LOOP
        UPDATE Rent 
        SET amount = amount * coef
        WHERE id = upd_row.id AND amount > CAST(0 AS MONEY);
    END LOOP; 
END
$$