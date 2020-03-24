

--Add a column
CREATE PROCEDURE p1 AS
BEGIN
	ALTER Table Club
	ADD PhoneNumber varchar(20)
END

EXEUCTE add_column


--Remove a column
CREATE PROCEDURE rp1 AS
BEGIN
	ALTER TABLE Club
	DROP COLUMN PhoneNumber
END


--Add primary key
CREATE Procedure p2 AS
BEGIN
	ALTER TABLE ActiveMembership
	ADD CONSTRAINT	pk_active_membership PRIMARY KEY(MembershipID)
END


--Remove primary key
CREATE Procedure rp2 AS
BEGIN
	ALTER TABLE ActiveMembership
	DROP CONSTRAINT pk_active_membership
END

EXECUTE add_primary_key
EXECUTE remove_primary_key

--Add foreign key
CREATE Procedure p3 AS
BEGIN
	ALTER TABLE Contract
	ADD CONSTRAINT fk_Contract_Trainer2 FOREIGN KEY(TrainerID) REFERENCES Trainer(TrainerID)
END

EXECUTE add_foregin_key


--Remove foreign key
CREATE PROCEDURE rp3 AS
BEGIN
	ALTER Table Contract
	DROP CONSTRAINT fk_Contract_Trainer2
END




--Add a table
CREATE PROCEDURE p4 AS
BEGIN
	CREATE Table Employee(Empid INT NOT NULL PRIMARY KEY, 
		FirstName varchar(50), LastName varchar(50), Position varchar(50)) ;
END


EXECUTE add_table


CREATE PROCEDURE rp4 AS
BEGIN 
	DROP Table Employee
END

EXECUTE delete_table


create table Versions(vid int primary key,no_ver int not null)




CREATE or ALTER PROCEDURE MAIN @versionToBring INT AS
BEGIN
	DECLARE @versionCurrent int= (select V.no_ver from Versions V)
	DECLARE @procedureToExecute varchar(50)
	IF @versionToBring >4 or @versionToBring <0
	BEGIN
		print('Invalid version number!')
		return
	END
	WHILE @versionToBring < @versionCurrent
	BEGIN
		SET @procedureToExecute= 'rp' + cast(@versionCurrent as varchar(2))
		EXECUTE @procedureToExecute
		SET @versionCurrent= @versionCurrent-1
	END

	WHILE @versionToBring > @versionCurrent
	BEGIN
		PRINT('EXECUTING')
		SET @versionCurrent= @versionCurrent+1
		SET @procedureToExecute= 'p' + cast(@versionCurrent as varchar(2))
		EXEC @procedureToExecute
	END
	DELETE from Versions
	INSERT INTO Versions VALUES(0,@versionToBring)
END


exec main 4

use [Sports-club]
SELECT *from Versions
DELETE from Versions
INSERT  INTO Versions VALUES(0,4)
INSERT INTO Versions VALUES(0, 0)	
	






	









