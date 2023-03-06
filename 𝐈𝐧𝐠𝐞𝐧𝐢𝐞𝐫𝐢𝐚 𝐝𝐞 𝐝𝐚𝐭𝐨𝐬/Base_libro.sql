#Se crean las tablas#
create table department(
dept_name varchar(20),
building varchar(15),
budget numeric(12,2),
primary key(dept_name));

create table course(
course_id varchar(7),
title varchar(50),
dept_name varchar(20),
credits numeric(2,0),
primary key(course_id),
foreign key(dept_name) references department(dept_name)
);

create table instructor(
ID varchar(5),
name varchar(20) not null,
dept_name varchar(20),
salary numeric(8,2),
primary key(ID),
foreign key(dept_name) references department(dept_name)
);

create table section(
course_id varchar(8),
sec_id varchar(8),
semester varchar(6),
year numeric(4,0),
building varchar(15),
room_number varchar(7),
time_slot_id varchar(4),
primary key (course_id, sec_id, semester, year),
foreign key (course_id) references course(course_id)
);

create table teaches(
ID varchar(5),
course_id varchar(8),
sec_id varchar(8),
semester varchar(6),
year numeric(4,0),
foreign key(ID) references instructor(ID),
foreign key(course_id, sec_id, semester, year) references section(course_id, sec_id, semester, year),
primary key(ID, course_id, sec_id, semester, year)
);

create table student(
ID varchar(5),
name varchar(20) not null,
dept_name varchar(20),
tot_cred numeric(3,0),
primary key (ID),
foreign key (dept_name) references department
);

create table takes(
ID varchar(5),
course_id varchar(8),
sec_id varchar(8),
semester varchar(6),
year numeric(4,0),
grade varchar(2),
primary key (ID, course_id, sec_id, semester, year),
foreign key (course_id, sec_id, semester, year) references section,
foreign key (ID) references student
);

#Se prueba el select#
select *
from department;

select *
from course;

select *
from instructor;

select *
from section;

select *
from teaches;

#insertar elementos#
insert into department values ('Biology', 'Watson', 90000);
insert into department values ('Comp. Sci.', 'Taylor', 100000);
insert into department values ('Elec. Eng.', 'Taylor', 85000);
insert into department values ('Finance', 'Painter', 120000);
insert into department values ('History', 'Painter', 50000);
insert into department values ('Music', 'Packard', 80000);
insert into department values ('Physics', 'Watson', 70000);

insert into course (course_id, title, dept_name, credits)
	values('BIO-101', 'Intro. to Biology', 'Biology', 4),
		('BIO-301', 'Genetics', 'Biology', 4),
		('BIO-399', 'Computational Biology', 'Biology', 3),
		('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', 4),
		('CS-190', 'Game Design', 'Comp. Sci.', 4),
		('CS-315', 'Robotics', 'Comp. Sci.', 3),
		('CS-319', 'Image Processing', 'Comp. Sci.', 3),
		('CS-347', 'Database System Concepts', 'Comp. Sci.', 3),
		('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', 3),
		('FIN-201', 'Investment Banking', 'Finance', 3),
		('HIS-351', 'World History', 'History', 3),
		('MU-199', 'Music Video Production', 'Music', 3),
		('PHY-101', 'Physical Principles', 'Physics', 4);

insert into instructor (ID, name, dept_name, salary)
	values(10101, 'Srinivasan', 'Comp. Sci.', 65000),
		(12121, 'Wu', 'Finance', 90000),
		(15151, 'Mozart', 'Music', 40000),
		(22222, 'Einstein', 'Physics', 95000),
		(32343, 'El Said', 'History', 60000),
		(33456, 'Gold', 'Physics', 87000),
		(45565, 'Katz', 'Comp. Sci.', 75000),
		(58583, 'Califieri', 'History', 62000),
		(76543, 'Singh', 'Finance', 80000),
		(76766, 'Crick', 'Biology', 72000),
		(83821, 'Brandt', 'Comp. Sci.', 92000),
		(98345, 'Kim', 'Elec. Eng.', 80000);
		
