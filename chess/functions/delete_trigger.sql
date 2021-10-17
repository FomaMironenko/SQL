CREATE OR REPLACE FUNCTION delete_trigger_fcn() RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
DECLARE
	toDropType VARCHAR(10);
	toDropCln CHAR(1);
	toDropRow SMALLINT;
BEGIN
	---- CHECK CORRECTNESS ----
	IF 	OLD.id IS NULL
		THEN RAISE EXCEPTION 'WRONG DELETE';
	END IF;
	SELECT type, cln, row INTO toDropType, toDropCln, toDropRow 
	FROM chessboard JOIN chessman ON chessboard.id = chessman.id
	WHERE chessboard.id = OLD.id;
	IF toDropType IS NULL THEN
		RAISE EXCEPTION 'TRYING TO EAT NONEXISTENT FIGURE %', OLD.id;
	END IF;
	IF toDropType = 'King' THEN
		RAISE EXCEPTION 'TRYING TO EAT A "King": %', OLD.id;
	END IF;
	---- LOG DATA ----
	INSERT INTO movelogs (type, figId, row, cln)
	VALUES('DEL', OLD.id, toDropRow, toDropCln);
	CALL log_eat(OLD.id, OLD.cln, OLD.row);
	
	RETURN OLD;
END
$$;

DROP TRIGGER IF EXISTS delete_trigger
ON chessboard;

CREATE TRIGGER delete_trigger BEFORE DELETE ON chessboard
	FOR EACH ROW EXECUTE PROCEDURE delete_trigger_fcn();

