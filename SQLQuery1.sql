Create table Books(
ID int primary key identity,
[Name] nvarchar(100) Check (LEN([Name])>3),
AuthorId int FOREIGN KEY REFERENCES Authors(ID),
[PageCount] int Check([PageCount]>10)
-----------------------------------------------
)
create table Authors(
ID int primary key identity,
[Name] nvarchar(30),
Surname nvarchar(30)
)
------------------------------------------
Create View vw_SelectAuthorFulnameWithBooks 
as 
Select b.ID,b.[Name],[Pagecount],a.[Name]+''+a.Surname 
as Fulname from Books b inner join Authors a on b.AuthorId=a.ID
-------------------------------------------
select *from  vw_SelectAuthorFulnameWithBooks  
-------------------------------------------
create procedure SerachBookName
@Search nvarchar(30)
as
Select b.ID,b.[Name],[Pagecount],a.[Name]+''+a.Surname 
as AuthorFulname from Books b inner join Authors a on b.AuthorId=a.ID 
Where a.[Name] like '%'+ @Search + '%' and b.[Name] like '%'+ @Search + '%'and 
a.Surname like '%'+@Search+'%'
-------------------------------------------
exec SerachBookName 'f'
-------------------------------------------
create procedure InsertAuthorTable
@name nvarchar(30),
@surname nvarchar(30)
as
insert into Authors values(@name,@surname)
--------------------------------------------
exec InsertAuthorTable Adam,Smith
--------------------------------------------
create procedure UpdateAuthorTable
@id int,
@name nvarchar(30),
@surname nvarchar(30)
as UPDATE Authors
SET [Name] = @name, [Surname]= @surname
WHERE ID = @id;
--------------------------------------------
exec UpdateAuthorTable 8, 'Adam','Smith'
--------------------------------------------
create procedure DeleteAuthorTable
@id int 
as
Delete from Authors where ID=@id
--------------------------------------------
exec DeleteAuthorTable 8
---------------------------------------------
create view vw_SelectAuthorsBooksCountsAndMax
as
Select a.ID,a.Name+' '+a.Surname as Fullname,Count(a.ID) 
as BookCount,MAX(b.PageCount) as MaxPageCountBook
from Books b join Authors a 
on b.AuthorId=a.ID group by a.ID,a.Name,a.Surname
----------------------------------------------
select * from vw_SelectAuthorsBooksCountsAndMax
----------------------------------------------

