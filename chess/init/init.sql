CREATE TABLE FigureType (
	type VARCHAR(10),
	price SMALLINT NOT NULL,
	
	PRIMARY KEY(type)	
);


CREATE TABLE ChessMan (
	id INT GENERATED ALWAYS AS IDENTITY,
	type VARCHAR(10),
	color CHAR(5) CHECK (color IN ('White', 'Black')),
	
	PRIMARY KEY(id),
	FOREIGN KEY(type) REFERENCES FigureType (type)
);


CREATE TABLE ChessBoard (
	id INT,
	row SMALLINT CHECK(row >= 1 AND row <= 8),
	cln CHAR CHECK(cln IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H')),
	
	PRIMARY KEY(id),
	FOREIGN KEY(id) REFERENCES ChessMan (id),
	UNIQUE(row, cln)
)