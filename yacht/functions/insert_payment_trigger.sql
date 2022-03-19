CREATE OR REPLACE FUNCTION insert_payment_trigger_fcn() RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
DECLARE
    
BEGIN
    IF (NEW.rent_id NOT IN (SELECT ActiveRent.rent_id FROM ActiveRent))
    THEN
        RAISE EXCEPTION 'The rent % is closed or not exists', NEW.rent_id;
    END IF;
	
	UPDATE Rent
    SET amount = GREATEST(CAST(0 AS MONEY), amount - NEW.amount)
    WHERE id = NEW.rent_id;
	
	RETURN NEW;
END
$$;

DROP TRIGGER IF EXISTS insert_payment_trigger
ON Payment;

CREATE TRIGGER insert_payment_trigger BEFORE INSERT ON Payment
	FOR EACH ROW EXECUTE PROCEDURE insert_payment_trigger_fcn();