insert into section (course_id, sec_id, semester, year, building, room_number, time_slot_id)
	values('BIO-101', 1, 'Summer', 2009, 'Painter', '514', 'B'),
		('BIO-301', '1', 'Summer', 2010, 'Painter', '514', 'A'),
		('CS-101', '1', 'Fall', 2009, 'Packard', '101', 'H'),
		('CS-101', '1', 'Spring', 2010, 'Packard', '101', 'F'),
		('CS-190', '1', 'Spring', 2009, 'Taylor', '3128', 'E'),
		('CS-190', '2', 'Spring', 2009, 'Taylor', '3128', 'A'),
		('CS-315', '1', 'Spring', 2010, 'Watson', '120', 'D'),
		('CS-319', '1', 'Spring', 2010, 'Watson', '100', 'B'),
		('CS-319', '2', 'Spring', 2010, 'Taylor', '3128', 'C'),
		('CS-347', '1', 'Fall', 2009, 'Taylor', '3128', 'A'),
		('EE-181', '1', 'Spring', 2009, 'Taylor', '3128', 'C'),
		('FIN-201', '1', 'Spring', 2010, 'Packard', '101', 'B'),
		('HIS-351', '1', 'Spring', 2010, 'Painter', '514', 'C'),
		('MU-199', '1', 'Spring', 2010, 'Packard', '101', 'D'),
		('PHY-101', '1', 'Fall', 2009, 'Watson', '100', 'A');
		
insert into teaches (ID, course_id, sec_id, semester, year)
	values('10101', 'CS-101', '1', 'Fall', 2009),
		('10101', 'CS-315', '1', 'Spring', 2010),
		('10101', 'CS-347', '1', 'Fall', 2009),
		('12121', 'FIN-201', '1', 'Spring', 2010),
		('15151', 'MU-199', '1', 'Spring', 2010),
		('22222', 'PHY-101', '1', 'Fall', 2009),
		('32343', 'HIS-351', '1', 'Spring', 2010),
		('45565', 'CS-101', '1', 'Spring', 2010),
		('45565', 'CS-319', '1', 'Spring', 2010),
		('76766', 'BIO-101', '1', 'Summer', 2009),
		('76766', 'BIO-301', '1', 'Summer', 2010),
		('83821', 'CS-190', '1', 'Spring', 2009),
		('83821', 'CS-190', '2', 'Spring', 2009),
		('83821', 'CS-319', '2', 'Spring', 2010),
		('98345', 'EE-181', '1', 'Spring', 2009);

insert into student (ID, name, dept_name, tot_cred)
	values('00128', 'Zhang', 'Comp. Sci.', 102),
		('12345', 'Shankar', 'Comp. Sci.', 32),
		('19991', 'Brandt', 'History', 80),
		('23121', 'Chavez', 'Finance', 110),
		('44553', 'Peltier', 'Physics', 56),
		('45678', 'Levy', 'Physics', 46),
		('54321', 'Williams', 'Comp. Sci.', 54),
		('55739', 'Sanchez', 'Music', 38),
		('70557', 'Snow', 'Physics', 0),
		('76543', 'Brown', 'Comp. Sci.', 58),
		('76653', 'Aoi', 'Elec. Eng.', 60),
		('98765', 'Bourikas', 'Elec. Eng.', 98),
		('98988', 'Tanaka', 'Biology', 120);

insert into takes (ID, course_id, sec_id, semester, year, grade) values
			('00128', 'CS-101', '1', 'Fall', 2009, 'A'),
			('00128', 'CS-347', '1', 'Fall', 2009 ,'A'),
			('12345', 'CS-101', '1', 'Fall', 2009, 'C'),
			('12345', 'CS-190', '2', 'Spring', 2009, 'A'),
			('12345', 'CS-315', '1', 'Spring', 2010, 'A'),
			('12345', 'CS-347', '1', 'Fall', 2009, 'A'),
			('19991', 'HIS-351', '1', 'Spring', 2010, 'B'),
			('23121', 'FIN-201', '1', 'Spring', 2010, 'C+'),
			('44553', 'PHY-101', '1', 'Fall', 2009, 'B'), 
			('45678', 'CS-101', '1', 'Fall', 2009, 'F'), 
			('45678', 'CS-101', '1', 'Spring', 2010, 'B+'),
			('45678', 'CS-319', '1', 'Spring', 2010, 'B'),
			('54321', 'CS-101', '1', 'Fall', 2009, 'A'),
			('54321', 'CS-190', '2', 'Spring', 2009 ,'B+'),
			('55739', 'MU-199', '1', 'Spring', 2010, 'A'),
			('76543', 'CS-101', '1', 'Fall', 2009, 'A'), 
			('76543', 'CS-319', '2', 'Spring', 2010, 'A'), 
			('76653', 'EE-181', '1', 'Spring', 2009, 'C'),
			('98765', 'CS-101', '1', 'Fall', 2009, 'C'),
			('98765', 'CS-315', '1', 'Spring', 2010, 'B'),
			('98988', 'BIO-101', '1', 'Summer', 2009 ,'A'), 
			('98988', 'BIO-301', '1', 'Summer', 2010, null);
			
