-- Se crean las tablas necesarias para la carga de datos

CREATE TABLE county (
	ID integer NOT NULL,
	name varchar(40),
	CONSTRAINT county_pk PRIMARY KEY (ID)
);

CREATE TABLE city (
	name varchar(20) NOT NULL,
	ID_county integer,
	CONSTRAINT city_pk PRIMARY KEY (name),
	foreign key (ID_county) references county(ID)
);

CREATE TABLE store (
	ID integer NOT NULL,
	name varchar(50) NOT NULL,
	address varchar(40),
	name_city varchar(20),
	CONSTRAINT store_pk PRIMARY KEY (ID),
	foreign key (name_city) references city(name)
);

CREATE TABLE vendor (
	ID integer NOT NULL,
	name varchar(50),
	CONSTRAINT vendor_pk PRIMARY KEY (ID),
	CONSTRAINT "Vendor_uq" UNIQUE (name)
);

CREATE TABLE category (
	ID integer NOT NULL,
	name varchar(50) NOT NULL,
	CONSTRAINT category_pk PRIMARY KEY (ID)
);

CREATE TABLE product (
	ID integer NOT NULL,
	name varchar(100) NOT NULL,
	volume numeric(6,2),
	ID_category integer,
	ID_vendor integer,
	CONSTRAINT product_pk PRIMARY KEY (ID),
	foreign key (ID_vendor) references vendor(ID),
	foreign key (ID_category) references category(ID)
);

CREATE TABLE zip_code (
	zip_code integer,
	name_city varchar(20),
	foreign key (name_city) references city(name)
);

CREATE TABLE sells (
	invoice varchar(20) NOT NULL,
	date date NOT NULL,
	bottle_cost numeric(6,2) NOT NULL,
	bottle_retail numeric(6,2) NOT NULL,
	bottles_sold integer NOT NULL,
	sale numeric(8,2),
	ID_store integer,
	ID_product integer,
	CONSTRAINT sells_pk PRIMARY KEY (invoice),
	foreign key (ID_store) references store(ID),
	foreign key (ID_product) references product(ID)
);

CREATE TABLE provides (
	ID_vendor integer,
	ID_store integer,
	foreign key (ID_vendor) references vendor(ID),
	foreign key (ID_store) references store(ID)
);

-- Se cargan los datos desde los archivos csv a las tablas creadas
copy county(ID, name)
from 'D:\Proyecto Datos\Proyecto_Datos\Tablas_datos_csv\county.csv' delimiter ';' csv header;
select * from county;

copy city(name, ID_county)
from 'D:\Proyecto Datos\Proyecto_Datos\Tablas_datos_csv\city.csv' delimiter ';' csv header;
select * from city;

copy store(ID, name, address, name_city)
from 'D:\Proyecto Datos\Proyecto_Datos\Tablas_datos_csv\store.csv' delimiter ';' csv header;
select * from store;

copy vendor(ID, name)
from 'D:\Proyecto Datos\Proyecto_Datos\Tablas_datos_csv\vendor.csv' delimiter ';' csv header;
select * from vendor;

copy category(ID, name)
from 'D:\Proyecto Datos\Proyecto_Datos\Tablas_datos_csv\category.csv' delimiter ';' csv header;
select * from category;

copy product(ID, name, volume, ID_category, ID_vendor)
from 'D:\Proyecto Datos\Proyecto_Datos\Tablas_datos_csv\product.csv' delimiter ';' csv header;
select * from product;

copy zip_code(zip_code, name_city)
from 'D:\Proyecto Datos\Proyecto_Datos\Tablas_datos_csv\zip_code.csv' delimiter ';' csv header;
select * from zip_code;

SET datestyle = "ISO, MDY";
copy sells(invoice, date, bottle_cost, bottle_retail, bottles_sold, sale, ID_store, ID_product)
from 'D:\Proyecto Datos\Proyecto_Datos\Tablas_datos_csv\sells.csv' delimiter ';' csv header;
select * from sells;

copy provides(ID_vendor, ID_store)
from 'D:\Proyecto Datos\Proyecto_Datos\Tablas_datos_csv\provides.csv' delimiter ';' csv header;
select * from provides;

--Consultas

--Número de ventas por categoria
select c.name as category, count(s.bottle_retail) as sales_number from sells as s left outer join product as p on s.ID_product = p.ID
left outer join category as c on p.ID_category = c.ID
group by c.name;

--Ingresos anuales
select cast(extract(year from s.date) as varchar) as Year, sum(s.sale) as Incomes from sells as s
group by Year;

--Ganancias por condado mensualmente (3 variables)
select co.name, sum((se.bottles_sold*(se.bottle_retail - se.bottle_cost))) as Earnings, to_char(se.date, 'Month') as month, extract(month from se.date) as month_number
from sells as se left outer join store as st on se.ID_store = st.ID
left outer join city as ci on st.name_city = ci.name
left outer join county as co on ci.ID_county = co.ID
group by month, co.name, month_number
order by month_number asc;

--Ventas mensuales
select extract(month from s.date) as month_number, to_char(s.date, 'Month') as month, count(s.bottle_retail) as sales_number from sells as s
group by month, month_number
order by month_number asc;

--Costo por categorias
select c.name, sum(s.bottle_cost) as total_bottle_cost from category as c left outer join product as p on c.ID = p.ID_category
left outer join sells as s on p.ID = s.ID_product
group by c.name;

--Ingresos por categorias de vodka anuales (3 variables)
select c.name, sum(s.sale) as Earnings, cast(extract(year from s.date) as varchar) as Year from category as c left outer join product as p on c.ID = p.ID_category
left outer join sells as s on p.ID = s.ID_product
where c.name like('%VODKA%') 
group by c.name, Year
order by Year asc;
