-- loome db
create database Targe21

--- db valimine
use Targe21

--- db kustutamine
drop database Targe21


--- tabeli loomine
cReaTE table Gender
(
Id int  not null primary key,
Gender nvarchar(10) not null
)

-- andmete sisestamine
insert into Gender (Id, Gender)
values (2, 'Male')
insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)
values (3, 'Unknown')

-- vaatame tabeli sisu
select * from Gender

create table Person 
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)
--- andmete sisestamine
insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (2, 'Wonderwoman', 'w@w.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (3, 'Batman', 'b@b.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (4, 'Aquaman', 'a@a.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (5, 'Catwoman', 'c@c.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (6, 'Antman', 'ant"ant.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (8, NULL, NULL, 2)

select * from Person

--- v��rv�tme �henduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

--- kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla v''rtust, siis
--- see automaatselt sisestab sellele reale v''rtuse 3 e nagu meil on unknown
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

--- piirangu kustutamine
alter table Person
drop constraint DF_Persons_GenderId

-- lisame veeru
alter table Person
add Age nvarchar(10)

--- lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

--- kustutame rea
delete from Person where Id = 11

select * from Person

-- kuidas uuendada andmeid
update Person
set Age = 50
where Id = 7

alter table Person
add City nvarchar(50)

-- k�ik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
-- k�ik, kes ei ela Gothamis
select * from Person where City <> 'Gotham'
-- k�ik, kes ei ela Gothamis
select * from Person where City != 'Gotham'

--- n�itab teatud vanusega inimesi
select * from Person where Age = 150 or Age = 35 or Age = 25
select * from Person where Age in (150, 35, 25)

-- n�itab teatud vanusevahemikus olevaid inimesi
select * from Person where Age between 22 and 39

-- wildcard e n�itab k�ik g-t�hega linnad
select * from Person where City like 'n%'
select * from Person where Email like '%@%'

-- n�itab k�iki, kellel ei ole @-m�rki emailis
select * from Person where Email not like '%@%'

--n�itab, kellel on emailis ees ja peale @-m�rki ainult �ks t�ht
select * from Person where Email like '_@_.com'

-- k]ik, kellel on nimes ei ole esimene t'hte W, A, C
select * from Person where Name like '[^WAS]%'
select * from Person

--- kes elavad Gothamis ja New Yorkis
select * from Person where (City = 'Gotham' or City = 'New York')

--- k�ik, kes elavad v�lja toodud linnades ja on vanemad, kui 29
select * from Person where (City = 'Gotham' or City = 'New York')
and Age >= 30

--- kuvab t�hestikulises j�rjekorras inimesi ja v�tab aluseks nime
select * from Person order by Name
--- kuvab vasutpidises j�rjestuses
select * from Person order by Name desc

--- v�tab kolm esimest rida
select top 3 * from Person 

-- kolm esimest, aga tabeli j�rjestus on Age ja siis Name
select * from Person
select top 3 Age, Name from Person

--- n�ita esimesed 50% tabelis
select top 50 percent * from Person

--- j�rjestab vanuse j�rgi isikud
select * from Person order by Age desc

--v�tab neli esimest ja j�rjestab vanuse j�rgi
select top 4 * from Person order by Age desc

-- muudab Age muutuja intiks ja n�itab vanuselises j�rjestuses
select * from Person order by cast(Age as int)

-- k�ikide isikute koondvanus
select sum(cast(Age as int)) from Person

-- kuvab k�ige nooremat isikut
select min(cast(Age as int)) from Person
-- kuvab k�ige vanemat isikut
select max(cast(Age as int)) from Person

-- n�eme konkreetsetes linnades olevate isikute koondvanust
-- enne oli Age string, aga enne p�ringut muutsime selle int-ks
select City, sum(Age) as TotalAge from Person group by City

--- kuidas saab koodiga muuta andmet��pi ja selle pikkust
alter table Person
alter column Name nvarchar(25)


--- kuvab esimeses reas v�lja toodud j�rjestuses ja kuvab Age-i TotalAge-ks
--- j�rjest City-s olevate nimede j�rgi ja siis genderId j�rgi
select City, GenderId, Sum(Age) as TotalAge from Person
group by City, GenderId order by City

--- n�itab, et mitu rida on selles tabelis
select count(*) from Person
select * from Person

--- n�itab tulemust, et mitu inimest on genderId v��rtusega 2 konkreetses linnas
--- arvutab vanuse kokku konkreetses linnas
select Genderid, City, sum(Age) as TotalAge, count(Id) as [Total Person(s)] 
from Person
where GenderId = '2'
group by GenderId, City

-- n�itab �ra, et mitu inimest vanemad, kui 41 ja kui palju igas linnas
select GenderId, City, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
group by GenderId, City having sum(Age) > 41


-- loome, tabelid Employees ja Department

create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (10, 'Russell', 'Male', 8800, NULL)

insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (1, 'IT', 'London', 'Rick')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (2, 'Payroll', 'Delhi', 'Ron')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (3, 'HR', 'New York', 'Christie')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (4, 'Other Department', 'Sydney', 'Cindrella')

select * from Department
select * from Employees

--- 
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

--- 2 tund
select * from Employees
select sum(cast(Salary as int)) from Employees  -- arvutab k�ikide palgad kokku
select min(cast(Salary as int)) from Employees  -- min palga saaja ja kui panen min asemele max, siis max palga saaja
select City, sum(cast(Salary as int)) as TotalSalary from Employees group by City  -- �he kuu palgafond linnade l�ikes

alter table Employees
add City nvarchar(30)
select * from Department

select City, Gender, sum(cast(Salary as int)) as TotalSalary from Employees group by City, Gender -- toome soolise erisuse p�ringusse
select City, Gender, sum(cast(Salary as int)) as TotalSalary from Employees group by City, Gender order by City -- linnad on t�hestikulises j�rjekorras
select Gender, City, sum(cast(Salary as int)) as TotalSalary from Employees group by City, Gender order by City

select count(*) from Employees -- loeb �ra, mitu inimest on nimekirjas, * asemele v�ib panna ka muid veergude nimetusi

select Gender, City, sum(cast(Salary as int)) as TotalSalary, 
count (Id) as [Total Employee(s)] 
from Employees 
group by Gender, City
--- mitu t��tajat on soo ja linna kaupa

select Gender, City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
where Gender='Fale'
group by Gender, City
--- kuvab ainult k�ik mehed linnade kaupa

select Gender, City, sum(cast(Salary as int)) as TotalSalary, 
count (Id) as [Total Employee(s)] 
from Employees 
group by Gender, City
having Gender ='Female'
--- kuvab ainult k�ik naised linnade kaupa

select * from Employees where sum(cast(Salary as int)) > 4000

select Gender, City, sum(cast(Salary as int)) as TotalSalary, count (Id) as [Total Employee(s)]
from Employees group by Gender, City
having sum(cast(Salary as int)) > 4000


--- loome tabeli, milles hakatakse automaatselt nummerdama Id-d
create table Test1
(
Id int identity(1,1),
Value nvarchar(20)
)
insert into Test1 values('X')

select * from Test1


--- kustutame veeru nimega City
alter table Employees
drop column City


--- inner join
-- kuvab neid, kellel on DepartmentName all olemas v��rtus
select FirstName, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

--- left join
--- kuidas saada k�ik andmed Employees-st k�tte
select Name, Gender, Salary, DepartmentName
from Employees
left join Department  -- v�ib kasutada ka LEFT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

---
--- kuidas saada DepartmentName alla uus nimetus e antud juhul Other Department
select Name, Gender, Salary, DepartmentName
from Employees
right join Department  -- v�ib kasutada ka RIGHT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

--- kuidas saada k�ikide tabelite v��rtused �hte p�ringusse
select Name, Gender, Salary, DepartmentName
from Employees
full outer join Department
on Employees.DepartmentId = Department.Id

-- cross join v�tab kaks allpool olevat tabelit kokku ja korrutab need omavahel l�bi
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department

--- p�ringu sisu
Select ColumnList
from   LeftTable
joinType  RightTable
on  JoinCondition

--- inner join

select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Department.Id = Employees.DepartmentId


--- kuidas kuvada ainult need isikud, kellel on DepartmentName NULL
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--- teise variant
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Department.Id is null

--- kuidas saame Department tabelis oleva rea, kus on NULL
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--- full join
--- m�lema tabeli mitte-kattuvate v��rtustega read kuvab v�lja
select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

select * from Department

-- saame muuta tabeli nimetust, alguses vana tabeli nimi ja siis uus soovitud
sp_rename 'Deparmtent1' , 'Department'

--- kasutame Employees tabeli asemel l�hendit E ja M
select E.Name as Employee, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

alter table Employees
add ManagerId int

--- inner join
--- kuvab ainult ManagerId all olevate isikute v��rtuseid
select E.Name as Employee, M.Name as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

--- k�ik saavad k�ikide �lemused olla
select E.Name as Employee, M.Name as Manager
from Employees E
cross join Employees M



select isnull('Ingvar', 'No Manager') as Manager

--- NULL asemel kuvab No Manager
select coalesce(NULL, 'No Manager') as Manager

--- kui Expression on �ige, siis paneb v''rtuse, mida sovid v�i m�ne teise v��rtuse
case when Expression Then '' else '' end

--- neil kellel ei ole �lemust, siis paneb neile No Manager teksti
select  E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id


--- teeme p'ringu, kus kasutame case-i
select E.Name as Employee, case when M.Name is null then 'No Manager' 
else M.Name end as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

-- lisame tabelisse uued veerud
alter table Employees
add MiddleName nvarchar(30)
alter table Employees
add LastName nvarchar(30)

select * from Employees

-- muudame ja lisame andmeid
update Employees
set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1

update Employees
set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2

update Employees
set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3

update Employees
set FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4

update Employees
set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5

update Employees
set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6

update Employees
set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7

update Employees
set FirstName = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8

update Employees
set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9

update Employees
set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10

select * from Employees

--- igast reast v�tab esimeses t�idetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees


--- loome kaks tabelit
create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

--- sisestame tabelisse andmeid
insert into IndianCustomers (Name, Email)
values ('Raj', 'R@R.com')
insert into IndianCustomers (Name, Email)
values ('Sam', 'S@S.com')

insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com')
insert into UKCustomers (Name, Email)
values ('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers


--- kasutame union all, n�itab k�iki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

--- korduvate v��rtustega read pannakse �hte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

--- kuidas tulemust sorteerida nime j�rgi
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers
order by Name


--- stored procedure
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end

--- n��d saab kasutada selle nimelist sp-d
spGetEmployees
exec spGetEmployees
execute spGetEmployees

select * from Employees


create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

-- kui n��d allolevat k�sklust k�ima panna, siis n�uab Gender parameetrit
spGetEmployeesByGenderAndDepartment
--- �ige variant
spGetEmployeesByGenderAndDepartment 'Male', 1

--- niimoodi saab sp tahetud j�rjekorrast m��da minna, kui ise paned muutujad paika
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

--- saab sp sisu vaadata result vaates
sp_helptext spGetEmployeesByGenderAndDepartment


--- 3 tund


-- kuidas muuta sp-d ja v�ti peale, et keegi teine peale teie ei saaks muuta
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
with encryption -- paneb v�tme peale
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

select * from Employees


-- sp tegemine

create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = count(Id) from Employees where Gender = @Gender
end

--- annab tulemuse, kus loendab �ra n�uetele vastavad read
--- prindib ka tulemuse kirja teel
declare @TotalCount int
execute spGetEmployeeCountByGender 'asd', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@Total is not null'
print @TotalCount

select * from Employees

--- n�itab �ra, et mitu rida vastab n�uetele
declare @TotalCount int
execute spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Male'
print @TotalCount

--- sp sisu vaatamine
sp_help spGetEmployeeCountByGender
--- tabeli info
sp_help Employees
-- kui soovid sp teksti n�ha
sp_helptext spGetEmployeeCountByGender

--- vaatame, millest s�ltub see sp
sp_depends spGetEmployeeCountByGender
--- vaatame tabelit
sp_depends Employees

---
create proc spGetNameById
@Id int,
@Name nvarchar(20) output
as begin
	select @Name = Id, @Name = FirstName from Employees
end

--- annab kogu tabeli ridade arvu
create proc spTotalCount2
@TotalCount int output
as begin
	select @TotalCount = count(Id) from Employees
end

--- saame teada, et mitu rida andmeid on tabelis
Declare @TotalEmployees int
Execute spTotalCount2 @TotalEmployees Output
Select @TotalEmployees

--- mis id all on keegi nime j�rgi
create proc spGetNameById1
@Id int,
@FirstName nvarchar(50) output
as begin
	select @FirstName = FirstName from Employees where Id = @Id
end
--- annab tulemuse, kus id 1 real on keegi koos nimega
declare @FirstName nvarchar(50)
execute spGetNameById1 1, @FirstName output
print 'Name of the employee = ' + @FirstName

---
declare 
@FirstName nvarchar(20)
execute spGetNameById 1, @FirstName out
print 'Name = ' + @FirstName

sp_help spGetNameById

---
create proc spGetNameById2
@Id int
as begin
	return (select FirstName from Employees where Id = @Id)
end

-- tuleb veateade kuna kutsusime v�lja int-i, aga Tom on string
declare @EmployeeName nvarchar(50)
execute @EmployeeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName



---- sisseehitatud string funktsioonid
--- see konverteerib ASCII t�he v��rtuse numbriks
select ascii('a')
-- kuvab A-t�he
select char (65)

--- prindime kogu t'hestiku v�lja
declare @Start int
set @Start = 97
WHILE (@Start <= 122)
begin
	select char (@Start)
	set @Start = @Start + 1
end

---- eemaldame t�hjad kohad sulgudes
select ltrim('          Hello')

--- t�hikute eemaldamine veerust
select ltrim(FirstName) as FirstName, MiddleName, LastName from Employees

select * from Employees

--- paremalt poolt t�hjad stringid l�ikab �ra
select rtrim('     Hello                     ')

----keerab kooloni sees olevad andmed vastupidiseks
--- vastavalt upper ja lower-ga saan muuta m�rkide suurust
--- reverse funktsioon p��rab k�ik �mber
select REVERSE(upper(ltrim(FirstName))) as FirstName, MiddleName, lower(LastName),
rtrim(ltrim(FirstName)) + ' ' + MiddleName + '  ' + LastName as FullName
from Employees

--- n�eb, mitu t�hte on s�nal ja loeb tyhikud sisse
select FirstName, len(FirstName) as [Total Characters] from Employees
--- n�eb, mitu t�hte on s�nal ja ei loe tyhikuid sisse
select FirstName, len(ltrim(FirstName)) as [Total Characters] from Employees


--- left, right, substring
-- vasakult poolt neli esimest t�hte
select left('ABCDEF', 4)
--- paremalt poolt kolm t�hte
select right('ABCDEF', 3)

--- kuvab @-t�hem�rgi asetust
select charindex('@', 'sara@aaa.com')

--- esimene nr peale komakohta n�itab, et mitmendast alustab  ja siis mitu nr peale seda kuvada
select substring('pam@bbb.com', 5, 2)


--- @-m�rgist kuvab kolm t�hem�rki. Viimase nr saab m��rata pikkust
select substring('pam@bbb.com', charindex('@', 'pam@bbb.com') + 1, 3)

--- peale @-m'rki reguleerin t�hem�rkide pikkuse n�itamist
select substring('pam@bbb.com', charindex('@', 'pam@bbb.com') + 2,
len('pam@bbb.com') - charindex('@', 'pam@bbb.com'))

--- saame teada domeeninimed emailides
select substring (Email, charindex( '@', Email) + 1,
len (Email) - charindex('@', Email)) as EmailDomain
from Employees

select * from Employees

alter table Employees
add Email nvarchar(20)

update Employees set Email = 'Tom@aaa.com' where Id = 1
update Employees set Email = 'Pam@bbb.com' where Id = 2
update Employees set Email = 'John@aaa.com' where Id = 3
update Employees set Email = 'Sam@bbb.com' where Id = 4
update Employees set Email = 'Todd@bbb.com' where Id = 5
update Employees set Email = 'Ben@ccc.com' where Id = 6
update Employees set Email = 'Sara@ccc.com' where Id = 7
update Employees set Email = 'Valarie@aaa.com' where Id = 8
update Employees set Email = 'James@bbb.com' where Id = 9
update Employees set Email = 'Russel@bbb.com' where Id = 10

select * from Employees

---lisame *-m�rgiga teatud kohast
select FirstName, LastName,
	substring(Email, 1, 2) + replicate('*', 5) + -- peale teist t�hem�rki paneb viis t'rni
	substring(Email, charindex('@', Email), len(Email) - charindex('@', Email)+1) as Email --kuni @-m�rgini e on d�naamiline
from Employees

--- kolm korda n�itab stringis olevat v''rtust
select replicate('asd', 3)

-- kuidas sisestada tyhikut kahe nime vahele
select space(5)

-- t�hikute arv ahe nime vahel
select FirstName + space(25) + LastName as FullName
from Employees

---PATINDEX
--- sama, mis CHARINDEX, aga d�naamilisem ja saab kasutada wildcardi
select Email, PATINDEX('%@aaa.com', Email) as FirstOccurence
from Employees
where PATINDEX('%@aaa.com', Email) > 0 --- leian k�ik selle domeeni esindajad ja 
--- alates mitmendast m'rgist algab @

--- k�ik .com-d asendatakse .net-ga
select Email, replace(Email, '.com', '.net') as ConvertedEamil
from Employees

---- soovin asendada peale esimest m'rki kolm t�hte viie t�rniga
select FirstName, LastName, Email,
	stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees


---
create table DateTime
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)

select * from DateTime

--konkreetse masina kellaaeg
select getdate(), 'GETDATE()'

--- 
insert into DateTime 
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())


update DateTime set c_datetimeoffset = '2022-04-08 14:49:28.1933333 +10:00'
where c_datetimeoffset = '2022-04-08 14:49:28.1933333 +00:00'

select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' --- aja p�ring
select SYSDATETIME(), 'SYSDATETIME'  -- veel t�psem aja p�ring
select SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET' --- t�pne aeg koos ajalise nihkega UTC suhtes
select GETUTCDATE(), 'GETUTCDATE' ---UTC aeg

--- 4 tund SQL

select ISDATE('asd') --tagastab 0 kuna string ei ole date
select ISDATE(getdate()) -- tagastab 1 kuna on kp
select ISDATE('2022-04-08 14:49:28.1933333') --- tagastab 0 kuna max kolm komakohta v�ib olla
select ISDATE('2022-04-08 14:49:28.193') -- tagastab 1
select DAY(GETDATE()) -- annab t�nase p�eva nr
select DAY('01/31/2017') -- annab stringis oleva kp ja j�rjestus peab olema �ige
select Month(GETDATE()) --annab jooksva kuu nr
select Month('03/31/2017') -- annab stringis oleva kuu
select Year(GETDATE()) -- annab jooksva aasta nr
select Year('01/31/2017') -- annab stringis oleva aasta nr

select datename(day, '2022-04-08 14:49:28.193') -- annab stringis oleva p�eva nr
select datename(WEEKDAY, '2022-04-08 14:49:28.193') -- annab stringis oleva p�eva s�nana
select datename(MONTH, '2022-04-08 14:49:28.193') -- ananb stringis oleva kuu s�nana

create table EmployeesWithDates
(
	Id nvarchar(2),
	Name nvarchar(20),
	DateOfBirth datetime
)

INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (1, 'Sam', '1980-12-30 00:00:00.000');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (2, 'Pam', '1982-09-01 12:02:36.260');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (3, 'John', '1985-08-22 12:03:30.370');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (4, 'Sara', '1979-11-29 12:59:30.670');

--- kuidas v�tta �hest veerust andmeid ja selle abil luua uued veerud
select	Name, DateOfBirth, DATENAME(WEEKDAY, DateOfBirth) as [Day],  ---vt DoB veerust p�eva ja kuvab p�eva nimetuse s�nana
		MONTH(DateOfBirth) as MonthNumber,  ---vt DoB veerust kp-d ja kuvab kuu nr
		DateName(Month, DateOfBirth) as [MonthName],  ---vt DoB veerust kuud ja kuvab s�nana
		Year(DateOfBirth) as [Year] -- v�tab DoB veerust aasta
from EmployeesWithDates


select DATEPART(weekday, '2022-04-24 12:02:36.260') -- kuvab 1 kuna USA n�dal algab p�hap�evaga
select DATEPART(month, '2022-04-24 12:02:36.260')  --kuvab kuu nr
select DATEADD(DAY, 20, '2022-04-24 12:02:36.260') -- liidab stringis olevale kp 20 p�eva juurde
select DATEADD(DAY, -20, '2022-04-24 12:02:36.260')  -- lahutab 20 p�eva maha
select DATEDIFF(MONTH, '11/30/2022', '01/31/2022')  -- kuvab kahe stringi kuudevahelist aega nr-na
select DATEDIFF(YEAR, '11/30/2020', '01/31/2022')  -- kuvab stringis olevate aastatevahelist aega nr-na



create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int, @months int, @days int
		select @tempdate = @DOB

		select @years = datediff(year, @tempdate, getdate()) - case when (month(@DOB) > month(getdate())) or (month(@DOB) 
		= month(getdate()) and day(@DOB) > day(getdate())) then 1 else 0 end
		select @tempdate = dateadd(year, @Years, @tempdate)

		select @months = datediff(month, @tempdate, getdate()) - case when day(@DOB) > day(getdate()) then 1 else 0 end
		select @tempdate = dateadd(MONTH, @months, @tempdate)

		select @days = datediff(day, @tempdate, getdate())

	declare @Age nvarchar(50)
		set @Age = cast(@years as nvarchar(4)) + ' Years ' + cast(@months as nvarchar(2)) + ' Months ' + cast(@days as nvarchar(2)) +
		' Days old'
	return @Age
end

-- saame vaadata kasutajate vanust 
select Id, Name, DateofBirth, dbo.fnComputeAge(DateOfBirth) as Age from EmployeesWithDates

-- kui kasutame seda funktsiooni, siis saame teada t'nase p�eva vahet stringis v�lja tooduga
select dbo.fnComputeAge('11/11/2010')

-- nr peale DOB muutujat n�itab, et mismoodi kuvada DOB-d
select Id, Name, DateOfBirth,
convert(nvarchar, DateOfBirth, 126) as ConvertedDOB
from EmployeesWithDates

select Id, Name, Name + ' - ' + cast(Id as nvarchar) as [Name-Id] from EmployeesWithDates

select cast(getdate() as date) -- t�nane kp
select convert(date, getdate()) -- t�nane kp

--- matemaatilised funktsioonid

select abs(-101.5) ---abs on absoluutne nr ja tulemuseks saame ilma miinus m'rgita tulemuse
select ceiling(15.2)  ---tagastab 16 ja suurendab suurema t�isarvu suunas
select ceiling(-15.2)  ---tagastab -15 ja suurendab suurema positiivse t�isarvu suunas
select floor(15.2) --- �mardab negatiivsema nr poole
select floor(-15.2) --- �mardab negatiivsema nr poole
select power(2, 4) -- hakkab korrutama 2x2x2x2, esimene nr on korrutatav
select SQUARE(9) -- antud juhul 9 ruudus
select sqrt(81) -- annab vastuse 9, ruutjuur

select rand() -- annab suvalise nr
select floor (rand() * 100) -- korrutab sajaga iga suvalise nr

--- iga kord n�itab 10 suvalist nr-t
declare @counter int
set @counter = 1
while (@counter <= 10)
	begin
		print floor(rand() * 1000)
		set @counter = @counter + 1
end

select ROUND(850.556, 2) -- �mardab kaks kohta peale komat, tulemus 850.560
select ROUND(850.556, 2, 1) -- �mardab allapoole, tulemus 850.550
select ROUND(850.556, 1) -- �mardab �lespoole ja v�tab ainult esimest nr peale koma arvesse 850.600 
select ROUND(850.556, 1, 1) -- �mardab allapoole
select ROUND(850.556, -2) -- �mardab t�isnr �lesse
select ROUND(850.556, -1) -- �mardab t�isnr allapoole


---
create function dbo.CalculateAge (@DOB date)
returns int
as begin
declare @Age int

set @Age = datediff(year, @DOB, GETDATE()) - 
	case
		when (month(@DOB) > month(getdate())) or
			 (month(@DOB) > month(getdate()) and day(@DOB) > day(getdate()))
		then 1
		else 0
		end
	return @Age
end

execute CalculateAge '10/08/2020'

-- arvutab v�lja, kui vana on isik ja v�tab arvesse kuud ja p�evad
-- antud juhul n�itab k�ike, kes on �le 36 a vanad
select Id, Name, dbo.CalculateAge(DateOfBirth) as Age from EmployeesWithDates
where dbo.CalculateAge(DateOfBirth) > 36


--- inline table valued functions

alter table EmployeesWithDates
add DepartmentId int
alter table EmployeesWithDates
add Gender nvarchar(10)

select * from EmployeesWithDates

update EmployeesWithDates set Gender = 'Male', DepartmentId = 1
where Id = 1
update EmployeesWithDates set Gender = 'Female', DepartmentId = 2
where Id = 2
update EmployeesWithDates set Gender = 'Male', DepartmentId = 1
where Id = 3
update EmployeesWithDates set Gender = 'Female', DepartmentId = 3
where Id = 4
insert into EmployeesWithDates (Id, Name, DateOfBirth, DepartmentId, Gender)
values (5, 'Todd', '1978-11-29 12:59:30.670', 1, 'Male')


-- scalare function annab mingis vahemikus olevaid andmeid, aga
-- inline table values ei kasuta begin ja end funktsioone
-- scalar annab v��rtused ja inline annab tabeli 
create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table
as
return (select Id, Name, DateOfBirth, DepartmentId, Gender
		from EmployeesWithDates
		where Gender = @Gender)

-- k�ik female t��tajad
select * from fn_EmployeesByGender('Female')

select * from fn_EmployeesByGender('Female')
where Name = 'Pam'  --- where abil saab otsingut t�psustada

select * from Department

--- kahest erinevast tabelist andmete v�tmine ja koos kuvamine
--- esimene on funktsioon ja teine tabel
select Name, Gender, DepartmentName
from fn_EmployeesByGender('Male') E
join Department D on D.Id = E.DepartmentId

--- multi-table statment

-- inline funktsioon
create function fn_GetEmployees()
returns table as
return (Select Id, Name, cast(DateOfBirth as date)
		   as DOB
		   from EmployeesWithDates)


select * from fn_GetEmployees()

-- multi-state puhul peab defineerima uue tabeli veerud koos muutujatega
create function fn_MS_GetEmployees()
returns @Table Table (Id int, Name nvarchar(20), DOB date)
as begin
	insert into @Table
	select Id, Name, Cast(DateOfBirth as date) from EmployeesWithDates

	return
end

select * from fn_MS_GetEmployees()

--- inline tabeli funktsioonid on paremini t��tamas kuna k�sitletakse vaatena
--- multi puhul on pm tegemist stored proceduriga ja kulutab ressurssi rohkem

update fn_GetEmployees() set Name = 'Sam1' where Id = 1  -- saab muuta andmeid
update fn_MS_GetEmployees() set Name = 'Sam 1' where Id = 1  -- ei saa muuta andmeid multistate puhul


-- deterministic ja non-deterministic

select count(*) from EmployeesWithDates
select SQUARE(3) -- k�ik tehtem�rgid on deterministic funktsioonid, sinna kuuluvad veel sum, avg, square

-- non-deterministic
select getdate()
select CURRENT_TIMESTAMP
select rand() --see funktsioon saab olla m�lemas kategoorias, k�ik oleneb sellest, kas sulgudes on 1 v�i ei ole

-- loome funktsiooni
create function fn_GetNameById(@id int)
returns nvarchar(30)
as begin
	return (select Name from EmployeesWithDates where Id = @id)
end

select dbo.fn_GetNameById(4)

drop table EmployeesWithDates

create table EmployeesWithDates
(
	Id int primary key,
	Name nvarchar(50) NULL,
	DateOfBirth datetime NULL,
	Gender nvarchar(10) NULL,
	DepartmentId int NULL
)

insert into EmployeesWithDates values(1, 'Sam', '1980-12-30 00:00:00.000', 'Male', 1)
insert into EmployeesWithDates values(2, 'Pam', '1982-09-01 12:02:36.260', 'Female', 2)
insert into EmployeesWithDates values(3, 'John', '1985-08-22 12:03:30.370', 'Male', 1)
insert into EmployeesWithDates values(4, 'Sara', '1979-11-29 12:59:30.670', 'Female', 3)
insert into EmployeesWithDates values(5, 'Todd', '1978-11-29 12:59:30.670', 'Male', 1)


create function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end

sp_helptext fn_GetEmployeeNameById

-- peale seda ei n�e funktsiooni sisu
alter function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
with encryption
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end

--- muudame �levalpool olevat funktsiooni, kindlasti tabeli ette panna dbo.TabeliNimi
alter function dbo.fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
with schemabinding
as begin
	return (select Name from dbo.EmployeesWithDates where Id = @Id)
end

-- ei saa kustutada tabelid ilma funktsiooni kustutamata
drop table dbo.EmployeesWithDates

--- 5 tund

--- temporary tables

--- #-m�rgi ette panemisel saame aru, et tegemist on temp table-ga
--- seda tabelit saab ainult selles p�ringus avada
create table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails

select Name from sysobjects
where Name like '#PersonDetails%'

--- kustuta temp table
drop table #PersonDetails


create proc spCreateLocalTempTable
as begin
create table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails
end

exec spCreateLocalTempTable

--- globaalse temp table tegemine
create table ##PersonDetails(Id int, Name nvarchar(20))


---index
create table EmployeeWithSalary
(
Id int primary key,
Name nvarchar(25),
Salary int,
Gender nvarchar(10)
)

insert into EmployeeWithSalary values(1, 'Sam', 2500, 'Male')
insert into EmployeeWithSalary values(2, 'Pam', 6500, 'Female')
insert into EmployeeWithSalary values(3, 'John', 4500, 'Male')
insert into EmployeeWithSalary values(4, 'Sara', 5500, 'Female')
insert into EmployeeWithSalary values(5, 'Todd', 3100, 'Male')

select * from EmployeeWithSalary

select * from EmployeeWithSalary
where Salary > 5000 and Salary < 7000

--- loome indeksi, mis asetab palga kahanevasse j�rjestusse
create index IX_Employee_Salary
on EmployeeWithSalary (Salary asc)

--- saame teada, et mis selle tabli primaarv�ti ja index
EXEC sys.sp_helpindex @objname = 'EmployeeWithSalary'


-- saame vaadata tabelit koos selle sisuga alates v�ga detialisest infost
SELECT 
     TableName = t.name,
     IndexName = ind.name,
     IndexId = ind.index_id,
     ColumnId = ic.index_column_id,
     ColumnName = col.name,
     ind.*,
     ic.*,
     col.* 
FROM 
     sys.indexes ind 
INNER JOIN 
     sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id 
INNER JOIN 
     sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
INNER JOIN 
     sys.tables t ON ind.object_id = t.object_id 
WHERE 
     ind.is_primary_key = 0 
     AND ind.is_unique = 0 
     AND ind.is_unique_constraint = 0 
     AND t.is_ms_shipped = 0 
ORDER BY 
     t.name, ind.name, ind.index_id, ic.is_included_column, ic.key_ordinal;

--- indeksi kustutamine
drop index EmployeeWithSalary.IX_Employee_Salary


---- indeksi t��bid:
--1. Klastrites olevad
--2. Mitte-klastris olevad
--3. Unikaalsed
--4. Filtreeritud
--5. XML
--6. T�istekst
--7. Ruumiline
--8. Veerus�ilitav
--9. Veergude indeksid
--10. V�lja arvatud veergudega indeksid

-- klastris olev indeks m��rab �ra tabelis oleva f��silise j�rjestuse 
-- ja selle tulemusel saab tabelis olla ainult �ks klastris olev indeks

drop table EmployeeWithSalary

create table EmployeeCity
(
Id int primary key,
Name nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50)
)


