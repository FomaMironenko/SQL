CREATE OR REPLACE FUNCTION insert_rent_trigger_after_fcn() RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
BEGIN
    INSERT INTO ActiveRent (rent_id) VALUES (NEW.id);
	RETURN NEW;
END
$$;

DROP TRIGGER IF EXISTS insert_rent_after_trigger
ON Rent;

CREATE TRIGGER insert_rent_after_trigger AFTER INSERT ON Rent
	FOR EACH ROW EXECUTE PROCEDURE insert_rent_trigger_after_fcn();
