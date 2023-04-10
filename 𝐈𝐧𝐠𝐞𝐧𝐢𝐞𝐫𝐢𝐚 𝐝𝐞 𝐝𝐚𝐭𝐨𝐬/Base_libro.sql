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

-- Añadir a instructores una columna llamada 'Fecha de nacimniento', ponerle a 3 instructores fechas: Enero, Febrero y Marzo, todos del año 80
alter table instructor 
add fecha_nacimiento date;

update instructor set fecha_nacimiento = '1980-01-20'
where name = 'Wu';
update instructor set fecha_nacimiento = '1980-02-12'
where name = 'El Said';
update instructor set fecha_nacimiento = '1980-03-08'
where name = 'Crick';
update instructor set fecha_nacimiento = '1819-01-06'
where name = 'Srinivasan';
update instructor set fecha_nacimiento = '1846-01-16'
where name = 'Einstein';
update instructor set fecha_nacimiento = '1860-12-07'
where name = 'Gold';
update instructor set fecha_nacimiento = '1861-03-08'
where name = 'Katz';
update instructor set fecha_nacimiento = '1871-08-02'
where name = 'Califieri';
update instructor set fecha_nacimiento = '1882-02-02'
where name = 'Singh';
update instructor set fecha_nacimiento = '1920-01-02'
where name = 'Brandt';
update instructor set fecha_nacimiento = '1935-01-10'
where name = 'Kim';
update instructor set fecha_nacimiento = '1958-04-30'
where name = 'Mozart';

select * from instructor
where fecha_nacimiento between '1980-01-01' and '1980-02-28'

-- consultar nombre del instructor, departamento, dia, mes, año 
select name, dept_name,
extract(year from fecha_nacimiento) as año_nacimiento, extract(month from fecha_nacimiento) as mes_nacimiento, extract(day from fecha_nacimiento) as dia_nacimiento
from instructor

-- modificar la tabla de instructores para que tenga por defecto en el salario el valor de 10000
alter table instructor
alter column salary set default 10000;

insert into instructor values(10205, 'Juan', 'Comp.Sci.')
insert into instructor values(10300, 'Maria', 'Finance')

select *
from instructor

delete from instructor where name = 'Juan'
delete from instructor where name = 'Maria'

-- Insertar imagenes a una tupla
alter table student
add foto bytea;

update student
set foto = bytea('C:/Users/Laboratorios EICT/Desktop/Daniel Fonseca/gato.jpg')
where id = '12345'

insert into student
values('14528', 'Luis Romero', 'Physics', 23, bytea('C:/Users/Laboratorios EICT/Desktop/Daniel Fonseca/perro.jpg'))


select *
from student

-- Crear el tipo de dato salario_anual de tipo numerico(12, 2) que sea mayor que 19000. Modificar la tabla instructor con el nuevo tipo de dato
create domain salario_anual numeric(12, 2)
constraint prueba_salario check(value >= 19000.00);

alter table instructor
alter column salary set data type salario_anual;

select * from instructor

insert into instructor values(12121, 'Wuu', 'Finance', 10000);  --Prueba del contraint

-- Cambiar el dato a presupuesto en tabla departamento
create domain nuevo_presupuesto numeric(15, 2)
constraint prueba_presupuesto check(value >= 50000.00);

alter table department
alter column budget set data type nuevo_presupuesto;

select * from department

-- Crea rel tipo de dato nombre_persona de tipo varchar(40) no nulo y usar el tipo de dato en la columna name de la tabla instructor
create domain nombre_persona varchar(40) not null

alter table instructor
alter column name set data type nombre_persona;

select * from instructor

create type cities_list as enum('Ney York', 'Miami', 'Houston') /* --> esto permite que para este tipo de dato solo se puedan agregar los elementos de la lista,
															           es decir, para la columna "city" solo se pueden agregar las ciudades New Yor, Miami y  Houston*/			
-- Agregar una columna a una tabla.

alter table instructor
add column city cities_list;

-- Autorizaciòn, se utiliza para asignar roles con privilegios o permisos a los usuarios.
-- Pasos para crear roles con privilegios:
/*
1. Crear una base de datos con su respectivo Query tool.
2. Desde la base de datos y el servidor de postgres, crear los nuevos roles y password y asignar los privilegios o servicios de cada rol.
3. Con click derecho desde el servidor de postgres, desconectar el servidor.
4. Desde la opción servers presionar click derecho 
5. Llenar los siguientes datos
	- name: 'Nombre del servidor'
	- Click en la pestaña 'Conexion'
	- Escribir en el nombre del host 'localhost'
	- Confirmar que el puerto sea 5432
	- Colocar la base de datos deseada
	- Escribir el nombre del rol que se creo
	- Colocar el password creado
*/
create role auxxiliar with login password '123*';
grant select on instructor to auxxiliar

