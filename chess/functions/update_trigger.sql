CREATE OR REPLACE FUNCTION update_trigger_fcn() RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
DECLARE
	isFreeCell BOOLEAN;
BEGIN
	---- CHECK CORRECTNESS ----
	IF 	NEW.row IS NULL OR NEW.cln IS NULL OR
		OLD.row IS NULL OR OLD.cln IS NULL OR
		NEW.id  IS NULL OR OLD.id  IS NULL OR
		NEW.id <> OLD.id
		THEN RAISE EXCEPTION 'WRONG UPDATE PARAMETERS';
	END IF;
	IF NEW.ROW = OLD.ROW AND NEW.cln = OLD.cln THEN
		RAISE EXCEPTION 'WRONG UPDATE: SAME CELL';
	END IF;
	SELECT COUNT(*) = 0 INTO isFreeCell
	FROM chessboard WHERE row = NEW.row AND cln = NEW.cln;
	IF NOT isFreeCell THEN
		RAISE EXCEPTION 'CAN NOT MOVE TO AN OCCUPIED CELL';
	END IF;
	---- LOG DATA ----
	INSERT INTO movelogs (type, figId, row, cln)
	VALUES('DEL', OLD.id, OLD.row, OLD.cln);
	INSERT INTO movelogs (type, figId, row, cln)
	VALUES('INS', NEW.id, NEW.row, NEW.cln);
	CALL log_move(NEW.id, OLD.cln, OLD.row, NEW.cln, NEW.row);
	
	RETURN NEW;
END
$$;

DROP TRIGGER IF EXISTS update_trigger
ON chessboard;

CREATE TRIGGER update_trigger BEFORE UPDATE ON chessboard
	FOR EACH ROW EXECUTE PROCEDURE update_trigger_fcn();

