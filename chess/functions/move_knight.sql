-- DROP PROCEDURE move_knight(INTEGER);

CREATE OR REPLACE PROCEDURE move_knight(figId INT, destCln CHAR(1), destRow SMALLINT)
LANGUAGE plpgsql AS
$$
DECLARE 
	c CHAR(1);
	r SMALLINT;
	figType VARCHAR(10);
	toDropId INT;
	toDropType VARCHAR(10);
BEGIN
	---- EXTRACT OPERATING FIGURE ----
	IF 	destRow NOT BETWEEN 1 AND 8 OR
	   	destCln NOT IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H')
		THEN RAISE EXCEPTION
			'DESTINATION CELL (%, %) OUT OF CHESSBOARD', destCln, destRow;
	END IF;
	-- extract figure data
	SELECT chessboard.cln, chessboard.row, chessman.type INTO c, r, figType
	FROM chessman JOIN chessboard ON chessman.id = chessboard.id
	WHERE chessman.id = figId;
	-- checks
	IF c IS NULL OR r IS NULL THEN
		RAISE EXCEPTION 'ID NOT FOUND: %', figId;
	END IF;
	IF figType <> 'Knight' THEN
		RAISE EXCEPTION 'FIGURE TYPE IS "%" INSTEAD OF "Knight"', figType;
	END IF;
	IF 	NOT (ABS(ASCII(c) - ASCII(destCln)) = 1 AND ABS(r - destRow) = 2) AND
		NOT (ABS(ASCII(c) - ASCII(destCln)) = 2 AND ABS(r - destRow) = 1)
		THEN RAISE EXCEPTION
			'WRONG KNIGHT MOVE: (%, %)', ABS(ASCII(c) - ASCII(destCln)), ABS(r - destRow);
	END IF;
	
	---- COMMIT A MOVE ----
	SELECT chessman.id, chessman.type INTO toDropId, toDropType
	FROM chessman JOIN chessboard ON chessman.id = chessboard.id
	WHERE chessboard.cln = destCln AND chessboard.row = destRow;
	IF toDropId IS NOT NULL THEN
		IF (SELECT same_color(figId, toDropId)) THEN
			RAISE EXCEPTION 'CAN NOT EAT A FIGURE OF SAME COLOR';
		END IF;
		DELETE FROM chessboard WHERE chessboard.id = toDropId;
		UPDATE chessboard SET row = destRow, cln = destCln WHERE id = figId;
	ELSE
		UPDATE chessboard SET row = destRow, cln = destCln WHERE id = figId;
	END IF;
END 
$$
