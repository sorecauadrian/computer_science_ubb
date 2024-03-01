-- creati o baza de date care se ocupa cu gestiunea caselor

-- a) entitatile de interes pentru domeniul problemei sunt: chiriasi, case, proprietari si piese de mobilier
-- b) fiecare chirias are nume, prenume, gen, data de nastere si inchiriaza de la un singur proprietar
-- c) o casa are strada, numar, localitate, cod postal si este gestionat de catre un proprietar.
-- d) fiecare proprietar este caracterizat prin nume, prenume, gen si functie.
-- e) fiecare piesa de mobilier este caracterizata prin denumire, descriere, cantitate si pret.
-- f) relativ la piesele de mobilier din fiecare casa se cunoaste data achizitionarii si data livrarii.

-- cerinte:
-- 1) scrieti un script sql care creeaza un model relational pentru a reprezenta datele. (4p)
-- 2) creati o procedura stocata care primeste un apartament, o piesa de mobilier, o data de achizitionare si o data de livrare, si adauga pieasa de mobilier apartamentui. daca deja exista, se actualizeaza data de achizitionare si data de livrare. (3p)
-- 3) creati un view care afiseaza denumirea pieselor de mobilier ce se gasesc in cel mult 3 case. (2p)

use gestiunea_caselor

-- 1

create table proprietar
(
	id int primary key identity(1, 1),
	nume varchar(32) not null,
	prenume varchar(32) not null,
	gen varchar(8) not null, 
	functie varchar(32) not null
);

create table chirias
(
	nume varchar(32) not null,
	prenume varchar(32) not null,
	gen varchar(8) not null,
	data_nastere date not null,
	id_proprietar int not null foreign key references proprietar(id)
);

create table casa
(
	id int primary key identity(1, 1),
	strada varchar(32) not null,
	numar int not null,
	localitate varchar(32) not null,
	cod_postal int not null,
	id_proprietar int not null foreign key references proprietar(id)
);

create table piesa_mobilier 
(
	id int primary key identity(1, 1),
	denumire varchar(32) not null,
	descriere varchar(256) not null,
	cantitate int not null,
	pret int not null
);
	
create table piesa_casa
(
	id_piesa int not null foreign key references piesa_mobilier(id),
	id_casa int not null foreign key references casa(id),
	primary key (id_piesa, id_casa),
	
	data_achizitionarii date not null,
	data_livrarii date not null
);

drop table piesa_casa
drop table piesa_mobilier
drop table casa
drop table chirias
drop table proprietar


insert into proprietar(nume, prenume, gen, functie) values ('nume1', 'prenume1', 'masculin', 'functie1'), ('nume2', 'prenume2', 'masculin', 'functie2'), ('nume3', 'prenume3', 'feminin', 'functie3')
insert into chirias(nume, prenume, gen, data_nastere, id_proprietar) values ('nume_chirias_1', 'prenume_chirias_1', 'masculin', '2000-01-01', 1), ('nume_chirias_2', 'prenume_chirias_2', 'feminin', '2000-01-01', 3)
insert into casa(strada, numar, localitate, cod_postal, id_proprietar) values ('strada1', 1, 'localitate1', 1, 1), ('strada2', 1, 'localitate1', 2, 1), ('strada1', 1, 'localitate2', 3, 2)
insert into piesa_mobilier(denumire, descriere, cantitate, pret) values ('denumire1', 'descriere1', 100, 100), ('denumire2', 'descriere2', 200, 50), ('denumire3', 'descriere3', 1000, 10000)
insert into piesa_casa(id_piesa, id_casa, data_achizitionarii, data_livrarii) values (1, 1, '2000-01-01', '2000-01-01'), (2, 1, '2001-01-01', '2001-01-01'), (2, 2, '2004-01-01', '2004-01-01'), (3, 3, '2006-01-01', '2006-01-01')

select * from proprietar
select * from chirias
select * from casa
select * from piesa_mobilier
select * from piesa_casa

-- 2

create or alter procedure AdaugaPiesaMobilierInCasa @id_piesa int, @id_casa int, @data_achizitionarii date, @data_livrarii date
as
begin
	if exists (select * from piesa_casa ps where ps.id_piesa = @id_piesa and ps.id_casa = @id_casa)
	begin
		update piesa_casa
		set data_achizitionarii = @data_achizitionarii, data_livrarii = @data_livrarii
		where id_piesa = @id_piesa and id_casa = @id_casa
	end
	else
	begin
		insert into piesa_casa(id_piesa, id_casa, data_achizitionarii, data_livrarii) values (@id_piesa, @id_casa, @data_achizitionarii, @data_livrarii)
	end
end

exec AdaugaPiesaMobilierInCasa 1, 1, '2002-01-01', '2002-01-01'
exec AdaugaPiesaMobilierInCasa 1, 3, '2008-01-01', '2008-01-01'

-- 3

create or alter view PieseMobilierCeSeAflaInCelMult3Case
as
select pm.denumire
from piesa_mobilier pm 
where pm.id in 
(
	select pc.id_piesa
	from piesa_casa pc 
	group by pc.id_piesa
	having count(*) <= 3
)

select * from PieseMobilierCeSeAflaInCelMult3Case
	
	
	
	
	
	
	
	
	
	