exec sp_helpindex EmployeeCity

-- andmete �ige j�rjestuse loovad klastris olevad indeksid ja kasutab selleks Id nr-t
-- p�hjus, miks antud juhul kasutab Id-d, tuleneb primaarv�tmest
insert into EmployeeCity values(3, 'John', 4500, 'Male', 'New York')
insert into EmployeeCity values(1, 'Sam', 2500, 'Male', 'London')
insert into EmployeeCity values(4, 'Sara', 5500, 'Female', 'Tokyo')
insert into EmployeeCity values(5, 'Todd', 3100, 'Male', 'Toronto')
insert into EmployeeCity values(2, 'Pam', 6500, 'Male', 'Sydney')

-- klastris olevad indeksid dikteerivad s�ilitatud andmete j�rjestuse tabelis 
-- ja seda saab klastrite puhul olla ainult �ks

select * from EmployeeCity

create clustered index IX_EmployeeCity_Name
on EmployeeCity(Name)

--- annab veateate, et tabelis saab olla ainult �ks klastris olev indeks
--- kui soovid, uut indeksit luua, siis kustuta olemasolev

--- saame luua ainult �he klastris oleva indeksi tabeli peale
--- klastris olev indeks on analoogne telefoni suunakoodile

-- loome composite indeksi
-- enne tuleb k�ik teised klastris olevad indeksid �ra kustutada

