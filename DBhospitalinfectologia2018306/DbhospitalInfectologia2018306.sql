/*
Diego Fernando Solis Lopez
IN5AM
2018306

modificaciones:
	Creacion de la DB 2021/02/09
    
    Creacion de Tablas 2021/02/09
    
    INSERTS 2021/02/10
    UPDATE  2021/02/10
    DELETE  2021/02/11
    SELECT  2021/02/11
    DROP    2021/02/11
    
*/
	
drop database if exists DBHospitalinfectologia2018306;

create database DBHospitalinfectologia2018306;

use DBHospitalinfectologia2018306;

create table Horarios(
	codigoHorario int not null auto_increment,
    horarioInicio datetime not null,
    horarioSalida datetime not null,
    lunes tinyint,
    martes tinyint,
    miercoles tinyint,
    jueves tinyint,
    viernes tinyint,
    primary key PK_codigoHorario (codigoHorario)
    
    );
    
create table Especialidades(
	codigoEspecialidad int not null auto_increment,
    nombreEspecialidad varchar(45),
    primary key PK_codigoEspecialidad (codigoEspecialidad)
    
    );
    
create table Medicos(
	codigoMedico int not null auto_increment,
    licenciaMedica int not null,
    nombres varchar(100) not null,
    apellidos varchar(100) not null,
    horaEntrada datetime not null,
    horaSalida datetime not null,
    turnoMaximo int not null,
    sexo varchar(20) not null,
    primary key PK_codigoMedico (codigoMedico)
    
    );

create table telefonosMedico(
	codigoTelefonoMedico int not null auto_increment,
    telefonoPersonal varchar (15) not null,
    telefonoTrabajo varchar(15),
    codigoMedico int,
    primary key PK_codigoTelefonoMedico (codigoTelefonoMedico),
    constraint FK_telefonosMedico_Medicos foreign key (codigoMedico) references Medicos(codigoMedico)
    );
    
create table Medico_Especialidad(
	codigoMedicoEspecialidad int not null auto_increment,
    codigoMedico int not null,
    codigoEspecialidad int not null,
    codigoHorario int not null,
    primary key PK_codigoMedicoEspecialidad (codigoMedicoEspecialidad),
    constraint FK_Medico_Especialidad_Especialidades foreign key (codigoEspecialidad) references Especialidades(codigoEspecialidad),
    constraint FK_Medico_Especialidad_Horarios foreign key (codigoHorario) references Horarios(codigoHorario),
    constraint FK_Medico_Especialidad_Medicos foreign key (codigoMedico) references Medicos(codigoMedico)
    
    );
    
create table Pacientes(
	codigoPaciente int not null auto_increment,
    DPI varchar(20) not null,
    nombres varchar(100) not null,
    apellidos varchar(100) not null,
    fechaNacimiento date not null,
    edad int,
    direccion varchar(150) not null,
    ocupacion varchar(50) not null,
    sexo varchar(15) not null,
    primary key PK_codigoPaciente (codigoPaciente)
    
    );
    
    
create table contactoUrgencia(
	codigoContactoUrgencia int not null auto_increment,
    nombres varchar(100) not null,
    apellidos varchar(100) not null,
    numeroContacto varchar(15) not null,
    codigoPaciente int,
    primary key PK_codigoContactoUrgencia (codigoContactoUrgencia),
    constraint Fk_contactoUrgencia_Pacientes foreign key (codigoPaciente) references Pacientes(codigoPaciente)
    
    );
    
create table Areas(
	codigoArea int not null auto_increment,
    nombreArea varchar(45) not null,
    primary key PK_codigoArea (codigoArea)
    
    );
    
create table Cargos(
	codigoCargo int not null auto_increment,
    nombreCargo varchar(45) not null,
    primary key PK_codigoCargo (codigoCargo)
    
    );
    
create table ResponsableTurno(
	codigoResponsableTurno int not null auto_increment,
    nombreResponsable varchar(100) not null,
    apellidosResponsable varchar(100) not null,
    telefonoPersonal varchar(15) not null,
    codigoArea int,
    codigoCargo int,
    primary key PK_codigoResponsableTurno (codigoResponsableTurno),
    constraint FK_ResponsableTurno_Areas foreign key (codigoArea) references Areas(codigoArea),
    constraint FK_ResponsableTurno_Cargos foreign key (codigoCargo) references Cargos(codigoCargo)
    
    );
    
 create table Turno(
	codigoTurno int not null auto_increment,
    fechaTurno date not null,
    fechaCita date not null,
    valorCita decimal(10,2) not null,
    codigoMedicoEspecialidad int,
    codigoTurnoResponsable int,
    codigoPaciente int,
    primary key PK_codigoTurno (codigoTurno),
    constraint FK_Turno_Medico_Especialidad foreign key (codigoMedicoEspecialidad) references Medico_Especialidad(codigoMedicoEspecialidad),
    constraint FK_Turno_ResponsableTurno foreign key (codigoTurnoResponsable) references ResponsableTurno(codigoResponsableTurno),
    constraint FK_Turno_Pacientes foreign key (codigoPaciente) references Pacientes(codigoPaciente)
    
    );
    
    
