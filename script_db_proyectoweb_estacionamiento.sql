Create Database ClubParking_DB

use ClubParking_DB


-- TABLAS----- 

create table T_Distrito(
coddis int identity not null primary key ,
nomdis varchar(30) not null,
estdis int not null
)
-------------------------------------------------
create table T_Perfil(
codper int identity not null primary key ,
nomper varchar(30) not null,
estper int not null
)
-------------------------------------------------
Create Table T_Empleado(
codemp int identity not null primary key ,
nomemp varchar (40) not null,
apeemp varchar(40) not null,
fecemp varchar(10) not null,
usuemp varchar(40) null,
contemp varchar(40) null,
estemp int not null,
codper int not null,
coddis int not null,
foreign key (coddis)references T_Distrito(coddis),
foreign key (codper)references T_Perfil(codper)
)

--insert into T_Empleado(nomemp,apeemp,fecemp,usuemp,contemp,coddis,codper,estemp)values('Gustavo','Valerio','20/06/2019','GUSTAVO','021096',2,1,1)

--select usuemp as 'Usuario',contemp as 'Contraseña',nomper as 'Perfil',nomdis as 'Distrito',estemp as 'Estado'
--from T_Empleado e inner join T_Perfil p on e.codper=p.codper inner join T_Distrito d on e.coddis=d.coddis
--where estemp=1 and estper=1 and estdis=1
----------------------------------------------------------------------

create table T_Cliente(
codcli int identity not null primary key ,
nomcli varchar(40)not null,
apecli varchar(40)not null,
feccli varchar(10) not null,
hi_cli time not null,
dircli varchar(40)not null,
dnicli varchar(8) not null,
celcli varchar(9)null,
matcli varchar(30)not null,
marcli varchar(40)not null,
modcli varchar(40)not null,
estcli int not null,
coddis int not null,
foreign key (coddis)references T_Distrito(coddis)
)
-------------------------------------------------------------------

create table T_Tarifa(
codtar int identity not null primary key,
tiptar varchar(40),
destar varchar(50),
pretar decimal(5,2),
esttar int
)
---------------------------------------------------------------------

create table T_Ticket(
codtic int identity not null primary key,
esttic int null,
codcli int not null
foreign key (codcli) references T_Cliente(codcli)
)

--insert into T_ticket(codtic,esttic,codcli)values(456,1,1)
--select codtic as 'CODIGO DE TICKET',codcli as 'CODIGO DE CLIENTE', esttic as 'Estado' from T_Ticket

---------------------------------------------------------------------

create table T_Boleta(
codbol int identity not null primary key,
estbol int,
codtic int
foreign key (codtic)references T_Ticket(codtic)
)

--insert into T_Boleta(codtic,estbol)values(1,1)
--select * from T_Boleta
--update T_Boleta SET estbol=1 where estbol=0

-------------------------------------------------------





--PROCEDIMIENTOS ALMACENADOS C.R.U.D

--ACCESO USUARIO
Create procedure SP_ACCESO
@usuemp varchar(40),
@conemp varchar(30)
as
Select nomemp  from T_Empleado where usuemp=@usuemp and contemp=@conemp

---------PROCEDIMIENTOS ALMACENADOS DE LA TABLA EMPLEADO----------------------------------------------------

Create Procedure SP_MostrarEmpleado
as
select codemp as 'Codigo',nomemp as 'Nombre',apeemp as 'Apellido',fecemp as 'Fecha',
nomper as 'Perfil', nomdis as 'Distrito', estemp as 'Estado'
from T_Empleado a inner join T_Perfil b on a.codper=b.codper inner join T_Distrito c on a.coddis=c.coddis
where estemp=1 and estper=1 and estdis=1
 
 ------------------------------------------------------------------------------------------------------------