create clustered index IX_Employee_Gender_Salary
on EmployeeCity(Gender desc, Salary asc)
-- kui teed select p�ringu sellele tabelile, siis peaksid n�gema andmeid, mis on j�rjestatud selliselt:
-- Esimeseks v�etakse aluseks Gender veerg kahanevas j�rjestuses ja siis Salary veerg t�usvas j�rjestuses

select * from EmployeeCity

--- mitte klastirs olev indeks
create nonclustered index IX_EmployeeCity_Name
on EmployeeCity(Name)
-- teeme p�ringu tabelile
select * from EmployeeCity

--- erinevused kahe indeksi vahel
--- 1. ainult �ks klastris olev indeks saab olla tabeli peale, 
--- mitte-klastris olevaid indekseid saab olla mitu
--- 2. klastris olevad indeksid on kiiremad kuna indeks peab tagasi viitama tabelile
--- Juhul, kui selekteeritud veerg ei ole olemas indeksis
--- 3. Klastris olev indeks m��ratleb �ra tabeli ridade slavestusj�rjestuse
--- ja ei n�ua kettal lisa ruumi. Samas mitte klastris olevad indeksid on 
--- salvestatud tabelist eraldi ja n�uab lisa ruumi


create table EmployeeFirstName
(
	Id int primary key,
	FirstName nvarchar(50),
	LastName nvarchar(50),
	Salary int,
	Gender nvarchar(10),
	City nvarchar(50)
)

