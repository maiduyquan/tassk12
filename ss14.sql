--1
use AdventureWorks2019
go
declare OTranName VARCHAR(30);
select OTranNAME='FirstTransaction';
BEGIN TRANSACTION OTranName;
--2
BEGIN TRANSACTION;

GO
DELETE FROM HumanResources.JobCandidate WHERE JobCandidateID=11;
go
commit transaction;
go
--3
begin transaction deleteCandidate
with mark 'N*Deleting a job candidate';
go
delete from HumanResources.JobCandidate where JobCandidateID=11;
go
commit transaction deleteCandidate;
--4
go
create table ValueTable([value]char)
go
--5
BEGIN transaction
insert into ValueTable VALUES('A');
insert into ValueTable VALUES('B');
go
rollback transaction
insert into ValueTable VALUES('C');
SELECT [value] FROM ValueTable;
--6
create procedure SaveTranExample @InputCandidateID int
as
declare @TranCounter int;
set @TranCounter=@@TRANCOUNT;
if @TranCounter>0
save transaction procedureSave;
else 
begin transaction;
delete HumanResources.JobCandidate
where JobCandidateID=@InputCandidateID;if @TranCounter=0
commit transaction;
if @TranCounter=1
rollback transaction procedureSave;
go
--7
print @@TRANCOUNT BEGIN TRAN 
PRINT @@TRANCOUNT BEGIN TRAN 
PRINT @@TRANCOUNT COMMIT 
PRINT @@TRANCOUNT COMMIT 
PRINT @@TRANCOUNT
--8
print @@TRANCOUNT BEGIN TRAN 
PRINT @@TRANCOUNT BEGIN TRAN 
print @@TRANCOUNT
rollback
print @@TRANCOUNT
--9
use AdventureWorks2019;
go
begin transaction ListPriceUpdate
with MARK 'update product list price';
go
update Production.Product
set ListPrice=ListPrice*1.20 where ProductNumber like 'BK-%';
go
commit transaction ListPriceUpdate;
go