insert into Horarios (horarioInicio,horarioSalida,lunes,martes,miercoles,jueves,viernes)
			values ('21-00-00 6:00:00','00-00-00 20:00:00',true,true,false,true,false);
insert into Horarios (horarioInicio,horarioSalida,lunes,martes,miercoles,jueves,viernes)
			values ('21-00-00 7:30:00','00-00-00 21:30:00',false,true,false,false,true);
insert into Horarios (horarioInicio,horarioSalida,lunes,martes,miercoles,jueves,viernes)
			values ('21-00-00 6:30:00','00-00-00 20:30:00',true,true,true,false,false);
insert into Horarios (horarioInicio,horarioSalida,lunes,martes,miercoles,jueves,viernes)
			values ('21-00-00 6:00:00','00-00-00 22:00:00',false,true,true,false,true);
insert into Horarios (horarioInicio,horarioSalida,lunes,martes,miercoles,jueves,viernes)
			values ('21-00-00 8:30:00','00-00-00 23:00:00',true,false,false,true,true);
            
insert into Especialidades (nombreEspecialidad)
			values ('traumatologo');            
insert into Especialidades (nombreEspecialidad)
			values ('cardiologia');
insert into Especialidades (nombreEspecialidad)
			values ('pediatria');
insert into Especialidades (nombreEspecialidad)
			values ('ginecologia');
insert into Especialidades (nombreEspecialidad)
			values ('hematologia');
            
insert into Medicos (licenciaMedica,nombres,apellidos,horaEntrada,horaSalida,turnoMaximo,sexo)
			values (76994,'Juan','Lopez','00-00-00 6:00:00','00-00-00 20:00:00',4,'masculino');
insert into Medicos (licenciaMedica,nombres,apellidos,horaEntrada,horaSalida,turnoMaximo,sexo)
			values (45971,'Diego','Solis','00-00-00 7:30:00','00-00-00 21:30:00',2,'masculino');
insert into Medicos (licenciaMedica,nombres,apellidos,horaEntrada,horaSalida,turnoMaximo,sexo)
			values (17820,'Julio','Arebalo','00-00-00 6:30:00','00-00-00 20:30:00',3,'masculino');
insert into Medicos (licenciaMedica,nombres,apellidos,horaEntrada,horaSalida,turnoMaximo,sexo)
			values (25471,'Samuel','Medina','00-00-00 6:00:00','00-00-00 22:00:00',3,'masculino');
insert into Medicos (licenciaMedica,nombres,apellidos,horaEntrada,horaSalida,turnoMaximo,sexo)
			values (81322,'Michael','Smith','00-00-00 8:30:00','00-00-00 23:00:00',3,'masculino');
            
insert into telefonosMedico (telefonoPersonal,telefonoTrabajo,codigoMedico)
			values (56789878,78906556,1);
insert into telefonosMedico (telefonoPersonal,telefonoTrabajo,codigoMedico)
			values (45673214,0,2);
insert into telefonosMedico (telefonoPersonal,telefonoTrabajo,codigoMedico)
			values (44089531,24253341,3);           
insert into telefonosMedico (telefonoPersonal,telefonoTrabajo,codigoMedico)
			values (90875413,67648132,4);           
insert into telefonosMedico (telefonoPersonal,telefonoTrabajo,codigoMedico)
			values (55673341,0,5); 

insert into Medico_Especialidad (codigoMedico,codigoEspecialidad,codigoHorario)
			values (1,1,1);
insert into Medico_Especialidad (codigoMedico,codigoEspecialidad,codigoHorario)
			values (2,2,2);
insert into Medico_Especialidad (codigoMedico,codigoEspecialidad,codigoHorario)
			values (3,3,3);            
insert into Medico_Especialidad (codigoMedico,codigoEspecialidad,codigoHorario)
			values (4,4,4);            
insert into Medico_Especialidad (codigoMedico,codigoEspecialidad,codigoHorario)
			values (5,5,5); 
 
insert into Pacientes (DPI,nombres,apellidos,fechaNacimiento,edad,direccion,ocupacion,sexo)
			values (783465439010,'Maria Fernanda','Lopez Arreola','1997-10-12',24,'colonia la esquina zona 10 de Guatemala','Estudiante','Femenino');
