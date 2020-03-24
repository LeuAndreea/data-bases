USE [Sports-club]


create or alter function dbo.checkSalary(@salary int)
returns int as
begin 
	declare @no int
	if @salary>1000 and @salary <=2000
		set @no=1
	else
		set @no=2
	return @no
end
go

create or alter function dbo.checkTrainerID(@v varchar(50))
returns int as
begin
	declare @exist bit
	if exists (select trainerId from Trainer where @v = trainerID)
		set @exist=1
	else
		set @exist=0
return @exist
end
go

create or alter function dbo.checkContractID(@v varchar(50))
returns int as
begin
	declare @ok bit
	if not exists (select contractID from Contract where @v = contractID)
		set @ok=1
	else
		set @ok=0
return @ok
end
go



create or alter procedure dbo.[addContract] @salary int, @trainerid varchar(30), @contractid varchar(50) 
AS
	begin
		if dbo.checkSalary(@salary)=1 and dbo.checkContractID(@contractid)=0 and dbo.checkTrainerID(@trainerid)=1
		begin
			INSERT INTO  Contract(salary, TrainerID, ContractID) VALUES (@salary,@trainerid,@contractid)
			print 'value added'
			select * from .Contract
		end

		else
		begin
			print 'the parameters where not correct'
			--select *from Contract
		end
	end
	go

create or alter procedure dbo.[addTrainer] @trainerdId varchar(50), @date date, @specialization varchar(50), @name varchar(50)
AS
	begin
		if dbo.checkTrainerID(@trainerdId)=0
		begin
			INSERT INTO Trainer(TrainerID,Name,DateOfBirth,Specialization) VALUES (@trainerdId,@name,@date,@specialization)
			print 'value added'
			select *from Trainer
		end

		else
		begin
			print 'parameters where not correct'
		end
	end
	go


create or alter view ViewInfo 
as
	select c.ContractID, c.TrainerID, c.Salary from Contract c 
		inner join Club a on c.TrainerID=a.TrainerID
		inner join Locations l on a.LocationID=l.locationID
	go

exec addContract 1300,134,99
exec addTrainer 444, '1980-09-27', 'Nimic','Rodila Marian'

select *from ViewInfo

create table TrainerCopy(TrainerID int, Name varchar(50), DateOfBirth date, Specialization varchar(50))
create table LocationCopy(LocationID varchar(50), Adress varchar(50), Availability varchar(50))
create table logs (logtime datetime, affectedTable varchar(50), logtype varchar(50), affectedRows int)

 create or alter trigger insertTrainer on Trainer for insert
 as
begin
	insert into TrainerCopy(TrainerID,Name, DateOfBirth,Specialization) 
	select TrainerID,Name, DateOfBirth,Specialization from inserted
	insert into Logs(logtime,affectedTable, logtype,affectedRows) 
	values(CURRENT_TIMESTAMP, 'Trainer', 'insert', @@ROWCOUNT)
end
go

create or alter trigger deleteTrainer on Trainer for delete
as
begin
	insert into TrainerCopy(TrainerID,Name, DateOfBirth,Specialization) 
	select TrainerID,Name, DateOfBirth,Specialization from deleted
	insert into Logs(logtime,affectedTable, logtype,affectedRows) 
	values(CURRENT_TIMESTAMP, 'Trainer', 'delete', @@ROWCOUNT)
end
go

create or alter trigger insertLocation on Locations for insert
as
begin
	insert into LocationCopy(LocationID , Adress, Availability) 
	select LocationID , Address, Availability from inserted
	insert into Logs(logtime,affectedTable, logtype,affectedRows) 
	values(CURRENT_TIMESTAMP, 'Location', 'add', @@ROWCOUNT)
end
go

create or alter trigger updateLocation on Locations for delete
as
begin
	insert into LocationCopy(LocationID , Adress, Availability) 
	select LocationID , Address, Availability from deleted
	insert into Logs(logtime,affectedTable, logtype,affectedRows) 
	values(CURRENT_TIMESTAMP, 'Location', 'delete', @@ROWCOUNT)
end
go

select*from Logs
insert into Trainer values (666, '.', '1980-12-02', '.')
select *from Logs
delete from Trainer where TrainerId=666
insert into Locations values (376, 'street' ,'Monday')
select *from Logs
delete from Locations where LocationID=376
select *from Logs

use [Sports-club]
Select *from Trainer
Select *from Contract
Select *from Locations
Select *from Participants
Select *from Membership
Select *from Club
Select *from ActiveMembership