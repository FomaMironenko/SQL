CREATE OR REPLACE FUNCTION insert_rent_trigger_fcn() RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
DECLARE
    _price MONEY;
BEGIN
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
