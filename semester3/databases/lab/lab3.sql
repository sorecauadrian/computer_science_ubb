use dont_starve_together

-- write SQL scripts that:
-- a. modify the type of a column;
-- b. add / remove a column;
-- c. add / remove a DEFAULT constraint;
-- d. add / remove a primary key;
-- e. add / remove a candidate key;
-- f. add / remove a foreign key;
-- g. create / drop a table.

/*
-- a. modify the type of a column;
create procedure setPerishTimeFromFoodSmallInt as
	alter table Food alter column perish_time smallint
	
create procedure setPerishTimeFromFoodInt as
	alter table Food alter column perish_time int
	
	
-- b. add / remove a column;
create procedure addOriginToPlayer as
	alter table Player add column origin varchar(256)
	
create procedure removeOriginFromPlayer as
	alter table Player drop column origin
	

-- c. add / remove a DEFAULT constraint;
create procedure addDefaultToHealthFromMob as
	alter table Mob add constraint DEFAULT0 default(0) for health
	
create procedure removeDefaultFromHealthFromMob as
	alter table Mob drop constraint DEFAULT0
	
	
-- d. add / remove a primary key;
create procedure addPrimaryKeyToDroppedBy as
	alter table DroppedBy add constraint FERTILIZER_MOB_PRIMARY_KEY primary key (fertilizer_id, mob_id)
	
create procedure removePrimaryKeyToDroppedBy as
	alter table DroppedBy drop constraint FERTILIZER_MOB_PRIMARY_KEY


-- e. add / remove a candidate key;
create procedure addCandidateKeyToPlayerFavouriteFood as
	alter table PlayerFavouriteFood add constraint PLAYER_FAVOURITE_FOOD_CANDIDATE_KEY unique (player_id, food_id)
	
create procedure removeCandidateKeyFromPlayerFavouriteFood as
	alter table PlayerFavouriteFood drop constraint PLAYER_FAVOURITE_FOOD_CANDIDATE_KEY
	
	
-- f. add / remove a foreign key;
create procedure addForeignKeyToSpawningObject as
	alter table SpawningObject add constraint SPAWNING_OBJECT_FOREIGN_KEY foreign key(mob_id) references Mob(id)
	
create procedure removeForeignKeyFromSpawningObject as
	alter table SpawningObject drop constraint SPAWNING_OBJECT_FOREIGN_KEY
	
	
-- g. create / drop a table.
create procedure createTableSpawningObject as
	create table SpawningObject
	(
		name varchar(32) not null,
		common_biome_name varchar(32) not null,
		renewable bit not null,
		
		constraint SPAWNING_OBJECT_PRIMARY_KEY primary key(name)
	)
	
create procedure dropTableSpawningObject as
	drop table SpawningObject
*/



-- a. modify the type of a column
create or alter procedure modifyColumnType
@tableName nvarchar(16),
@columnName nvarchar(16),
@newType nvarchar(16)
as
begin 
	declare @modifyColumnTypeVariable nvarchar(max)
	set @modifyColumnTypeVariable = 'alter table ' + quotename(@tableName) + ' alter column ' + quotename(@columnName) + ' ' + @newType
	execute sp_executesql @modifyColumnTypeVariable
end



-- b. add / remove a column
create or alter procedure addColumn
@tableName nvarchar(16),
@newColumn nvarchar(16),
@type nvarchar(16)
as
begin
	declare @addColumnVariable nvarchar(max)
	set @addColumnVariable = 'alter table ' + quotename(@tableName) + ' add ' +  quotename(@newColumn) + ' ' + @type
	execute sp_executesql @addColumnVariable
end

create or alter procedure removeColumn
@tableName nvarchar(16),
@columnName nvarchar(16)
as
begin
	declare @removeColumnVariable nvarchar(max)
	set @removeColumnVariable = 'alter table ' + quotename(@tableName) + ' drop column ' + quotename(@columnName)
	execute sp_executesql @removeColumnVariable
