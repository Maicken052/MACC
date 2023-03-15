create table actor(
id integer,
nombre varchar(30) not null,
genero varchar(10),
fecha_nacimiento date,
primary key(id)
);

create table productor(
codigo integer,
nombre varchar(30) not null,
primary key(codigo)
);

create table pelicula(
codigo integer,
titulo varchar(30) not null,
estudio varchar(30),
año integer,
duracion integer,
genero varchar(30),
presupuesto numeric(10,2),
primary key(codigo)
);

create table protagonizar(
codigo_pelicula integer,
id_actor integer,
foreign key(id_actor) references actor(id),
foreign key(codigo_pelicula) references pelicula(codigo),
primary key(codigo_pelicula, id_actor)
);

create table producir(
codigo_pelicula integer,
codigo_productor integer,
foreign key(codigo_productor) references productor(codigo),
foreign key(codigo_pelicula) references pelicula(codigo),
primary key(codigo_pelicula, codigo_productor)
);

create table trailer(
codigo integer,
duracion integer,
codigo_pelicula integer,
foreign key(codigo_pelicula) references pelicula(codigo),
primary key(codigo, codigo_pelicula)
);

insert into pelicula(codigo, titulo, estudio, año, duracion, genero, presupuesto) values
	(10001, 'Fight Club', '20th Century Fox', 1999, 139, 'Drama', 63000000),
	(10002, 'The Shining', 'Elstree Studios', 1980, 146, 'Terror', 19000000),
	(10003, 'Avengers: Infinity War', 'Marvel Studios', 2018, 149, 'Superhéroes', 300000000),
	(10004, 'Mindsommar', 'A24', 2019, 147, 'Terror', 9000000),
	(10005, 'Interstellar', 'Paramount Pictures', 2014, 169, 'Ciencia ficción', 165000000);

insert into actor(id, nombre, genero, fecha_nacimiento) values
	(100011, 'Edward Norton', 'M', '1969/08/18'),
	(100012, 'Brad Pitt', 'M', '1963/12/18'),
	(100021, 'Jack Nicholson', 'M', '1937/04/22'),
	(100022, 'Shelley Duvall', 'F', '1949/07/07'),
	(100031, 'Robert Downey Jr', 'M', '1965/04/04'),
	(100032, 'Scarlett Johansson', 'F', '1984/11/22'),
	(100041, 'Florence Pugh', 'F', '1996/01/03'),
	(100042, 'Will Poulter', 'M', '1993/01/28'),
	(100051, 'Matthew McConaughey', 'M', '1969/11/04'),
	(100052, 'Anne Hathaway', 'F', '1982/11/12');
			
insert into protagonizar(codigo_pelicula, id_actor) values
	(10001, 100011),
    (10001, 100012),
    (10002, 100021),
    (10002, 100022),
    (10003, 100031),
    (10003, 100032),
    (10004, 100041),
    (10004, 100042),
    (10005, 100051),
    (10005, 100052);
    
insert into trailer(codigo, duracion, codigo_pelicula) values
	(1010, 2.27, 10001),
    (1020, 0.55, 10002), 
    (1030, 2.24, 10003),
    (1031, 2.25, 10003),
    (1040, 2.39, 10004), 
    (1050, 1.39, 10005), 
    (1051, 2.20, 10005), 
    (1052, 2.26, 10005), 
    (1053, 2.19, 10005);
    
insert into productor(codigo, nombre) values
	(10, 'Ross Grayson Bell'),
    (11, 'Ceán Chaffin'),
    (12, 'Art Linson'),
    (20, 'Stanley Kubrick'),
    (30, 'Kevin Feige'),
    (40, 'Lars Knudsen'),
    (41, 'Patrik Andersson'),
    (50, 'Christopher Nolan'),
    (51, 'Emma Thomas'),
    (52, 'Lynda Obst');
    
insert into producir(codigo_pelicula, codigo_productor) values
	(10001, 10),
    (10001, 11),
    (10001, 12),
    (10002, 20),
    (10003, 30),
    (10004, 40),
    (10004, 41),
    (10005, 50),
    (10005, 51),
    (10005, 52);
    
-- Obtener las peliculas cuyo presupuesto sea inferior a X = 50000000
select *
from pelicula
where presupuesto < 50000000;

