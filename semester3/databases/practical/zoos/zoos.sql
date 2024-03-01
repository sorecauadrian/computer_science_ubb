-- create a database storing data about several zoos. you will manage zoos, animals, food, visitors and visits.

-- each zoo has an id, an administrator, a name and several animals.
-- an animal has an id, a name and date of birth. it can eat various foods, the latter consisting of an id and a name.
-- the system stores the daily quota (integer number) for each animal and food, e.g., animal A1 <food F1, 1; food F2, 5>; animal A2 <food F2, 1; food F5, 2>.
-- a visitor is characterized by a personal number (an id), name and age. a visitor can visit several zoos.
-- such a visit is defined by a unique identifier, a day, the paid price, the visitor's personal number and the zoo id.

-- requirements:
-- 1. write a sql script that creates the corresponding relational data model. (4p)
-- 2. implement a stored procedure that receives an animal and deletes all the data about the food quotas for that animal. (1p)
-- 3. create a view that shows the ids of the zoos with the smallest number of visits. (2p)
-- 4. implement a function that lists the ids of the visitors who went to the zoos that have at least n animals, where n >= 1 is a function paramter. (2p)

use zoos

-- 1

create table zoo 
(
	id int primary key identity(1, 1),
	administrator varchar(32) not null,
	name varchar(32) not null
);

create table animal
(
	id int primary key identity(1, 1),
	name varchar(32) not null,
	date_of_birth date not null,
	zoo_id int not null foreign key references zoo(id)
);

create table food
(
	id int primary key identity(1, 1),
	name varchar(32) not null
);

create table animal_food
(
	animal_id int not null foreign key references animal(id),
	food_id int not null foreign key references food(id),
	primary key (animal_id, food_id),
	
	quota int
);

create table visitor
(
	id int primary key identity(1, 1),
	name varchar(32) not null,
	age int not null
);

create table visit
(
	id int primary key identity(1, 1),
	visit_day date not null,
	price int not null,
	visitor_id int not null foreign key references visitor(id),
	zoo_id int not null foreign key references zoo(id)
);

drop table visit
drop table visitor
drop table animal_food
drop table food
drop table animal
drop table zoo

insert into zoo(administrator, name) values ('admin1', 'zoo1'), ('admin2', 'zoo2'), ('admin3', 'zoo3');
insert into animal(name, date_of_birth, zoo_id) values ('animal1', '2000-01-01', 1), ('animal2', '2005-01-01', 1), ('animal3', '2010-01-01', 2);
insert into food(name) values ('food1'), ('food2'), ('food3'), ('food4'), ('food5');
insert into animal_food(animal_id, food_id, quota) values (1, 1, 10), (1, 2, 20), (1, 5, 5), (2, 4, 10), (3, 3, 30), (3, 5, 10);
insert into visitor(name, age) values ('visitor1', 20), ('visitor2', 40), ('visitor3', 10);
insert into visit(visit_day, price, visitor_id, zoo_id) values ('2000-01-01', 20, 1, 1), ('2005-01-01', 30, 1, 2), ('2010-01-01', 40, 2, 1);

select * from animal_food
select * from visit

-- 2

create or alter procedure DeleteDataAboutFoodQuota @animal_id int
as 
begin
	if exists (select * from animal where id = @animal_id)
	begin
		delete from animal_food
		where animal_id = @animal_id
	end
	else
	begin
		raiserror('animal with id %d does not exist', 14, 1, @animal_id)
		return
	end
end


exec DeleteDataAboutFoodQuota 3

-- 3

create or alter view ZoosWithTheSmallestNumberOfVisits
as
select z.id
from zoo z
where z.id in 
(
	select v.zoo_id
	from visit v
	group by v.zoo_id
	having count(*) <= all (select count(*) from visit vi group by vi.zoo_id)
)

select * from ZoosWithTheSmallestNumberOfVisits

-- alternatively
create or alter view SmallestVisitsZoos
as
select ranked_visits.zoo_id
from 
(
    select zoo_id, row_number() over (order by count(*) asc) as visit_rank
    from visit
    group by zoo_id
) ranked_visits
where visit_rank = 1;

select * from SmallestVisitsZoos

-- 4

create function VisitorsWhoWentToZoosWithAtLeastNAnimals(@N int)
returns table
as
return
(
	select distinct v.id
	from visitor v inner join visit vi on v.id = vi.visitor_id inner join zoo z on vi.zoo_id = z.id
	where z.id in 
	(
		select a.zoo_id
		from animal a
		group by a.zoo_id
		having count(*) >= @N
	)
)

select * from VisitorsWhoWentToZoosWithAtLeastNAnimals(0)
select * from VisitorsWhoWentToZoosWithAtLeastNAnimals(1)
select * from VisitorsWhoWentToZoosWithAtLeastNAnimals(2)
select * from VisitorsWhoWentToZoosWithAtLeastNAnimals(3)



