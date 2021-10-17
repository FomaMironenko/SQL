CREATE OR REPLACE FUNCTION same_color(id1 INT, id2 INT) RETURNS BOOLEAN
LANGUAGE plpgsql AS
$$
DECLARE
	color1 CHAR(5);
	color2 CHAR(5);
BEGIN
	SELECT color INTO color1
	FROM chessman WHERE chessman.id = id1;
	SELECT color INTO color2
	FROM chessman WHERE chessman.id = id2;
	RETURN (color1 IS NOT NULL) AND (color2 IS NOT NULL) AND (color1 = color2); 
END
$$