insert into Pacientes (DPI,nombres,apellidos,fechaNacimiento,edad,direccion,ocupacion,sexo)
			values (4357216789010,'Juan Fernando','Arriaza Zarina','2003-09-22',17,'colonia el mezquital zona 3 de Villa Canales','Estudiante','Masculino');            
insert into Pacientes (DPI,nombres,apellidos,fechaNacimiento,edad,direccion,ocupacion,sexo)
			values (2435182901001,'Luisa Lizett','Camacho Cortez','1996-08-30',25,'condominio nuevo amanecer zona 14 de Guatemala','Trabajadora','Femenino');           
insert into Pacientes (DPI,nombres,apellidos,fechaNacimiento,edad,direccion,ocupacion,sexo)
			values (7652026936301,'Carlos Eduardo','Gonzales Pineda','1975-05-22',46,'Condominio Los tres jinetes zona 10 de Mixco','Jubilado','Masculino');            
insert into Pacientes (DPI,nombres,apellidos,fechaNacimiento,edad,direccion,ocupacion,sexo)
			values (5643129753651,'Julio Antonio','Medina Paz','1977-03-12',44,'condomino lomas altas 2 zona 7 de Villa nueva','Trabajador','Masculino');
            
insert into contactoUrgencia(nombres,apellidos,numeroContacto,codigoPaciente)
			values ('Maria Jose','Lopez Fernandez',54369812,1);
insert into contactoUrgencia(nombres,apellidos,numeroContacto,codigoPaciente)
			values ('Mario Alejandro','Gomez',76459812,2);            
insert into contactoUrgencia(nombres,apellidos,numeroContacto,codigoPaciente)
			values ('Victor Antonio','Mazariegos Perez',65273583,3);            
insert into contactoUrgencia(nombres,apellidos,numeroContacto,codigoPaciente)
			values ('Luis Enrique','Florez Galdamez',24765151,4);           
insert into contactoUrgencia(nombres,apellidos,numeroContacto,codigoPaciente)
			values ('Brandon Alezander','Ramos Garcia',34872574,5);            

insert into Areas(nombreArea)
			values('Traumatologia');
insert into Areas(nombreArea)
			values('Cardeologia');	            
insert into Areas(nombreArea)
			values('Pediatria');	           
insert into Areas(nombreArea)
			values('Ginecologia');	            
insert into Areas(nombreArea)
			values('Emergencia');
            
insert into Cargos(nombreCargo)
			values('Ayudante');
insert into Cargos(nombreCargo)
			values('Recepcionista');            
insert into Cargos(nombreCargo)
			values('Enfermera');            
insert into Cargos(nombreCargo)
			values('Enfermero');            
insert into Cargos(nombreCargo)
			values('Mantenimineto');  
            
insert into ResponsableTurno(nombreResponsable,apellidosResponsable,telefonoPersonal,codigoArea,codigoCargo)
			values('Massimo','Abelardo',98561264,1,1);
insert into ResponsableTurno(nombreResponsable,apellidosResponsable,telefonoPersonal,codigoArea,codigoCargo)
			values('Lucrecia Fernanda','Zuleta Garcia',45762353,2,2);            
insert into ResponsableTurno(nombreResponsable,apellidosResponsable,telefonoPersonal,codigoArea,codigoCargo)
			values('Alexandra Isabella','Gomez Loera',34762183,3,3);            
insert into ResponsableTurno(nombreResponsable,apellidosResponsable,telefonoPersonal,codigoArea,codigoCargo)
			values('Juan Jose','Rodenas Cuezi',54344421,4,4);            
insert into ResponsableTurno(nombreResponsable,apellidosResponsable,telefonoPersonal,codigoArea,codigoCargo)
			values('Tom','Brady',43805041,5,5);   
            
insert into Turno(fechaTurno,fechaCita,valorCita,codigoMedicoEspecialidad,codigoTurnoResponsable,codigoPaciente)
			values('2021-08-11','2021-08-12',78.50,1,1,1);	
insert into Turno(fechaTurno,fechaCita,valorCita,codigoMedicoEspecialidad,codigoTurnoResponsable,codigoPaciente)
			values('2021-09-04','2021-09-05',98.36,2,2,2);            
insert into Turno(fechaTurno,fechaCita,valorCita,codigoMedicoEspecialidad,codigoTurnoResponsable,codigoPaciente)
			values('2021-09-23','2021-09-24',76.50,3,3,3);            
insert into Turno(fechaTurno,fechaCita,valorCita,codigoMedicoEspecialidad,codigoTurnoResponsable,codigoPaciente)
			values('2021-10-30','2021-10-31',85.35,4,4,4);            