Create Procedure SP_InsertarEmpleado
@nomemp varchar(40),
@apeemp varchar(40),
@fecemp varchar(10),
--@usuemp varchar(20),
--@contemp varchar(10),
@codper int,
@coddis int,
@estemp int
as
Insert into T_Empleado(nomemp,apeemp,fecemp,codper,coddis,estemp) values (@nomemp,@apeemp,@fecemp,@codper,@coddis,@estemp)
--------------------------------------------------------------
Create Procedure SP_ModificarEmpleado
@codemp int,
@nomemp varchar(40),
@apeemp varchar(40),
@fecemp varchar(10),
--@usuemp varchar(20),
--@contemp varchar(10),
@codper int,
@coddis int,
@estemp int
as
Update T_Empleado set nomemp=@nomemp where codemp=@codemp
Update T_Empleado set apeemp=@apeemp where codemp=@codemp
Update T_Empleado set fecemp=@fecemp where codemp=@codemp
Update T_Empleado set codper=@codper where codemp=@codemp
Update T_Empleado set coddis=@coddis where codemp=@codemp
Update T_Empleado set estemp=@estemp where codemp=@codemp
------------------------------------------------------------------
Create Procedure SP_EliminarEmpleado
@codemp int
as
Update T_Empleado set estemp=0 where codemp=@codemp
------------------------------------------------------------------
Create Procedure SP_BuscarEmpleado
@nomemp varchar(40),
@codper int,
@coddis int
as
Select a.codemp as 'Codigo',a.nomemp as 'Nombre',fecemp as 'Fecha',a.apeemp as 'Apellido',b.codper as 'Perfil',c.coddis as 'Distrito',a.estemp as 'Estado' 
from T_Empleado a inner join T_Perfil b on a.codper=b.codper inner join T_Distrito c on a.coddis=c.coddis 
where nomemp like '%'+@nomemp+'%' and b.codper like @codper and c.coddis like @coddis

--Create Procedure SP_BuscarEmpleadopordistrito
--@coddis int
--as
--Select a.codemp as 'Codigo',a.nomemp as 'Nombre',fecemp as 'Fecha',a.apeemp as 'Apellido',b.codper as 'Perfil',c.coddis as 'Distrito',a.estemp as 'Estado' 
--from T_Empleado a inner join T_Perfil b on a.codper=b.codper inner join T_Distrito c on a.coddis=c.coddis 
--where  c.coddis like @coddis

------------------------------------------------------------------



---------------PROCEDIMIENTOS ALMACENADOS DE LA TABLA DISTRITO---------------------------------------------------------------

Create procedure SP_MostrarDistrito
as
Select coddis as 'Codigo',nomdis as 'Nombre', estdis as 'Estado' 
from T_Distrito
where estdis = 1

--select * from T_Distrito
--Update T_Distrito set estdis=1 where estdis=0
-------------------------------------------------------------------

Create Procedure SP_InsertarDistrito
@nomdis varchar(40),
@estdis int
as
insert into T_Distrito(nomdis,estdis) values (@nomdis,@estdis)

-----------------------------------------------------------------

Create Procedure SP_ModificarDistrito
@coddis int,
@nomdis varchar(40),
@estdis int
as
Update T_Distrito set nomdis=@nomdis where coddis=@coddis
Update T_Distrito set estdis=@estdis where coddis=@coddis

------------------------------------------------------------------

create procedure SP_EliminarDistrito
@coddis int
as
Update T_Distrito set estdis=0 where coddis=@coddis

------------------------------------------------------------------

Create procedure SP_BuscarDistrito
@nomdis varchar(40)
as
select coddis as 'Codigo',nomdis as 'Nombre',estdis as 'Estado' 
from T_Distrito
where nomdis like '%'+@nomdis+'%'

---------------------PROCEDIMIENTOS ALMACENADOS DE LA TABLA PERFIL------------------------------

Create procedure SP_MostrarPerfil
as
Select codper as 'Codigo',nomper as 'Nombre',estper as 'Estado'  
from T_Perfil
where estper=1

--select * from T_Perfil
--Update T_Perfil set estper=1 where estper=0
----------------------------------------------------------------

create procedure SP_InsertarPerfil
@nomper varchar(40),
@estper int
as
insert into T_Perfil(nomper,estper) values (@nomper,@estper)

----------------------------------------------------------------

create procedure SP_ModificarPerfil
@codper int,
@nomper varchar(40),
@estper int
as
Update T_Perfil set nomper=@nomper where codper=@codper
update T_Perfil set estper=@estper where codper=@codper

---------------------------------------------------------------

Create procedure SP_EliminarPerfil
@codper int
as
Update T_Perfil set estper=0 where codper=@codper