#Borrar items#
delete from department where (dept_name, building, budget) = ('Elec. Eng.', 'Taylor', 85000);
delete from course;

#select#
select name 
from instructor;

select distinct dept_name
from instructor;

select ID, name, dept_name, salary*1.5  #Cambia el valor del atributo per solo visualmente#
from instructor;

select name
from instructor
where dept_name = 'Comp. Sci.' and salary > 70000;

select i.name, d.dept_name, d.budget
from instructor as i, department as d;

select name, instructor.dept_name, building
from instructor, department
where instructor.dept_name = department.dept_name;

select name, course_id
from instructor, teaches
where instructor.ID = teaches.ID;

select dept_name, building, budget
from department
where building like 'W%';

#consultar el nombre del instructor, el nombre del curso, el nombre del semestre y el año cuando se oriento el curso#
select i.name, i.dept_name, c.title, t.semester, t.year
from instructor as i, course as c, teaches as t
where i.ID = t.ID and c.course_id = t.course_id;

#update#
update instructor
set salary = salary*1.05;
select *
from instructor;

#Actualizar el presupuesto incrementando en un 10% los valores del dept de musica y de biologia#
update department
set budget = budget*1.1
where dept_name = 'Biology' or dept_name = 'Music';
select *
from department;

#crear una columna nueva llamada prueba con el tipo de dato varchar de 20 caracteres en la tabla de instructores. Llenar el valor Hola a la tupla del instructor#
alter table instructor add prueba varchar(20);

update instructor
set prueba = 'Hola'
where name = 'Einstein';

select *
from instructor;

alter table instructor drop prueba;   #Borramos la columna#

#1) Crear una nueva columna llamada fecha_contratacion en la tabla instructor.#
alter table instructor add fecha_contratacion date;
select * 
from instructor;

#2) Crear una nueva columna llamada hora_ingreso en la tabla instructor.#
alter table instructor add hora_ingreso time;
select * 
from instructor;

#3) Llenar en las nuevas columnas datos para los instructores: Gold, Mozart y Kim.#
update instructor
	set fecha_contratacion = '11/5/2022', hora_ingreso = '12:00'
 	where instructor.name = 'Gold' or instructor.name = 'Mozart' or instructor.name = 'Kim';
select * 
from instructor;

#4) Tomando como referencia las tablas curso y departamento, consultar las columnas: codigo del curso, titulo, creditos y edificio donde se orientan los cursos.#
select c.course_id, c.title, c.credits, d.building
from course as c, department as d
where d.dept_name = c.dept_name ;

#Ordenar info#
select name
	from instructor
	where dept_name = 'Physics'
	order by name;
	
select name, salary
	from instructor
	order by salary desc, name asc; #Le da priorida al salario#

#Operaciones entre conjuntos#
#si se coloca la palabra all muestra las tuplas repetidas#

#Union#
(select course_id
	from section
	where semester = 'Fall' and year = 2009)
union
(select course_id
	from section
	where semester = 'Spring' and year = 2010);

/*ESTOS OPERADORES NO ESTAN EN MYSQL, PERO SIRVE SI SE EJECUTAN

#Interseccion#
(select course_id
	from section
	where semester = 'Fall' and year = 2009)
intersect
(select course_id
	from section
	where semester = 'Spring' and year = 2010);

#Except#
(select course_id
	from section
	where semester = 'Fall' and year = 2009)
except
(select course_id
	from section
	where semester = 'Spring' and year = 2010);
*/

select name
from instructor
where salary is null;

#Consultar nombre del instructor y nombre del departamento de los instructores que no tienen hora de ingreso#
select i.name, i.dept_name 
from instructor as i
where hora_ingreso is null;

#Promedio de presupuesto del edificio watson#
select avg(budget) from department
where building = 'Watson';

#Consultar que edificio de departamento tiene el mismo presupuesto que el promedio de todos los presupuestos de departamento 
select building, budget from department
where budget = (select avg(budget) as promedio_presupuesto from department);

#Consultar el máximo, minimo, promedio y suma de salarios de los instructores
select max(salary), min(salary), avg(salary), sum(salary) from instructor;

#Consultar el máximo, minimo, promedio y suma de salarios de los instructores del departamento de fisica#
select max(salary), min(salary), avg(salary), sum(salary) from instructor
where dept_name = 'Physics';

