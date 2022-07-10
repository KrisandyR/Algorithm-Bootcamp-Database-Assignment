USE OOVEO_SALON

--1
SELECT * FROM MsStaff
WHERE StaffGender = 'Female'

--2
SELECT StaffName,
'Rp. ' + CAST(StaffSalary as varchar) as [Staff Salary]
FROM MsStaff
WHERE (StaffName like '%m%') AND
StaffSalary >= 10000000


--3
SELECT TreatmentName, Price
FROM MsTreatment MT 
JOIN MsTreatmentType TT ON MT.TreatmentTypeId = TT.TreatmentTypeId

WHERE TreatmentTypeName in ('message / spa', 'beauty care')

--4
SELECT StaffName, StaffPosition,
CONVERT(VARCHAR, TransactionDate, 107) AS [TransactionDate]
FROM MsStaff MS
JOIN HeaderSalonServices HS ON MS.StaffId = HS.StaffID
WHERE StaffSalary between 7000000 and 10000000


--5
SELECT
SUBSTRING (CustomerName, 1, CHARINDEX(' ', CustomerName, 0)) as [Name],
LEFT(CustomerGender, 1) as [Gender],
PaymentType
FROM MsCustomer MC
JOIN HeaderSalonServices HS ON MC.CustomerId = HS.CustomerId
WHERE PaymentType = 'Debit'

--6
SELECT
UPPER(LEFT(CustomerName, 1) + LEFT(SUBSTRING(CustomerName, CHARINDEX(' ', CustomerName, 0)+1, CHARINDEX(' ', CustomerName, 0)+2), 1)) as [Initial],
DATENAME(WEEKDAY, TransactionDate) as [Day]
FROM MsCustomer MC
JOIN HeaderSalonServices HS ON MC.CustomerId = HS.CustomerId
WHERE DATEDIFF(DAY, TransactionDate, '24 December 2012') < 3

--7
SELECT 
TransactionDate,
RIGHT(CustomerName, CHARINDEX(' ', REVERSE(CustomerName))) as [CustomerName]
FROM MsCustomer MC
JOIN HeaderSalonServices HS ON MC.CustomerId = HS.CustomerId
WHERE CustomerName like '% %' AND
DATENAME(WEEKDAY, TransactionDate) = 'Saturday'

--8
SELECT 
StaffName, 
CustomerName, 
REPLACE(CustomerPhone,'0', '+62') as [CustomerPhone], --kelemahan: semua 0 dalam cust phone ikut keganti semua jadi +62
CustomerAddress
FROM MsCustomer MC
JOIN HeaderSalonServices HS ON MC.CustomerId = HS.CustomerId
JOIN MsStaff MS ON MS.StaffId = HS.StaffId
WHERE StaffName like '% % %'
--vowel character a, i, u, e, o (?)

--9
SELECT 
StaffName,
TreatmentName,
DATEDIFF(DAY, TransactionDate, '24 December 2012') as [Term of Transaction]
FROM MsStaff MS 
JOIN HeaderSalonServices HS ON MS.StaffId = HS.StaffId
JOIN DetailSalonServices DS ON DS.TransactionId = HS.TransactionId
JOIN MsTreatment MT ON MT.TreatmentId = DS.TreatmentId
WHERE LEN(TreatmentName) > 20 OR TreatmentName like '% %'

--10
SELECT 
TransactionDate,
CustomerName, 
TreatmentName,
CAST(Price as int)*20/100 as [Discount],
PaymentType
FROM MsStaff MS 
JOIN HeaderSalonServices HS ON MS.StaffId = HS.StaffId
JOIN DetailSalonServices DS ON DS.TransactionId = HS.TransactionId
JOIN MsTreatment MT ON MT.TreatmentId = DS.TreatmentId
JOIN MsCustomer MC ON MC.CustomerId = HS.CustomerId
WHERE DAY(TransactionDate) = 22