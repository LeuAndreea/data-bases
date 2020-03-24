
USE [Sports-club]

Delete from Membership 

INSERT INTO Trainer(TrainerID,Name,DateOfBirth,Specialization) VALUES (134,'Popescu Andrei','2015-11-05','Swimming')
INSERT INTO Trainer(TrainerID,Name,DateOfBirth,Specialization) VALUES (222, 'Sacara Adi','1980-08-04','Skydiving')
INSERT INTO Trainer(TrainerID,Name,DateOfBirth,Specialization) VALUES (546, 'Leu Andreea','1999-04-27', 'Rock climbing')
INSERT INTO Trainer(TrainerID,Name,DateOfBirth,Specialization) VALUES (876, 'Miclea Veronica', '1987-09-19','Swimming')
INSERT INTO Trainer(TrainerID,Name,DateOfBirth,Specialization) VALUES (987, 'Sebeni Ioana', '1985-11-30','Fitness')

INSERT INTO Contract(TrainerID,ContractID,Salary) VALUES(134,22,1600)
INSERT INTO Contract(TrainerID,ContractID,Salary) VALUES(222,11,2500)
INSERT INTO Contract(TrainerID,ContractID,Salary) VALUES(546,45,1800)
INSERT INTO Contract(TrainerID,ContractID,Salary) VALUES(876,77,1600)
INSERT INTO Contract(TrainerID,ContractID,Salary) VALUES(987,90,2000)

INSERT INTO Locations(LocationID,Address,Availability) VALUES(111,'str Paris nr 15','Tuesday')
INSERT INTO Locations(LocationID,Address,Availability) VALUES(222,'str Planoarelor nr 27','Saturday')
INSERT INTO Locations(LocationID,Address,Availability) VALUES(333,'srr Berarie nr 6','Monday')


INSERT INTO Participants(ParticipantID,Name,Email) VALUES(2331, 'Leu Radu', 'a@a') 
INSERT INTO Participants(ParticipantID,Name,Email) VALUES(6789, 'Buzan Vlad','b@b')

INSERT INTO Membership(membID,Type,Price) VALUES('567','Unlimited acces',190)
INSERT INTO Membership(membID,Type,Price) VALUES ('132','8 clases/month',120)
INSERT INTO Membership(membID,Type,Price) VALUES ('546','4 clases/month',100)

INSERT INTO Club(Name,ClubID,LocationID,TrainerID) VALUES ('Skydiving',7009,222,222)
INSERT INTO Club(Name,ClubID,LocationID,TrainerID) VALUES ('Yoga',874,111,134)

INSERT INTO ActiveMembership(MembershipID,ParticipantID,ClubID,Availability) VALUES (567,2331,7009,'2019-12-12')
INSERT INTO ActiveMembership(MembershipID,ParticipantID,ClubID,Availability) VALUES	(874,6789,874,'2019-11-12')



UPDATE Locations
SET Availability='Thursday'
WHERE Address Like '%Paris%'

UPDATE Membership
SET Price=Price+20
WHERE Price IS NOT NULL

DELETE FROM  Club
WHERE Name LIKE 'Rock%'

SELECT *
From Trainer
WHERE Name Like'S_&'
UNION
SELECT *
From Trainer
WHERE Year(DateOfBirth)<1991 

SELECT t1.Name
FROM Trainer t1
WHERE Name Like'S%'
INTERSECT
SELECT t2.Name
FROM Trainer t2 
WHERE Year(DateOfBirth)>1980


SELECT l1.Address, l1.Availability
FROM Locations l1
WHERE Address IS NOT NULL
EXCEPT
SELECT l2.Address,l2.Availability
FROM Locations l2
WHERE Availability='Saturday'

select *from Club c LEFT OUTER JOIN Trainer t ON c.TrainerID=t.TrainerID

select *from Club c RIGHT OUTER JOIN Trainer t ON c.TrainerID=t.TrainerID


select *from Club c INNER JOIN Trainer t ON c.TrainerID=t.TrainerID
INNER JOIN Locations l ON l.LocationID=c.LocationID 

SELECT t.Name, t.DateOfBirth
FROM Contract c INNER JOIN Trainer t ON c.TrainerID=t.TrainerID
WHERE Salary>2000

SELECT p.Name
FROM Participants p
WHERE Name IS NOT NULL and p.ParticipantID IN (SELECT p.ParticipantID FROM ActiveMembership a)

SELECT t.Name 
FROM Trainer t
WHERE Name IS NOT NULL and EXISTS (SELECT * FROM Contract c WHERE c.TrainerID=t.TrainerID)

SELECT m.Availability, p.Name
from ActiveMembership m INNER JOIN Participants p ON p.ParticipantID=m.ParticipantID
GROUP BY m.Availability, p.Name

SELECT  AVG(c.Salary)
FROM Contract c

select c.trainerID,c.Salary
from Contract c
order by Salary asc

Select *from Trainer
Select *from Contract
Select *from Locations
Select *from Participants
Select *from Membership
Select *from Club
Select *from ActiveMembership




