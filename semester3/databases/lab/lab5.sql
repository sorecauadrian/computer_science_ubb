use dont_starve_together

-- dropping the tables if they already exist
if exists (select * from dbo.sysobjects where id = object_id(N'[Event]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [Event]

if exists (select * from dbo.sysobjects where id = object_id(N'[NPC]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [NPC]

if exists (select * from dbo.sysobjects where id = object_id(N'[EventNPC]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [EventNPC]

-- creating the tables
CREATE TABLE Event
(
	id INT PRIMARY KEY,
	name VARCHAR(32) NOT NULL,
	no_of_days INT NOT NULL
);

CREATE TABLE NPC 
(
	id INT PRIMARY KEY,
	name VARCHAR(32) NOT NULL,
	no_of_tasks INT
);

CREATE TABLE EventNPC
(
	id INT PRIMARY KEY,
	event_id INT FOREIGN KEY REFERENCES Event(id),
	npc_id INT FOREIGN KEY REFERENCES NPC(id)
);

-- now we got tables 

-- Ta(aid, a2, ...) => Event
-- Tb(bid, b2, ...) => NPC
-- Tc(cid, aid, bid, ...) => EventNPC

-- procedures to generate and insert data into Event, NPC and EventNPC
CREATE OR ALTER PROCEDURE insertIntoEvent(@rows INT) AS 
	WHILE @rows > 0 
	BEGIN
		INSERT INTO Event VALUES (@rows, 'test', @rows)
		SET @rows = @rows - 1
	END
	
CREATE OR ALTER PROCEDURE insertIntoNPC(@rows INT) AS 
	WHILE @rows > 0 
	BEGIN
		INSERT INTO NPC VALUES (@rows, 'test', @rows)
		SET @rows = @rows - 1
	END
	
CREATE OR ALTER PROCEDURE insertIntoEventNPC(@rows INT) AS 
	DECLARE @event_id INT
	DECLARE @npc_id INT
	WHILE @rows > 0 
	BEGIN
		SET @event_id = (SELECT TOP 1 id FROM Event ORDER BY NEWID())
		SET @npc_id = (SELECT TOP 1 id FROM NPC ORDER BY NEWID())
		INSERT INTO EventNPC VALUES (@rows, @event_id, @npc_id)
		SET @rows = @rows - 1
	END
	
-- inserting data
EXEC insertIntoEvent 1000 -- 43 seconds
EXEC insertIntoNPC 1000 -- 44 seconds
EXEC insertIntoEventNPC 100 -- 5 seconds


-- a. write queries on Event such that their execution plans contain the following operators:
-- - clustered index scan
-- - clustered index seek
-- - nonclustered index scan
-- - nonclustered index seek
-- - key lookup

-- CREATE NONCLUSTERED INDEX days_index ON Event(no_of_days)
ALTER TABLE Event ADD CONSTRAINT unique_no_of_days UNIQUE (no_of_days)

SELECT * FROM Event -- clustered index scan
SELECT * FROM Event WHERE id < 100 -- clustered index seek
SELECT no_of_days FROM Event ORDER BY no_of_days -- nonclustered index scan
SELECT no_of_days FROM Event WHERE no_of_days < 100 -- nonclustered index seek
SELECT name, no_of_days FROM Event WHERE no_of_days < 100 -- key lookup

-- DROP INDEX days_index ON Event
ALTER TABLE Event DROP CONSTRAINT unique_no_of_days

-- b. write a query on table NPC with a WHERE clause of the form WHERE no_of_tasks = value and analyze its execution plan.
-- create a nonclustered index that can speed up the query. examine the execution plan again.

SELECT * FROM NPC WHERE no_of_tasks = 1 -- clustered index scan 0.501 seconds
CREATE NONCLUSTERED INDEX tasks_index ON NPC(no_of_tasks)
SELECT * FROM NPC WHERE no_of_tasks = 1 -- nonclustered index scan 0.014 seconds

-- dropping the index for retrying the experiment
DROP INDEX tasks_index ON NPC

-- c. create a view that joins at least 2 tables. 
-- check whether existing indexes are helpful; if not, reassess existing indexes / examine the cardinality of the tables.

CREATE OR ALTER VIEW viewEventNPC AS
	SELECT TOP 1000 e.no_of_days, NPC.no_of_tasks
	FROM EventNPC enpc INNER JOIN Event e ON e.id = enpc.event_id INNER JOIN NPC npc ON npc.id = enpc.npc_id
	WHERE e.no_of_days < 3000 AND npc.no_of_tasks > 300
	
SELECT * FROM viewEventNPC
-- 0.309 seconds without indexes
-- 0.021 seconds with indexes


	
	
	
	
	
	