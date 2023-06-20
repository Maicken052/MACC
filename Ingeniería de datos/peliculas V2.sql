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
presupuesto numeric(12,2),
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

create table director(
id_actor integer,
director integer,
primary key(id_actor, director),
foreign key(id_actor) references actor(id),
foreign key(director) references actor(id)	
);

INSERT INTO pelicula VALUES(1001,'Corazón Valiente', 'Paramount Pictures', 1995, 177, 'Drama', 72000000);
INSERT INTO pelicula VALUES(1002,'Bajos instintos', 'InterCom', 1992, 127, 'Suspenso', 49000000);
INSERT INTO pelicula VALUES(1003,'Una propuesta indecente', 'Paramount Pictures', 1993, 117, 'Drama', 38000000);
INSERT INTO pelicula VALUES(1004,'Duro de Matar', '20th Century Fox', 1988, 131, 'Acción', 28000000);
INSERT INTO pelicula VALUES(1005,'Hannibal', 'Universal Studios', 2001, 131, 'Terror', 87000000);
INSERT INTO pelicula VALUES(1006,'Contracara', 'Paramount Pictures', 1997, 138, 'Acción', 80000000);
INSERT INTO pelicula VALUES(1007,'La Roca', 'Buena Vista Pictures', 1996, 136, 'Acción', 75000000);
INSERT INTO pelicula VALUES(1008,'Malefica', 'Walt Disney Pictures', 2014, 97, 'Fantasía', 180000000);
INSERT INTO pelicula VALUES(1009,'Troya', 'Warner Bros. Pictures', 2004, 163, 'Acción', 175000000);
INSERT INTO pelicula VALUES(1010,'Soy Leyenda', 'Warner Bros. Pictures', 2007, 101, 'Drama', 150000000);
INSERT INTO pelicula VALUES(1011,'Rapidos y Furiosos', 'Universal Pictures', 2001, 107, 'Acción', 38000000);
INSERT INTO pelicula VALUES(1012,'Piratas del Caribe', 'Walt Disney Pictures', 2003, 143, 'Acción', 140000000);
INSERT INTO pelicula VALUES(1013,'Gran Torino', 'Warner Bros. Pictures', 2008, 116, 'Drama', 33000000);
INSERT INTO pelicula VALUES(1014,'Mama Mia', 'Universal Studios', 2008, 108, 'Comedia Musical', 52000000);
INSERT INTO pelicula VALUES(1015,'Mejor imposible', 'Sony Pictures', 1997, 139, 'Comedia Romántica', 50000000);
INSERT INTO pelicula VALUES(1016,'El hombre lobo', 'Universal Pictures', 2010, 102, 'Terror', 150000000);
INSERT INTO pelicula VALUES(1017,'Sueño de Fuga', 'Columbia Pictures', 1994, 142, 'Drama', 25000000);
INSERT INTO pelicula VALUES(1018,'Año bisiesto', 'Universal Pictures', 2010, 100, 'Comedia Romántica', null);
INSERT INTO pelicula VALUES(1019,'Shrek', 'DreamWorks Pictures', 2001, 90, 'Animación', 60000000);
INSERT INTO pelicula VALUES(1020,'El diario de la princesa', 'Walt Disney Pictures', 2001, 114, 'Comedia', 26000000);

INSERT INTO actor VALUES(00,'SIN DIRECTOR');
INSERT INTO actor VALUES(10,'Mel Gibson', 'M', '1956-01-03');
INSERT INTO actor VALUES(20,'Sharone Stone', 'F', '1958-03-10');
INSERT INTO actor VALUES(30,'Demi Moore', 'F', '1962-11-11');
INSERT INTO actor VALUES(40,'Bruce Willis', 'M', '1955-03-19');
INSERT INTO actor VALUES(50,'Antony Hopkins', 'M', '1937-12-31');
INSERT INTO actor VALUES(60,'Nicholas Cage', 'M', '1964-01-07');
INSERT INTO actor VALUES(70,'Sean Connery', 'M', '1930-08-25');
INSERT INTO actor VALUES(80,'Angelina Jolie', 'F', '1975-06-04');
INSERT INTO actor VALUES(90,'Brad Pitt', 'M', '1963-12-18');
INSERT INTO actor VALUES(100,'Will Smith', 'M', '1968-09-25');
INSERT INTO actor VALUES(110,'Dwayne Johnson', 'M', '1972-05-02');
INSERT INTO actor VALUES(120,'Johnny Depp', 'M', '1963-06-09');
INSERT INTO actor VALUES(130,'Clint Eastwood', 'M', '1930-05-31');
INSERT INTO actor VALUES(140,'Meryl Streep', 'F', '1949-06-22');
INSERT INTO actor VALUES(150,'Jack Nicholson', 'M', '1937-04-22');
INSERT INTO actor VALUES(160,'Benicio del Toro', 'M', '1967-02-19');
INSERT INTO actor VALUES(170,'Morgan Freeman', 'M', '1937-06-01');
INSERT INTO actor VALUES(180,'Amy Adams', 'F', '1974-08-20');
INSERT INTO actor VALUES(190,'Eddie Murphy', 'M', '1961-04-03');
INSERT INTO actor VALUES(200,'Anne Hathaway', 'F', '1982-11-12');

