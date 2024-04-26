-- DROP DATABASE STATEMENTS
USE master 
GO
ALTER DATABASE AppleStore 
SET single_user WITH ROLLBACK IMMEDIATE
DROP DATABASE AppleStore

-- CREATE DATABASE STATEMENTS
CREATE DATABASE AppleStore

GO
USE AppleStore
GO

-- DROP STATEMENTS
DROP TABLE Payment;
DROP TABLE Deliveries;
DROP TABLE Orders;
DROP TABLE Work_In;
DROP TABLE Stores;
DROP TABLE Employee;
DROP TABLE Products;
DROP TABLE Available_Categories;
DROP TABLE Available_Model;
DROP TABLE Model;
DROP TABLE Colour;
DROP TABLE Customers;
DROP TABLE Categories;

-- CREATE TABLE STATEMENTS
CREATE TABLE Categories (
	catID INT PRIMARY KEY NOT NULL, -- auto increments primary key = personl/unique id
	catName VARCHAR(30) NOT NULL
	--catYearRelease INT NOT NULL,
	--catType VARCHAR(30)
);

CREATE TABLE Model (
	modID INT PRIMARY KEY NOT NULL,
	catID INT FOREIGN KEY REFERENCES Categories(catID) ON DELETE CASCADE ON UPDATE CASCADE, -- foreign key = an id taken from another table
	modName VARCHAR(30) NOT NULL
);

CREATE TABLE Colour (
	-- m(colours):n(products)
	colID INT PRIMARY KEY NOT NULL,
	colName VARCHAR(30) NOT NULL
);