insert into Turno(fechaTurno,fechaCita,valorCita,codigoMedicoEspecialidad,codigoTurnoResponsable,codigoPaciente)
			values('2021-11-08','2021-11-09',96.44,5,5,5);                      

update Horarios set horarioInicio='21-00-00 9:30:00',horarioSalida='21-00-00 12:00:00',lunes=false,martes=false,miercoles=true,jueves=false,viernes=true 
		where codigoHorario=1;

update Especialidades set nombreEspecialidad='Traumatologia' 
		where codigoEspecialidad=1;
        
update Medicos set licenciaMedica=78236,nombres='Jose',apellidos='Alvarez',horaEntrada='2021-00-00 7:30:00',horaSalida='2021-00-00 22:00:00',turnoMaximo=2,sexo='Masculino'
        where codigoMedico=1;
        
update telefonosMedico set telefonoPersonal=78965380,telefonoTrabajo=66618020
		where codigoTelefonoMedico=1;
        
update Pacientes set DPI=7845028438215,nombres='Luisa Johana',apellidos='Veliz Carrillo',fechaNacimiento='2003-02-02',edad=18,direccion='Calle montereal casa apt54 zona 5 de Guatemala',ocupacion='Estudiante',sexo='Femenino'
		where codigoPaciente=1;

update contactoUrgencia set nombres='Julio Alberto',apellidos='Sanchez Gramajo',numeroContacto=46976624
		where codigoContactoUrgencia=1;

update Areas set nombreArea='Anestesiologia'
		where codigoArea=1;

update Cargos set nombreCargo='Gerente'
		where codigoCargo=1;

update ResponsableTurno set nombreResponsable='Juan Luis',apellidosResponsable='Alvarez Pineda',telefonoPersonal=67984410  
		where codigoResponsableTurno=1;
        
update Turno set fechaTurno='2021-08-12',fechaCita='2021-08-13',valorCita=80.35
		where codigoTurno=1;
        
delete  from Turno where codigoTurno=3;

delete from ResponsableTurno where codigoResponsableTurno=3;

delete from Areas where codigoArea=3;

delete from Cargos where codigoCargo=3;

delete from contactoUrgencia where codigoContactoUrgencia=3;

delete from Pacientes where codigoPaciente=3;

delete from Medico_Especialidad where codigoMedicoEspecialidad=3;

delete from telefonosMedico where codigoTelefonoMedico=3;

delete from Medicos where codigoMedico=3;

delete from Especialidades where codigoEspecialidad=3;

delete from Horarios where codigoHorario=3;

select 
	Tur.codigoTurno,
    Tur.fechaTurno,
    Tur.fechaCita,
    Tur.valorCita,
    Tur.codigoMedicoEspecialidad,
    Tur.codigoTurnoResponsable,
    Tur.codigoPaciente
    from Turno Tur;
    
select
		ResT.nombreResponsable,
        ResT.apellidosResponsable,
        ResT.telefonoPersonal,
        ResT.codigoArea,
        ResT.codigoCargo
        from ResponsableTurno ResT;

select 	
		Ar.nombreArea
        from Areas Ar;

select 
		Car.nombreCargo
        from Cargos Car;
        
select         
		cu.nombres,
        cu.apellidos,
        cu.numeroContacto,
        cu.codigoPaciente
        from contactoUrgencia cu;
        
select         
        Pa.DPI,
        Pa.apellidos,
        Pa.nombres,
        Pa.fechaNacimiento,
        Pa.edad,
        Pa.direccion,
        Pa.ocupacion,
        Pa.sexo
        from Pacientes Pa;

select   
		Me.codigoMedico,
        Me.codigoEspecialidad,
        Me.codigoHorario
        from Medico_Especialidad Me;
        
select        
		Tm.telefonoPersonal,
        Tm.telefonoTrabajo,
		Tm.codigoMedico
        from telefonosMedico tm;
 
select
		med.licenciaMedica,
        med.nombres,
        med.apellidos,
        med.horaEntrada,
        med.horaSalida,
		med.turnoMaximo,
        med.sexo
        from Medicos med;
        
select        
		es.nombreEspecialidad
        from Especialidades es;
        
select 
		h.horarioInicio,
        h.horarioSalida,
        h.lunes,
        h.martes,
        h.miercoles,
        h.jueves,
        h.viernes
        from Horarios h;
        
        
        
drop table Turno;

drop table ResponsableTurno;

drop table Areas;

drop table Cargos;

drop table contactoUrgencia;

drop table Pacientes;

drop table Medico_Especialidad;

drop table telefonosMedico;

drop table Medicos;

drop table Especialidades;

drop table Horarios;
