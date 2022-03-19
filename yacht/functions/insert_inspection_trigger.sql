CREATE OR REPLACE FUNCTION insert_inspection_trigger_fcn() RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
DECLARE
    isInRentState BOOLEAN;
BEGIN
    IF (SELECT is_in_rent(NEW.yacht_id)) THEN
        RAISE EXCEPTION 'The yacht % is in active rent', NEW.yacht_id;
    END IF;
	IF (NEW.yacht_id NOT IN (SELECT id FROM Yacht)) THEN
		RAISE EXCEPTION 'The yacht % does not exist', NEW.yacht_id;
	END IF;
	RETURN NEW;
END
$$;

DROP TRIGGER IF EXISTS insert_inspection_trigger
ON Inspection;

CREATE TRIGGER insert_inspection_trigger BEFORE INSERT ON Inspection
	FOR EACH ROW EXECUTE PROCEDURE insert_inspection_trigger_fcn();
