--Quizin Şərtləri...

--1. Academy databazasını yaradın - 2 bal
--2. Groups(İd,Name) ve Students(İd,Name,Surname,Groupİd) table-ları yaradın(one-to-many), təkrar qrup adı əlavə etmək olmasın - 5 bal
--3. Students table-na Grade (int) kalonunu əlavə etmək - 3 bal
--4. Groups table-na 3 data(P129,P124,P221), Students table-na 4 data əlavə edin(1 tələbə p221 qrupna, 3 tələbə p129 qrupuna aid olsun) - 5 bal
--5. P129 qrupuna aid olan tələbələrin siyahisini gosterin - 10 bal
--6. Her qrupda neçə tələbə olduğunu göstərən siyahı çıxarmaq - 15 bal
--7. View yaratmaq - tələbə adını, qrupun adını-qrup kimi , tələbə soyadını, tələbənin balını göstərməli - 20 bal
--8. Procedure yazmalı - göndərilən baldan yüksək bal alan tələbələrin siyahısını göstərməlidir - 20 bal
--9. Funksiya yazmalı - göndərilən qrup adina uyğun neçə tələbə olduğunu göstərməlidir - 20 bal
--Qeyd: faylınızı tez-tez save edin ki, sonda ağlaşma olmasın:)))
--Qeyd: 11:45 - ə  qədər commmit edin!!!

--1. Academy databazasını yaradın - 2 bal

Create database Academy

--2. Groups(İd,Name) ve Students(İd,Name,Surname,Groupİd) table-ları yaradın(one-to-many), təkrar qrup adı əlavə etmək olmasın - 5 bal

Create table Groups
(
	id int primary key identity,
	Name nvarchar(255) unique
)

Create table Students
(
	id int primary key identity,
	Name nvarchar(255),
	Surname nvarchar(255),
	GroupId int Foreign key references Groups(id)
)

--3. Students table-na Grade (int) kalonunu əlavə etmək - 3 bal

Alter Table Students
add Grade int 

--4. Groups table-na 3 data(P129,P124,P221), Students table-na 4 data əlavə edin(1 tələbə p221 qrupna, 3 tələbə p129 qrupuna aid olsun) - 5 bal

Insert into Groups
Values
('P129'),
('P124'),
('P221')

Insert into Students
Values
('Kamil' , 'Babayev' , 2 , 80),
('Vasif' , 'Aliyev' , 3 , 100),
('Alyasar' , 'Jabbarli' , 1 , 100),
('Musa' , 'Dadashow' , 1 , 100),
('Perviz' , 'Alizade' , 1 , 100)

--5. P129 qrupuna aid olan tələbələrin siyahisini gosterin - 10 bal

Select * from Students where GroupId = 1

--6. Her qrupda neçə tələbə olduğunu göstərən siyahı çıxarmaq - 15 bal

Select Groups.Name , COUNT(Students.Name) from Groups join Students on Students.GroupId = Groups.id
Group by Groups.Name

--7. View yaratmaq - tələbə adını, qrupun adını-qrup kimi , tələbə soyadını, tələbənin balını göstərməli - 20 bal

create view usv_getstudentnamesurnamegrade
as 
Select Students.Name , Groups.Name as Qrup , Students.Surname, Students.Grade from Groups join Students on Students.GroupId = Groups.id

Select * From usv_getstudentnamesurnamegrade

--8. Procedure yazmalı - göndərilən baldan yüksək bal alan tələbələrin siyahısını göstərməlidir - 20 bal

Create Procedure usp_getstudentsbygrade @grade int
as
begin
	Select * from Students Where Grade > @grade
end

exec usp_getstudentsbygrade 70

--9. Funksiya yazmalı - göndərilən qrup adina uyğun neçə tələbə olduğunu göstərməlidir - 20 bal

Create Function usf_Getstudentscountbygroupname
(@groupname nvarchar)
returns int
as
begin
	declare @studentscount int
	Select @studentscount = COUNT(Students.Name)  From Groups join Students on Students.GroupId = Groups.id
	WHERE  Groups.Name LIKE '%' + @groupname +'%'
	Group by Groups.Name
	return @studentscount
end