----------------------------------------------------------------

create procedure SP_BuscarPerfil
@nomper varchar(40)
as
Select codper as 'Codigo', nomper as 'Nombre', estper as 'Estado' 
from T_Perfil
where nomper like '%'+@nomper+'%'

----------PROCEDIMIENTO ALMACENADO DE LA TABLA CLIENTE------------------------------------------

create procedure SP_MostrarCliente
as
select codcli as 'Codigo',nomcli as 'Nombre',apecli as 'Apellido',
feccli as 'Fecha de ingreso',hi_cli as 'Hora de ingreso',dircli as 'Direccion',dnicli as 'DNI',
celcli as 'Celular',matcli as 'Matricula',marcli as 'Marca',modcli as 'Modelo',nomdis as 'Distrito',estcli as 'Estado'
from T_Cliente c inner join T_Distrito d on c.coddis=d.coddis
where estcli=1 and estdis=1

--select * from T_Cliente
--Update T_Cliente set estcli=1 where estcli=0
------------------------------------------------------------------------------

create procedure SP_InsertarCliente
@nomcli varchar(40),
@apecli varchar(40),
@feccli varchar(20),
@hi_cli time,
@dircli varchar(50),
@dnicli varchar(10),
@celcli varchar(15),
@matcli varchar(40),
@marcli varchar(40),
@modcli varchar(40),
@coddis int,
@estcli int
as
insert into T_Cliente(nomcli,apecli,feccli,hi_cli,dircli,dnicli,celcli,matcli,marcli,modcli,coddis,estcli) 
values (@nomcli,@apecli,@feccli,@hi_cli,@dircli,@dnicli,@celcli,@matcli,@marcli,@modcli,@coddis,@estcli)

--------------------------------------------------------------------------------------------

create procedure SP_ModificarCliente
@codcli int,
@nomcli varchar(40),
@apecli varchar(40),
@dircli varchar(30),
@dnicli varchar(10),
@celcli varchar(20),
@matcli varchar(40),
@marcli varchar(40),
@modcli varchar(40),
@coddis int,
@estcli int
as
Update T_Cliente set nomcli=@nomcli where codcli=@codcli
update T_Cliente set apecli=@apecli where codcli=@codcli
update T_Cliente set matcli=@matcli where codcli=@codcli
update T_Cliente set marcli=@marcli where codcli=@codcli
update T_Cliente set modcli=@modcli where codcli=@codcli
update T_Cliente set dircli=@dircli where codcli=@codcli
update T_Cliente set dnicli=@dnicli where codcli=@codcli
update T_Cliente set celcli=@celcli where codcli=@codcli
update T_Cliente set coddis=@coddis where codcli=@codcli
update T_Cliente set estcli=@estcli where codcli=@codcli

--------------------------------------------------------------------

create procedure SP_EliminarCliente
@codcli int
as
update T_Cliente set estcli=0 where codcli=@codcli

----------------------------------------------------------------------

create procedure SP_BuscarCliente
@nomcli varchar(40),
@coddis int
as
select codcli as 'Codigo',nomcli as 'Nombre',apecli as 'Apellido',
feccli as 'Fecha de ingreso',hi_cli as 'Hora de ingreso',dircli as 'Direccion',dnicli as 'DNI',celcli as 'Celular',
nomdis as 'Distrito', estcli as 'Estado'
from T_Cliente c inner join T_Distrito d on c.coddis=d.coddis 
where nomcli like '%'+@nomcli+'%' and c.coddis like @coddis

--------PROCEDIMIENTO ALMACENADO DE LA TABLA TARIFA------------------------------------

create procedure SP_MostrarTarifa
as
select codtar as 'Codigo',tiptar as 'Tipo de vehiculo' ,destar as 'Descripcion',pretar as 'Precio',esttar as 'Estado' 
from T_Tarifa where esttar = 1

--------------------------------------------------------------------------------------

create procedure SP_InsertarTarifa
@tiptar varchar(40),
@destar varchar(40),
@pretar decimal(5,2),
@esttar int
as
insert into T_Tarifa(tiptar,destar,pretar,esttar)values(@tiptar,@destar,@pretar,@esttar)

