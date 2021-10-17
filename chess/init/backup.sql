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
);



INSERT INTO FigureType(type, price) VALUES 
('King', 10),
('Queen', 9),
('Rook', 5),
('Bishop', 3),
('Knight', 3),
('Pawn', 1);



INSERT INTO ChessMan (type, color) VALUES
('King', 'Black'),
('King', 'White'),
('Queen', 'Black'),
('Queen', 'White'),
('Rook', 'Black'),
('Rook', 'Black'),
('Rook', 'White'),
('Rook', 'White'),
('Bishop', 'Black'),
('Bishop', 'Black'),
('Bishop', 'White'),
('Bishop', 'White'),
('Knight', 'Black'),
('Knight', 'Black'),
('Knight', 'White'),
('Knight', 'White'),
('Pawn', 'Black'),
('Pawn', 'Black'),
('Pawn', 'Black'),
('Pawn', 'Black'),
('Pawn', 'Black'),
('Pawn', 'Black'),
('Pawn', 'Black'),
('Pawn', 'Black'),
('Pawn', 'White'),
('Pawn', 'White'),
('Pawn', 'White'),
('Pawn', 'White'),
('Pawn', 'White'),
('Pawn', 'White'),
('Pawn', 'White'),
('Pawn', 'White');




INSERT INTO ChessBoard
(id, row, cln) VALUES
(1, 8, 'B'),
(3, 7, 'C'),
(6, 8, 'F'),
(13, 3, 'G'),
(19, 7, 'B'),
(23, 6, 'C'),

(2, 1, 'G'),
(4, 5, 'H'),
(11, 4, 'B'),
(26, 2, 'F'),
(27, 2, 'G'),
(31, 3, 'H');