/* Estructura de una funcion
create function nombreFuncion(p1)
returns tipo retorno
as $$
declare
	variable tipo;
	variable2 tipo,
begin
	sentencias;
	return retorno;
end;
$$ language plpgsql;
*/

-- Hacer una funcion que reciba por parametro el codigo del estudiante y consulte su nombre
create function estudiante_por_codigo(codest varchar(5))
returns varchar(20)
as $$
declare
	nombre varchar(20);
begin
	nombre=
		(select s.name
		from student as s
		where s.id = codest);
	return nombre;
end;
$$ language plpgsql;

select estudiante_por_codigo('45678'); -- Prueba de la funcion
drop function estudiante_por_codigo(codest varchar(5))-- Borrar la funcion

-- Hacer una funcion que reciba por parametro el nombre del departamento y consulte su presupuesto
create function presupuesto_por_departamento(deptname varchar(20))
returns numeric(12,2)
as $$
declare
	presupuesto numeric(12,2);
begin
	presupuesto=
		(select d.budget
		from department as d
		where d.dept_name = deptname);
	return presupuesto;
end;
$$ language plpgsql;

select presupuesto_por_departamento('Biology'); -- Prueba de la funcion
drop function  presupuesto_por_departamento(dept_name varchar(20))-- Borrar la funcion

/* Hacer una funcion que reciba por parametro el nombre del departamento y
genere la suma de los salarios de los instructores */
create function sum_salarios(deptname varchar(20))
returns float
as $$
declare
	sum_salarios float;
begin
	sum_salarios=
		(select sum(i.salary)
		from instructor as i 
		where i.dept_name = deptname
		);
	return sum_salarios;
end;
$$ language plpgsql;

select sum_salarios('History'); --Probar la funcion
drop function  sum_salarios(deptname varchar(20)); --Borrar la funcion

/* Hacer una funcion que reciba por parametro el nombre del departamento y
muestre el numero de instructores por departamento */
create function num_instructores(deptname varchar(20))
returns integer
as $$
declare
	num_inst integer;
begin
	select count(*) into num_inst
	from instructor as i 
	where i.dept_name = deptname;
	return num_inst;
end;
$$ language plpgsql;

select num_instructores('History'); -- Probar la fucion
drop function  num_instructores(deptname varchar(20)); -- Borrar la funcion

/* Hacer una funcion que reciba por parametro el nombre del departamento 
y consulte el nombre del instructor y su salario */

-- Replace: para no tener que borrar todo, sino actualizarla
create or replace function buscar_salarios(dp_name varchar) 
	returns table(nom_ins varchar, sal_ins numeric(8,2)) as $$
	begin
		return query select name, salary from instructor where dept_name = dp_name;
	end;
	$$ language plpgsql;
	
select * from buscar_salarios('History');

/* Crear una funcion que reciba por parametro el nombre del departamento y el salario de los instructores. 
Mostar el nombre del instructor, nombre del departamento y salario. Mostrar los salarios superiores al valor especificado en el parametro */
create or replace function info_instructores(dp_name varchar, salario float) 
	returns table(nom_ins varchar, nom_dept varchar, sal_ins numeric(8,2)) as $$
	begin
		return query select name, dept_name, salary from instructor where dept_name = dp_name and salary > salario;
	end;
	$$ language plpgsql;
	
select * from info_instructores('History', 60000); --Probar la funcion

/* Crear una funcion que reciba por parametro el semestre en el cual los estudiantes tomaron cursos. 
Consultar el id, nombre del estudiante y nombre del departamento de la tabla estudiantes. */
create or replace function info_estudiantes(sem varchar) 
	returns table(idest varchar, nombre varchar, deptname varchar) as $$
	begin
		return query select distinct e.ID, e.name, e.dept_name from student as e, takes as t where e.ID = t.ID and t.semester = sem;
	end;
	$$ language plpgsql;
	
select * from info_estudiantes('Fall'); --Probar la funcion

-- FUNCIONES

/*Crear una función que reciba por parámetro el nombre del estudiante. 
Consultar el id y nombre del estudiante que no ha tomado cursos.*/
create or replace function est_no_cursos(nombre varchar) 
	returns table(idest varchar, nombre_ varchar) as $$
	begin
		return query select e.ID, e.name
					from student as e 
					where e.name = nombre and e.ID not in(select ID
														  from takes);
	end;
	$$ language plpgsql;

select * from est_no_cursos('Zhang'); --Probar la funcion

/*Crear una función que reciba por parámetro el presupuesto del departamento. 
Consultar el nombre del departamento y presupuesto considerando los presupuestos
superiores al ingresado por parámetro.*/
create or replace function presupuesto_superior(bud float) 
	returns table(deptname varchar, budget_ numeric(12,2)) as $$
	begin
		return query select d.dept_name, d.budget
					from department as d
					where d.budget > bud;
	end;
	$$ language plpgsql;