#Consultar la suma del presupuesto del edificio Taylor, renombrar la columna con el nombre suma presupuesto
select sum(budget) as suma_presupuesto
from department
where building = 'Taylor';

#Consulta el nombre del departamento y el salario promedio de los profesores que pertenecen a cierto departamento. 
select dept_name, avg(salary) as salario_promedio 
from instructor
group by dept_name;

#Consultar el nombre del edificio y la suma de presupuestos de los departamentos que pertenecen a cierto edificio. 
select building, sum(budget) as presupuesto_promedio
from department
group by building;

#Consultar el nombre del departamento y la suma de creditos de los cursos que pertenecen a cierto departamento. 
select dept_name, sum(credits) as creditos_promedio
from course
group by dept_name;

#Consultar el semestre y la cantidad de cursos tomados en dicho semestre, agrupar por semestre. 
select semester, count(course_id) as cursos_tomados
from section
group by semester;

#Consultar el año y la cantidad de cursos tomados en dicho año, agrupar por año. 
select year, count(course_id) as cursos_tomados
from section
group by year;

#Consultar el ID del profesor y la cantidad de cursos orientados por el profesor, agrupar por ID. 
select ID, count(course_id) as cursos_orientados
from teaches
group by ID;

#Consultar el nombre del departamento y el salario promedio de los profesores de dicho departamento, solo mostar resultados mayores a 42000 
select dept_name, avg(salary) as avg_salary
from instructor
group by dept_name
having avg(salary) > 42000;

#Consultar el nombre del departamento y el promedio de los creditos de los cursos de dicho departamento, solo mostar resultados mayores a 3
select dept_name, avg(credits) as avg_credits
from course
group by dept_name
having avg(credits) > 3.0;

--Subconsultas
select name, salary
from instructor
where salary<(select salary from instructor where name = 'Califieri');

-- Clausula in
select distinct course_id
from section
where semester = 'Fall' and year = 2009 and
course_id in (select course_id from section where semester = 'Spring' and year = 2010);

-- Clausula some
select name, salary, dept_name
from instructor 
where salary > some
				(select salary from instructor  where dept_name = 'Biology');

-- Clausula all
select d.dept_name, d.budget
from department as d
where d.budget > all(select d.budget from department as d where d.building = 'Taylor');

-- Clausula exist
select course_id
from section as S
where semester = 'Fall' and year = 2009 and exists(select * 
												   from section as T
												   where semester = 'Spring' and year = 2010 and S.course_id = T.course_id);
												   
--Los instructores que no han dictado clases
select *
from instructor as i
where not exists(select i.ID from teaches as t where i.ID = t.ID)

--Consultar todos los cursos dictados en los que haya un instructor del departamento de fisica.
select *
from teaches as t
where t.ID in (select i.ID from instructor as i where i.dept_name = 'Physics');

--Consultar el nombre de los instructores que dictaron cursos.
select i.name
from instructor as i
where exists(select i.ID from teaches as t where i.ID = t.ID)

--Consultar id, nombre y departamento de los estudiantes que tomaron cursos en otoño.
select s.ID, s.name, s.dept_name
from student as s
where s.ID in (select t.ID from takes as t where t.semester = 'Fall')

--Consultar la suma de los creditos por departamento.
select dept_name, sum(tot_cred) as cred_por_dept
from student
group by dept_name

--Consultar el departamento y el total de creditos matriculados por los estudiantes donde la suma de creditos es mayor a 200
select dept_name, sum(tot_cred)
from student
group by dept_name
having sum(tot_cred) > 200

--
select dept_name, sum_cred 
from (select dept_name, sum(tot_cred) from student group by dept_name)
as sum_cred(dept_name, sum_cred)
where sum_cred > 100;

select distinct s.ID, s.name
from student as s
where not exists((select course_id from course where dept_name = 'Biology')
				 except
				 (select t.course_id from takes as t where s.ID = t.ID))
			
-- Subconsulta en from
select dept_name, avg_salary
from(select dept_name, avg(salary) from instructor group by dept_name) as dept_avg(dept_name, avg_salary) 
where avg_salary > 42000

select building, sum_budget
from (select building, sum(budget) from department group by building) as dep_sum(building, sum_budget)
where sum_budget >150000

select semester, cant
from (select semester, count(course_id) from section group by semester) as cant_courses(semester, cant)
where cant > 8

