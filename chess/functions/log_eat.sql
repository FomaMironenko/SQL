CREATE OR REPLACE PROCEDURE log_eat(toDropId INT, figCln CHAR(1), figRow SMALLINT)
LANGUAGE plpgsql AS
$$ DECLARE 
	figColor CHAR(5);
	figType VARCHAR(10);
BEGIN 
	SELECT color, type INTO figColor, figType FROM chessman WHERE id = toDropId;
	RAISE NOTICE 'DROP % %: (%, %)', figColor, figType, figCln, figRow;
END $$