select * from presupuesto_superior(70000); --Probar la funcion

/*Crear un role o usuario denominado asistente que tenga permiso de ingreso con la 
clave 'asistente123#' 
y que pueda agregar datos, consultar y modificar los datos de la tabla cursos.
Insertar 2 tuplas nuevas.
Consultar el titulo de los cursos que tienen 4 créditos.
Modificar los cursos con 4 créditos a 5 créditos.*/

create role asistente with login password 'asistente123#';
grant select, insert, update on course to asistente;

insert into course values('CS-120', 'Ing. de datos', 'Comp. Sci.', 2);
insert into course values('CS-320', 'Algebral Lineal', 'Comp. Sci.', 3);

select title
from course
where credits = 5;

update course
set credits = 5
where credits = 4

/*Crear un role o usuario denominado monitor que tenga permiso de ingreso con la 
clave 'monitor1*' y que pueda consultar y eliminar los datos de 
las tablas cursos y departamento.
Consultar el titulo del curso y nombre del departamento de los cursos cuyo 
Id inicia con la letra C.
Revocar los permisos de las tablas cursos y departamentos.*/

create role monitor with login password 'monitor1';
grant select, delete course, department to monitor;

select title, dept_name
from course
where course_id like 'C%'

revoke select, delete on course, department from monitor;

/*Ejercicio 1
Crear un trigger llamado actualizar_instructor que permita 
aumentar el salario de los instructores en un 20%.  
Registrar en una tabla nueva llamada registro_instructor, 
el nombre del instructor, el salario actual, 
la fecha de modificación y el nuevo salario.*/

/* Paso 1. Crear la tabla registro instructor */ 
create table registro_instructor(
	name varchar(20) not null,
	salary numeric(8,2),
	fecha_modificacion date,
	salario_nuevo numeric (8,2)
);

-- Paso 2. Consultar las tablas instructor y registro_instructor
select * from instructor;
select * from registro_instructor;

-- Paso 3. Crear la funcion actualizar salario
create or replace function actualizar_salario() returns trigger as $insertar$
declare
begin
	insert into registro_instructor values(old.name, old.salary, current_date, new.salary);
	return null;
end;
$insertar$ language plpgsql;

-- Paso 4. Crear el trigger 
create trigger actualizar_instructor after update
on instructor for each row
execute procedure actualizar_salario();


-- Paso 5.probar el trigger 
update instructor set salary=salary*1.10
where id='12121';

select *
from registro_instructor

/* Crear un trigger que permita registrar de la tabla estudiantes el id, nombre del estudiante,
nombre del departamento y total creditos, cuando se elimine, actualice e inserte en la misma tabla,
con el proposito de conservar los valores antiguos (old) y mostrar los valores nuevos (new).*/

-- Paso 1. Consultar la tabla student
select *
from student;

insert into student values('12349', 'Cruz', 'Comp. Sci.', 19);

-- Paso 2. Crear una tabla llamada registro_estudiantes que tenga las mismas columnas de student
create table registro_estudiantes(
ID varchar(5),
name varchar(20) not null,
dept_name varchar(20),
tot_cred numeric(3,0)                                                                                                                                                                                
);

-- Paso 3. Crear la funcion del trigger
create or replace function ejercicio1_trigger() returns trigger as $ejercicio1$
declare
begin
insert into registro_estudiantes values(old.id, old.name, old.dept_name, old.tot_cred);
return null;
end;
$ejercicio1$ language plpgsql;

create or replace function ejercicio1_trigger_insertar() returns trigger as $ejercicio1_insert$
declare
begin
insert into registro_estudiantes values(new.id, new.name, new.dept_name, new.tot_cred);
return null;
end;
$ejercicio1_insert$ language plpgsql;

-- Paso 4. Crear el trigger
create trigger borrar_estudiantes after delete
on student for each row
execute procedure ejercicio1_trigger();

create trigger actualizar_estudiantes after update
on student for each row
execute procedure ejercicio1_trigger();

create trigger insertar_estudiantes after insert
on student for each row
execute procedure ejercicio1_trigger_insertar();

drop trigger borrar_estudiantes on student;
drop trigger actualizar_estudiantes on student;
drop trigger insertar_estudiantes on student;

-- Paso 5. Generar las consultas delete, update e insert para probar el trigger
-- Probar delete
delete from student
where id = '19981'

-- Probar update
update student set tot_cred = tot_cred+20
where id = '19991'

-- Probar insert
insert into student values('19981', 'Brandt', 'History', 81);

select *
from student

select *
from registro_estudiantes;

