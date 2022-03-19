CREATE OR REPLACE FUNCTION insert_rent_trigger_fcn() RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
DECLARE
    _price MONEY;
	lastInspection DATE;
BEGIN
    --------- VALIDATE THE OPERATION ---------
    IF (SELECT is_in_rent(NEW.yacht_id)) THEN
        RAISE EXCEPTION 'The yacht % is in active rent', NEW.yacht_id;
    END IF;
	SELECT 
		MAX(_date) FROM Inspection WHERE yacht_id = NEW.yacht_id
	INTO lastInspection;
	IF (lastInspection IS NULL OR lastInspection < CURRENT_DATE - 31) THEN
	   RAISE EXCEPTION 'The yacht % needs to be inspected', NEW.yacht_id;
	END IF;

    --------- COMPUTE THE AMOUNT OF RENT ---------
	SELECT price FROM YachtType
    JOIN Yacht ON YachtType.id = Yacht.yacht_type
    WHERE Yacht.id = NEW.yacht_id
    INTO _price;

    IF _price IS NULL THEN
        RAISE EXCEPTION 'WRONG INSERT PARAMETERS';
    END IF;
    NEW.amount = _price * NEW.length;
	RETURN NEW;
END
$$;

DROP TRIGGER IF EXISTS insert_rent_trigger
ON Rent;

CREATE TRIGGER insert_rent_trigger BEFORE INSERT ON Rent
	FOR EACH ROW EXECUTE PROCEDURE insert_rent_trigger_fcn();
