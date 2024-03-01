-- create a database to manage train schedules. the database will store data about routes of all the trains.
-- the entitites of interest to the problem domain are: trains, train_types, stations and routes.
-- each train has a name and belongs to a type.
-- the train type has only a description.
-- each station has a name. station names are unique.
-- each route has a name, an associated train and a list of stations with arrival and departure times in each station. route names are unique.
-- the arrival and departure times are represented as hour:minute pairs, e.g., train arrives at 5pm and leaves at 5:10pm.

-- 1. write a sql script that creates the corresponding relational data model. (4p)
-- 2. implement a stored procedure that receives a route, a station, arrival and departure times, and adds the station to the route. if the station is already on the route, the arrival and departure times are updated. (1p)
-- 3. create a view that shows the names of the routes that pass through all the stations. (2p)
-- 4. implement a function that lists the names of the stations with more than R routes, where R >= 1 is a function parameter.

use train_schedules

-- 1

create table train_type
(
	id int primary key identity(1, 1),
	description varchar(128) not null
);

create table train 
(
	id int primary key identity(1, 1),
	name varchar(32) not null,
	train_type_id int foreign key references train_type(id)
);

create table station
(
	id int primary key identity(1, 1),
	name varchar(32) not null unique
);

create table route
(
	id int primary key identity(1, 1),
	name varchar(32) not null unique,
	train_id int foreign key references train(id)
);

create table route_station 
(
	route_id int foreign key references route(id),
	station_id int foreign key references station(id),
	arrival_time varchar(8) not null,
	departure_time varchar(8) not null,
	primary key (route_id, station_id)
);

drop table route_station;
drop table route;
drop table station;
drop table train;
drop table train_type;

insert into train_type(description) values ('type1'), ('type2'), ('type3');
insert into train(name, train_type_id) values ('train1', 1), ('train2', 1), ('train3', 2);
insert into station(name) values ('station1'), ('station2'), ('station3');
insert into route(name, train_id) values ('route1', 1), ('route2', 3);
insert into route_station(route_id, station_id, arrival_time, departure_time) values (1, 1, '5pm', '5:10pm'), (1, 2, '5:20pm', '5:30pm'), (2, 1, '3:40pm', '4pm');

select * from train_type
select * from train
select * from station
select * from route
select * from route_station

-- 2

create or alter procedure AddStationToRoute @station_name varchar(32), @route_name varchar(32), @arrival_time varchar(8), @departure_time varchar(8)
as 
begin
	declare @route_id int = (select id from route where name = @route_name),
			@station_id int = (select id from station where name = @station_name)
			
	if @route_id is null
	begin
		raiserror('route %s does not exist', 16, 1, @route_name)
		return
	end
	
	if @station_id is null
	begin
		raiserror('station %s does not exist', 16, 1, @station_name)
		return
	end
	
	if exists (select * from route_station where route_id = @route_id and station_id = @station_id)
		update route_station
		set arrival_time = @arrival_time, departure_time = @departure_time
		where route_id = @route_id and station_id = @station_id
	else
		insert route_station(route_id, station_id, arrival_time, departure_time)
		values (@route_id, @station_id, @arrival_time, @departure_time)
		
end

exec AddStationToRoute 'station2', 'route2', '4:20pm', '4:40pm';
exec AddStationToRoute 'station1', 'route2', '5:30pm', '5:40pm';

-- 3

create or alter view RoutesWithAllStations
as 
select r.name
from route r
where not exists 
(
	select id from station
	except
	select station_id from route_station rs where rs.route_id = r.id
)

select * from RoutesWithAllStations

-- 4

create function FilterStationsByNumberOfRoutes (@routes int)
returns table
as 
return
(
	select s.name
	from station s
	where s.id in
	(
		select rs.station_id
		from route_station rs
		group by rs.station_id
		having count(*) > @routes
	)
)

select * from FilterStationsByNumberOfRoutes(1)
select * from FilterStationsByNumberOfRoutes(2)