create table movimiento (
    idmovimiento serial primary key,
	fecha timestamp not null,
	codigoproducto int not null,
	tipomovimiento varchar(1) not null, 
	cantidad int not null,
	valor int not null
);

create table saldos(
idsaldo serial primary key,
codigoproducto int not null,
fecha timestamp not null,
nuevosaldo int not null
);

create or replace function actualizar_saldo() returns trigger as $body$
declare ultimosaldo int = 0;
declare registros int = 0;

begin 
	select count(1) into registros from saldos where codigoproducto = new.codigoproducto;
	if registros>0 then
		select nuevosaldo into ultimosaldo from saldos where id_saldo = (select max(id_saldo) from saldos where codigoproducto = new.codigoproducto);
	end if;
	if new.tipomovimiento = 'E' then
		ultimosaldo = ultimosaldo + new.cantidad;
	else
		ultimosaldo = ultimosaldo - new.cantidad;
	end if;
	insert into saldos (codigoproducto, fecha, nuevosaldo) values(new.codigoproducto, current_timestamp, ultimosaldo);
return new;
end $body$ language 'plpgsql'

create trigger actualizar_valores before insert
on movimiento for each row
execute procedure actualizar_saldo();

insert into movimiento(fecha, codigoproducto, tipomovimiento, cantidad, valor) values (current_timestamp, 6, 'S', 2, 1000);
insert into movimiento(fecha, codigoproducto, tipomovimiento, cantidad, valor) values ('2022/08/13', 50, 'E', 2, 1000);
insert into movimiento(fecha, codigoproducto, tipomovimiento, cantidad, valor) values ('2022/08/14', 50, 'E', 2, 2000);
insert into movimiento(fecha, codigoproducto, tipomovimiento, cantidad, valor) values ('2022/08/14', 50, 'S', 5, 2000);

select *
from movimiento

select *
from saldos

--
create table autor
(id integer,
nombre character varying (30) not null,
fecha_nacimiento date not null,
genero char(2) not null,
primary key(id) 
);

insert into autor (id, nombre,fecha_nacimiento,genero)
	values (1, 'Gabriel Garcia Marquez', '6/3/1973','M'),
		   (2,  'Franz Kafka', '3/7/1983','M'),
		   (3, 'Jorge Luis Borges','24/8/1982','M'),
		   (4, 'Isabel Allende', '5/4/1980','F'),
		   (5, 'Rosa Montero','9/10/1970','F'),
		   (6, 'Ana Milena Robles','3/7/1990','NB'),
		   (7, 'Andres Diaz','5/1/1992','NB');

alter table autor
add column edad integer;

create table info_autor(
nombre varchar (30) not null,
	fecha_nacimiento date not null,
	edad integer
);

select *
from autor, info_autor;

create or replace function actualizar_autor() returns trigger as $insertar$
declare
begin
	insert into info_autor values(OLD.nombre, OLD.fecha_nacimiento, NEW.edad);
	return null;
end;
$insertar$ language plpgsql;

create trigger crear_edad after update
on autor for each row
execute procedure actualizar_autor();

drop trigger crear_edad on autor
delete from info_autor

update autor set edad = (current_date-fecha_nacimiento)/365
where id = 2

select *
from autor;

select *
from info_autor;

/*Crear un trigger que se dispare cuando se incremente en 50% el numero total de
creditos de los estudiantes. 
Registrar los datos necesarios del nombre del estudiante, el departamento 
y los creditos actualizados.*/

create table info_student(
ID varchar(5),
name varchar(20) not null,
dept_name varchar(20),
tot_cred numeric(3,0)
);

select *
from student

create or replace function aumentar_50_creditos() returns trigger as $body$
declare
begin
	if new.tot_cred = old.tot_cred*1.50 then 
		insert into info_student values(old.ID, old.name, old.dept_name, new.tot_cred);
	end if;
return null;
end;
$body$ language plpgsql;

create trigger aumentar_creditos before update
on student for each row
execute procedure aumentar_50_creditos();

drop trigger aumentar_creditos on student
delete from info_student

update student
set tot_cred = tot_cred*1.50
where id = '00128'

select *
from info_student;

select *
from student;

/*Crear un trigger que se dispare cuando se elimine una tupla de la tabla cursos
Registrar todas las columnas de la tabla cursos en una nueva tabla, sin modificar la tabla cursos*/

create table info_course(
course_id varchar(7),
title varchar(50),
dept_name varchar(20),
credits numeric(2,0)
);

insert into course values('BIO-999', 'Intro. to Anatomy', 'Biology', 3);

create or replace function borrar_curso()
returns trigger as $borrar_curso_$
declare
begin
	insert into info_course values(old.course_id, old.title, old.dept_name, old.credits);
	return null;
end;
$borrar_curso_$ language plpgsql;