INSERT INTO director VALUES(10, 00);
INSERT INTO director VALUES(20, 10);
INSERT INTO director VALUES(30, 50);
INSERT INTO director VALUES(40, 130);
INSERT INTO director VALUES(50, 190);
INSERT INTO director VALUES(50, 10);
INSERT INTO director VALUES(60, 80);
INSERT INTO director VALUES(70, 130);
INSERT INTO director VALUES(80, 00);
INSERT INTO director VALUES(90, 130);
INSERT INTO director VALUES(100, 40);
INSERT INTO director VALUES(100, 10);
INSERT INTO director VALUES(110, 160);
INSERT INTO director VALUES(120, 150);
INSERT INTO director VALUES(120, 160);
INSERT INTO director VALUES(130 ,00);
INSERT INTO director VALUES(140, 180);
INSERT INTO director VALUES(140, 80);
INSERT INTO director VALUES(150, 70);
INSERT INTO director VALUES(150, 130);
INSERT INTO director VALUES(160, 00);
INSERT INTO director VALUES(170, 80);
INSERT INTO director VALUES(180, 190);
INSERT INTO director VALUES(190, 160);
INSERT INTO director VALUES(200, 40);
INSERT INTO director VALUES(200, 160);

insert into productor(codigo, nombre) values
	(1, 'Icon Productions'),
    (2, 'Columbia Pictures'),
    (3, 'Paramount Pictures'),
    (4, 'Silver Pictures'),
    (5, 'Metro-Goldwyn-Mayer'),
    (6, 'Paramount Pictures'),
    (7, 'Hollywood Pictures'),
    (8, 'Walt Disney Pictures'),
    (9, 'Warner Bros. Pictures'),
    (10, 'Warner Bros. Pictures'),
	(11, 'Universal Pictures'),
	(12, 'Walt Disney Pictures'),
	(13, 'Malpaso Productions'),
	(14, 'Playtone'),
	(15, 'Graice Films'),
	(16, 'Universal Pictures'),
	(17, 'Castle Rock Entertainment'),
	(18, 'IMCINE'),
	(19, 'DreamWorks Pictures'),
	(20, 'Walt Disney Pictures');

insert into producir(codigo_pelicula, codigo_productor) values
	(1001, 1),
    (1002, 2),
    (1003, 3),
    (1004, 4),
    (1005, 5),
    (1006, 6),
    (1007, 7),
    (1008, 8),
    (1009, 9),
    (1010, 10),
	(1011, 11),
	(1012, 12),
	(1013, 13),
	(1014, 14),
	(1015, 15),
	(1016, 16),
	(1017, 17),
	(1018, 18),
	(1019, 19),
	(1020, 20);

insert into protagonizar(codigo_pelicula, id_actor) values
	(1001, 10),
    (1002, 20),
    (1003, 30),
    (1004, 40),
    (1005, 50),
    (1006, 60),
    (1007, 70),
    (1008, 80),
    (1009, 90),
    (1010, 100),
	(1011, 110),
	(1012, 120),
	(1013, 130),
	(1014, 140),
	(1015, 150),
	(1016, 160),
	(1017, 170),
	(1018, 180),
	(1019, 190),
	(1020, 200);
	
insert into trailer(codigo, duracion, codigo_pelicula) values
	(0010, 1.25, 1001),
	(0011, 2.27, 1001),
    (0020, 0.52, 1002),
	(0021, 3.55, 1002),
    (0030, 2.21, 1003),
	(0031, 4.24, 1003),
    (0040, 2.26, 1004),
	(0041, 6.25, 1004),
    (0050, 2.39, 1005), 
	(0051, 8.35, 1005), 
    (0060, 1.33, 1006), 
	(0061, 3.39, 1006),
    (0070, 2.23, 1007),
	(0071, 6.20, 1007), 
    (0080, 2.24, 1008), 
	(0081, 2.25, 1008), 
    (0090, 1.19, 1009),
	(0091, 5.17, 1009),
	(0100, 0.26, 1010), 
	(0101, 6.29, 1010),
	(0110, 2.32, 1011), 
	(0111, 2.31, 1011),
	(0120, 1.54, 1012), 
	(0121, 3.55, 1012),
	(0130, 5.16, 1013),
	(0131, 5.13, 1013),
	(0140, 2.28, 1014), 
	(0141, 6.22, 1014), 
	(0150, 3.69, 1015), 
	(0151, 2.66, 1015),
	(0160, 4.91, 1016),
	(0161, 1.98, 1016), 
	(0170, 5.42, 1017),
	(0171, 4.42, 1017), 
	(0180, 1.53, 1018), 
	(0181, 7.54, 1018), 
	(0190, 2.24, 1019), 
	(0191, 0.25, 1019),
	(0200, 3.16, 1020),
	(0201, 1.11, 1020);
	
