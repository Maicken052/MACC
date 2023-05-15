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
INSERT INTO actor VALUES(10,'Mel Gibson');
INSERT INTO actor VALUES(20,'Sharone Stone');
INSERT INTO actor VALUES(30,'Demi Moore');
INSERT INTO actor VALUES(40,'Bruce Willis');
INSERT INTO actor VALUES(50,'Antony Hopkins');
INSERT INTO actor VALUES(60,'Nicholas Cage');
INSERT INTO actor VALUES(70,'Sean Connery');
INSERT INTO actor VALUES(80,'Angelina Jolie');
INSERT INTO actor VALUES(90,'Brad Pitt');
INSERT INTO actor VALUES(100,'Will Smith');
INSERT INTO actor VALUES(110,'Dwayne Johnson');
INSERT INTO actor VALUES(120,'Johnny Depp');
INSERT INTO actor VALUES(130,'Clint Eastwood');
INSERT INTO actor VALUES(140,'Meryl Streep');
INSERT INTO actor VALUES(150,'Jack Nicholson');
INSERT INTO actor VALUES(160,'Benicio del Toro');
INSERT INTO actor VALUES(170,'Morgan Freeman');
INSERT INTO actor VALUES(180,'Amy Adams');
INSERT INTO actor VALUES(190,'Eddie Murphy');
INSERT INTO actor VALUES(200,'Anne Hathaway');

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

-- Calcular el rango para las películas registradas por el productor Warner de acuerdo con la duración y mostrarlas de mayor a menor. 

-- Calcular el rango para los trailer de acuerdo con la película y con el promedio de duración mostrando los datos de menor a mayor.

-- OLAP

-- Utilizando GROUPING SETS, calcular la suma del presupuesto de las películas agrupando por año y género. 

-- Utilizando CUBE, contar los actores agrupados por género y año de nacimiento

-- Utilizando ROLLUP, obtener el promedio de la duración de las películas de acuerdo con el estudio y el género.
