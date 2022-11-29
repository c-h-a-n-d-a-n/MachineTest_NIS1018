CREATE DATABASE MS_SQL_SERVER_Machine_Test_01
USE MS_SQL_SERVER_Machine_Test_01

CREATE TABLE EmployeeID_NIS1018(
	EmployeeID INT PRIMARY KEY,
	EmpName NVARCHAR(40),
	Phone NVARCHAR(40),
	Email NVARCHAR(40),
	Area_Code NVARCHAR(40)
)

CREATE TABLE Manufactuer_NIS1018(
	MfName NVARCHAR(40) PRIMARY KEY,
	City NVARCHAR(40),
	State VARCHAR(40)
)

CREATE TABLE Computer_NIS1018(
	SerialNumber INT PRIMARY KEY,
	MfName NVARCHAR(40)
		CONSTRAINT fk_Manuf_Com 
		FOREIGN KEY (MfName) 
		REFERENCES Manufactuer_NIS1018(MfName),
	Model NVARCHAR(40),
	Weights INT,
	EmployeeID INT 
		CONSTRAINT fk_Emp_Com 
		FOREIGN KEY (EmployeeID) 
		REFERENCES EmployeeID_NIS1018(EmployeeID)
)

SELECT * FROM Computer_NIS1018
SELECT * FROM Manufactuer_NIS1018
SELECT * FROM EmployeeID_NIS1018

INSERT INTO Manufactuer_NIS1018 VALUES ('Lg','Deadwood','South_Dakota'),
									   ('Hp','Jaisalmer','Rajasthan'),
									   ('Asus','Trivandrum','Kerala');
INSERT INTO Manufactuer_NIS1018 VALUES ('Dell','Nalanda','Bihar')
INSERT INTO Computer_NIS1018 VALUES 
									(1,'Lg', 'NIS1017', 1017, 2),
									(2,'Hp', 'NIS1028', 1028, 3),
									(3,'Hp', 'NIS1029', 1029, 4),
								    (4,'Asus', 'NIS1025', 1025, 5),
									(5,'Lg', 'NIS1018', 1018, 1);



INSERT INTO EmployeeID_NIS1018 VALUES 
	(1, 'Chandan', '9878765688', 'chandan@gmail.com', '443103'),
    (2, 'Kumar', '9235674321', 'kumar@gmail.com', '623789'),
    (3, 'Rohan', '8975673632', 'rohan@gmail.com', '508982'),
    (4, 'Vishwsh', '7896785675', 'vishwash@gmail.com','122345'),
    (5, 'Sunny', '9808976865', 'sunny@gmail.com', '456876');
INSERT INTO EmployeeID_NIS1018 VALUES 
	(6, 'ChandanKumar', '987874568', 'chandankumart@gmail.com', '245683')
--1. List the manufacturers’ names that are located in South Dakota.
SELECT MfName,State
FROM Manufactuer_NIS1018
WHERE State like 'South_Dakota'


--2. Calculate the average weight of the computers in use.
SELECT AVG(Weights) AS [Average_weight] 
FROM Computer_NIS1018
WHERE EmployeeID is not null;



--3. List the employee names for employees whose area_code starts with 2
SELECT EmpName, Area_Code
FROM EmployeeID_NIS1018
WHERE Area_Code like '2%';



---4. List the serial numbers for computers that have a weight below average
SELECT SerialNumber, Weights
FROM Computer_NIS1018
WHERE Weights < (SELECT AVG(Weights) FROM Computer_NIS1018);

--5. List the manufacturer names of companies that do not have any
--computers in use. Use a subquery.
SELECT MfName
FROM Manufactuer_NIS1018
WHERE MfName NOT IN (SELECT MfName FROM Computer_NIS1018);

--6. Create a VIEW with the list of employee name, their computer serial
--number, and the city that they were manufactured in. Use a join.
CREATE VIEW vw_emp_list
AS
    SELECT e.EmpName, c.SerialNumber, m.City
    FROM EmployeeID_NIS1018 AS e
    INNER JOIN Computer_NIS1018 AS c
    ON e.EmployeeId = c.EmployeeID
    INNER JOIN Manufactuer_NIS1018 AS m
    ON c.MfName = m.MfName


SELECT * FROM vw_emp_list

--7. Write a Stored Procedure to accept EmployeeId as parameter and
--List the serial number, manufacturer name, model, and weight of
--computer that belong to the specified Employeeid.
CREATE PROCEDURE sp_compt 
@EmployeeId INT
AS
    BEGIN
        SELECT SerialNumber, MfName, Model, Weights
        FROM Computer_NIS1018
        WHERE EmployeeID = @EmployeeId
    END;

EXEC sp_compt 2;


--1
SELECT MfName,State
FROM Manufactuer_NIS1018
WHERE State like 'South_Dakota'
--2
SELECT AVG(Weights) AS [Average_weight] 
FROM Computer_NIS1018
WHERE EmployeeID is not null;
--3
SELECT EmpName, Area_Code
FROM EmployeeID_NIS1018
WHERE Area_Code like '2%';
--4
SELECT SerialNumber, Weights
FROM Computer_NIS1018
WHERE Weights < (SELECT AVG(Weights) FROM Computer_NIS1018);
--5
SELECT MfName
FROM Manufactuer_NIS1018
WHERE MfName NOT IN (SELECT MfName FROM Computer_NIS1018);
--6
SELECT * FROM vw_emp_list
--7
EXEC sp_compt 2;
