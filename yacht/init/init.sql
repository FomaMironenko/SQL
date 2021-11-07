CREATE TABLE YachtType (
	id INTEGER GENERATED ALWAYS AS IDENTITY,
	quality VARCHAR(10) CHECK (quality IN ('Normal', 'Medium', 'Premium', 'Luxe')),
	people SMALLINT, CHECK (people BETWEEN 1 AND 1000),
	price MONEY, CHECK (price > CAST(0.00 AS MONEY)),
	
	PRIMARY KEY(id)
);

CREATE TABLE Yacht (
	id INTEGER GENERATED BY DEFAULT AS IDENTITY(START 100000 INCREMENT 1),
	yacht_type INTEGER,
	name VARCHAR(100),
	
	FOREIGN KEY (yacht_type) REFERENCES YachtType(id), 
	PRIMARY KEY (id)
);

CREATE TABLE Customer (
	id INTEGER GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100),
	surename VARCHAR(100),
	patronymic VARCHAR(100),
	address VARCHAR(400),
	phone CHAR(11) CHECK (phone SIMILAR TO '8(0|1|2|3|4|5|6|7|8|9)*' ) UNIQUE,
	license VARCHAR(30) CHECK (license SIMILAR TO '(0|1|2|3|4|5|6|7|8|9)*') UNIQUE,
	banc_acc CHAR(16) CHECK (banc_acc SIMILAR TO '(0|1|2|3|4|5|6|7|8|9)*') UNIQUE,
	
	PRIMARY KEY (id)
);

CREATE TABLE Inspection (
	id INTEGER GENERATED ALWAYS AS IDENTITY,
	yacht_id INTEGER,
	_date DATE,
	passed BOOLEAN,
	
	PRIMARY KEY (id),
	FOREIGN KEY (yacht_id) REFERENCES Yacht (id)
);

CREATE TABLE Rent (
	id INTEGER GENERATED ALWAYS AS IDENTITY,
	yacht_id INTEGER,
	customer_id INTEGER,
	init_date DATE,
	length INTEGER CHECK (length > 0),
	amount MONEY DEFAULT(CAST(0.00 AS MONEY)), -- will be set by insert_rent_trigger
	discount DOUBLE PRECISION DEFAULT (0) CHECK (discount BETWEEN 0 AND 1),
	
	PRIMARY KEY (id),
	FOREIGN KEY (yacht_id) REFERENCES Yacht (id),
	FOREIGN KEY (customer_id) REFERENCES Customer (id)
);

CREATE TABLE Payment (
	id INTEGER GENERATED ALWAYS AS IDENTITY,
	rent_id INTEGER,
	_date DATE,
	amount MONEY CHECK (amount > CAST(0.00 AS MONEY)),
	
	PRIMARY KEY (id),
	FOREIGN KEY (rent_id) REFERENCES Rent (id)
);

CREATE TABLE ActiveRent (
	id INTEGER GENERATED ALWAYS AS IDENTITY,
	rent_id INTEGER,	
	
	PRIMARY KEY (id),
	FOREIGN KEY (rent_id) REFERENCES Rent (id)
);

CREATE TABLE CloseRent (
	id INTEGER GENERATED ALWAYS AS IDENTITY,
	rent_id INTEGER,
	inspection_id INTEGER,
	_date DATE,
	
	PRIMARY KEY (id),
	FOREIGN KEY (rent_id) REFERENCES Rent (id),
	FOREIGN KEY (inspection_id) REFERENCES Inspection (id)
);


