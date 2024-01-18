-- your assignment is to design a database that manages 'cinema productions'. the entities of interest for the problem domain are: actors, movies, companies, cinema productions and stage directors.

-- each 'movie' has a name, a release date, belongs to a production 'company' and has a stage director.
-- the 'company' has a name and an id. 
-- a stage dirctor can direct multiple movies, has a name and a number of awards. 
-- each 'cinema production' has a title, an associated movie and a list of actors with an entry moment for each actor.
-- every actor has a name and a ranking.

-- 1. write a sql script that creates the corresponding relational data model. (4p)
-- 2. create a stored procedure that receives an actor, an entry moment and a cinema production and adds the new actor to the cinema production. (1p)
-- 3. create a view that shows the name of the actors that appear in all cinema productions. (2p)
-- 4. create a function that returns all movies that have the release date after '2018-01-01' and have at least p productions, where p is a function parameter. (2p)
-- (1p of)

use cinema

-- 1

create table company
(
	id int primary key identity(1, 1),
	name varchar(32) not null
);

create table stage_director
(
	id int primary key identity(1, 1),
	name varchar(32) not null, 
	awards int not null
);

create table movie
(
	id int primary key identity(1, 1),
	name varchar(32) not null,
	release_date date not null,
	company_id int foreign key references company(id),
	stage_director_id int foreign key references stage_director(id)
);

create table cinema_production
(
	id int primary key identity(1, 1),
	title varchar(32) not null,
	movie_id int foreign key references movie(id)
);

create table actor 
(
	id int primary key identity(1, 1),
	name varchar(32) not null,
	ranking int not null
);

create table cinema_production_actor
(
	cinema_production_id int foreign key references cinema_production(id),
	actor_id int foreign key references actor(id),
	entry_moment datetime not null,
	primary key (cinema_production_id, actor_id)
);

-- 2

create or alter procedure AddCinemaProductionActor @cinema_production_id int, @actor_id int, @entry_moment datetime
as
begin
	set nocount on;

	insert into cinema_production_actor(cinema_production_id, actor_id, entry_moment) values (@cinema_production_id, @actor_id, @entry_moment)	
end

declare @cinema_production_id int;
declare @actor_id int;
declare @entry_moment datetime;
set @cinema_production_id = 1;
set @actor_id = 1;
set @entry_moment = '2000-01-01 00:00:00';

exec AddCinemaProductionActor @cinema_production_id, @actor_id, @entry_moment;

-- 3

create view NamesOfActorsThatAppearInAllCinemaProductions
as
select a.name
from actor a
where not exists 
(
	select cp.id
	from cinema_production cp
	where not exists 
	(
		select 1
		from cinema_production_actor cpa
		where cpa.actor_id = a.id and cpa.cinema_production_id = cp.id
	)
);

select * from NamesOfActorsThatAppearInAllCinemaProductions;

-- 4

create function MoviesThatHaveReleaseDateAfterXAndHasAtLeastYProductions (@release_date date, @productions int)
returns table
as 
return
(
	select m.id, m.name, m.release_date, count(p.id) as production_count
	from movie m inner join cinema_production p on m.id = p.movie_id
	where m.release_date > @release_date
	group by m.id, m.name, m.release_date
	having count(p.id) >= @productions
);

select * 
from MoviesThatHaveReleaseDateAfterXAndHasAtLeastYProductions('2018-01-01', 2);