select min(sum_bud) as min_budget
from (select dept_name, sum(budget) from department group by dept_name) as sum_budget(dept_name, sum_bud)


-- Borrar datos con condiciones
delete from teaches
where course_id in (select course_id from course
				   where course_id = 'CS-101')

-- Pasar datos a otra tabla
create table department_copy(
dept_name varchar(20),
building varchar(15),
budget numeric(12,2),
primary key(dept_name));

insert into department_copy select* from department_copy

-- Actualizar informaciòn con subconsulta
update instructor
set salary = salary * 1.05
where salary < (select avg(salary) from instructor)

-- Eliminar las tuplas de los cursos orientados en el año 2009 y en primavera
delete from teaches
where course_id in (select course_id from teaches where year = 2009 and semester = 'Spring')

-- Actualizar los presupuestos de los departamentos cuyo edificio es Taylor
update department
set budget = budget * 2
where building in (select building from department where building = 'Taylor')

-- Join
select * 
from student
join takes 
on student.ID = takes.ID;

select * 
from student as s, takes as t
where s.ID = t.ID;

select student.ID as ID, name, dept_name, tot_cred, course_id, sec_id, semester, year, grade
from student join takes on student.ID = takes.ID;

-- Consultar los estudiantes que no tomaron cursos
select *
from student left join takes
on student.ID  = takes.ID
where takes.ID is null;

-- Consultar los intructores que no enseñaron cursos
select *
from instructor left join teaches
on instructor.ID = teaches.ID
where teaches.ID is null;

-- Consultar todas las clases tomadas y no tomadas por los estudiantes
select *
from takes
natural right outer join student;

-- Consultar todos los cursos dictados y no dictados
select *
from teaches
natural right outer join instructor
where teaches is not null;

select *
from teaches
natural right outer join instructor
where teaches is null;

-- Todos los profesores que dieron cursos
select *
from instructor
natural right outer join teaches;


-- Consultar los estudiantes que tomaron cursos
select *
from student
natural join takes

-- Consultar todos los datos de la tabla curso registrados o tomados por los estudiantes en primavera
select *
from student
natural join takes
where semester = 'Spring';

select *
from student
natural join takes
where semester != 'Spring';

-- Cursos dictados en primavera
select *
from course
natural join takes
where semester = 'Spring';

-- view

create view faculty as
select ID, name, dept_name
from instructor;

select * from faculty

-- elaborar una view llamada instructores_CS-190
create view instructores_CS_190 as
select distinct instructor.* from instructor natural join teaches
where instructor.id = teaches.id and course_id = 'CS-190';

-- elaborar una view llamada estudientes_A
create view estudientes_A as
select student.*, course_id from student natural join takes
where takes.grade = 'A';

-- crear view de cursos de fisica de otoño del 2009
create view physics_fall_2009 as
select course.course_id, sec_id, building, room_number
from course natural join section
where course.dept_name = 'Physics' and section.semester = 'Fall' and year = '2009'

-- insertar en facultad
insert into faculty values ('30765', 'Green', 'Music');

-- Transacciones
-- Begin: Iniciacilizar la transacción
begin
insert into instructor(id, name, dept_name, salary) values(3333, 'Jorge Ramirez', 'Music', 100000);
-- Rollback: Dentro de una transacciòn, rechazar el efecto
rollback
-- Commit: Dentro de una transacciòn, aceptar el efecto
commit

update instructor set salary = salary*1.10

delete from instructor 
where name = 'Jorge Ramirez';

-- Ejercicio 1
begin
update department set budget = budget *1.20
where dept_name = 'Comp. Sci';

commit

select *
from department

-- Ejercicio  2
begin
update department set building = 'Beethoven'
where dept_name ='Music'

select *
from department

rollback

'constraint unica'
alter table instructor
add mail  varchar(20) unique;

update instructor set mail = 'einstein@gmail.com'
where name = 'Einstein'

update instructor set mail = 'einstein@gmail.com'
where name = 'Wu'

select *
from instructor

'Clausula check'
alter table instructor
add constraint min_salary
check(
	salary > 0
);

update instructor set salary = -1
where dept_name = 'History'

-- Modificar la tabla de cursos para que el numero de creditos sea mayor a cero
alter table course
add constraint min_cred
check(
	credits > 0
)
-- añadir una nueva columna en la tabla cursos llamada area que sea unica
alter table course
add area varchar(20) unique;

update course set area = 'Math'
where dept_name = 'Comp. Sci.'

update course set area = 'Natural Science'
where dept_name = 'Biology'
select *
from course