exec sp_helpindex EmployeeFirstName

--- ei saa sisestada kahte samasuguse Id v��rtusega rida
insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(1, 'John', 'Menco', 2500, 'Male', 'London')

---
drop index EmployeeFirstName.PK__Employee__3214EC07CD193801
--- kui k�ivitad �levalpool oleva koodi, siis tuleb veateade
--- et SQL server kasutab UNIQUE indeksit j�ustamaks v��rtuste unikaalsust ja primaarv�tit
--- koodiga Unikaalseid Indekseid ei saa kustutada, aga k�sitsi saab

-- sisestame uuesti kaks koodirida andmeid
insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(1, 'John', 'Menco', 2500, 'Male', 'London')

--- unikaalset indeksid kasutatakse kindlustamaks v��rtuste unikaalsust (sh primaarv�tme oma)

-- m�lemat t��pi indeksid saavad olla unikaalsed

create unique nonclustered index UIX_Employee_Firstname_Lastname
on EmployeeFirstName(FirstName, LastName)
-- alguses annab veateate, et Mike Sandoz-st on kaks korda
-- ei saa lisada mitte-klastris olevat indeksit, kui ei ole unikaalseid andmeid
--- kustutame tabeli ja sisestame andmed uuesti

insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(2, 'John', 'Menco', 2500, 'Male', 'London')

--- lisame uue unikaalse piirnagu
alter table EmployeeFirstName
add constraint UQ_EmployeeFirstName_City
unique nonclustered(City)

--- ei luba tabelisse v��rtusega uut Londonit
insert into EmployeeFirstName values(3, 'John', 'Menco', 3500, 'Male', 'London')

-- saab vaadata indeksite nimekirja
exec sp_helpconstraint EmployeeFirstName

---
-- 1.Vaikimisi primaarv�ti loob unikaalse klastris oleva indksi, samas unikaalne piirang
-- loob unikaalse mitte-klastris oleva indeksi
-- 2. Unikaalset indeksit v�i piirangut ei saa luua olemasolevasse tabelisse, kui tabel 
-- juba sisaldab v��rtusi v�tmeveerus
-- 3. Vaikimisi korduvaid v��rtusied ei ole veerus lubatud,
-- kui peaks olema unikaalne indeks v�i piirang. Nt, kui tahad sisestada 10 rida andmeid,
-- millest 5 sisaldavad korduviad andmeid, siis k�ik 10 l�katakse tagasi. Kui soovin ainult 5
-- rea tagasi l�kkamist ja �lej��nud 5 rea sisestamist, siis selleks kasutatakse IGNORE_DUP_KEY

--koodin�ide:
create unique index IX_EmployeeFirstName
on EmployeeFirstName(City)
with ignore_dup_key

insert into EmployeeFirstName values(3, 'John', 'Menco', 3512, 'Male', 'London')
insert into EmployeeFirstName values(4, 'John', 'Menco', 3123, 'Male', 'London1')
insert into EmployeeFirstName values(4, 'John', 'Menco', 3220, 'Male', 'London1')
--- enne ignore k�sku oleks k�ik kolm rida tagasi l�katud, aga
--- n��d l�ks keskmine rida l�bi kuna linna nimi oli unikaalne

select * from EmployeeFirstName

--- view

--- view on salvestatud SQL-i p�ring. Saab k�sitleda ka virtuaalse tabelina

select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

select FirstName, Salary, Gender, DepartmentId
from Employees

-- loome view
create view vEmployeesByDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

--- view p�ringu esile kutsumine
select * from vEmployeesByDepartment

-- view ei salvesta andmeid vaikimisi
-- seda tasub v�tta, kui salvestatud virtuaalse tabelina

-- milleks vaja:
-- saab kasutada andmebaasi skeemi keerukuse lihtsutamiseks,
-- mitte IT-inimesele
-- piiratud ligip��s andmetele, ei n�e k�iki veerge

-- teeme veeru, kus n�eb ainult IT-t��tajaid
create view vITEmployeesInDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id
where Department.DepartmentName = 'IT'
-- �levalpool olevat p�ringut saab liigitada reataseme turvalisuse alla
-- tahan ainult n�idata IT osakonna t��tajaid

select * from vITEmployeesInDepartment

-- veeru taseme turvalisus
-- peale selecti m��ratled veergude n�itamise �ra
create view vEmployeesInDepartmentSalaryNoShow
as
select FirstName, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

select * from vEmployeesInDepartmentSalaryNoShow


---saab kasutada esitlemaks koondandmeid ja �ksikasjalike andmeid
-- view, mis tagastab summeeritud andmeid
create view vEmployeesCountByDepartment
as
select DepartmentName, count(Employees.Id) as TotalEmployees
from Employees
join Department
on Employees.DepartmentId = Department.Id
group by DepartmentName

select * from vEmployeesCountByDepartment

-- kui soovid vaadata view sisu
sp_helptext vEmployeesCountByDepartment
-- muuta
alter view vEmployeesCountByDepartment
-- kustutada
drop view vEmployeesCountByDepartment

--- view uuendused
-- kas l�bi view saab uuendada andmeid

--- teeme andmete uuenduse, aga enne teeme view
update vEmployeesDataExceptSalary
set [FirstName] =  'Tom' where Id = 2

create view vEmployeesDataExceptSalary
as
select Id, FirstName, Gender, DepartmentId
from Employees

---
-- kustutame ja sisestame andmeid
delete from vEmployeesDataExceptSalary where Id = 2
insert into vEmployeesDataExceptSalary (Id, Gender, DepartmentId, FirstName)
values(2, 'Female', 2, 'Pam') 


select * from Employees


--- indekseeritud view
-- MS SQL-s on indekseeritud view nime all ja 
-- Oracle-s materjaliseeritud view

create table Product
(
Id int primary key,
Name nvarchar(20),
UnitPrice int
)

insert into Product values (1, 'Books', 20)
insert into Product values (2, 'Pens', 14)
insert into Product values (3, 'Pencils', 11)
insert into Product values (4, 'Clips', 10)

create table ProductSales
(
Id int,
QuantitySold int
)

insert into ProductSales values(1, 10)
insert into ProductSales values(3, 23)
insert into ProductSales values(4, 21)
insert into ProductSales values(2, 12)
insert into ProductSales values(1, 13)
insert into ProductSales values(3, 12)
insert into ProductSales values(4, 13)
insert into ProductSales values(1, 11)
insert into ProductSales values(2, 12)
insert into ProductSales values(1, 14)

-- loome view, mis annab meile veerud TotalSales ja TotalTransaction

create view vTotalSalesByProduct
with schemabinding
as 
select Name,
sum(isnull((QuantitySold * UnitPrice), 0)) as TotalSales,
count_big(*) as TotalTransactions
from dbo.ProductSales
join dbo.Product
on dbo.Product.Id = dbo.ProductSales.Id
group by Name

--- kui soovid luua indeksi view sisse, siis peab j�rgima teatud reegleid
-- 1. view tuleb luua koos schemabinding-ga
-- 2. kui lisafunktsioon select list viitab v�ljendile ja selle tulemuseks
-- v�ib olla NULL, siis asendusv��rtus peaks olema t�psustatud. 
-- Antud juhul kasutasime ISNULL funktsiooni asendamaks NULL v��rtust
-- 3. kui GroupBy on t�psustatud, siis view select list peab
-- sisaldama COUNT_BIG(*) v�ljendit
-- 4. Baastabelis peaksid view-d olema viidatud kahesosalie nimega
-- e antud juhul dbo.Product ja dbo.ProductSales.


select * from vTotalSalesByProduct

create unique clustered index UIX_vTotalSalesByProduct_Name
on vTotalSalesByProduct(Name)
-- paneb selle view t�hestikulisse j�rjestusse

-- 6 SQL tund


--- view piirangud

create view vEmployeeDetails
@Gender nvarchar(20)
as
Select Id, FirstName, Gender, DepartmentId
from Employees
where Gender = @Gender

--- vaatesse ie saa kaasa panan parameetreid e antud juhul Gender

create function fnEmployeeDetails(@Gender nvarchar(20))
returns table
as return
(Select Id, FirstName, Gender, DepartmentId
from Employees where Gender = @Gender)

--funktsiooni esile kutsumine koos parameetriga
select * from fnEmployeeDetails('male')

--- order by kasutamine
create view vEmployeeDetailsSorted
as 
select Id, FirstName, Gender, DepartmentId
from Employees
order by Id

-- order by-d ei saa kasutada

--- temp table kasutamine

create table ##TestTempTable(Id int, FirstName nvarchar(20), Gender nvarchar(10))

insert into ##TestTempTable values(101, 'Martin', 'Male')
insert into ##TestTempTable values(102, 'Joe', 'Female')
insert into ##TestTempTable values(103, 'Pam', 'Female')
insert into ##TestTempTable values(104, 'James', 'Male')
-- sisestame andmed

create view vOnTempTable
as
select Id, FirstName, Gender
from ##TestTempTable

-- temp table-s ei saa kasutada view-d

-- Triggerid

-- DML trigger
--- kokku on kolme t��pi: DML, DDL ja LOGON

--- trigger on stored procedure eriliik, mis automaatselt k�ivitub, kui mingi tegevus 
--- peaks andmebaasis aset leidma

--- DML - data manipulation language
--- DML-i p�hilised k�sklused: insert, update ja delete

-- DML triggereid saab klasifitseerida  kahte t��pi:
-- 1. After trigger (kutsutakse ka FOR triggeriks)
-- 2. Instead of trigger (selmet trigger e selle asemel trigger)

--- after trigger k�ivitub peale s�ndmust, kui kuskil on tehtud insert, update ja delete

-- kasutame Employees tabelit


--loome uue tabeli

create table EmployeeAudit
(
Id int identity(1, 1) primary key,
AuditData nvarchar(1000)
)

-- peale iga t��taja sisestamist tahame teada saada t��taja Id-d, p�eva ning aega(millal sisestati)
-- k�ik andmed tulevad EmployeeAudit tabelisse

create trigger trEmployeeForInsert
on Employees
for insert
as begin
Declare @Id int
select @Id = Id from inserted
insert into EmployeeAudit
values ('New employee with Id = ' + CAST(@Id as nvarchar(5)) + ' is added at ' 
+ CAST(GETDATE() as nvarchar(20)))
end


select * from Employees

insert into Employees values (11, 'Male', 3000, 1, 3, 'Bob', 'Blob', 'Bomb', 'bob@bomb.com')

select * from EmployeeAudit

--- delete trigger
create trigger trEmployeeForDelete
on Employees
for delete
as begin
	declare @Id int
	select @Id = Id from deleted

	insert into EmployeeAudit
	values('An existing employee with Id =  ' + cast(@Id as nvarchar(5)) + ' is deleted at '
	+ CAST(GETDATE() as nvarchar(20)))
end

delete from Employees where Id = 11

select * from EmployeeAudit

--- update trigger

