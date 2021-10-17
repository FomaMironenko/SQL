CREATE OR REPLACE PROCEDURE log_move(
	figId INT, figCln CHAR(1), figRow SMALLINT, destCln CHAR(1), destRow SMALLINT)
LANGUAGE plpgsql AS
$$ DECLARE 
	figColor CHAR(5);
	figType VARCHAR(10);
BEGIN 
	SELECT color, type INTO figColor, figType FROM chessman WHERE id = figId;
	RAISE NOTICE 'MOVE % %: (%, %) -> (%, %)', figColor, figType, figCln, figRow, destCln, destRow;
END $$