-- Obtener el titulo, año, duracion y género de las películas grabadas en el estudio X = Marvel Studios
select titulo, año, duracion, genero
from pelicula
where estudio = 'Marvel Studios';

-- Obtener los trailer de las películas del año X = 1980
select pelicula.titulo, trailer.codigo, trailer.duracion
from trailer, pelicula
where trailer.codigo_pelicula = pelicula.codigo and pelicula.año = 1980;

-- Obtener el código y el título de las películas producidas por el productor X = 'Christopher Nolan' como por el productor Y = 'Kevin Feige'.
select p.codigo, p.titulo, prtor.nombre
from pelicula as p, producir as prir, productor as  prtor
where prtor.codigo = prir.codigo_productor and prir.codigo_pelicula = p.codigo and (prtor.nombre = 'Kevin Feige' or prtor.nombre = 'Christopher Nolan');

-- Obtener los datos de las películas protagonizadas por el actor X = 'Brad Pitt'.
select p.*
from pelicula as p, actor as a, protagonizar as pro
where a.id = pro.id_actor and pro.codigo_pelicula = p.codigo and a.nombre = 'Brad Pitt';

-- Obtener todos los datos de las películas, ordenados de manera descendente por la duración
select *
from pelicula
order by duracion desc;

-- Consultar los datos de los actores cuyo nombre empieza por la letra X = 'R'
select *
from actor
where nombre like 'R%';

-- Obtener todos los datos de las películas y los nombres de sus respectivos protagonistas
select p.*, a.nombre
from pelicula as p, actor as a, protagonizar as pro
where a.id = pro.id_actor and pro.codigo_pelicula = p.codigo;

-- Obtener los datos de las películas grabadas en el estudio X = 'A24', así como también del estudio Y = '20th Century Fox'
select *
from pelicula 
where estudio = 'A24' or estudio = '20th Century Fox';

-- Obtener el número de películas cuyo género es Y = 'Terror'
select genero, count(codigo) as num_de_peliculas
from pelicula
where genero = 'Terror';

-- Calcular el número de películas por productor y ordenar por el nombre del productor
select pr.nombre, count(p.codigo) as num_de_p_por_productor
from pelicula as p, productor as pr, producir as pir
where pr.codigo = pir.codigo_productor and pir.codigo_pelicula = p.codigo
group by pr.nombre
order by pr.nombre;

-- TALLER 2
-- SUBCONSULTAS

-- El nombre y fecha de nacimiento de los actores mayores de edad, que hayan protagonizado películas después del año 2020 y con edad superior que alguno de los actores mujeres. 
insert into pelicula values(10006, 'Elvis', 'Warner Bros. Pictures', 2022, 159, 'Musical', 85000000);
insert into actor values(100061, 'Austin Butler', 'M', '1991/08/17');
insert into actor values(100062, 'Tom Hanks', 'M', '1956/07/09');
insert into protagonizar values(10006, 100061);
insert into protagonizar values(10006, 100062);
insert into productor values(60, 'Baz Luhrmann');
insert into producir values(10006, 60);

select distinct nombre, fecha_nacimiento
from actor as a
where a.id in (select a.id from pelicula as p, actor as a, protagonizar as pro
			   where a.id = pro.id_actor 
			   and pro.codigo_pelicula = p.codigo
			   and año > 2020
			   and (((CURRENT_DATE - fecha_nacimiento)/365)>18)
			   and ((CURRENT_DATE - fecha_nacimiento)/365)> some (select ((CURRENT_DATE - fecha_nacimiento)/365) 
																  from actor
																  where genero = 'F'));
																  
-- Los datos de los productores que nunca han producido películas.	
insert into productor values(71, 'Quentin Tarantino');

select *
from productor 
where codigo not in (select p.codigo 
					from productor as p, producir as pro 
                    where p.codigo = pro.codigo_productor);

-- Todos los datos de los productores que han registrado películas con la máxima duración.
select *
from productor
where codigo in (select p.codigo
				from productor as p, producir as prod, pelicula as peli
                where p.codigo = prod.codigo_productor and prod.codigo_pelicula = peli.codigo and peli.duracion in (select max(duracion)
																													from pelicula))
                                                                                                                    
