CREATE TABLE Customers
(
    CustomerID    SERIAL PRIMARY KEY,
    FirstName     VARCHAR(40) NOT NULL,
    MiddleInitial VARCHAR(40),
    LastName      VARCHAR(40) NOT NULL
);

CREATE TABLE Employees
(
    EmployeeID    SERIAL PRIMARY KEY,
    FirstName     VARCHAR(40) NOT NULL,
    MiddleInitial VARCHAR(40),
    LastName      VARCHAR(40) NOT NULL
);

CREATE TABLE Products
(
    ProductID SERIAL PRIMARY KEY,
    Name      VARCHAR(50) NOT NULL,
    Price     NUMERIC
);

CREATE TABLE Sales
(
    SalesID       SERIAL PRIMARY KEY,
    SalesPersonID INT NOT NULL REFERENCES Employees ON UPDATE CASCADE,
    CustomerID    INT NOT NULL REFERENCES Customers ON UPDATE CASCADE,
    ProductID     INT NOT NULL REFERENCES Products ON UPDATE CASCADE,
    Quantity      INT NOT NULL
);

