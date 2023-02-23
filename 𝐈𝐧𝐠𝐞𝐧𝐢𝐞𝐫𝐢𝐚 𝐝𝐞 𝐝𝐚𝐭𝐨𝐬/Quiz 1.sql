'''Punto a'''
create table pelicula(
codigo integer,
titulo varchar(30) not null,
estudio integer,
año integer,
duracion integer,
genero varchar(30),
presupuesto numeric(10,2),
primary key(codigo)
);

create table productor(
codigo integer,
nombre varchar(30) not null,
primary key(codigo)
);

create table producir(
codigo_pelicula integer,
codigo_productor integer,
foreign key(codigo_pelicula) references pelicula,
foreign key (codigo_productor) references productor,
primary key(codigo_pelicula, codigo_productor)
);

'''Punto b'''
insert into pelicula(codigo, titulo, estudio, año, duracion, genero, presupuesto) values
	(10001, 'Gato con botas', 1, 2015, 210, 'Aventura', 10000000),
	(20002, 'La calabaza magica', 2, 2010, 180, 'Ciencia Ficcion', 49000000);
insert into pelicula values(30003, 'Mickey Mouse', 3, 2000, 150, 'Animacion', 60000000)

insert into productor(codigo, nombre) values
	(101, 'Pepe'),
	(202, 'Fulano');
insert into productor values(303, 'Walt')

insert into producir(codigo_pelicula, codigo_productor) values
	(10001, 101),
	(20002, 202);
insert into producir values (30003, 303)

'''Punto c'''
select *
from pelicula
where año < 2015

'''Punto d'''
select pr.codigo
from pelicula as p, productor as pr, producir as pir 
where pr.codigo = pir.codigo_productor and pir.codigo_pelicula = p.codigo and p.presupuesto > 50000000

'''punto e'''
select *
from pelicula
where duracion > 200
