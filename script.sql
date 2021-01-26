
-- Conde Osorio, Marcos V.
-- Del Hierro Díez, Alejandro
-- Fernández Iglesias, Jesús
-- González Mediavilla, Daniel
-- G02



-- CREATE de las tablas


CREATE TABLE Persona(
	idPersona char(15),
	idJefe char(15),
	idSiguiente char(15),
	fechaFin date,
	nombre char(100),
	domicilio char(100),
	fecha_nacimiento date,
	primary key(idPersona),
	foreign key(idJefe) references Persona(idPersona) on update cascade on delete restrict,
	foreign key(idSiguiente) references Persona(idPersona) on update cascade on delete restrict
);


CREATE TABLE Mercado (
	idMercado char(15),
	idEncargado char(15) not null,
	horario bit (7),
	asociacion TINYINT(1),
	direccion char(15),
	primary key(idMercado),
	foreign key(idEncargado) references Persona(idPersona) on update cascade on delete restrict
);


CREATE TABLE Puesto (
	idPuesto int,
	idMercado char(15),
	denominacion enum('pescaderia','carniceria','frutas_verduras', 'alimentacion','panaderia','bar','otros') not null,
	obras TINYINT(1),
	diasCerrado int,
	informacion char(200),
	primary key(idPuesto,idMercado),
	foreign key (idMercado) references Mercado(idMercado) on update cascade on delete restrict
);


CREATE TABLE Concesion(
	idConcesion char(15),
	idTitular char(15),
	idPuesto int,
	idMercado char(15),
	fechaConcesion date,
	fechaExp date,
	motivoExp char(100),
	motivoSusp char(100),
	primary key(idConcesion,idTitular,idPuesto,idMercado),
	foreign key(idTitular) references Persona(idPersona) on update cascade on delete restrict,
	foreign key(idPuesto,idMercado) references Puesto(idPuesto,idMercado) on update cascade on delete restrict
);


CREATE TABLE Sancion(
	idSancion char(15),
	idPuesto int,
	idMercado char(15),
	gravedad smallint,
	motivo char(125),
	multa float (5,2),
	fecha date,
	detalles char(255),
	primary key(idSancion),
	foreign key(idPuesto,idMercado) references Puesto(idPuesto,idMercado) on update cascade on delete restrict
);


CREATE TABLE Registro(
	idRegistro int,
	idMercado char(15),
	fecha date,
	detalles char(225),
	procedencia char(100),
	titular char(100),
	clase char(225),
	peso float(5,2),
	primary key(idRegistro,idMercado),
	foreign key(idMercado) references Mercado(idMercado) on update cascade on delete restrict
);

CREATE TABLE Deuda(
	idFactura int,
	idDeudor char(15),
	agua float(5,2),
	luz float(5,2),
	gas float(5,2),
	camara float(5,2),
	residuos float(5,2),
	cannon int,
	primary key(idFactura,idDeudor),
	foreign key(idDeudor) references Persona(idPersona) on update cascade on delete restrict
);



show tables;



/*
-- drop de las tablas:

drop TABLE Concesion;
drop TABLE Sancion;
drop TABLE Registro;
drop TABLE Deuda;
drop TABLE Puesto;
drop TABLE Mercado;
drop TABLE Persona;

*/



-- INSERT de tuplas:


insert into Persona(idPersona, idJefe, idSiguiente) values
	("0001t",null,null),
	("0002t",null,null),
	("0003t",null,null),
	("0004t",null,null),
	("0005t",null,null),
	("0004e","0001t",null),
	("0005e","0001t",null),
	("0006e","0002t",null),
	("0007e","0003t",null),
	("0008e","0004t",null),
	("0001h",null,"0001t"),
	("0002h",null,"0003t"),
	("0001g",null,null),
	("0002g",null,null),
	("0003g",null,null)
;

insert into Persona(idPersona, idJefe, idSiguiente, fechaFin,fecha_nacimiento) values
	("0006t",null,null,'2018-11-01',null),
	("0003h",null,null,null,'1990-11-01')
;


insert into Persona(idPersona, idJefe, idSiguiente, fechaFin,fecha_nacimiento,nombre) values
	("0007t",null,null,null,'1990-12-01','Titular1'),
	("0008t",null,null,null,'1980-11-01','Titular2')
;



insert into Mercado(idMercado, idEncargado) values
  ("Mercado1","0001g"),
  ("Mercado2","0001g"),
  ("Mercado3","0002g"),
  ("Mercado4","0003g")
;