create trigger borrar_curso_ before delete
on course for each row
execute procedure borrar_curso();

delete trigger borrar_curso on course;
delete from info_course;

delete from course
where (course_id, title, dept_name, credits) = ('BIO-999', 'Intro. to Anatomy', 'Biology', 3);

select *
from info_course

select *
from course

-- RECURSIVIDAD
-- Consultas recursivas
create table universidad(
programa_id serial primary key,
programa varchar not null,
facultad_id int
);

insert into universidad(programa_id, programa, facultad_id)
values
(1, 'Vicerrectoria', null),
(2, 'Facultad de Ingenieria', 1),
(3, 'Facultad de Medicina', 1),
(4, 'Facultad de Humanidades', 1),
(5, 'Facultad de Ciencias', 1),
(6, 'Ing. Sistemas', 2),
(7, 'Ing. Industrial', 2),
(8, 'Ing. Civil', 2),
(9, 'Ing. Electronica', 2),
(10, 'Medicina', 3),
(11, 'Enfermeria', 3),
(12, 'Medicina Veterinaria', 3),
(13, 'Fisioterapia', 3),
(14, 'Filosofia', 4),
(15, 'Educacion', 4),
(16, 'Fisica', 5),
(17, 'Quimica', 5),
(18, 'Biologia', 5),
(19, 'Matematicas', 5),
(20, 'Estadistica', 5);

select * from universidad;

with recursive jerarquia as(
select programa_id, programa, facultad_id from universidad
where programa_id = 3
union
select u.programa_id, u.programa, u.facultad_id from universidad u
inner join jerarquia j on j.programa_id = u.facultad_id)
select * from jerarquia;

-- Antepasados
create table miembro
	(id integer,
	 nombre character varying(50) not null,	
	 primary key(id)
	);

create table antepasado
	(id_miembro integer,
	 id_miembro1 integer,	
	 foreign key (id_miembro) references miembro,
	 foreign key (id_miembro1) references miembro
	);



INSERT INTO miembro VALUES(10000,'SIN FAMILIA');
INSERT INTO miembro VALUES(10111,'José Fernando Contreras Arias');
INSERT INTO miembro VALUES(10112,'Lorena Villegas Martínez');
INSERT INTO miembro VALUES(10113,'Jorge Andrés Avendaño Linares');
INSERT INTO miembro VALUES(10114,'Juan Carlos López Méndez');
INSERT INTO miembro VALUES(10115,'Sofia Penagos Alvarez');
INSERT INTO miembro VALUES(10116,'Sergio Andres Toledo');
INSERT INTO miembro VALUES(10117,'Ana Suárez Gómez');
INSERT INTO miembro VALUES(10118,'Lorena Paez Velandia');
INSERT INTO miembro VALUES(10119,'Ana Maria Fuentes Rojas');
INSERT INTO miembro VALUES(10120,'Carlos Alberto Gomez Franco');
INSERT INTO miembro VALUES(10121,'Lina Ballesteros Hoyos');
INSERT INTO miembro VALUES(10122,'Angelica Diaz Lopez');
INSERT INTO miembro VALUES(10123,'Juan Camilo Zarate Robledo');
INSERT INTO miembro VALUES(10124,'Carolina Manrique Lara');
INSERT INTO miembro VALUES(10125,'Jesus Andres Arbelaez Torres');
INSERT INTO miembro VALUES(10128,'Edith Zambrazo Orjuela');
INSERT INTO miembro VALUES(10129,'Adriana Marcela Jimenez Fuentes');
INSERT INTO miembro VALUES(10130,'Luz Linares Orjuela');
INSERT INTO miembro VALUES(10131,'Luis Martinez Rodriguez');
INSERT INTO miembro VALUES(10132,'Milena Romero Alvarez');
INSERT INTO miembro VALUES(10133,'Lina Marcela Jimenez Rios');
INSERT INTO miembro VALUES(10134,'Ana Maria Jimenez Diaz');
INSERT INTO miembro VALUES(10135,'Oscar Mauricio Avila Villa');
INSERT INTO miembro VALUES(10136,'Diana Jaramillo Velez');
INSERT INTO miembro VALUES(10137,'Camilo Andres Robledo');


