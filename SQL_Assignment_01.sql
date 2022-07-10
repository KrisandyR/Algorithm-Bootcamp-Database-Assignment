-- Nomor 1

CREATE TABLE MsCustomer(
    CustomerId char(5) PRIMARY KEY CHECK (CustomerID LIKE 'CU[0-9][0-9][0-9]'),
    CustomerName varchar(50),
    CustomerGender varchar(10) CHECK (CustomerGender in ('Male', 'Female')),
    CustomerPhone varchar(13),
    CustomerAddress varchar(100)
)

CREATE TABLE MsStaff(
    StaffId char(5) PRIMARY KEY CHECK (StaffID LIKE 'SF[0-9][0-9][0-9]'),
    StaffName varchar(50),
	StaffGender varchar(10) CHECK(StaffGender in ('Male','Female')),
	StaffPhone varchar(13),
	StaffAddress varchar(100),
	StaffSalary numeric(11, 2),
	StaffPosition varchar(20)
)

CREATE TABLE MsTreatmentType(
	TreatmentTypeId char(5) PRIMARY KEY CHECK (TreatmentTypeId LIKE 'TT[0-9][0-9][0-9]'),
	TreatmentTypeName varchar(50)
)

CREATE TABLE MsTreatment(
	TreatmentId char(5) PRIMARY KEY CHECK (TreatmentId LIKE 'TM[0-9][0-9][0-9]'),
	TreatmentTypeId char(5) FOREIGN KEY(TreatmentTypeId) REFERENCES MsTreatmentType(TreatmentTypeId),
	TreatmentName varchar(50),
	Price numeric(11,2)
)

CREATE TABLE HeaderSalonServices(
	TransactionId char(5) PRIMARY KEY CHECK(TransactionId LIKE 'TR[0-9][0-9][0-9]'),
	CustomerId char(5) FOREIGN KEY(CustomerId) REFERENCES MsCustomer(CustomerId),
	StaffId char(5) FOREIGN KEY (StaffId) REFERENCES MsStaff(StaffId),
	TransactionDate date,
	PaymentType varchar(50)
)

CREATE TABLE DetailSalonServices(
	TransactionId char(5) FOREIGN KEY(TransactionId) REFERENCES HeaderSalonServices(TransactionId),
	TreatmentId char(5) FOREIGN KEY (TreatmentId) REFERENCES MsTreatment(TreatmentId)
	PRIMARY KEY (TransactionId, TreatmentId)
)

-- Nomor 2
DROP TABLE DetailSalonServices

-- Nomor 3
CREATE TABLE DetailSalonServices(
	TransactionId char(5) FOREIGN KEY(TransactionId) REFERENCES HeaderSalonServices(TransactionId),
	TreatmentId char(5) FOREIGN KEY (TreatmentId) REFERENCES MsTreatment(TreatmentId)
)

ALTER TABLE DetailSalonServices ADD PRIMARY KEY (TransactionId, TreatmentId)

-- Nomor 4
ALTER TABLE MsStaff WITH NOCHECK ADD CONSTRAINT StaffName CHECK(LEN(StaffName) BETWEEN 5 AND 20)
ALTER TABLE MsStaff DROP CONSTRAINT StaffName

-- Nomor 5
ALTER TABLE MsTreatment ADD Description varchar(100)
ALTER TABLE MsTreatment DROP COLUMN Description