end
	
	

-- c. add / remove a DEFAULT constraint
create or alter procedure addDefaultConstraint
@tableName nvarchar(16),
@columnName nvarchar(16),
@defaultValue nvarchar(16)
as
begin
	declare @addDefaultConstraintVariable nvarchar(max)
	set @addDefaultConstraintVariable = 'alter table ' + quotename(@tableName) + ' add constraint DF_' + @tableName + '_' + @columnName + ' default ' + @defaultValue + ' for ' + quotename(@columnName)
	execute sp_executesql @addDefaultConstraintVariable
end

create or alter procedure removeDefaultConstraint
@tableName nvarchar(16),
@columnName nvarchar(16)
as
begin 
	declare @removeDefaultConstraintVariable nvarchar(max)
	set @removeDefaultConstraintVariable = 'alter table ' + quotename(@tableName) + ' drop constraint DF_' + @tableName + '_' + @columnName
	execute sp_executesql @removeDefaultConstraintVariable
end
	
	

-- d. add / remove a primary key
create or alter procedure addPrimaryKey
@tableName nvarchar(16),
@columnName nvarchar(16)
as
begin
	declare @addPrimaryKeyVariable nvarchar(max)
	set @addPrimaryKeyVariable = 'alter table ' + quotename(@tableName) + ' add constraint PK_' + @tableName + 'primary key (' + quotename(@columnName) + ')'
	execute sp_executesql @addPrimaryKeyVariable
end

create or alter procedure removePrimaryKey
	@tableName nvarchar(16)
as 
begin
	declare @removePrimaryKeyVariable nvarchar(max)
	set @removePrimaryKeyVariable = 'alter table' + quotename(@tableName) + ' drop constraint PK_' + @tableName	
	execute sp_executesql @removePrimaryKeyVariable
end
	
	

-- e. add / remove a candidate key
create or alter procedure addCandidateKey
@tableName nvarchar(16),
@columnName nvarchar(16)
as 
begin
	declare @addCandidateKeyVariable nvarchar(max)
	set @addCandidateKeyVariable = 'alter table ' + quotename(@tableName) + ' add constraint UQ_' + @tableName + ' unique (' + quotename(@columnName) + ')'
	execute sp_executesql @addCandidateKeyVariable
end

create or alter procedure removeCandidateKey
@tableName nvarchar(16)
as
begin
	declare @removeCandidateKeyVariable nvarchar(max)
	set @removeCandidateKeyVariable = 'alter table ' + quotename(@tableName) + 'drop constraint UQ_' + @tableName
	execute sp_executesql @removeCandidateKeyVariable
end
	
	

-- f. add / remove a foreign key
create or alter procedure addForeignKey
@tableName nvarchar(16),
@columnName nvarchar(16),
@tableOfForeignKey nvarchar(16),
@columnOfForeignKey nvarchar(16)
as
begin
	declare @addForeignKeyVariable nvarchar(max)
	set @addForeignKeyVariable = 'alter table ' + quotename(@tableName) + ' add constraint FK_' + @tableName + '_' + @tableOfForeignKey + ' foreign key (' + quotename(@columnName) + ') references' + quotename(@tableOfForeignKey) + '(' + quotename(@columnOfForeignKey) + ')'
	execute sp_executesql @addForeignKeyVariable
end

create or alter procedure removeForeignKey
@tableName nvarchar(16),
@tableOfForeignKey nvarchar(16)
as
begin
	declare @removeForeignKeyVariable nvarchar(max)
	set @removeForeignKeyVariable = 'alter table ' + quotename(@tableName) + ' drop constraint FK_' + @tableName + '_' + @tableOfForeignKey
	execute sp_executesql @removeForeignKeyVariable
end



-- g. create / drop a table
create or alter procedure createTable
@tableName nvarchar(16),
@columnName nvarchar(16),
@type nvarchar(16)
as
begin
	declare @createTableVariable nvarchar(max)
	set @createTableVariable = 'create table ' + quotename(@tableName) + '(' + quotename(@columnName) + ' ' + quotename(@type) + ')'
	execute sp_executesql @createTableVariable