-- CONSULTAS RECURSIVAS

-- Obtener los actores que fueron dirigidos por Benicio del Toro
with recursive benicio_dirigio AS(
select *
from director
where director in(
		select id
		from actor
		where nombre = 'Benicio del Toro')
UNION
	select d.id_actor, d.director
	from director as d
	inner join benicio_dirigio as b on b.id_actor = d.director
) 
select *
from benicio_dirigio;

-- Obtener los directores de Antony Hopkins
with recursive antony_fue_dirigido AS(
select *
from director
where id_actor in(
		select id
		from actor
		where nombre = 'Antony Hopkins')
UNION
	select d.id_actor, d.director
	from director as d
	inner join antony_fue_dirigido as b on d.id_actor = b.director
) 
select *
from antony_fue_dirigido;

-- Obtener el director de Eddie Murphy y los actores que él dirigió.
with recursive eddie_historial as (
select * from director
where id_actor in(select id from actor where nombre = 'Eddie Murphy') 
	or
	  director in(select id from actor where nombre = 'Eddie Murphy')
union
select d.* 
from director as d
inner join eddie_historial as ed
on ed.director = d.id_actor or ed.id_actor = d.director)
select * 
from eddie_historial;

-- Obtener los actores dirigidos por Amy Adams y los directores con los que trabajó
with recursive amy_historial as (
select * from director
where id_actor in(select id from actor where nombre = 'Amy Adams') 
	or
	  director in(select id from actor where nombre = 'Amy Adams')
union
select d.* 
from director as d
inner join amy_historial as ed
on ed.director = d.id_actor or ed.id_actor = d.director)
select * 
from amy_historial;

-- Obtener los directores de Anne Hathaway.
with recursive anne_fue_dirigida AS(
select *
from director
where id_actor in(
		select id
		from actor
		where nombre = 'Anne Hathaway')
UNION
	select d.id_actor, d.director
	from director as d
	inner join anne_fue_dirigida as b on d.id_actor = b.director
) 
select *
from anne_fue_dirigida;

-- AGREGACIÓN AVANZADA

-- Calcular el rango de las películas de acuerdo de acuerdo con el género y con la suma del presupuesto mostrándolo de mayor a menor.
select rank() OVER (order by sum(peli.presupuesto) desc) as pres, peli.genero, sum(peli.presupuesto)
from pelicula as peli
group by peli.genero
order by pres

-- Calcular el rango para las películas registradas por el productor Warner de acuerdo con la duración y mostrarlas de mayor a menor. 
select rank() OVER (order by peli.duracion desc) as dur, peli.titulo, peli.duracion
from pelicula as peli
inner join producir as prod
on peli.codigo = prod.codigo_pelicula
inner join productor as p
on prod.codigo_productor = p.codigo
where p.nombre = 'Warner Bros. Pictures'
order by dur

-- Calcular el rango para los trailer de acuerdo con la película y con el promedio de duración mostrando los datos de menor a mayor.
select rank() OVER (order by avg(trailer.duracion) desc) as dur, peli.titulo, avg(trailer.duracion)
from pelicula as peli
inner join trailer 
on peli.codigo = trailer.codigo_pelicula
group by peli.codigo
order by dur

-- OLAP

-- Utilizando GROUPING SETS, calcular la suma del presupuesto de las películas agrupando por año y género. 
select genero, año, sum(presupuesto)
from pelicula 
group by grouping sets(
	   (año),
	   (genero),
	   ()
   );

-- Utilizando CUBE, contar los actores agrupados por género y año de nacimiento
select genero, extract(year from fecha_nacimiento), count(id)
from actor
group by CUBE(genero, extract(year from fecha_nacimiento))


-- Utilizando ROLLUP, obtener el promedio de la duración de las películas de acuerdo con el estudio y el género.
select estudio, genero, avg(duracion)
from pelicula
group by rollup(estudio, genero)

/* Reglas ER a R
Transformar al modelo relacional

Un modelo entidad relacion debe ser transformando en un modelo relacional considerando 
las siguientes reglas:
1. Relacion uno a uno: El analista o administrador de la base de datos debe tomar la decision de cual de las dos tablas
tendra la llave primaria de la tabla relacional.
2. Relacion uno a muchos: La tabla con llave principal (uno) solo tendra las columnas que muestra el modelo entidad-relacion
y la tabala con cardinalidad 'varios' debe tener la llave de la tabla relacionada (llave foranea).
3. Relacion muchos a muchos: se deben crear 3 tablas: tabla izquierda, tabla derecha y la relacion se convierte en tabla
considerando sus propios atributos y las llaves de la tabla izquierda y la tabla derecha (ambas llaves foraneas).
4. Entidad debil: se transforma en una tabla con sus propios atributos y la llave de la entidad fuerte, mas sus propios
atributos.
5. Atributo multivariado: Se debe convertir en una tabla, con las filas necesarias y la llave primaria de la entidad
*/
