use rugby

-- 1

create table city
(
	id int primary key identity(1, 1),
	name varchar(32) unique
);

create table stadium
(
	id int primary key identity(1, 1),
	name varchar(32), 
	id_city int foreign key references city(id)
);

create table team
(
	id int primary key identity(1, 1),
	country varchar(32) unique
);

create table player 
(
	id int primary key identity(1, 1),
	name varchar(32),
	birthday date,
	nationality varchar(32),
	position_ varchar(32),
	flag bit,
	team_id int foreign key references team(id)
);

create table coach
(
	id int primary key identity(1, 1),
	name varchar(32), 
	nationality varchar(32),
	team_id int foreign key references team(id)
);

create table game
(
	id int primary key identity(1, 1),
	playing_date date, 
	team1_id int foreign key references team(id),
	team2_id int foreign key references team(id),
	stadium_id int foreign key references stadium(id),
	final_score varchar(32),
	winner int foreign key references team(id),
	flag bit
);

select * from city
select * from stadium
select * from team
select * from player
select * from coach
select * from game

insert into city(name) values ('city1'), ('city2')
insert into team(country) values ('team1'), ('team2'), ('team3')
insert into stadium(name, id_city) values ('stadium1', 1), ('stadium2', 2)


-- 2

create or alter procedure AddOrUpdateGame @playing_date date, @team1_name varchar(32), @team2_name varchar(32), @stadium_name varchar(32), @final_score varchar(32), @winner varchar(32), @flag bit 
as 
begin
	declare @team1_id int = (select id from team where country = @team1_name),
			@team2_id int = (select id from team where country = @team2_name),
			@stadium_id int = (select id from stadium where name = @stadium_name),
			@winner_id int = (select id from team where country = @winner)
			
	if @team1_id is null
	begin
		raiserror('team %s does not exist', 16, 1, @team1_name)
		return
	end
	
	if @team2_id is null
	begin
		raiserror('team %s does not exist', 16, 1, @team2_name)
		return
	end
	
	if @stadium_id is null
	begin
		raiserror('stadium %s does not exist', 16, 1, @stadium_name)
		return
	end
	
	if @winner_id is null
	begin
		raiserror('team %s does not exist', 16, 1, @winner)
		return
	end
	
	if exists (select * from game where (team1_id = @team1_id and team2_id = @team2_id) or (team1_id = @team2_id and team2_id = @team1_id))
		update game
		set final_score = @final_score
		where (team1_id = @team1_id and team2_id = @team2_id) or (team1_id = @team2_id and team2_id = @team1_id)
	else
		insert into game(playing_date, team1_id, team2_id, stadium_id, final_score, winner, flag)
		values (@playing_date, @team1_id, @team2_id, @stadium_id, @final_score, @winner_id, @flag)
		
end


execute AddOrUpdateGame '2000-01-01', 'team1', 'team2', 'stadium1', '2-0', 'team1', 1
execute AddOrUpdateGame '2000-01-01', 'team2', 'team3', 'stadium2', '2-0', 'team3', 0
execute AddOrUpdateGame '2000-01-01', 'team1', 'team2', 'stadium1', '3-1', 'team1', 1

-- 3

create or alter view StadiumsWithAllGamesInOvertime
as
select s.name
from stadium s
where not exists 
(
	select stadium_id from game g where g.stadium_id = s.id
	except
	select stadium_id from game g where g.stadium_id = s.id and g.flag = 1
)

select * from StadiumsWithAllGamesInOvertime

-- 4

create function WinningWithDifferenceOnSpecificStadium (@S int, @R int)
returns table
as
return 
(
	select count(*) 
	from 
	(
		select distinct t.name
		from team t inner join game g on g.team1_id = t.id or g.team2_id = t.id inner join stadium s on g.stadium_id = s.id
		where s.id = @S and cast(substring(g.final_score, 1, 1) as INTEGER) - cast(substring(g.final_score, 1, 3) as INTEGER) > @R
	)
)



