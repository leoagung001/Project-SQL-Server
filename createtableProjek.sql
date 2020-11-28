CREATE DATABASE PROJECT

CREATE TABLE Staff (
	StaffID CHAR (5) PRIMARY KEY NOT NULL
	CHECK (StaffID LIKE 'SF[0-9][0-9][0-9]'),
	StaffName VARCHAR (255)
	CHECK (LEN(StaffName) > 6 AND LEN(StaffName) <31) ,
	StaffEmail VARCHAR (255),
	StaffDOB DATE ,
	StaffGender VARCHAR (7) 
	CHECK (StaffGender IN  ('MALE', 'FEMALE')) ,
	StaffPhone VARCHAR (13) ,
	StaffAddress VARCHAR (255) 
)

CREATE TABLE Movie (
	MovieID CHAR (5) PRIMARY KEY NOT NULL
	CHECK (MovieID LIKE 'MV[0-9][0-9][0-9]'),
	MovieName VARCHAR (255),
	MovieLicense VARCHAR (255),
	MovieDuration INT
	CHECK (MovieDuration <= 240) ,
)

CREATE TABLE Studio (
	StudioID CHAR (5) PRIMARY KEY NOT NULL
	CHECK (StudioID LIKE 'ST[0-9][0-9][0-9]'),
	StudioName VARCHAR (255),
	StudioPrice INT 
	CHECK (StudioPrice BETWEEN 35000 AND 65000),
)

CREATE TABLE ScheduleTransaction (
	ScheduleTransactionID CHAR (5) PRIMARY KEY NOT NULL
	CHECK (ScheduleTransactionID  LIKE 'MS[0-9][0-9][0-9]'),
	StudioID CHAR (5) ,
	MovieID CHAR (5) ,
	DateandTime DATETIME 
	CHECK (DATEDIFF(day,getdate(),DateandTime) <=7 ),
	FOREIGN KEY (StudioID) REFERENCES Studio (StudioID),
	FOREIGN KEY (MovieID) REFERENCES Movie (MovieID)
)

DROP TABLE HeaderMovieTransaction

CREATE TABLE HeaderMovieTransaction(
	MovieTransactionID CHAR (6) PRIMARY KEY NOT NULL
	CHECK (MovieTransactionID  LIKE 'MTr[0-9][0-9][0-9]'),
	StaffID CHAR (5) references Staff(StaffID),
	TransactionDate DATE
)

DROP TABLE DetailMovieTransaction

CREATE TABLE DetailMovieTransaction(
	MovieTransactionID CHAR (6) NOT NULL,
	ScheduleTransactionID CHAR (5) NOT NULL,
	Seats INT,
	FOREIGN KEY (MovieTransactionID) REFERENCES HeaderMovieTransaction(MovieTransactionID),
	FOREIGN KEY (ScheduleTransactionID) REFERENCES ScheduleTransaction (ScheduleTransactionID)
)
--salah
ALTER TABLE DetailMovieTransaction ADD PRIMARY KEY (ScheduleTransactionID, MovieTransactionID)

DROP TABLE HeaderRefreshmentTransaction

CREATE TABLE HeaderRefreshmentTransaction (
	RefreshmentSaleID CHAR (6) PRIMARY KEY NOT NULL
	CHECK (RefreshmentSaleID LIKE 'RTr[0-9][0-9][0-9]'),
	StaffID CHAR (5) REFERENCES Staff(StaffID),
	TransactionDate DATE
)


CREATE TABLE RefreshmentType(
	RefreshmentTypeID CHAR (5) PRIMARY KEY NOT NULL
	CHECK (RefreshmentTypeID LIKE 'RT[0-9][0-9][0-9]'),
	RefreshmentTypeName VARCHAR(255)
)

CREATE TABLE Refreshment (
	RefreshmentID CHAR (5) PRIMARY KEY NOT NULL
	CHECK (RefreshmentID LIKE 'RE[0-9][0-9][0-9]'),
	RefreshmentTypeID CHAR (5) REFERENCES RefreshmentType (RefreshmentTypeID),
	RefreshmentStock INT CHECK (RefreshmentStock > 50), 
	RefreshmentPrice INT,
	RefreshmentName VARCHAR(255),
)

CREATE TABLE DetailRefreshmentTransaction(
	RefreshmentSaleID CHAR (6) NOT NULL
	CHECK (RefreshmentSaleID LIKE 'RTr[0-9][0-9][0-9]'),
	RefreshmentID CHAR (5) NOT NULL REFERENCES Refreshment(RefreshmentID),
	Quantity INT
)

ALTER TABLE DetailRefreshmentTransaction ADD PRIMARY KEY (RefreshmentSaleID,RefreshmentID) 