INSERT INTO antepasado VALUES(10111,10113);
INSERT INTO antepasado VALUES(10111,10112);
INSERT INTO antepasado VALUES(10112,10000);-- Sin Antepasado
INSERT INTO antepasado VALUES(10113,10115);
INSERT INTO antepasado VALUES(10114,10115);
INSERT INTO antepasado VALUES(10114,10112);
INSERT INTO antepasado VALUES(10115,10112);
INSERT INTO antepasado VALUES(10116,10117);
INSERT INTO antepasado VALUES(10117,10119);
INSERT INTO antepasado VALUES(10118,10117);
INSERT INTO antepasado VALUES(10118,10119);
INSERT INTO antepasado VALUES(10119,10000);--Sin Antepasado
INSERT INTO antepasado VALUES(10120,10117);
INSERT INTO antepasado VALUES(10120,10119);
INSERT INTO antepasado VALUES(10121,10000);--Sin Antepasado
INSERT INTO antepasado VALUES(10122,10123);
INSERT INTO antepasado VALUES(10123,10125);
INSERT INTO antepasado VALUES(10124,10121);
INSERT INTO antepasado VALUES(10124,10123);
INSERT INTO antepasado VALUES(10125,10121);
INSERT INTO antepasado VALUES(10128,10130);
INSERT INTO antepasado VALUES(10129,10128);
INSERT INTO antepasado VALUES(10130,10000);--Sin Antepasado
INSERT INTO antepasado VALUES(10131,10129);
INSERT INTO antepasado VALUES(10131,10130);
INSERT INTO antepasado VALUES(10132,10129);
INSERT INTO antepasado VALUES(10132,10130);
INSERT INTO antepasado VALUES(10133,10134);
INSERT INTO antepasado VALUES(10133,10137);
INSERT INTO antepasado VALUES(10134,10135);
INSERT INTO antepasado VALUES(10135,10137);
INSERT INTO antepasado VALUES(10136,10134);
INSERT INTO antepasado VALUES(10136,10137);
INSERT INTO antepasado VALUES(10137,10000);--Sin Antepasado


-- obtener los descendientes de Lina Ballesteros
with recursive miembros_descendientes AS(
select id_miembro, id_miembro1
from antepasado
where id_miembro1 in(
		select id
		from miembro
		where nombre = 'Lina Ballesteros Hoyos')
UNION
	select a.id_miembro, a.id_miembro1
	from antepasado as a
	inner join miembros_descendientes as d on d.id_miembro = a.id_miembro1
) 
select *
from miembros_descendientes;

-- Obtener los antepasados de Jose Fernando Contreras Arias
with recursive miembros_ascendientes AS(
select id_miembro, id_miembro1
from antepasado
where id_miembro in(
		select id
		from miembro
		where nombre = 'José Fernando Contreras Arias')
UNION
	select a.id_miembro, a.id_miembro1
	from antepasado as a
	inner join miembros_ascendientes as d on d.id_miembro1 = a.id_miembro
)
select *
from miembros_ascendientes;

-- Obtener los antepasados y descendientes de Adriana Marcela Jimenez Fuentes
with recursive antes_y_despues as (
select * from antepasado
where id_miembro in(select id from miembro where nombre = 'Adriana Marcela Jimenez Fuentes') 
	or
	  id_miembro1 in(select id from miembro where nombre = 'Adriana Marcela Jimenez Fuentes')
union
select a.* 
from antepasado as a
inner join antes_y_despues as ad 
on ad.id_miembro1 = a.id_miembro or ad.id_miembro = a.id_miembro1)
select * from antes_y_despues;

--
create table territorio(
id integer,
nombre varchar(20) not null,
primary key(id)
);

create table region(
id_region_1 integer,
id_region_2 integer,
foreign key (id_region_1) references territorio,
foreign key (id_region_2) references territorio
);

INSERT INTO territorio VALUES(11,'Europa');
INSERT INTO territorio VALUES(12,'America');
INSERT INTO territorio VALUES(13,'Asia');
INSERT INTO territorio VALUES(14,'Africa');
INSERT INTO territorio VALUES(15,'Colombia');
INSERT INTO territorio VALUES(16,'Bogota');
INSERT INTO territorio VALUES(17,'Paris');
INSERT INTO territorio VALUES(18,'Francia');
INSERT INTO territorio VALUES(19,'Rio de Janeiro');
INSERT INTO territorio VALUES(20,'Marruecos');
INSERT INTO territorio VALUES(21,'Medellin');
INSERT INTO territorio VALUES(22,'China');
INSERT INTO territorio VALUES(23,'Shanghai');
INSERT INTO territorio VALUES(24,'Brasil');
INSERT INTO territorio VALUES(25,'Kenia');
INSERT INTO territorio VALUES(26,'Pekin');
INSERT INTO territorio VALUES(27,'Mombasa');
INSERT INTO territorio VALUES(28,'Estados Unidos');
INSERT INTO territorio VALUES(29,'Rabat');
INSERT INTO territorio VALUES(30,'Miami');

