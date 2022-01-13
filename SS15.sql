--1
begin try
declare @num int;
select @num=217/0;
end try
begin catch
print 'error occurred,unable to divide by 0'
end catch;
--2
use AdventureWorks2019
go
begin try
select 217/0;
end try
begin catch
select
ERROR_NUMBER() as ErrorNumber, ERROR_SEVERITY() as ErrorSeverity,ERROR_LINE() as ErrorLine,ERROR_MESSAGE() as ErrorMessage;
end catch;
go
--3
use AdventureWorks2019
go
if OBJECT_ID('sp_ErrorInfo','P') IS NOT NULL
DROP PROCEDURE sp_ErrorInfo;
go
create Procedure sp_ErrorInfo
as
select
ERROR_NUMBER() as ErrorNumber,
ERROR_SEVERITY() as ErrorSeverity,
ERROR_STATE() as ErrorState,
ERROR_PROCEDURE() as ErrorProcedure,
ERROR_LINE() as ErrorLine,
ERROR_MESSAGE() as ErrorMessage;
go
begin try select 217/0;
end try
begin catch
EXECUTE sp_ErrorInfo;
--4
use AdventureWorks2019;
go
begin transaction;
begin try
delete from Production.Product where ProductID=980;
end try
begin catch
select
ERROR_SEVERITY() as ErrorSeverity,
ERROR_NUMBER() as ErrorNumber,
ERROR_PROCEDURE() as ErrorProcedure,
ERROR_STATE() as ErrorState,
ERROR_MESSAGE() as ErrorMessage,
ERROR_LINE() as ErrorLine; if @@TRANCOUNT>0
rollback transaction;
end catch;
if @@TRANCOUNT > 0 commit transaction;
go
--5
use AdventureWorks2019;
go
begin try
update HumanResources.EmployeePayHistory set PayFrequency=4
where BusinessEntityID=1;
end try
begin catch
if @@ERROR=547
print N'check constraint violation has occurred.';
end catch
--6
raiserror (N'This is an error message %s %d.',10,1,N'serial number',23);
go
--7
raiserror (N'%*.*s',10,1,7,3,N'Hello Word');
go
raiserror (N'%7.3s',10,1,N'Hello Word');
go
--8
raiserror ('raisesError in the Try block.',16,1);
end try
begin catch
declare @ErrorMessage NVARCHAR(4000); DECLARE @ErrorSeverity INT;
declare @ErrorState INT;
select
@ErrorMessage=ERROR_MESSAGE(),@ErrorSeverity=ERROR_SEVERITY(),
@ErrorState=ERROR_STATE();
raiserror (@ErrorMessage,@ErrorSeverity,@ErrorState);
end catch;
--9
begin try
select 217/0;
end try
begin catch
select ERROR_STATE() as ErrorState;
end catch;
go
--10
begin try
select 217/0;
end try
begin catch
select ERROR_SEVERITY() as ErrorSeverity;
end catch;
go
--11
use AdventureWorks2019;
go
if OBJECT_ID ('usp_Example','P') IS NOT NULL
drop procedure usp_Example;
go
create procedure usp_Example as
select 217/0;
go
begin try
execute usp_Example;
end try
begin catch
select ERROR_PROCEDURE() as ErrorProcedure;
end catch;
go
--12
use AdventureWorks2019
go
if OBJECT_ID ('usp_Example','P') IS NOT NULL
drop procedure usp_Example;
go
create procedure usp_Example as
select 217/0;
go
begin try
execute usp_Example;
end try
begin catch select
ERROR_NUMBER() as ErrorNumber,
ERROR_SEVERITY() as ErrorSeverity,
ERROR_STATE() as ErrorState,
ERROR_PROCEDURE() as ErrorProcedure,
ERROR_MESSAGE() as ErrorMessage,
ERROR_LINE() as ErrorLine;
end catch;
go
--13
begin try
select 217/0;
end try
begin catch
select ERROR_NUMBER() as ErrorNumber;
end catch;
go
--14
begin try 
select 217/0;
end try
begin catch
select ERROR_MESSAGE() as ErrorMessage;
end catch;
go
--15
begin try
select 217/0;
end try
begin catch
select ERROR_LINE() as ErrorLine;
end catch;
go
--16
use AdventureWorks2019
go
begin try
select *from Nonexistent;
end try
begin catch
select
ERROR_NUMBER() as ErrorNumber,
ERROR_MESSAGE() as ErrorMessage;
end catch
--17
if OBJECT_ID ('usp_Example','P') IS NOT NULL
drop procedure usp_Example;
go
create procedure sp_example as
select * from Nonexistent;
go
begin try
execute sp_example;
end try
begin catch select
ERROR_NUMBER() as ErrorNumber,
ERROR_MESSAGE() as ErrorMessage;
end catch;
--18
use tempdb;
go
create table dbo.TestRethrow(
ID int primary key
);
begin try
insert dbo.TestRethrow(ID) values(1);
insert dbo.TestRethrow(ID) values(1);
end try
begin catch
print 'in catch block.';
throw;
end catch;