end

create or alter procedure dropTable
@tableName nvarchar(16)
as
begin
	declare @dropTableVariable nvarchar(max)
	set @dropTableVariable = 'drop table ' + quotename(@tableName)
	execute sp_executesql @dropTableVariable
end
	
	
execute createTable @tableName = 'SpawningObject', @columnName = 'id',  @type = int
execute addColumn @tableName = 'SpawningObject', @columnName =  'name', @type = varchar(32)
execute addPrimaryKey @tableName = 'SpawningObject', @columnName = 'id'
	
create table versionTable (version int)
insert into versionTable values (0) -- initial version

create table procedureTable (version int, normalProcedureName varchar(max), reverseProcedureName varchar(max))
insert into procedureTable values
(1, 'createTable @tableName = ' + 'SpawningObject' + ', ' + '@columnName = ' + 'id' + ', ' + '@type = ' + 'int', 
	'dropTable @tableName = ' + 'SpawningObject'),
(2, 'addColumn @tableName = ' + 'SpawningObject' + ', ' + '@columnName = ' + 'name' + ', ' + '@type = ' + 'varchar(32)',
	'removeColumn @tableName = ' + 'SpawningObject' + ', ' + '@columnName = ' + 'name'),
(3, 'addPrimaryKey @tableName = ' + 'SpawningObject' + ', ' + '@columnName = ' + 'id', 
	'removePrimaryKey @tableName = ' + 'SpawningObject'),
(4, 'addCandidateKey @tableName = ' + 'SpawningObject' + ', ' + '@columnName = ' + 'name',
	'removeCandidateKey @tableName = ' + 'SpawningObject'),
(5, 'addForeignKey @tableName = ' + 'SpawningObject' + ', ' + '@columnName = ' + 'mob_id' + ', ' + '@tableOfForeignKey = ' + 'Mob' + ', ' + '@columnOfForeignTable = ' + 'id',
	'removeForeignKey @tableName = ' + 'SpawningObject' + ', ' + '@tableOfForeignKey = ' + 'Mob'),
(6, 'addDefaultConstraint @tableName = ' + 'SpawningObject' + ', ' + '@columnName = ' + 'mob_id' + ', ' + '@defaultValue = ' + 'null',
	'removeDefaultConstraint @tableName = ' + 'SpawningObject' + ', ' + '@columnName = ' + 'mob_id'),
(7, 'modifyColumn @tableName = ' + 'SpawningObject' + ', ' + '@columnName = ' + 'name' + ', ' + '@newType = ' + 'varchar(64)',
	'modifyColumn @tableName = ' + 'SpawningObject' + ', ' + '@columnName = ' + 'name' + ', ' + '@newType = ' + 'varchar(32)')

create or alter procedure goToVersion
@newVersion int
as
begin
	declare @currentVersion int
	select @currentVersion = (select version from versionTable)
	
	if @newVersion < 0 or @newVersion > (select max(version) from procedureTable)
	begin
		raiserror('there is no such version', 10, 1)
		return
	end
	
	declare @procedureToExecute varchar(max)
	if (@newVersion > @currentVersion)
		while (@newVersion > @currentVersion)
		begin
			set @currentVersion = @currentVersion + 1
			set @procedureToExecute = (select normalProcedureName from procedureTable where version = @currentVersion)
			execute(@procedureToExecute)
		end
	else if (@newVersion < @currentVersion)
		while (@newVersion < @currentVersion)
		begin
			set @procedureToExecute = (select reverseProcedureName from procedureTable where version = @currentVersion)
			set @currentVersion = @currentVersion - 1
			execute(@procedureToExecute)
		end
	
		update versionTable
		set version = @currentVersion	
end
	


select * from versionTable
select * from procedureTable

exec goToVersion 3

select * from versionTable
select * from SpawningObject