INSERT INTO region VALUES(11,10);
INSERT INTO region VALUES(12,10);
INSERT INTO region VALUES(13,10);
INSERT INTO region VALUES(14,10);
INSERT INTO region VALUES(15,12);
INSERT INTO region VALUES(16,15);
INSERT INTO region VALUES(17,18);
INSERT INTO region VALUES(18,11);
INSERT INTO region VALUES(19,24);
INSERT INTO region VALUES(24,12);
INSERT INTO region VALUES(20,14);
INSERT INTO region VALUES(21,15);
INSERT INTO region VALUES(22,13);
INSERT INTO region VALUES(23,22);
INSERT INTO region VALUES(25,14);
INSERT INTO region VALUES(26,22);
INSERT INTO region VALUES(27,25);
INSERT INTO region VALUES(28,12);
INSERT INTO region VALUES(29,20);
INSERT INTO region VALUES(30,28);

/*1. Obtener los elementos del territorio del cual depende Colombia*/
with recursive colombia_relacion AS(
select id_region_1, id_region_2
from region
where id_region_1 in (select id
					  from territorio
					  where nombre = 'Colombia')
	or id_region_1 in 
UNION	
	select reg.id_region_1, reg.id_region_2
	from region as reg
	inner join colombia_relacion as col 
	on col.id_region_2 = reg.id_region_1 
)
select *
from colombia_relacion;

/*2. Obtener los elementos que corresponden al Continente Americano*/
with recursive america_relacion AS(
select id_region_1, id_region_2
from region
where id_region_1 in (select id
					  from territorio
					  where nombre = 'America')
	or id_region_2 in (select id
					  from territorio
					  where nombre = 'America')
UNION	
	select reg.id_region_1, reg.id_region_2
	from region as reg
	inner join america_relacion as ame
	on ame.id_region_2 = reg.id_region_1 or ame.id_region_1 = reg.id_region_2
)
select *
from america_relacion;

/*3. Obtener los elementos que corresponden a Bogota*/
with recursive bogota_relacion AS(
select id_region_1, id_region_2
from region
where id_region_1 in (select id
					  from territorio
					  where nombre = 'Bogota')
UNION	
	select reg.id_region_1, reg.id_region_2
	from region as reg
	inner join bogota_relacion as col 
	on col.id_region_2 = reg.id_region_1 
)
select *
from bogota_relacion;

--?
create table grade_points(
   grade varchar(2) primary key,
   points numeric(2,1)
);

insert into grade_points values('A+',4.2);
insert into grade_points values('A',4.0);
insert into grade_points values('A-',3.7);
insert into grade_points values('B+',3.3);
insert into grade_points values('B',3.0);
insert into grade_points values('B-',2.7);
insert into grade_points values('C+',2.3);
insert into grade_points values('C',2.0);
insert into grade_points values('C-',1.7);
insert into grade_points values('F',0.0);

select *
from grade_points;

create view student_grades(ID, GPA) as
   select ID, credit_points/case credit_sum when 0 then null else credit_sum end 
     from(select ID,
		  sum(case grade when NULL then 0 else credits end) as credit_sum,
		  sum(case grade when NULL then 0 else credits*points end) as credit_points
		  from(takes natural join course) natural left outer join grade_points
		  group by ID)
		  as credit_student(ID, credit_sum)
		 
	union
	  select ID, NULL
	  from student
	  where ID not in (select ID from takes)
	  
	  
select *
from student_grades;

select *
from takes;

select ID, rank() over (order by (GPA) desc) as s_rank
from student_grades;

select ID, (1+(select count(*)
			  from student_grades B
			  where B.GPA>A.GPA)) as s_rank
from student_grades A
order by s_rank;

create view dept_grades(ID, dept_name, GPA) as
	select ID, dept_name, credit_points / case credit_sum when 0 then null else credit_sum end
	from (select ID, dept_name,
		   sum(case grade when NULL then 0 else credits end) as credit_sum,
		   sum(case grade when NULL then 0 else credits*points end) as credit_points
		   from(takes natural join course) natural left outer join grade_points
		   group by ID,dept_name) 
		   as credit_student(ID, dept_name, credit_sum)
	union
	select ID, dept_name, NULL
	from student
	where ID not in (select ID from takes)

select *
from dept_grades

--Ejercicio 3
select ID, dept_name,
  rank() over(partition by dept_name order by GPA desc) as dept_rank
  from dept_grades
  order by dept_name, dept_rank;

-- CLAUSULAS DE AGRUPACION