--------------------------------------------------------------------------------------

create procedure SP_ModificarTarifa
@codtar int,
@tiptar varchar(40),
@destar varchar(40),
@pretar decimal(5,2),
@esttar int
as
Update T_Tarifa set tiptar=@tiptar where codtar=@codtar
Update T_Tarifa set destar=@destar where codtar=@codtar
update T_Tarifa set pretar=@pretar where codtar=@codtar
update T_Tarifa set esttar=@esttar where codtar=@codtar

---------------------------------------------------------------------

create procedure SP_EliminarTarifa
@codtar int
as
Update T_Tarifa set esttar=0 where codtar=@codtar

---------------------------------------------------------------------

create procedure SP_BuscarTarifa
@tiptar varchar(40)
as
select codtar as 'Codigo',tiptar as 'Tipo de vehiculo',destar as'Descripcion',pretar as 'Precio',esttar as 'Estado'  
from T_Tarifa where tiptar like '%'+@tiptar+'%' and esttar=1

------------------------------------------------------------------------

create procedure SP_BuscarTarifa_des
@destar varchar(40)
as
select codtar as 'Codigo',tiptar as 'Tipo de vehiculo',destar as'Descripcion',pretar as 'Precio',esttar as 'Estado'  
from T_Tarifa where destar like '%'+@destar+'%' and esttar=1


--------------------------------------------------------------------------------------------------------------

------------PROCEDIMIENTO ALMACENADO DE LA TABLA BOLETA-----------

create procedure SP_MostrarBoleta
as
select codbol as 'Codigo',k.codtic as 'Ticket',nomcli as 'Nombre',matcli as 'Matricula',estbol as 'Estado'
from T_Boleta b inner join T_Ticket k on b.codtic=k.codtic inner join T_Cliente c on k.codcli=c.codcli
where  estbol=1 and esttic=1

--------------------------------------------------------------------

create procedure SP_InsertarBoleta
@estbol int,
@codtic int
as
insert into T_Boleta(estbol,codtic) values (@estbol,@codtic)

------------------------------------------------------------------------

create procedure SP_ModificarBoleta
@codbol int,
@estbol int,
@codtic int
as
update T_Boleta set codtic=@codtic where codbol=@codbol
update T_Boleta set estbol=@estbol where codbol=@codbol

------------------------------------------------------------------------

create procedure SP_EliminarBoleta
@codbol int
as
update T_Boleta set estbol=0 where codbol=@codbol

--------------------------------------------------------------------------

create procedure SP_BuscarBoleta
@codbol int
as
select codbol as 'Codigo',k.codtic as 'Codigo de ticket',estbol as 'Estado'
from T_Boleta b inner join T_Ticket k on b.codtic=k.codtic
where estbol = 1 and esttic = 1

------------PROCEDIMIENTO ALMACENADO DE LA TABLA TICKET------------

create procedure SP_MostrarTicket
as
select codtic as 'Codigo',c.codcli as 'Codigo del cliente',nomcli as 'Nombre',apecli as 'Apellido',matcli as 'Matricula',
feccli as 'Fecha de ingreso',hi_cli as 'Hora de ingreso',esttic as 'Estado'
from T_ticket t inner join T_Cliente c on t.codcli=c.codcli
where esttic = 1 and estcli=1

--------------------------------------------------------------------------

create procedure SP_InsertarTicket
@esttic int,
@codcli int
as
insert into T_ticket(esttic,codcli) values (@esttic,@codcli)

---------------------------------------------------------------

create procedure SP_ModificarTicket
@codtic int,
@esttic int,
@codcli int
as
update T_ticket set codcli=@codcli where codtic=@codtic
update T_ticket set esttic=@esttic where codtic=@codtic


-----------------------------------------------------------------

create procedure SP_EliminarTicket
@codtic int
as
update T_ticket set esttic=0 where codtic=@codtic

------------------------------------------------------------------

create procedure SP_BuscarTicket
@codtic int
as
select codtic as 'Codigo',nomcli as 'Nombre',apecli as 'Apellido',matcli as 'Matricula'
from T_ticket t inner join T_Cliente c on t.codcli=c.codcli
where esttic = 1 and c.codcli=1

---------------------------------------------------------------------