-- Todos los datos de los actores que han protagonizado películas registradas por el productor Warner.
select *
from actor as act
where exists(select act.*
			from protagonizar as prota, pelicula as peli
            where act.id = prota.id_actor and prota.codigo_pelicula = peli.codigo and peli.estudio = 'Warner Bros. Pictures')
            
-- El título y la duración de las películas protagonizadas por el actor Brad Pitt, cuya duración supera alguna duración de las películas protagonizadas por Bruce Willis.
insert into pelicula values(10007, 'Pulp Fiction', 'A Band Apart', 	1994, 154, 'Comedia negra', 8000000);
insert into actor values(100071, 'Bruce Willis', 'M', '1955-03-19');
insert into protagonizar values(10007, 100071);

insert into pelicula values(10008, 'Once Upon a Time in Hollywood', 'Columbia Pictures', 2019, 160, 'ucronía', 90000000);
insert into protagonizar values(10008, 100012);

select peli.titulo, peli.duracion
from pelicula as peli, actor as act, protagonizar as prota
where act.id = prota.id_actor and prota.codigo_pelicula = peli.codigo and act.nombre = 'Brad Pitt' and peli.duracion > some(select p.duracion
																															from pelicula as p, actor as a, protagonizar as prot
																															where a.id = prot.id_actor and prot.codigo_pelicula = p.codigo and a.nombre = 'Bruce Willis')
-- Promedio de edades de los actores de aquel género de películas donde la edad promedio es superior a 40.
select peli.genero, avg(actores.age) as edad_promedio
from protagonizar as prota, pelicula as peli, (select a.*, TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) from actor as a) as actores(id, nombre, genero, fecha_nacimiento, age)
where actores.id = prota.id_actor and prota.codigo_pelicula = peli.codigo 
group by peli.genero
having avg(actores.age)>40;
                                                                                        
-- JOIN																								
																	
-- Cantidad de actores hombres que protagonizaron películas del productor Warner y que fueron registradas antes del 2020.
-- Nombre de los actores que no han protagonizado películas en el 2022. Mostrar los datos de forma ascendente.
-- Datos del (los) trailer de películas protagonizadas por el actor Tom Cruise.
-- Datos de los productores que no tienen registradas películas.
-- Todos los datos de los actores que han protagonizado películas registradas por el productor Warner.
-- Datos de las películas que no han sido protagonizadas por Tom Cruise, ni Brad Pitt.

-- VISTAS
-- Número de películas registradas por cada productor.
create view num_peli_por_pord as
select prod.nombre, count(peli.codigo)
from productor as prod, producir, pelicula as peli
where prod.codigo = producir.codigo_productor and producir.codigo_pelicula = peli.codigo
group by prod.nombre;

-- Promedio de duración de las películas registradas por cada productor.
create view prom_duracion_peli_por_productor as
select prod.nombre, avg(peli.duracion)
from productor as prod, producir, pelicula as peli
where prod.codigo = producir.codigo_productor and producir.codigo_pelicula = peli.codigo
group by prod.nombre;

-- Cantidad de películas protagonizadas por cada actor hombre.
create view pelis_por_actor_h as
select act.nombre, count(peli.codigo)
from actor as act, protagonizar as prota, pelicula as peli
where act.id = prota.id_actor and prota.codigo_pelicula = peli.codigo and act.genero = 'M'
group by act.nombre;

-- Nombre y edad de los actores que protagonizan películas cuyo trailer tiene una duración de menos de 2 minutos.
create view actores_de_trailers as
select act.nombre, TIMESTAMPDIFF(YEAR, act.fecha_nacimiento, CURDATE()) as edad
from actor as act, trailer as t, protagonizar as prota, pelicula as peli
where act.id = prota.id_actor and prota.codigo_pelicula = peli.codigo and t.codigo_pelicula = peli.codigo and t.duracion <2.00;

-- RESTRICCIONES
-- Actualizar la tabla actor para que en la columna género sólo se permita agregar los valores: F, M y NB.
alter table actor
add constraint generos_permitidos
check(genero = 'F' or genero = 'M' or genero = 'NB');

-- Actualizar la tabla película para que la duración sea mínimo 60 minutos.
alter table pelicula
add constraint duracion_minima
check(duracion >= 60);

-- Actualizar la tabla película para que sólo se permita registrar películas después del año 1950.
alter table pelicula
add constraint año_despues_del_1950
check(año > 1950);