create table Empleados(
	id integer,
	primer_nombre character varying (50) not null,
	primer_apellido character varying (50) not null,
	genero char(1) not null,
	email character varying (50) not null,
	salario integer,
	cod_depto integer,
	primary key(id)
);
	
	
INSERT INTO Empleados VALUES(10,'Diana','Linares','F','diana_linares@gmail.com',2000000,2);
INSERT INTO Empleados VALUES(11,'Andres','Marin','M','andres_marin@gmail.com',5000000,2);
INSERT INTO Empleados VALUES(12,'Jose','Perez','M','jose_perez@gmail.com',3000000,1);
INSERT INTO Empleados VALUES(13,'Sandra','Mendieta','F','sandra_mendieta@gmail.com',4000000,1);
INSERT INTO Empleados VALUES(14,'Diego','Hernandez','M','diego_hernandez@gmail.com',2000000,1);
INSERT INTO Empleados VALUES(15,'Laura','Moreno','F','laura_moreno@gmail.com',3000000,2);
INSERT INTO Empleados VALUES(16,'Maria','Alvarez','F','maria_alvarez@gmail.com',6000000,1);
INSERT INTO Empleados VALUES(17,'Ana','Robledo','F','ana_robledo@gmail.com',2000000,1);
INSERT INTO Empleados VALUES(18,'Pedro','Mendez','M','pedro_mendez@gmail.com',5000000,2);	

--Grouping sets
select cod_depto, genero, sum(salario)
from empleados
group by 
   grouping sets(
   (cod_depto, genero),
	   (cod_depto),
	   (genero),
	   ()
   );

--Clausula cube
select cod_depto, sum(salario)
from empleados
group by CUBE(cod_depto)
order by cod_depto;

select cod_depto, sum(salario)
from empleados
group by CUBE(cod_depto, genero)
order by cod_depto, genero;

--Rollup
select cod_depto, genero, sum(salario)
from empleados
group by ROLLUP(cod_depto, genero)
order by cod_depto, genero;

-- EJERCICIO
CREATE TABLE sales(
item_name varchar(10) NOT NULL,
color varchar(10),
clothes_size varchar(10),
quantity integer,
primary key(item_name , color , clothes_size ),
CHECK(
	item_name IN ('skirt', 'dress', 'shirt', 'pants')
),
CHECK(
	color IN ('dark', 'pastel', 'white')
),
CHECK(
	clothes_size IN ('small', 'medium', 'large')
)
);

insert into sales values ('skirt', 'dark', 'small', 2);
insert into sales values ('skirt', 'dark', 'medium', 5);
insert into sales values ('skirt', 'dark', 'large' ,1);
insert into sales values ('skirt', 'pastel', 'small', 11);
insert into sales values ('skirt', 'pastel', 'medium', 9);						  
insert into sales values ('skirt', 'pastel', 'large', 15);						  
insert into sales values ('skirt', 'white', 'small', 2);
insert into sales values ('skirt', 'white', 'medium', 5);	
insert into sales values ('skirt', 'white', 'large', 3);
insert into sales values ('dress', 'dark', 'small', 2);
insert into sales values ('dress', 'dark', 'medium', 6);
insert into sales values ('dress', 'dark', 'large', 12);
insert into sales values ('dress', 'pastel', 'small', 4);
insert into sales values ('dress', 'pastel', 'medium', 3);
insert into sales values ('dress', 'pastel', 'large', 3);						  
insert into sales values ('dress', 'white', 'small', 2);
insert into sales values ('dress', 'white', 'medium', 3);						  
insert into sales values ('dress', 'white', 'large', 0);					  
insert into sales values ('shirt', 'dark', 'small', 2);					  
insert into sales values ('shirt', 'dark', 'medium', 6);
insert into sales values ('shirt', 'dark', 'large', 6);					  
insert into sales values ('shirt', 'pastel', 'small', 4);
insert into sales values ('shirt', 'pastel', 'medium', 1);						  
insert into sales values ('shirt', 'pastel', 'large', 2);						  
insert into sales values ('shirt', 'white', 'small', 17);						  
insert into sales values ('shirt', 'white', 'medium', 1);
insert into sales values ('shirt', 'white', 'large', 10);					  
insert into sales values ('pants', 'dark', 'small', 14);				  
insert into sales values ('pants', 'dark', 'medium', 6);					  
insert into sales values ('pants', 'dark', 'large', 0);				  
insert into sales values ('pants', 'pastel', 'small', 1);						  
insert into sales values ('pants', 'pastel', 'medium', 0);						  
insert into sales values ('pants', 'pastel', 'large', 1);					  
insert into sales values ('pants', 'white', 'small', 3);					  
insert into sales values ('pants', 'white', 'medium', 0);						  
insert into sales values ('pants', 'white', 'large', 2);

-- Consultar la suma de cantidades con base en las columnas item_name, color, clothes_size
select item_name, color, clothes_size, sum(quantity)
from sales
group by grouping sets(
(item_name, color, clothes_size),
(item_name),
(color),
(clothes_size),
()
);

order by item_name, color, clothes_size;

select item_name, color, clothes_size, sum(quantity)
from sales
group by cube(item_name, color, clothes_size)
order by item_name, color, clothes_size;

select item_name, color, clothes_size, sum(quantity)
from sales
group by rollup(item_name, color, clothes_size)
order by item_name, color, clothes_size;