create trigger trEmployeeForUpdate
on Employees
for update
as begin
	-- muutujate deklareerimine
	declare @Id int
	declare @OldGender nvarchar(20), @NewGender nvarchar(20)
	declare @OldSalary int, @NewSalary int
	declare @OldDepartmetnId int, @NewDepartmetnId int
	declare @OldManagerId int, @NewManagerId int
	declare @OldFirstName nvarchar(20), @NewFirstName nvarchar(20)
	declare @OldMiddleName nvarchar(20), @NewMiddleName nvarchar(20)
	declare @OldLastName nvarchar(20), @NewLastName nvarchar(20)
	declare @OldEmail nvarchar(50), @NewEmail nvarchar(50)

	-- muutuja, kuhu l�heb l�pptekst
	declare @AuditString nvarchar(1000)

	-- laeb k�ik uuendatud andmed temp table alla
	select * into #TempTable
	from inserted

	-- k�ib l�bi k�ik andmed temp table-s
	while(exists(select Id from #TempTable))
	begin
		set @AuditString = ''
		-- selekteerib esimese rea andmed temp table-st
		select top 1 @Id = Id, @NewGender = Gender,
		@NewSalary = Salary, @NewDepartmetnId = DepartmentId,
		@NewManagerId = ManagerId, @NewFirstName = FirstName,
		@NewMiddleName = MiddleName, @NewLastName = LastName,
		@NewEmail = Email
		from #TempTable
		-- v�tab vanad andmed kustutatud tabelist
		select @OldGender = Gender,
		@OldSalary = Salary, @OldDepartmetnId = DepartmentId,
		@OldManagerId = ManagerId, @OldFirstName = FirstName,
		@OldMiddleName = MiddleName, @OldLastName = LastName,
		@OldEmail = Email
		from deleted where Id = @Id

		-- loob auditi stringi d�naamiliselt
		set @AuditString = 'Employee with Id = ' + CAST(@Id as nvarchar(4)) + 'changed'
		if(@OldGender <> @NewGender)
			set @AuditString = @AuditString + ' Gender from ' + @OldGender + ' to ' +
			@NewGender

		if(@OldSalary <> @NewSalary)
			set @AuditString = @AuditString + ' Salary from ' + cast(@OldSalary as nvarchar(20)) 
			+ ' to ' + cast(@NewSalary as nvarchar(10))

		if(@OldDepartmetnId <> @NewDepartmetnId)
			set @AuditString = @AuditString + ' DepartmentId from ' + cast(@OldDepartmetnId as nvarchar(20)) 
			+ ' to ' + cast(@NewDepartmetnId as nvarchar(10))

		if(@OldManagerId <> @NewManagerId)
			set @AuditString = @AuditString + ' ManagerId from ' + cast(@OldManagerId as nvarchar(20)) 
			+ ' to ' + cast(@NewManagerId as nvarchar(10))

		if(@OldFirstName <> @NewFirstName)
			set @AuditString = @AuditString + ' Firstname from ' + @OldFirstName + ' to ' +
			@NewFirstName

		if(@OldMiddleName <> @NewMiddleName)
			set @AuditString = @AuditString + ' Middlename from ' + @OldMiddleName + ' to ' +
			@NewMiddleName

		if(@OldLastName <> @NewLastName)
			set @AuditString = @AuditString + ' Lastname from ' + @OldLastName + ' to ' +
			@NewLastName

		if(@OldEmail <> @NewEmail)
			set @AuditString = @AuditString + ' Email from ' + @OldEmail + ' to ' +
			@NewEmail

		insert into dbo.EmployeeAudit values (@AuditString)
		-- kustutab temp table-st rea, et saaksime liikuda uue rea juurde
		delete from #TempTable where Id = @Id
	end
end

update Employees set FirstName = 'test123', Salary = 4000, MiddleName = 'test456'
where Id = 10

select * from Employees
select * from EmployeeAudit

--instead of trigger

create table Employee
(
Id int primary key,
Name nvarchar(30),
Gender nvarchar(10),
DepartmentId int
)

-- kellel ei ole seda tabelit, siis nemad sisestavad selle koodi
create table Department
(
Id int primary key,
DepartmentName nvarchar(20)
)

insert into Employee values(1, 'John', 'Male', 3)
insert into Employee values(2, 'Mike', 'Male', 2)
insert into Employee values(3, 'Pam', 'Female', 1)
insert into Employee values(4, 'Todd', 'Male', 4)
insert into Employee values(5, 'Sara', 'Female', 1)
insert into Employee values(6, 'Ben', 'Male', 3)

--
create view vEmployeeDetails
as
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Employee.DepartmentId = Department.Id

select * from vEmployeeDetails

insert into vEmployeeDetails values(7, 'Valarie', 'Female', 'IT')
-- tuleb veateade
-- n��d vaatame, et kuidas saab instead of triggeriga seda probleemi lahendada

create trigger tr_vEmployeeDetails_InsteadOfInsert
on vEmployeeDetails
instead of insert
as begin
	declare @DeptId int

	select @DeptId = dbo.Department.Id
	from Department
	join inserted
	on inserted.DepartmentName = Department.DepartmentName

	if(@DeptId is null)
		begin
		raiserror('Invalid department name. Statement terminated', 16, 1)
		return
	end

	insert into dbo.Employee(Id, Name, Gender, DepartmentId)
	select Id, Name, Gender, @DeptId
	from inserted
end

--- raiserror funktsioon
-- selle eesm�rk on tuua v�lja veateade, kui DepartmentName veerus ei ole v��rtust
-- ja ei klapi uue sisestatud v��rtusega. 
-- Esimene on parameeter on veateate sisu, teine on veataseme nr (nr 16 t�hendab �ldiseid vigu),
-- kolmas on olek

delete from Employee where Id = 7


update vEmployeeDetails
set Name = 'Johny', DepartmentName = 'IT'
where Id = 1 
-- ei saa uuendada andmeid kuna mitu tabelit on sellest m�jutatud


update vEmployeeDetails
set DepartmentName = 'IT'
where Id = 1 

select * from vEmployeeDetails


create trigger tr_vEmployeeDetails_InsteadOfUpdate
on vEmployeeDetails
instead of update
as begin

	if(UPDATE(Id))
	begin
		raiserror('Id cannot be changed', 16, 1)
		return
	end

	if(update(DepartmentName))
	begin
		declare @DeptId int
		select @DeptId = Department.Id
		from Department
		join inserted
		on inserted.DepartmentName = Department.DepartmentName

		if(@DeptId is null)
		begin
			raiserror('Invalid Department Name', 16, 1)
			return
		end

		update Employee set DepartmentId = @DeptId
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end

	if(UPDATE(Gender))
	begin
		update Employee set Gender = inserted.Gender
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end

	if(UPDATE(Name))
	begin
		update Employee set Name = inserted.Name
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end
end

update Employee set Name = 'John123', Gender = 'Male', DepartmentId = 3
where Id = 1

select * from vEmployeeDetails

---- harjutus 47 delete trigger
-- 7 tund SQL

create view vEmployeeCount
as
select DepartmentId, DepartmentName, count(*) as TotalEmployees
from Employee
join Department
on Employee.DepartmentId = Department.Id
group by DepartmentName, DepartmentId

select * from vEmployeeCount

--- n�itab �ra osakonnad, kus on t��tajaid 2 tk v�i rohkem
select DepartmentName, TotalEmployees from vEmployeeCount
where TotalEmployees >= 2

select DepartmentName, DepartmentId, COUNT(*) as TotalEmployees
into #TempEmployeeCount
from Employee
join Department
on Employee.DepartmentId = Department.Id
group by DepartmentName, DepartmentId

select * from #TempEmployeeCount

select DepartmentName, TotalEmployees 
from #TempEmployeeCount
where TotalEmployees >= 2


create view vEmployeeDetails
as 
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Employee.DepartmentId = Department.Id

--kustutada �ra InsteadOfDelete trigger vEmployeeDetails alt
-- kui seda triggerit ei ole, siis annab veateate
delete from vEmployeeDetails where Id = 2


create trigger trEmployeeDetails_InsteadOfDelete
on vEmployeeDetails
instead of delete
as begin
delete Employee
from Employee
join deleted
on Employee.Id = deleted.Id
end


--- harjutus 48 P�ritud tabelid ja CTE
-- CTE t�hendab common table expression

select * from Employee

insert into Employee values(1, 'John', 'Male', 3)
insert into Employee values(2, 'Mike', 'Male', 2)


--- CTE
with EmployeeCount(DepartmentName, DepartmentId, TotalEmployees)
as
	(
	select DepartmentName, DepartmentId, COUNT(*) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	group by DepartmentName, DepartmentId
	)
select DepartmentName, TotalEmployees
from EmployeeCount
where TotalEmployees >= 2
--- CTE-d v�ivad sarnaneda temp table-ga
-- sarnane p�ritud tabelile ja ei ole salvestatud objektina
-- ning kestab p�ringu ulatuses

-- p�ritud tabel
select DepartmentName, TotalEmployees
from
(
select DepartmentName, DepartmentId, COUNT(*) as TotalEmployees
from Employee
join Department
on Employee.DepartmentId = Department.Id
group by DepartmentName, DepartmentId
)
as EmployeeCount
where TotalEmployees >= 2

--- mitu CTE-d j�rjest
with EmployeeCountBy_Payroll_IT_Dept(DepartmentName, Total)
as
(
	select DepartmentName, COUNT(Employee.Id) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	where DepartmentName in('Payroll', 'IT')
	group by DepartmentName
),
-- peale koma panemist saad uue CTE juurde kirjutada
EmployeesCountBy_HR_Admin_Dept(DepartmentName, Total)
as
(
	select DepartmentName, COUNT(Employee.Id) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	group by DepartmentName
)
-- kui on kaks CTE-d, siis unioni abli �hendad p�ringu
select * from EmployeesCountBy_HR_Admin_Dept
union
select * from EmployeeCountBy_Payroll_IT_Dept

---
with EmployeeCount(DepartmentId, TotalEmployees)
as
	(
		select DepartmentId, count(*) as TotalEmployees
		from Employee
		group by DepartmentId
	)
--select 'Hello'
--- peale CTE-d peab kohe tulema k�sklus SELECT, INSERT, UPDATE v�i DELETE
--- kui proovid midagi muud, siis tuleb veateade
select DepartmentName, TotalEmployees
from Department
join EmployeeCount
on Department.Id = EmployeeCount.DepartmentId
order by TotalEmployees


--- uuendamine CTE-s

--- loome lihtsa CTE
with Employees_Name_Gender
as
(
	select Id, Name, Gender from Employee 
)
select * from Employees_Name_Gender

--- uuendame andmeid l�bi CTE
with Employees_Name_Gender
as
(
	select Id, Name, Gender from Employee 
)
update Employees_Name_Gender set Gender = 'Male' where Id = 1

select * from Employee

--- kasutame join-i CTE tegemisel
with EmployeesByDepartment
as
(
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
select * from EmployeesByDepartment

--- kasutame joini ja muudame �hes tabelis andmeid
with EmployeesByDepartment
as
(
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
update EmployeesByDepartment set Gender = 'Male' where Id = 1 

--- kasutame joini ja muudame m�lemas tabelis andmeid
with EmployeesByDepartment
as
(
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
update EmployeesByDepartment set Gender = 'Male', DepartmentName = 'IT' 
where Id = 1 
-- ei luba mitmes tabelis andmeid korraga muuta

with EmployeesByDepartment
as
(
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
update EmployeesByDepartment set DepartmentName = 'IT' 
where Id = 1 

--- kokkuv�te CTE-st
-- 1. kui CTE baseerub �hel tabelil, siis uuendus t��tab
-- 2. kui CTE baseerub mitmel tablil, siis tuleb veateade
-- 3. kui CTE baseerub mitmel tabelil ja tahame muuta ainult �hte tabelit, siis
-- uuendus saab tehtud


--- harjutus 51: korduv CTE

--- CTE, mis iseendale viitab, kutsutakse korduvaks CTE-ks
--- kui tahad andmeid n�idata hierarhiliselt

select * from Employee

-- kustutab k�ik andmed tabelis
truncate table Employee

insert into Employee values (1, 'Tom', 2)
insert into Employee values (2, 'Josh', null)
insert into Employee values (3, 'Mike', 2)
insert into Employee values (4, 'John', 3)
insert into Employee values (5, 'Pam', 1)
insert into Employee values (6, 'Mary', 3)
insert into Employee values (7, 'James', 1)
insert into Employee values (8, 'Sam', 5)
insert into Employee values (9, 'Simon', 1)

--- �ks v�imalus on teha self join
--- ja kuvada NULL veeru asemel Super Boss 
select Emp.Name as [Employee Name],
ISNULL(Manager.Name, 'Super Boss') as [Manager Name]
from dbo.Employee Emp
left join Employee Manager
on Emp.ManagerId = Manager.Id

---
with EmployeesCTE(Id, Name, ManagerId, [Level])
as
(
	select Employee.Id, Name, ManagerId, 1
	from Employee
	where ManagerId is null

	union all

	select Employee.Id, Employee.Name,
	Employee.ManagerId, EmployeesCTE.[Level] + 1
	from Employee
	join EmployeesCTE
	on Employee.ManagerId = EmployeesCTE.Id
)
select EmpCTE.Name as Employee, isnull(MgrCTE.Name, 'Super Boss') as Manager,
EmpCTE.[Level]
from EmployeesCTE EmpCTE
left join EmployeesCTE MgrCTE
on EmpCTE.ManagerId = MgrCTE.Id



--- harjutus 54: PIVOT

create table ProductSales
(
SalesAgent nvarchar(50),
SalesCountry nvarchar(50),
SalesAmount int
)

insert into ProductSales values('Tom', 'UK', 200)
insert into ProductSales values('John', 'US', 180)
insert into ProductSales values('John', 'UK', 260)
insert into ProductSales values('David', 'India', 450)
insert into ProductSales values('Tom', 'India', 350)

insert into ProductSales values('David', 'US', 200)
insert into ProductSales values('Tom', 'US', 130)
insert into ProductSales values('John', 'India', 540)
insert into ProductSales values('John', 'UK', 120)
insert into ProductSales values('David', 'UK', 220)

insert into ProductSales values('John', 'UK', 420)
insert into ProductSales values('David', 'US', 320)
insert into ProductSales values('Tom', 'US', 340)
insert into ProductSales values('Tom', 'UK', 660)
insert into ProductSales values('John', 'India', 430)

insert into ProductSales values('David', 'India', 230)
insert into ProductSales values('David', 'India', 280)
insert into ProductSales values('Tom', 'UK', 480)
insert into ProductSales values('John', 'UK', 360)
insert into ProductSales values('David', 'UK', 140)

--- 
select SalesCountry, SalesAgent, SUM(SalesAmount) as Total
from ProductSales
group by SalesCountry, SalesAgent
order by SalesCountry, SalesAgent

-- pivot n�ide

select SalesAgent, India, US, UK
from ProductSales
pivot
(
sum(SalesAmount) for SalesCountry in ([India], [US], [UK])
)
as PivotTable


--- p�ring muudab unikaalsete veergude v��rtust (India, US ja UK) SalesCountry veerus
--- omaette veergudeks koos veergude SalesAmount liitmisega. 

create table ProductSalesWithId
(
Id int primary key,
SalesAgent nvarchar(50),
SalesCountry nvarchar(50),
SalesAmount int
)

insert into ProductSalesWithId values(1, 'Tom', 'UK', 200)
insert into ProductSalesWithId values(2, 'John', 'US', 180)
insert into ProductSalesWithId values(3, 'John', 'UK', 260)
insert into ProductSalesWithId values(4, 'David', 'India', 450)
insert into ProductSalesWithId values(5, 'Tom', 'India', 350)

insert into ProductSalesWithId values(6, 'David', 'US', 200)
insert into ProductSalesWithId values(7, 'Tom', 'US', 130)
insert into ProductSalesWithId values(8, 'John', 'India', 540)
insert into ProductSalesWithId values(9, 'John', 'UK', 120)
insert into ProductSalesWithId values(10, 'David', 'UK', 220)

insert into ProductSalesWithId values(11, 'John', 'UK', 420)
insert into ProductSalesWithId values(12, 'David', 'US', 320)
insert into ProductSalesWithId values(13, 'Tom', 'US', 340)
insert into ProductSalesWithId values(14, 'Tom', 'UK', 660)
insert into ProductSalesWithId values(15, 'John', 'India', 430)

insert into ProductSalesWithId values(16, 'David', 'India', 230)
insert into ProductSalesWithId values(17, 'David', 'India', 280)
insert into ProductSalesWithId values(18, 'Tom', 'UK', 480)
insert into ProductSalesWithId values(19, 'John', 'UK', 360)
insert into ProductSalesWithId values(20, 'David', 'UK', 140)

--- 
select SalesAgent, India, US, UK
from ProductSalesWithId
pivot
(
	sum(SalesAmount) for SalesCountry in ([India], [US], [UK])
)
as PivotTable

--- p�hjuseks on Id veeru olemasolu ProductSalesWithId, mida v�etakse arvesse
--- p��ramise ja grupeerimise j�rgi
select SalesAgent, India, US, UK
from 
(
	select SalesAgent, SalesCountry, SalesAmount from ProductSalesWithId
)
as SourceTable
pivot
(
sum(SalesAmount) for SalesCountry in (India, US, UK)
)
as PivotTable

--- UNPIVOT
SELECT Id, FromAgentOrCountry, CountryOrAgent
FROM
(
    select Id, SalesAgent, SalesCountry, SalesAmount
	from ProductSalesWithId
) as SourceTable
UNPIVOT
(
   CountryOrAgent for FromAgentOrCountry in (SalesAgent, SalesCountry)
)
as PivotTable

--- 55 harjutus
--- 8 SQL tund

--- transactions

-- transaction j�lgib j�rgmisi samme:
-- 1. selle algus
-- 2. k�ivitab DB k�ske
-- 3. kontrollib vigu. Kui on viga, siis taastab algse oleku

create table MailingAddress
(
	Id int not null primary key,
	EmployeeNumber int,
	HouseNumber nvarchar(50),
	StreetAddress nvarchar(50),
	City nvarchar(10),
	PostalCode nvarchar(20)
)

insert into MailingAddress 
values(1, 101, '#10', 'King Street', 'Londoon', 'CR27DW')

create table PhysicalAddress
(
	Id int not null primary key,
	EmployeeNumber int,
	HouseNumber nvarchar(50),
	StreetAddress nvarchar(50),
	City nvarchar(10),
	PostalCode nvarchar(20)
)

insert into PhysicalAddress 
values(1, 101, '#10', 'King Street', 'Londoon', 'CR27DW')


create proc spUpdateAddress
as begin
	begin try
		begin transaction
			update MailingAddress set City = 'LONDON'
			where MailingAddress.Id = 1 and EmployeeNumber = 101

			update PhysicalAddress set City = 'LONDON'
			where PhysicalAddress.Id = 1 and EmployeeNumber = 101
		commit transaction
	end try
	begin catch
		rollback tran
	end catch
end

-- k�ivitame sp
spUpdateAddress

select * from MailingAddress
select * from PhysicalAddress

-- muudame sp nimega spUpdateAddress
alter proc spUpdateAddress
as begin
	begin try
		begin transaction
			update MailingAddress set City = 'LONDON 12'
			where MailingAddress.Id = 1 and EmployeeNumber = 101

			update PhysicalAddress set City = 'LONDON LONDON'
			where PhysicalAddress.Id = 1 and EmployeeNumber = 101
		commit transaction
	end try
	begin catch
		rollback tran
	end catch
end

-- k�ivitame sp
spUpdateAddress

select * from MailingAddress
select * from PhysicalAddress

-- kui teine uuendus ei l�he l�bi, siis esimene ei l�he ka l�bi
-- k�ik uuendused peavad l�bi minema


--- transaction ACID test

-- edukas transaction peab l�bima ACID testi:
-- A - atomic e aatomlikus
-- C - consistent e j�rjepidevus
-- I - isolated e isoleeritus
-- D - durable e vastupidav

--- Atomic - k�ik tehingud transactionis on kas edukalt t�idetud v�i need 
-- l�katakse tagasi. Nt, m�lemad k�sud peaksid alati �nnesutma. Andmebaas 
-- teeb sellisel juhul: v�tab esimese update tagasi ja veeretab selle algasendisse
-- e taastab algsed andmed

--- Consistent - k�ik transactioni puudutavad andmed j�etakse loogiliselt 
-- j�rjepidevasse olekusse. Nt, kui laos saadaval olevaid esemete hulka 
-- v�hendatakse, siis tabelis peab olema vastav kanne. Inventuur ei saa
-- lihtsalt kaduda

--- Isolated - transaction peab andmeid m�jutama, sekkumata teistesse
-- samaaegsetesse transactionitesse. See takistab andmete muutmist, mis 
-- p�hinevad sidumata tabelitel. Nt, muudatused kirjas, mis hiljem tagasi 
-- muudetakse. Enamik DB-d kasutab tehingute isoleerimise s�ilitamiseks 
-- lukustamist

--- Durable - kui muudatus on tehtud, siis see on p�siv. Kui s�steemiviga v�i
-- voolukatkestus ilmneb enne k�skude komplekti valmimist, siis t�histatkse need 
-- k�sud ja andmed taastakse algsesse olekusse. Taastamine toimub peale 
-- s�steemi taask�ivitamist.


-- subqueries
-- tabel t�hjaks
truncate table Product
truncate table ProductSales

create table Product
(
Id int identity primary key,
Name nvarchar(50),
Description nvarchar(250)
)

create table ProductSales
(
Id int primary key identity,
ProductId int foreign key references Product(Id),
UnitPrice int,
QuantitySold int
)

insert into Product values (1, 'TV', '52 inch black color LCD TV')
insert into Product values (2, 'Laptop', 'Very thin black color laptop')
insert into Product values (3, 'Desktop', 'HP high performance desktop')

insert into ProductSales values(3, 450, 5)
insert into ProductSales values(2, 250, 7)
insert into ProductSales values(3, 450, 4)
insert into ProductSales values(3, 450, 9)

select * from Product
select * from ProductSales

-- kirjutame p�ringu, mis annab infot m��mata toodetest
select Id, Name, Description
from Product
where Id not in (select distinct ProductId from ProductSales)

-- enamus juhtudel saab subqueriet asendada JOIN-ga
-- teeme sama p�ringu JOIN-ga
select Product.Id, Name, Description
from Product
left join ProductSales
on Product.Id = ProductSales.ProductId
where ProductSales.ProductId is null


-- teeme subqueri, kus kasutame select-i. Kirjutame p�ringu, kus
-- saame teada NAME ja TotalQuantity veeru andemeid

select Name,
(select sum(QuantitySold) from ProductSales where ProductId = Product.Id) as
[Total Quantity]
from Product
order by Name

-- sama tulemus JOIN-ga
select Name, SUM(QuantitySold) as TotalQuantity
from Product
left join ProductSales
on Product.Id = ProductSales.ProductId
group by Name
order by Name

--- subqueryt saab subquery sisse panna
-- subquerid on alati sulgudes ja neid nimetatakse sisemisteks p�ringuteks

---- rohkete andmetega testimise tabel

truncate table Product
truncate table ProductSales

create table Product
(
Id int identity primary key,
Name nvarchar(50),
Description nvarchar(250)
)

create table ProductSales
(
Id int primary key identity,
ProductId int foreign key references Product(Id),
UnitPrice int,
QuantitySold int
)

--- sisestame n�idisandmed Product tabelisse:
declare @Id int
set @Id = 1
while(@Id <= 300000)
begin
	insert into Product values('Product - ' + cast(@Id as nvarchar(20)),
	'Product - ' + cast(@Id as nvarchar(20)) + ' Description')

	print @Id
	set @Id = @Id + 1
end

declare @RandomProductId int
declare @RandomUnitPrice int
declare @RandomQuantitySold int

-- ProductId
declare @LowerLimitForProductId int
declare @UpperLimitForProductId int

set @LowerLimitForProductId = 1
set @UpperLimitForProductId = 100000

--UnitPrice
declare @LowerLimitForUnitPrice int
declare @UpperLimitForUnitPrice int

set @LowerLimitForUnitPrice = 1
set @UpperLimitForUnitPrice = 100

--QuantitySold
declare @LowerLimitForQuantitySold int
declare @UpperLimitForQuantitySold int

set @LowerLimitForQuantitySold = 1
set @UpperLimitForQuantitySold = 10

declare @Counter int
set @Counter = 1

while(@Counter <= 450000)
begin
	select @RandomProductId = round(((@UpperLimitForProductId -
	@LowerLimitForProductId) * RAND() + @LowerLimitForProductId), 0)

	select @RandomUnitPrice = round(((@UpperLimitForUnitPrice -
	@LowerLimitForUnitPrice) * RAND() + @LowerLimitForUnitPrice), 0)

	select @RandomQuantitySold = round(((@UpperLimitForQuantitySold -
	@LowerLimitForQuantitySold) * RAND() + @LowerLimitForQuantitySold), 0)

	insert into ProductSales
	values(@RandomProductId, @RandomUnitPrice, @RandomQuantitySold)

	print @Counter
	set @Counter = @Counter + 1
end


select * from Product
select * from ProductSales

--- v�rdleme subquerit ja JOIN-i

select Id, Name, Description
from Product
where Id in
(
select Product.Id from ProductSales
)
--- 300 000 rida 2 sekundiga

-- teeme cache puhtaks, et uut p�ringut ei oleks kuskile vahem�llu salvestatud
checkpoint;
go
dbcc DROPCLEANBUFFERS; --- puhastab p�ringu cache-i
go
dbcc FREEPROCCACHE;  -- puhastab t�itva planeeritud cache-i
go

-- teeme sama tabeli peale inner join p�ringu
select distinct Product.Id, Name, Description
from Product
inner join ProductSales
on Product.Id = ProductSales.ProductId
--- p�ring tehti 1 sekundaiga
-- teeme cache puhtaks

select Id, Name, Description
from Product
where not exists(select * from ProductSales where ProductId = Product.Id)
--- sain 201048 rida ja 1 sekundiga
-- teeme vahem�lu puhtaks

-- kasutame join-i
select Product.Id, Name, Description
from Product
left join ProductSales
on Product.Id = ProductSales.ProductId
where ProductSales.ProductId is null

---- CURSOR-d

--- realtsiooniliste DB-de halduss�steemid saavad v�ga h�sti hakkama 
--- SETS-ga. SETS lubab mitut p�ringut kombineerida �heks tulemuseks.
--- Sinna alla k�ivad UNION, INTERSECT ja EXCEPT.

update ProductSales set UnitPrice = 50 where ProductSales.ProductId = 101

--- kui on vaja rea kaupa andmeid t��delda, siis k�ige parem oleks kasutada 
--- Cursoreid. Samas on need j�udlusele halvad ja v�imalusel v�ltida. 
--- Soovitav oleks kasutada JOIN-i.

-- Cursorid jagunevad omakorda neljaks:
-- 1. Forward-Only e edasi-ainult
-- 2. Static e staatilised
-- 3. Keyset e v�tmele seadistatud
-- 4. Dynamic e d�naamiline

-- Cursori n�ide:
 if the ProductName = 'Product - 55', set UnitPrice to 55

 --------------------------
 declare @ProductId int
 -- deklareerime cursori 
 declare ProductIdCursor cursor for
 select ProductId from ProductSales
 -- open avaldusega t�idab select avaldust
 -- ja sisestab tulemuse
 open ProductIdCursor

 fetch next from ProductIdCursor into @ProductId
--- kui tulemuses on veel ridu, siis @@FETCH_STATUS on 0
 while(@@FETCH_STATUS = 0)
 begin
	declare @ProductName nvarchar(50)
	select @ProductName = Name from Product where Id = @ProductId

	if(@ProductName = 'Product - 55')
	begin
		update ProductSales set UnitPrice = 55 where ProductId = @ProductId
	end

	else if(@ProductName = 'Product - 65')
	begin
		update ProductSales set UnitPrice = 65 where ProductId = @ProductId
	end

	else if(@ProductName = 'Product - 1000')
	begin
		update ProductSales set UnitPrice = 1000 where ProductId = @ProductId
	end

	fetch next from ProductIdCursor into @ProductId
end
-- vabastab rea seadistuse e suleb cursori
close ProductIdCursor
-- vabastab ressursid, mis on seotud cursoriga
deallocate ProductIdCursor


--- vaatame, kas read on uuendatud
select Name, UnitPrice
from Product join
ProductSales on Product.Id = ProductSales.ProductId
where(Name = 'Product - 55' or Name = 'Product - 65' or Name = 'Product - 1000')


--- asendame cursorid JOIN-ga
update ProductSales
set UnitPrice = 
	case
		when Name = 'Product - 55' Then 155
		when Name = 'Product - 65' Then 165
		when Name like 'Product - 1000' Then 10001
	end
from ProductSales
join Product
on Product.Id = ProductSales.ProductId
where Name = 'Product - 55' or Name = 'Product - 65' or
Name like 'Product - 1000'

-- vaatame tulemust
select Name, UnitPrice
from Product join
ProductSales on Product.Id = ProductSales.ProductId
where(Name = 'Product - 55' or Name = 'Product - 65' or Name = 'Product - 1000')


--- harjutus 64
--- 9 SQL tund

--- tabelite info

-- nimekiri tabelitest
select * from SYSOBJECTS where xtype = 'S'

select * from sys.tables
--- nimekiri tabelitest ja view-st
select * from INFORMATION_SCHEMA.TABLES

-- kui soovid erinevaid objektit��pe vaadata, siis kasuta XTYPE s�ntaksit
select distinct XTYPE from sysobjects

-- IT - internal table
-- P - stored procedure
-- PK - primary key constraint
-- S - system table
-- SQ - service queue
-- U - user table
-- V - view


--- skriptide uuesti k�ivitamine

create table Employee
(
Id int primary key,
Name nvarchar(30),
ManagerId int
)

--- annab teada, kas selle nimega tabel on juba olemas
if not exists (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'Employee')
begin
	create table Employee
	(
	Id int primary key,
	Name nvarchar(30),
	ManagerId int
	)
		print 'Table Employee created'
	end
	else
	begin
		print 'Table Employee already exists'
end

--- saab kasutada ka sisseehitatud funktsiooni: OBJECT_ID()
if OBJECT_ID('Employee') is null
begin
	print 'Table created'
end
else
begin
	print 'Table already exists'
end

--- tahame sama nimega tabeli �ra kustutada ja siis uuesti luua
if OBJECT_ID('Employee') is not null
begin
	drop table Employee
end
create table Employee
(
Id int primary key,
Name nvarchar(30),
ManagerId int
)

alter table Employee
add Email nvarchar(50)

--- kui teha uuesti k�ivitatavaks veeru kontrollimist ja loomist
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where
COLUMN_NAME = 'Email' and TABLE_NAME = 'Employee' and TABLE_SCHEMA = 'dbo')
begin
	alter table Employee
	add Email nvarchar(50)
end
else
begin
	print 'Column already exists'
end

--- kontrollime, kas mingi nimega veerg on olemas
if COL_LENGTH('Employee', 'Email') is not null
begin
	print 'Column already exists'
end
else 
begin
	print 'Column does not exists'
end


---- MERGE
--- tutvustati aastal 2008, mis lubab teha sisestamist, uuendamist ja kustutamist
--- ei pea kasutama mitut k�sku

-- merge puhul peab alalti olema v�hemalt kaks tabelit:
-- 1. algallika tabel e source table
-- 2. sihtm�rk tabel e target table

-- �hendab sihttabeli l�htetabeliga ja kasutab m�lemas tabelis �hist veergu
-- koodin�ide:
merge [TARGET] as T
using [SOURCE] as S
	on [JOIN_CONDITIONS]
when matched then
	[UPDATE_STATMENT]
when not matched by target then
	[INSERT_STATEMENT]
when not matched by source then
	[DELETE STATEMENT]



create table StudentSource
(
Id int primary key,
Name nvarchar(20)
)
go
insert into StudentSource values(1, 'Mike')
insert into StudentSource values(2, 'Sara')
go
create table StudentTarget
(
Id int primary key,
Name nvarchar(20)
)
insert into StudentTarget values(1, 'Mike M')
insert into StudentTarget values(3, 'John')
go

-- 1. kui leitakse klappiv rida, siis StudentTarget tabel on uuendatud
-- 2. kui read on StudentSource tabelis olemas, aga neid ei ole StudentTarget-s,
-- puuduolevad read sisestatakse 
-- 3. kui read on olemas StudentTarget-s, aga mitte StudentSource-s, siis StudentTarget
-- tabelis read kustutatakse �ra
merge StudentTarget as T
using StudentSource as S
on T.Id = S.Id
when matched then
	update set T.Name = S.Name
when not matched by target then
	insert (Id, Name) values(S.Id, S.Name)
when not matched by source then
	delete;

select * from StudentTarget
select * from StudentSource

--tabelid sisust t�hjaks
truncate table StudentTarget
truncate table StudentSource

insert into StudentSource values(1, 'Mike')
insert into StudentSource values(2, 'Sara')
go
insert into StudentTarget values(1, 'Mike M')
insert into StudentTarget values(3, 'John')
go

merge StudentTarget as T
using StudentSource as S
on T.Id = S.Id
when matched then
	update set T.Name = S.Name
when not matched by target then
	insert (Id, Name) values(S.Id, S.Name);



--- transaction-d

-- mis see on?
-- on r�hm k�ske, mis muudavad DB-s salvestatuid andmeid. Tehingut k�sitletakse
-- �he t���ksusena. Kas k�ik k�sud �nnestuvad v�i mitte. Kui �ks tehing sellest eba�nnestub
-- siis k�ik juba muudetud andmed muudetakse tagasi


create table Account
(
Id int primary key,
AccountName nvarchar(25),
Balance int
)

insert into Account values(1, 'Mark', 1000)
insert into Account values(2, 'Mary', 1000)

--- transaction taga, etm�lemad uuendatavad k�sud saavad �ra tehtud

begin try
	begin transaction
		update Account set Balance = Balance - 100 where Id = 1
		update Account set Balance = Balance + 100 where Id = 2
	commit transaction
	print 'Transaction Commited'
end try
begin catch
	rollback tran
	print 'Transaction rolled back'
end catch

select * from Account

--- m�ned levinumad probleemid:
-- 1. Dirty read e must lugemine
-- 2. Lost Updates e kadunud uuendused
-- 3. Nonreapeatable reads e kordumatud lugemised
-- 4. Phantom read e fantoom lugmine

--- k�ik eelnevad probleemid lahendaks �ra, kui lubaksite igal ajal 
--- korraga �hel kasutajal �he tehingu teha. Selle tulemusel k�ik tehingud
--- satuvad j�rjekorda ja neil v�ib tekkida vajadus kaua oodata, enne
--- kui v�imalus tehingut teha saabub.

--- kui lubada samaaegselt k��ik tehingud �ra teha, siis see omakorda tekitab probleeme
--- Probleemi lahendamiseks pakub MSSQL server erinevaid tehinguisolatsiooni tasemeid,
--- et tasakaalustada samaaegsete andmete CRUD(create, read, update ja delete) probleeme:

-- 1. read uncommited e lugemine ei ole teostatud
-- 2. read commited e lugemine tehtud
-- 3. repeatable read e korduv lugemine
-- 4. snapshot e kuvat�mmis
-- 5. serializable e serialiseerimine

--- iga juhtumile tuleb l�heneda juhtumip�hiselt
-- mida v�hem valet lugemist tuleb, seda aeglasem


--- dirty read n�ide
create table Inventory
(
Id int identity primary key,
Product nvarchar(100),
ItemsInStock int
)
go
insert into Inventory values ('iPhone', 10)
select * from Inventory

-- 1. k�sklus
-- 1 transaction
begin tran
update Inventory set ItemsInStock = 9 where Id = 1
-- kliendile tuleb arve
waitfor delay '00:00:15'
--- ebapiisav saldoj��k, teeb rollback-i
rollback tran

-- 2. k�sklus
-- samal tegin uu p�ringuga akna, kus kohe peale 
-- peale esimest k�ivitan teise
--- 2  transaction
set tran isolation level read uncommitted
select * from Inventory where Id = 1

-- 3. k�sklus
--- n��d panen selle k�skluse t��le
select * from Inventory (nolock) where Id = 1

--- muutsin esimese k�suga 9 iPhone peale, aga
--- ikka on 10 tk.


--- Lost update probleem
select * from Inventory

set tran isolation level repeatable read
--- tran 1
begin tran
declare @ItemsInStock int

select @ItemsInStock = ItemsInStock
from Inventory where Id = 1

waitfor delay '00:00:10'
set @ItemsInStock = @ItemsInStock - 1

update Inventory
set ItemsInStock = @ItemsInStock where Id = 1

print @ItemsInStock
commit transaction


--- samal ajal panen teise transaction-i t��le teisest p�ringust
set tran isolation level repeatable read
begin tran
declare @ItemsInStock int

select @ItemsInStock = ItemsInStock
from Inventory where Id = 1

waitfor delay '00:00:1'
set @ItemsInStock = @ItemsInStock - 2

update Inventory
set ItemsInStock = @ItemsInStock where Id = 1

print @ItemsInStock
commit tran


--- non repeatable read n�ide

--- see juhtub, kui �ks transaction loeb samu andmeid kaks korda
--- ja teine transaction uuendab neid andmeid esimese ja 
--- ja teise k�su vahel esimese transactioni jooksutamise ajal

--- esimene tran
--set tran isolation level repeatable read
begin tran
select  ItemsInStock from Inventory where Id = 1

waitfor delay '00:00:10'

select ItemsInStock from Inventory where Id = 1
commit tran

--- panen n��d tran 2 k�ima

update Inventory set ItemsInStock = 5
where Id = 1

--- non repeatable read probleemi lahendamiseks kasutatakse tran 1 ees:
--- set tran isolation level repeatable read


---- Phantom read n�ide

create table Employee
(
Id int primary key,
Name nvarchar(25)
)

insert into Employee values(1, 'Mark')
insert into Employee values(3, 'Sara')
insert into Employee values(100, 'Mary')

--- tran 1
set tran isolation level serializable

begin tran
select * from Employee where Id between 1 and 3

waitfor delay '00:00:10'
select * from Employee where Id between 1 and 3
commit tran

--- panen kohe teise trani t��le
insert into Employee 
values(2, 'Marcus')

--- vastuseks tuleb: Mark ja Sara. Marcust ei n�ita, aga peaks

--- erinevus korduvlugemisega ja serialiseerimisega
-- korduv lugemine hoiab �ra ainult kordumatud lugemised
-- serialiseerimine hoiab �ra kordumatud lugemised ja
-- phantom read probleemid
-- isolatsioonitase tagab, et �he tehingu loetud andmed ei 
-- takistaks muid transactioneid

--- DEADLOCK

-- kui andmebaasis tekib ummikseis

create table TableA
(
Id int identity primary key,
Name nvarchar(50)
)
go
Insert into TableA values('Mark')
go
create table TableB
(
Id int identity primary key,
Name nvarchar(50)
)
go
Insert into TableB values('Mary')

--- transaction 1
-- samm nr 1
begin tran
UPDATE TableA SET Name = 'Mark Transaction 1' where Id = 1

-- samm nr 3
UPDATE TableB SET Name = 'Mary Transaction 1' where Id = 1

commit tran


-- samm nr 2
begin tran
UPDATE TableA SET Name = 'Mark Transaction 2' where Id = 1

-- samm nr 4
UPDATE TableB SET Name = 'Mary Transaction 2' where Id = 1

commit tran
truncate table TableB

--- kuidas SQL server tuvastab deadlocki
--- lukustatakse serveri l�im, mis t��tab vaikimisi iga 5 sek j�rel
--- et tuvastada ummikuid. Kui leiab deadlocki, siis langeb 
--- deadlocki intervall 5 sek-lt 100 millisekundini.

--- mis juhtub deadlocki tuvastamisel
--- tuvastamisel l�peetab DB-mootor deadlocki ja valib �he l�ime 
--- ohvriks. Seej�rel keeratakse deadlockiohvri tehing tagasi ja 
--- tagastatakse rakendusele viga 1205. Ohvri tehingtagasit�mbamine
--- vabastab k�ik selle transactioni valduses olevad lukud.
--- See v�imaldab teistel transactionitel blokeringut t�histada ja
--- edasi liikuda.

--- mis on DEADLOCK_PRIORITY
--- vaikimisi valib SQL server deadlockiohvri tehingu, mille 
--- tagasiv�tmine k�ige odava (v�tab v�hem ressurssi). Seanside 
--- prioriteeti saab muuta SET DEADLOCK_PRIORTY

--- DEADLOCK_PRIORTY
--- 1. vaikimisi on see Normali peal
--- 2. Saab seadistada LOW, NORMAL ja HIGH peale
--- 3. saab seadistada ka nr v��rtusena -10-st kuni 10-ni

--- Ohvri valimise kriteeriumid
--- 1. Kui prioriteedid on erinevad, siis k�ige madalama t�htsusega valitakse ohvriks
--- 2. Kui m�lemal sessioonil on sama prioriteet, siis valitakse ohvriks transaction,
--- mille tagasi viimine on k�ige v�hem ressurssi n�udev.
--- 3. Kui m�lemal sessioonil on sama prioriteet ja sama ressursi kulutamine,
--- siis ohver valitakse juhuslikuse alusel

truncate table TableA
truncate table TableB

insert into TableA values('Mark')
insert into TableA values('Ben')
insert into TableA values('Todd')
insert into TableA values('Pam')
insert into TableA values('Sara')

insert into TableB values('Mary')

--- tran 1
--- samm 1
begin tran
update TableA set Name = Name + 
'Transaction 1' where Id in (1, 2, 3, 4, 5)

--- samm 3
update TableB set Name = Name + 
'Transaction 1' where Id = 1
--- samm 5
commit tran

---------------
set deadlock_priority high
go
begin tran
update TableB set Name = 
Name + 'Transaction 1' where Id = 1

--- samm 4
update TableA set Name = 
Name + 'Transaction 1' where Id in (1, 2, 3, 4, 5)
--- samm 6
commit tran

truncate table TableA
truncate table TableB

---- deadlocki logimine

dbcc Traceon(1222, -1)

dbcc TraceStatus(1222, -1)

dbcc TraceOff(1222, -1)

insert into TableA values('Mark')
insert into TableB values('Mary')

create proc spTransaction1
as begin
	begin tran
	update TableA set Name = 'Mark Transaction 1' where Id = 1
	waitfor delay '00:00:05'
	update TableB set Name = 'Mary Transaction 1' where Id = 1
	commit tran
end

create proc spTransaction2
as begin
	begin tran
	update TableB set Name = 'Mark Transaction 2' where Id = 1
	waitfor delay '00:00:05'
	update TableA set Name = 'Mary Transaction 2' where Id = 1
	commit tran
end

exec spTransaction1
-- errorlogi kuvamine
execute sp_readerrorlog


--- j�tkame siin, teeme h��letuna seda tundi
-- kuidas saada koodi abil 
-- selleks on meil vaja ]iget objectId, aga hetkel ei ole

select OBJECT_NAME([objectId]) -- ei ole selle infot hetkel
from sys.partitions
where hobt_id = 72057594047430656 -- need nr tulid mul 
--- eelnevast t;;st, kui ise katsetasin, aga hetkel ei 
--- ole seda seal

---Deadlocki vea k�sitlemine try catchiga
alter proc spTransaction1
as begin
	begin tran
	begin try
		update TableA set Name = 'Mark Transaction 1' where Id = 1
		waitfor delay '00:00:05'
		update TableB set Name = 'Mary Transaction 1' where Id = 1

		commit tran
		select 'Transaction Successful'
	end try
	begin catch
		-- vaatab, kas see error  deadlocki oma
		if(ERROR_NUMBER() = 1205)
		begin
			select 'Deadlock. Transaction failed. Please retry'
		end

		rollback
	end catch
end
-- kohe alustame teise samasuguse tegemist, kas j]udsite kirjutada
-- muutke m[lemaid sp-d
alter proc spTransaction2
as begin
	begin tran
	begin try
		update TableB set Name = 'Mary Transaction 2' where Id = 1
		waitfor delay '00:00:05'
		update TableA set Name = 'Mark Transaction 2' where Id = 1

		commit tran
		select 'Transaction Successful'
	end try
	begin catch
		-- vaatab, kas see error  deadlocki oma
		if(ERROR_NUMBER() = 1205)
		begin
			select 'Deadlock. Transaction failed. Please retry'
		end

		rollback
	end catch
end
-- n[[d k'ivit
--- esimeses aknas
spTransaction1
exec spTransaction1
execute spTransaction1
-- ei ole vahet
--- teises aknas
spTransaction2


--- blokeerivate p'ringute leidmine

begin tran
update TableA set Name = 'Mark Transaction 1' 
where Id = 1

--- teise aknasse kirjutame:
select COUNT(*) from TableA
delete from TableA where Id = 1
truncate table TableA
drop table TableA



SELECT
    [s_tst].[session_id],
    [s_es].[login_name] AS [Login Name],
    DB_NAME (s_tdt.database_id) AS [Database],
    [s_tdt].[database_transaction_begin_time] AS [Begin Time],
    [s_tdt].[database_transaction_log_bytes_used] AS [Log Bytes],
    [s_tdt].[database_transaction_log_bytes_reserved] AS [Log Rsvd],
    [s_est].text AS [Last T-SQL Text],
    [s_eqp].[query_plan] AS [Last Plan]
FROM
    sys.dm_tran_database_transactions [s_tdt]
JOIN
    sys.dm_tran_session_transactions [s_tst]
ON
    [s_tst].[transaction_id] = [s_tdt].[transaction_id]
JOIN
    sys.[dm_exec_sessions] [s_es]
ON
    [s_es].[session_id] = [s_tst].[session_id]
JOIN
    sys.dm_exec_connections [s_ec]
ON
    [s_ec].[session_id] = [s_tst].[session_id]
LEFT OUTER JOIN
    sys.dm_exec_requests [s_er]
ON
    [s_er].[session_id] = [s_tst].[session_id]
CROSS APPLY
    sys.dm_exec_sql_text ([s_ec].[most_recent_sql_handle]) AS [s_est]
OUTER APPLY
    sys.dm_exec_query_plan ([s_er].[plan_handle]) AS [s_eqp]
ORDER BY
    [Begin Time] ASC;
GO