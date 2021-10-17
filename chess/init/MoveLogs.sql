CREATE TABLE MoveLogs (
	id INT GENERATED ALWAYS AS IDENTITY,
	type CHAR(3) CHECK(type IN ('INS', 'DEL')),
	figId INT,
	row SMALLINT CHECK(row >= 1 AND row <= 8),
	cln CHAR CHECK(cln IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H')),
	
	PRIMARY KEY(id),
	FOREIGN KEY(figId) REFERENCES chessman (id)
);