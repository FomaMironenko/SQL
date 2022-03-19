CREATE OR REPLACE FUNCTION is_in_rent(yid INT) RETURNS BOOLEAN
LANGUAGE plpgsql AS
$$
BEGIN
    RETURN (yid IN (
		SELECT Rent.yacht_id 
        FROM ActiveRent
        LEFT JOIN Rent ON Rent.id = ActiveRent.rent_id
	));
END
$$