insert into Mercado(idMercado, idEncargado, horario,asociacion,direccion) values
  ("Mercado5","0003g",b'1111110',1,"calle X")
;



insert into Puesto (idPuesto,idMercado,denominacion) values
	(1,"Mercado1",1),
	(1,"Mercado2",1),
	(1,"Mercado3",2),
	(1,"Mercado4",3),
	(2,"Mercado2",4),
	(3,"Mercado2",5),
	(3,"Mercado3",6),
	(4,"Mercado4",7)
;


insert into Sancion (idSancion,idPuesto,idMercado,gravedad) values
	("s1",1,"Mercado1",1),
	("s2",1,"Mercado2",1),
	("s3",1,"Mercado3",2),
	("s4",1,"Mercado1",3)
;


insert into Deuda (idFactura,idDeudor) values
	(1,"0001t"),
	(2,"0001t"),
	(3,"0002t"),
	(4,"0003t")
;

insert into Registro (idRegistro,idMercado,detalles,peso) values
	(1,"Mercado1","mercancia en mal estado",4.5),
	(2,"Mercado1","reclamacion cliente",null)
;



insert into Concesion (idConcesion,idTitular,idPuesto,idMercado) values
  ('00001','0001t',1,'Mercado1'),
  ('00002','0001t',1,'Mercado2'),
  ('00003','0001t',3,'Mercado3'),
  ('00004','0002t',1,'Mercado2'),
  ('00005','0003t',4,'Mercado4'),
  ('00001','0003t',1,'Mercado1'),
  ('00006','0002t',1,'Mercado3')
;

insert into Concesion (idConcesion,idTitular,idPuesto,idMercado) values
  ('00007','0006t',2,'Mercado2')
;

insert into Concesion (idConcesion,idTitular,idPuesto,idMercado) values
  ('00008','0007t',1,'Mercado3'),
  ('00008','0008t',1,'Mercado3')
;

insert into Concesion (idConcesion,idTitular,idPuesto,idMercado,motivoExp,fechaExp) values
  ('00009','0008t',1,'Mercado3',"impago del cannon",'2018-11-01')
;


-- select de las tablas:

select * from Persona;
select * from Mercado;
select * from Puesto;
select * from Concesion;
select * from Sancion;
select * from Registro;
select * from Deuda;




-- CONSULTAS BASICAS:


-- como saber el ID de los titulares??
select distinct idTitular from Concesion;

-- -> obtener todos los datos de los titulares??
select distinct P.* from Concesion C, Persona P where P.idPersona=C.idTitular;

-- comprobar de un titular con ID="0001t"
select distinct idTitular,idConcesion,idPuesto,idMercado from Concesion C where C.idTitular="0001t";

-- comprobar los datos de una persona con ID="0004e"
select * from Persona P where P.idPersona="0004e";

-- como ver empleados-jefes
select empleado.idPersona as empleado, jefe.idPersona as jefe from Persona jefe, Persona empleado where jefe.idPersona=empleado.idJefe;

-- saber los trabajadores de un titular, por ejemplo de ID="0001t"
select idPersona as empleados from Persona P where P.idJefe="0001t";

-- titulares fallecidos
select idTitular from Concesion C, Persona P where P.fechaFin is not null and P.idPersona=C.idTitular;

-- Puestos libres
select P.idPuesto,P.idMercado from Puesto P where (P.idPuesto,P.idMercado) NOT IN (select idPuesto,idMercado from Concesion) ;

-- Puestos sancionados
select P.idPuesto, P.idMercado,S.idSancion from Puesto P, Sancion S where S.idPuesto=P.idPuesto and S.idMercado=P.idMercado;

select distinct C.idPuesto, C.idMercado,S.idSancion from Concesion C, Sancion S where S.idPuesto=C.idPuesto and S.idMercado=C.idMercado;

-- Personas sancionadas
select distinct C.idTitular,S.idSancion from Concesion C, Sancion S where S.idPuesto=C.idPuesto and S.idMercado=C.idMercado;



-- + CONSULTAS:


-- comprobar horario de los Mercados;
select bin (horario),idMercado from Mercado;

-- Edad media de las personas titulares:

select avg(T.edad) as edadMediaPersonasTitulares from(select timestampdiff(year, P.fecha_nacimiento, curdate()) as edad from Persona P, Concesion C where P.idPersona=C.idTitular )T;

-- Concesiones canceladas
select * from Concesion C where C.motivoExp is not  NULL;

-- Personas con más de 2 empleados
-- select P.idPersona from Persona P where P.idJefe is not null group by P.idJefe having count(*) > 2;





