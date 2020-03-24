Use [TEST]
GO

IF OBJECT_ID('Cities', 'U') IS NOT NULL
	DROP TABLE Cities
IF OBJECT_ID('Architect', 'U') IS NOT NULL
	DROP TABLE Architect
IF OBJECT_ID('Building', 'U') IS NOT NULL
	DROP TABLE Building
IF OBJECT_ID('Bridge', 'U') IS NOT NULL
	DROP TABLE Bridge
IF OBJECT_ID('Employment', 'U') IS NOT NULL
	DROP TABLE Employment

Use [TEST]
GO

CREATE   TABLE Cities(cityId INT PRIMARY KEY IDENTITY(1,1), cname VARCHAR(20), population INT, area varchar(50))

CREATE  TABLE Architect(architectId INT PRIMARY KEY IDENTITY(1,1),forename varchar(50), surname varchar(50), experience int)

CREATE TABLE Building(buildingId INT PRIMARY KEY IDENTITY(1,1), hieght float, descr varchar(100), architectId int references Architect(architectId))

CREATE TABLE Brdige(bridgeID INT PRIMARY KEY IDENTITY(1,1), name varchar(50), yearOfConstruction int, architectId int references Architect(architectId))


CREATE TABLE Employment(contractID INT PRIMARY KEY IDENTITY(1,1), architectId int references Architect(architectId), cityId int references Cities(cityId), startDate date, endDate date, score int,
					CONSTRAINT checkScore CHECK (score between 0 and 5))


CREATE OR ALTER PROCEDURE addEmployment(@architectName varchar(50), @cityName varchar(50), @startDate date, @endDate date, @score int) AS
BEGIN
	DECLARE @ArchitectID INT = (SELECT ArchitectID from Architect WHERE forename = @architectName),
			@CityID int = (SELECT CityID from Cities WHERE cname = @cityName)

	if @ArchitectID IS NULL OR @CityID IS NULL
	BEGIN
		raiserror('no such architect or city!',16,1)
		return -1
	end

	INSERT INTO Employment VALUES (@ArchitectID, @CityID, @startDate, @endDate, @score)

END
GO


CREATE OR ALTER FUNCTION  filterArchitect(@R int) RETURNS TABLE 

RETURN SELECT A.forename 
FROM Architect A where A.ARCHITECTid IN (
SELECT B.ArchitectId from Brdige B 
group by B.ARCHITECTID HAVING COUNT(*) >= @R
)

GO


INSERT INTO Cities VALUES('Campia Turzii', 15000,'jud cluj')
INSERT INTO Architect VALUES('Leu','Ioan', 6)
INSERT INTO Architect VALUES('Buzan','Ioan', 5)




SELECT * FROM CITIES
SELECT *FROM Architect
SELECT *FROM employment

addEmployment 'Leu','Campia Turzii', '2010-08-04', '2010-08-27',5
addEmployment 'Buzan','Campia Turzii', '2010-08-04', '2010-08-27',5
addEmployment 'Leu','Cluj', '2010-08-04', '2010-08-27',5
addEmployment 'Leu','Campia Turzii', '2010-08-04', '2010-08-27',7


INSERT INTO Brdige VALUES ('Golden Gate',1940,1),('Brooklyn Bridge',1930,1)
INSERT INTO Brdige VALUES ('Podo vechio',1920,2)



SELECT *FROM filterArchitect(1)