CREATE TABLE Available_Model (
	colID INT FOREIGN KEY REFERENCES Colour(colID) ON DELETE CASCADE ON UPDATE CASCADE,
	modID INT FOREIGN KEY REFERENCES Model(modID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT PK_Available_Model PRIMARY KEY (colID, modID)
);

CREATE TABLE Available_Categories (
	colID INT FOREIGN KEY REFERENCES Colour(colID) ON DELETE CASCADE ON UPDATE CASCADE,
	catID INT FOREIGN KEY REFERENCES Categories(catID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT PK_Available_Categories PRIMARY KEY (colID, catID)
);

CREATE TABLE Stores (
	-- 1(store):n(employees)
	stoID INT PRIMARY KEY NOT NULL,
	stoLoc VARCHAR(200) NOT NULL
);

CREATE TABLE Products (
	-- m(products):n(colours)
	proID INT PRIMARY KEY NOT NULL,
	modID INT FOREIGN KEY REFERENCES Model(modID) ON DELETE CASCADE ON UPDATE CASCADE,
	colID INT FOREIGN KEY REFERENCES Colour(colID) ON DELETE CASCADE ON UPDATE CASCADE,
	proName VARCHAR(100) NOT NULL,
	proDescription VARCHAR(500) NOT NULL,
	proRate INT
);

CREATE TABLE Employee (
	empID INT PRIMARY KEY NOT NULL,
	catID INT FOREIGN KEY REFERENCES Categories(catID) ON DELETE CASCADE ON UPDATE CASCADE,
	empName VARCHAR(100) NOT NULL,
	empSalary INT,
	empWork INT,
	empJob VARCHAR(100) NOT NULL, 
	empExperience INT
);

CREATE TABLE Work_In (
	stoID INT FOREIGN KEY REFERENCES Stores(stoID) ON DELETE CASCADE ON UPDATE CASCADE,
	empID INT FOREIGN KEY REFERENCES Employee(empID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT PK_Work_In PRIMARY KEY (stoID, empID)
);

CREATE TABLE Customers (
	-- 1(customer):n(orders)
	cusID INT PRIMARY KEY NOT NULL,
	cusName VARCHAR(100) NOT NULL,
	cusPhoneNr INT UNIQUE,
	cusAdrres VARCHAR(200) NOT NULL,
	cusPoints INT
);

CREATE TABLE Orders (
	ordID INT PRIMARY KEY NOT NULL,
	cusID INT FOREIGN KEY REFERENCES Customers(cusID) ON DELETE CASCADE ON UPDATE CASCADE,
	proID INT FOREIGN KEY REFERENCES Products(proID) ON DELETE CASCADE ON UPDATE CASCADE,
	ordDate DATE,
	ordCode VARCHAR(100)
);

CREATE TABLE Payment (
	ordID INT FOREIGN KEY REFERENCES Orders(ordID) ON DELETE CASCADE ON UPDATE CASCADE,
	payDate DATE,
	payType VARCHAR(50),
	CONSTRAINT PK_Payment PRIMARY KEY (ordID)
);

CREATE TABLE Deliveries (
	delID INT PRIMARY KEY NOT NULL,
	ordID INT,
	CONSTRAINT FK_Deliveries FOREIGN KEY (ordID) REFERENCES Orders(ordID) ON DELETE CASCADE ON UPDATE CASCADE,
	delDate DATE
);

-- INSERT STATEMENTS
INSERT INTO Categories(catID, catName) VALUES (1, 'MacBook')
INSERT INTO Categories(catID, catName) VALUES (2, 'iPad')
INSERT INTO Categories(catID, catName) VALUES (3, 'iPhone')
INSERT INTO Categories(catID, catName) VALUES (4, 'Watch')
INSERT INTO Categories(catID, catName) VALUES (5, 'AirPods')
INSERT INTO Categories(catID, catName) VALUES (6, 'iMac')

INSERT INTO Model(modID, catID, modName) VALUES (1, 1, 'Air')
INSERT INTO Model(modID, catID, modName) VALUES (2, 1, 'Pro')
INSERT INTO Model(modID, catID, modName) VALUES (3, 2, 'Air')
INSERT INTO Model(modID, catID, modName) VALUES (4, 2, 'Pro')
INSERT INTO Model(modID, catID, modName) VALUES (5, 2, 'Mini')
INSERT INTO Model(modID, catID, modName) VALUES (6, 3, 'Pro')
INSERT INTO Model(modID, catID, modName) VALUES (7, 3, 'Mini')
INSERT INTO Model(modID, catID, modName) VALUES (8, 3, 'Max')
INSERT INTO Model(modID, catID, modName) VALUES (9, 4, 'Series 1')
INSERT INTO Model(modID, catID, modName) VALUES (10, 4, 'Series 2')
INSERT INTO Model(modID, catID, modName) VALUES (11, 5, 'Pro')
INSERT INTO Model(modID, catID, modName) VALUES (12, 5, 'Max')

INSERT INTO Colour(colID, colName) VALUES (1, 'Red')
INSERT INTO Colour(colID, colName) VALUES (2, 'Orange')
INSERT INTO Colour(colID, colName) VALUES (3, 'Blue')
INSERT INTO Colour(colID, colName) VALUES (4, 'Black')
INSERT INTO Colour(colID, colName) VALUES (5, 'Pink')
INSERT INTO Colour(colID, colName) VALUES (6, 'White')
INSERT INTO Colour(colID, colName) VALUES (7, 'Yellow')
INSERT INTO Colour(colID, colName) VALUES (8, 'Green')

INSERT INTO Available_Model(colID, modID) VALUES (1, 1)
INSERT INTO Available_Model(colID, modID) VALUES (2, 2)
INSERT INTO Available_Model(colID, modID) VALUES (3, 3)
INSERT INTO Available_Model(colID, modID) VALUES (4, 4)
INSERT INTO Available_Model(colID, modID) VALUES (5, 5)
INSERT INTO Available_Model(colID, modID) VALUES (6, 6)

INSERT INTO Available_Categories(colID, catID) VALUES (1, 1)
INSERT INTO Available_Categories(colID, catID) VALUES (2, 2)
INSERT INTO Available_Categories(colID, catID) VALUES (3, 3)
INSERT INTO Available_Categories(colID, catID) VALUES (4, 4)
INSERT INTO Available_Categories(colID, catID) VALUES (5, 5)

INSERT INTO Stores(stoID, stoLoc) VALUES (1, 'Bucharest')
INSERT INTO Stores(stoID, stoLoc) VALUES (2, 'Dublin')
INSERT INTO Stores(stoID, stoLoc) VALUES (3, 'Paris')
INSERT INTO Stores(stoID, stoLoc) VALUES (4, 'Rome')
INSERT INTO Stores(stoID, stoLoc) VALUES (5, 'Amsterdam')
INSERT INTO Stores(stoID, stoLoc) VALUES (6, 'Prague')
INSERT INTO Stores(stoID, stoLoc) VALUES (7, 'Vienna')

INSERT INTO Products(proID, modID, colID, proName, proDescription, proRate) VALUES (1, 1, 3, 'MacBook Air Blue', 'MacBook Air is an incredibly portable laptop — it’s nimble and quick, with a silent, fanless design and a beautiful Retina display.', 2)
INSERT INTO Products(proID, modID, colID, proName, proDescription) VALUES (2, 1, 1, 'MacBook Air Red', 'MacBook Air is an incredibly portable laptop — it’s nimble and quick, with a silent, fanless design and a beautiful Retina display.')
INSERT INTO Products(proID, modID, colID, proName, proDescription, proRate) VALUES (3, 2, 5, 'MacBook Pro Pink', 'MacBook Pro has the compact design supports up to 20 hours of battery life and an active cooling system to sustain enhanced performance.', 5)
INSERT INTO Products(proID, modID, colID, proName, proDescription, proRate) VALUES (4, 2, 4, 'MacBook Pro Black', 'MacBook Pro has the compact design supports up to 20 hours of battery life and an active cooling system to sustain enhanced performance.', 3)
INSERT INTO Products(proID, modID, colID, proName, proDescription) VALUES (5, 3, 2, 'iPad Air Orange', 'iPad Air lets you immerse yourself in whatever you’re reading, watching, or creating.')
INSERT INTO Products(proID, modID, colID, proName, proDescription, proRate) VALUES (6, 3, 3, 'iPad Air Blue', 'iPad Air lets you immerse yourself in whatever you’re reading, watching, or creating.', 1)
INSERT INTO Products(proID, modID, colID, proName, proDescription, proRate) VALUES (7, 4, 2, 'iPad Pro Orange', 'Astonishing performance. Incredibly advanced displays. Superfast wireless connectivity.', 3)
INSERT INTO Products(proID, modID, colID, proName, proDescription, proRate) VALUES (8, 5, 5, 'iPad Mini Pink', 'iPad mini is meticulously designed to be absolutely beautiful. Larger edge-to-edge screen, along with narrow borders and elegant rounded corners.', 2)
INSERT INTO Products(proID, modID, colID, proName, proDescription, proRate) VALUES (9, 5, 6, 'iPad Mini White', 'iPad mini is meticulously designed to be absolutely beautiful. Larger edge-to-edge screen, along with narrow borders and elegant rounded corners.', 5)
INSERT INTO Products(proID, modID, colID, proName, proDescription, proRate) VALUES (10, 6, 4, 'iPhone Pro Black', 'A magical new way to interact with iPhone. Groundbreaking safety features designed to save lives. An innovative 48MP camera for mind-blowing detail.', 4)
INSERT INTO Products(proID, modID, colID, proName, proDescription) VALUES (11, 6, 6, 'iPhone Pro White', 'A magical new way to interact with iPhone. Groundbreaking safety features designed to save lives. An innovative 48MP camera for mind-blowing detail.')
INSERT INTO Products(proID, modID, colID, proName, proDescription) VALUES (12, 7, 1, 'iPhone Mini Red', 'A magical new way to interact with iPhone. Groundbreaking safety features designed to save lives. An innovative 48MP camera for mind-blowing detail.')
INSERT INTO Products(proID, modID, colID, proName, proDescription, proRate) VALUES (13, 8, 2, 'iPhone Max Orange', 'A magical new way to interact with iPhone. Groundbreaking safety features designed to save lives. An innovative 48MP camera for mind-blowing detail.', 1)
INSERT INTO Products(proID, modID, colID, proName, proDescription, proRate) VALUES (14, 9, 4, 'Watch Series 1 Black', 'Powerful sensors for insights about your health and fitness. Innovative safety features. Convenient ways to stay connected.', 2)
INSERT INTO Products(proID, modID, colID, proName, proDescription, proRate) VALUES (15, 10, 6, 'Watch Series 2 White', 'Powerful sensors for insights about your health and fitness. Innovative safety features. Convenient ways to stay connected.', 4)
INSERT INTO Products(proID, modID, colID, proName, proDescription, proRate) VALUES (16, 11, 1, 'AirPods Pro Red', 'With plenty of talk and listen time, voice-activated Siri access, and an available wireless charging case, AirPods deliver an incredible wireless headphone experience.', 2)
INSERT INTO Products(proID, modID, colID, proName, proDescription) VALUES (17, 12, 3, 'AirPods Max Blue', 'AirPods Max is a perfect balance of exhilarating high-fidelity audio and the effortless magic of AirPods. The ultimate personal listening experience is here.')

INSERT INTO Employee(empID, catID, empName, empSalary, empWork, empJob, empExperience) VALUES (1, 1, 'Andreea', 7000, 7, 'Advertising & Marketing Manager', 80)
INSERT INTO Employee(empID, catID, empName, empSalary, empWork, empJob, empExperience) VALUES (2, 2, 'Cosmina', 4500, 9, 'Cleaning & Maintenance', 60)
INSERT INTO Employee(empID, catID, empName, empSalary, empWork, empJob, empExperience) VALUES (3, 3, 'Iulia', 5000, 6, 'Visual Merchandiser', 65)
INSERT INTO Employee(empID, catID, empName, empSalary, empWork, empJob, empExperience) VALUES (4, 4, 'Alexandra', 3500, 5, 'Cleaning & Maintenance', 40)
INSERT INTO Employee(empID, catID, empName, empSalary, empWork, empJob, empExperience) VALUES (5, 5, 'Vasile', 4000, 9, 'Sales Associate', 50)
INSERT INTO Employee(empID, catID, empName, empSalary, empWork, empJob, empExperience) VALUES (6, 1, 'Cristian', 3000, 7, 'Sales Associate', 35)
INSERT INTO Employee(empID, catID, empName, empSalary, empWork, empJob, empExperience) VALUES (7, 2, 'Florin', 10000, 4, 'Store Manager', 100)
INSERT INTO Employee(empID, catID, empName, empSalary, empWork, empJob, empExperience) VALUES (8, 3, 'Ana', 2500, 7, 'Sales Associate', 25)
INSERT INTO Employee(empID, catID, empName, empSalary, empWork, empJob, empExperience) VALUES (9, 4, 'Maria', 1000, 8, 'Visual Merchandiser', 20)
INSERT INTO Employee(empID, catID, empName, empSalary, empWork, empJob, empExperience) VALUES (10, 5, 'Olivia', 5500, 8, 'Sales Associate', 70)
INSERT INTO Employee(empID, catID, empName, empSalary, empWork, empJob, empExperience) VALUES (11, 6, 'Diana', 5000, 4, 'Sales Associate', 70)

INSERT INTO Work_In(stoID, empID) VALUES (1, 1)
INSERT INTO Work_In(stoID, empID) VALUES (2, 2)
INSERT INTO Work_In(stoID, empID) VALUES (2, 3)
INSERT INTO Work_In(stoID, empID) VALUES (3, 4)
INSERT INTO Work_In(stoID, empID) VALUES (1, 5)
INSERT INTO Work_In(stoID, empID) VALUES (2, 6)
INSERT INTO Work_In(stoID, empID) VALUES (2, 8)
INSERT INTO Work_In(stoID, empID) VALUES (3, 7)
INSERT INTO Work_In(stoID, empID) VALUES (3, 10)
INSERT INTO Work_In(stoID, empID) VALUES (1, 9)

INSERT INTO Customers(cusID, cusName, cusPhoneNr, cusAdrres, cusPoints) VALUES (1, 'Cristina', 757602354, 'Str Plopilor, Nr 77', 90)
INSERT INTO Customers(cusID, cusName, cusPhoneNr, cusAdrres, cusPoints) VALUES (2, 'Edward', 759743685, 'Str Vladimir, Nr 12', 78)
INSERT INTO Customers(cusID, cusName, cusPhoneNr, cusAdrres, cusPoints) VALUES (3, 'Florin', 711136910, 'Str Lalelelor, Nr 56', 67)
INSERT INTO Customers(cusID, cusName, cusPhoneNr, cusAdrres, cusPoints) VALUES (4, 'Alina', 726138997, 'Str Victoriei, Nr 4', 127)
INSERT INTO Customers(cusID, cusName, cusAdrres, cusPoints) VALUES (5, 'Olivia', 'Str Decebal, Nr 97', 59)
INSERT INTO Customers(cusID, cusName, cusPhoneNr, cusAdrres, cusPoints) VALUES (6, 'Iulia', 756984123, 'Str Decebal, Nr 9', 86)
INSERT INTO Customers(cusID, cusName, cusPhoneNr, cusAdrres, cusPoints) VALUES (7, 'Alexandra', 736589423, 'Str Artarilor, Nr 2', 90)

INSERT INTO Orders(ordID, cusID, proID, ordDate, ordCode) VALUES (1, 1, 10, '2022-02-10', '59PER5')
INSERT INTO Orders(ordID, cusID, proID, ordDate, ordCode) VALUES (2, 1, 15, '2022-02-10', '59PER5')
INSERT INTO Orders(ordID, cusID, proID, ordDate, ordCode) VALUES (3, 1, 7, '2022-02-10', '59PER5')
INSERT INTO Orders(ordID, cusID, proID, ordDate, ordCode) VALUES (4, 2, 1, '2022-12-01', '69YIO5')
INSERT INTO Orders(ordID, cusID, proID, ordDate, ordCode) VALUES (5, 3, 16, '2022-10-19', 'OERT68')
INSERT INTO Orders(ordID, cusID, proID, ordDate, ordCode) VALUES (6, 3, 8, '2022-10-19', 'OERT68')
INSERT INTO Orders(ordID, cusID, proID, ordDate, ordCode) VALUES (7, 3, 5, '2022-10-19', 'OERT68')
INSERT INTO Orders(ordID, cusID, proID, ordDate, ordCode) VALUES (8, 4, 17, '2022-11-30', '6TIGLP')
INSERT INTO Orders(ordID, cusID, proID, ordDate, ordCode) VALUES (9, 5, 14, '2022-12-01', '67E3RT')

INSERT INTO Payment(ordID, payDate, payType) VALUES (1, '2022-02-10', 'Card')
INSERT INTO Payment(ordID, payDate, payType) VALUES (2, '2022-02-10', 'Card')
INSERT INTO Payment(ordID, payDate, payType) VALUES (3, '2022-02-10', 'Card')
INSERT INTO Payment(ordID, payDate, payType) VALUES (4, '2022-12-01', 'Cash')
INSERT INTO Payment(ordID, payDate, payType) VALUES (5, '2022-10-19', 'Cash')
INSERT INTO Payment(ordID, payDate, payType) VALUES (6, '2022-10-19', 'Cash')
INSERT INTO Payment(ordID, payDate, payType) VALUES (7, '2022-10-19', 'Cash')
INSERT INTO Payment(ordID, payDate, payType) VALUES (8, '2022-11-30', 'Cash')
INSERT INTO Payment(ordID, payDate, payType) VALUES (9, '2022-12-01', 'Cash')

INSERT INTO Deliveries(delID, ordID, delDate) VALUES (1, 1, '2022-02-10')
INSERT INTO Deliveries(delID, ordID, delDate) VALUES (2, 2, '2022-02-10')
INSERT INTO Deliveries(delID, ordID, delDate) VALUES (3, 3, '2022-02-10')
INSERT INTO Deliveries(delID, ordID, delDate) VALUES (4, 4, '2022-12-04')
INSERT INTO Deliveries(delID, ordID, delDate) VALUES (5, 5, '2022-10-20')
INSERT INTO Deliveries(delID, ordID, delDate) VALUES (6, 6, '2022-10-20')
INSERT INTO Deliveries(delID, ordID, delDate) VALUES (7, 7, '2022-10-20')
INSERT INTO Deliveries(delID, ordID, delDate) VALUES (8, 8, '2022-12-15')
INSERT INTO Deliveries(delID, ordID, delDate) VALUES (9, 9, '2022-12-10')

SELECT * FROM Categories
SELECT * FROM Model
SELECT * FROM Colour
SELECT * FROM Stores
SELECT * FROM Products
SELECT * FROM Employee
SELECT * FROM Work_In
SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM Payment
SELECT * FROM Deliveries