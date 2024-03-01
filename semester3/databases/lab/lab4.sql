use dont_starve_together

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
	ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_Tables

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
	ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tables

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
	ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_TestRuns

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
	ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_TestRuns

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
	ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tests

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
	ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Tests

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
	ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_Views

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
	ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Views

if exists (select * from dbo.sysobjects where id = object_id(N'[Tables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [Tables]

if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [TestRunTables]

if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [TestRunViews]

if exists (select * from dbo.sysobjects where id = object_id(N'[TestRuns]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [TestRuns]

if exists (select * from dbo.sysobjects where id = object_id(N'[TestTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [TestTables]

if exists (select * from dbo.sysobjects where id = object_id(N'[TestViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [TestViews]

if exists (select * from dbo.sysobjects where id = object_id(N'[Tests]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [Tests]

if exists (select * from dbo.sysobjects where id = object_id(N'[Views]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [Views]

CREATE TABLE [Tables] 
(
	[TableID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]

CREATE TABLE [TestRunTables] 
(
	[TestRunID] [int] NOT NULL ,
	[TableID] [int] NOT NULL ,
	[StartAt] [datetime] NOT NULL ,
	[EndAt] [datetime] NOT NULL 
) ON [PRIMARY]

CREATE TABLE [TestRunViews] 
(
	[TestRunID] [int] NOT NULL ,
	[ViewID] [int] NOT NULL ,
	[StartAt] [datetime] NOT NULL ,
	[EndAt] [datetime] NOT NULL 
) ON [PRIMARY]

CREATE TABLE [TestRuns] 
(
	[TestRunID] [int] IDENTITY (1, 1) NOT NULL ,
	[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StartAt] [datetime] NULL ,
	[EndAt] [datetime] NULL 
) ON [PRIMARY]

CREATE TABLE [TestTables] 
(
	[TestID] [int] NOT NULL ,
	[TableID] [int] NOT NULL ,
	[NoOfRows] [int] NOT NULL ,
	[Position] [int] NOT NULL 
) ON [PRIMARY]

CREATE TABLE [TestViews] 
(
	[TestID] [int] NOT NULL ,
	[ViewID] [int] NOT NULL 
) ON [PRIMARY]

CREATE TABLE [Tests] 
(
	[TestID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]

CREATE TABLE [Views] 
(
	[ViewID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]

ALTER TABLE [Tables] WITH NOCHECK ADD CONSTRAINT [PK_Tables] PRIMARY KEY  CLUSTERED ([TableID])  ON [PRIMARY] 

ALTER TABLE [TestRunTables] WITH NOCHECK ADD CONSTRAINT [PK_TestRunTables] PRIMARY KEY  CLUSTERED ([TestRunID], [TableID])  ON [PRIMARY] 

ALTER TABLE [TestRunViews] WITH NOCHECK ADD CONSTRAINT [PK_TestRunViews] PRIMARY KEY  CLUSTERED ([TestRunID], [ViewID])  ON [PRIMARY] 

ALTER TABLE [TestRuns] WITH NOCHECK ADD CONSTRAINT [PK_TestRuns] PRIMARY KEY  CLUSTERED ([TestRunID])  ON [PRIMARY] 

ALTER TABLE [TestTables] WITH NOCHECK ADD CONSTRAINT [PK_TestTables] PRIMARY KEY  CLUSTERED ([TestID], [TableID])  ON [PRIMARY] 

ALTER TABLE [TestViews] WITH NOCHECK ADD CONSTRAINT [PK_TestViews] PRIMARY KEY  CLUSTERED ([TestID], [ViewID])  ON [PRIMARY] 

ALTER TABLE [Tests] WITH NOCHECK ADD CONSTRAINT [PK_Tests] PRIMARY KEY  CLUSTERED ([TestID])  ON [PRIMARY] 

ALTER TABLE [Views] WITH NOCHECK ADD CONSTRAINT [PK_Views] PRIMARY KEY  CLUSTERED ([ViewID])  ON [PRIMARY] 

ALTER TABLE [TestRunTables] ADD CONSTRAINT [FK_TestRunTables_Tables] FOREIGN KEY ([TableID]) REFERENCES [Tables] ([TableID]) ON DELETE CASCADE  ON UPDATE CASCADE,
								CONSTRAINT [FK_TestRunTables_TestRuns] FOREIGN KEY ([TestRunID]) REFERENCES [TestRuns] ([TestRunID]) ON DELETE CASCADE  ON UPDATE CASCADE 

ALTER TABLE [TestRunViews] ADD CONSTRAINT [FK_TestRunViews_TestRuns] FOREIGN KEY ([TestRunID]) REFERENCES [TestRuns] ([TestRunID]) ON DELETE CASCADE  ON UPDATE CASCADE ,
								CONSTRAINT [FK_TestRunViews_Views] FOREIGN KEY ([ViewID]) REFERENCES [Views] ([ViewID]) ON DELETE CASCADE  ON UPDATE CASCADE 

ALTER TABLE [TestTables] ADD CONSTRAINT [FK_TestTables_Tables] FOREIGN KEY ([TableID]) REFERENCES [Tables] ([TableID]) ON DELETE CASCADE  ON UPDATE CASCADE ,
							CONSTRAINT [FK_TestTables_Tests] FOREIGN KEY ([TestID]) REFERENCES [Tests] ([TestID]) ON DELETE CASCADE  ON UPDATE CASCADE 

ALTER TABLE [TestViews] ADD CONSTRAINT [FK_TestViews_Tests] FOREIGN KEY ([TestID]) REFERENCES [Tests] ([TestID]),
							CONSTRAINT [FK_TestViews_Views] FOREIGN KEY ([ViewID]) REFERENCES [Views] ([ViewID])

-- lab4 --

-- Tables
CREATE PROCEDURE addToTables (@tableName VARCHAR(255)) AS
	IF @tableName NOT IN (SELECT TABLE_NAME  FROM INFORMATION_SCHEMA.TABLES) BEGIN
		PRINT 'table doesnt exist'
		RETURN 
	END
	IF @tableName IN (SELECT Name FROM Tables) BEGIN
		PRINT 'table already in Tables'
		RETURN 
	END
	
	INSERT INTO Tables(Name) Values (@tableName);


-- Views
CREATE PROCEDURE addToViews(@viewName VARCHAR(255)) AS 
	IF @viewName NOT IN (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS) BEGIN
		PRINT 'view doesnt exist'
		RETURN 
	END
	IF @viewName IN (SELECT Name FROM Views) BEGIN
		PRINT 'view already in Views'
		RETURN 
	END
	
	INSERT INTO Views(Name) Values (@viewName);


-- Tests
CREATE PROCEDURE addToTests(@testName VARCHAR(255)) AS 
	IF @testName IN (SELECT Name FROM Tests) BEGIN
		PRINT 'test already in Tests'
		RETURN 
	END
	
	INSERT INTO Tests(Name) Values (@testName);


-- TestTables
CREATE PROCEDURE connectTableToTest(@tableName VARCHAR(255), @testName VARCHAR(255), @rows INT, @pos INT) AS
	IF @tableName NOT IN (SELECT Name FROM Tables) BEGIN
		PRINT 'table not in Tables'
		RETURN 
	END
	IF @testName NOT IN (SELECT Name FROM Tests) BEGIN
		PRINT 'test not in Tests'
		RETURN 
	END 
	
	DECLARE @tableId int
	DECLARE @testId int
	SET @tableId = (SELECT TableID FROM Tables WHERE Name=@tableName)
	SET @testId = (SELECT TestID FROM Tests WHERE Name=@testName)
	IF EXISTS(SELECT * FROM TestTables WHERE TestId=@testId AND TableId=@tableId) BEGIN 
		PRINT 'TestTable connection already exists'
	END
	
	INSERT INTO TestTables VALUES(@testId, @tableId, @rows, @pos);
	

-- TestViews
CREATE PROCEDURE connectViewToTest(@viewName VARCHAR(255), @testName VARCHAR(255)) AS
	IF @viewName NOT IN (SELECT Name FROM Views) BEGIN
		PRINT 'view not in Views'
		RETURN 
	END
	IF @testName NOT IN (SELECT Name FROM Tests) BEGIN
		PRINT 'test not in Tests'
		RETURN 
	END 
	
	DECLARE @viewId int
	DECLARE @testId int
	SET @viewId = (SELECT ViewID FROM Views WHERE Name=@viewName)
	SET @testId = (SELECT TestID FROM Tests WHERE Name=@testName)
	IF EXISTS(SELECT * FROM TestViews WHERE TestId=@testId AND ViewID=@viewId) BEGIN 
		PRINT 'TestView connection already exists'
	END
	
	INSERT INTO TestViews  VALUES(@testId, @viewId);
	

-- TestRun
CREATE PROCEDURE runTest(@testName VARCHAR(255), @description VARCHAR(255)) AS
	IF @testName NOT IN (SELECT Name FROM TESTS) BEGIN
		PRINT 'test not in Tests'
		RETURN
	END
	
	DECLARE @testStartTime DATETIME2
	DECLARE @testRunId INT
	DECLARE @tableId INT
	DECLARE @table VARCHAR(255)
	DECLARE @rows INT
	DECLARE @pos INT
	DECLARE @command VARCHAR(255)
	DECLARE @tableInsertStartTime DATETIME2
	DECLARE @tableInsertEndTime DATETIME2
	DECLARE @testId INT
	DECLARE @view VARCHAR(255)
	DECLARE @viewId INT
	DECLARE @viewStartTime DATETIME2
	DECLARE @viewEndTime DATETIME2
	
	SET @testId = (SELECT TestId FROM Tests T WHERE T.Name = @testName)
	
	DECLARE tableCursor CURSOR SCROLL FOR 
		SELECT T1.Name, T1.TableId, T2.NoOfRows, T2.Position
		FROM Tables T1 INNER JOIN TestTables T2 ON T1.TableID = T2.TableID
		WHERE T2.TestID = @testId
		ORDER BY T2.Position ASC
	
	DECLARE viewCursor CURSOR SCROLL FOR 
		SELECT V.Name, V.ViewId
		FROM Views V INNER JOIN TestViews TV ON V.ViewID = TV.ViewID 
		WHERE TV.TestID = @testId
	
	
	SET @testStartTime = sysdatetime()
	
	INSERT INTO TestRuns(Description, StartAt, EndAt) VALUES(@description, @testStartTime, @testStartTime)
	SET @testRunId = SCOPE_IDENTITY()
	
	-- deleting the records
	OPEN tableCursor
	FETCH FIRST FROM tableCursor INTO @table, @tableId, @rows, @pos
	
	WHILE @@FETCH_STATUS = 0 BEGIN
		EXEC ('DELETE FROM ' + @table)
		FETCH tableCursor INTO @table, @tableId, @rows, @pos
	END
	
	-- inserting the records
	FETCH LAST FROM tableCursor INTO @table, @tableId, @rows, @pos

	WHILE @@FETCH_STATUS = 0 BEGIN
		SET @command = 'populateTable' + @table
		IF @rows > 0 AND @command NOT IN (SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES) BEGIN
			PRINT @command + 'does not exist'
			RETURN
		END
		SET @tableInsertStartTime = sysdatetime()
		IF @rows > 0 BEGIN
			EXEC @command @rows
		END
		SET @tableInsertEndTime = sysdatetime()
		INSERT INTO TestRunTables VALUES(@testRunId, @tableId, @tableInsertStartTime, @tableInsertEndTime)
		FETCH PRIOR FROM tableCursor INTO @table, @tableId, @rows, @pos
	END
	CLOSE tableCursor
	DEALLOCATE tableCursor 
	
	-- views
	OPEN viewCursor
	FETCH viewCursor INTO @view, @viewId
	
	WHILE @@FETCH_STATUS = 0 BEGIN
		SET @viewStartTime = sysdatetime()
		EXEC ('SELECT * FROM ' + @view)
		SET @viewEndTime = sysdatetime()
		INSERT INTO TestRunViews VALUES(@testRunID, @viewId, @viewStartTime, @viewEndTime)
		FETCH viewCursor INTO @view, @viewId	
	END
	CLOSE viewCursor 
	DEALLOCATE viewCursor
	
	
	UPDATE TestRuns 
	SET EndAt = sysdatetime()
	WHERE TestRunID = @testRunId;

-- restarting the tables
DELETE FROM TestRunTables 
DELETE FROM TestRunViews
DELETE FROM TestRuns
DELETE FROM TestTables 
DELETE FROM TestViews
DELETE FROM Tests 
DELETE FROM Tables 
DELETE FROM Views 

SELECT * FROM TestRuns
SELECT * FROM TestRunTables
SELECT * FROM TestRunViews 

-- test1 -- 

-- a table with a single-column primary key and no foreign keys
CREATE TABLE Biom
(
	name VARCHAR(32) PRIMARY KEY
);
-- droping the table
DROP TABLE Biom 

-- a view with a SELECT statement operating on one table
CREATE VIEW BiomView AS
	SELECT * FROM Biom;


CREATE PROCEDURE populateTableBiom (@rows INT) AS
	WHILE @rows > 0 BEGIN 
		INSERT INTO Biom VALUES('biom_' + CONVERT(VARCHAR(32), @rows))
		SET @rows = @rows - 1
	END;

EXEC addToTables 'Biom';
EXEC addToViews 'BiomView';
EXEC addToTests 'BiomTest';
EXEC connectTableToTest 'Biom', 'BiomTest', 1000, 0;
EXEC connectViewToTest 'BiomView', 'BiomTest';

EXEC runTest 'BiomTest', 'test1';


-- test2 --

-- a table with a single-column primary key and at least one foreign key
CREATE TABLE Event
(
	name VARCHAR(32) PRIMARY KEY
);

CREATE TABLE NPC
(
	name VARCHAR(32) PRIMARY KEY,
	event_name VARCHAR(32) FOREIGN KEY REFERENCES Event(name)
);

DROP TABLE Event
DROP TABLE NPC

CREATE VIEW NPCEventView AS
	SELECT npc.name AS npc_name, event.name AS event_name
	FROM NPC npc LEFT OUTER JOIN Event event ON npc.event_name = event.name;

CREATE PROCEDURE populateTableEvent (@rows INT) AS
	WHILE @rows > 0 BEGIN 
		INSERT INTO Event VALUES('event_' + CONVERT(VARCHAR(32), @rows))
		SET @rows = @rows - 1
	END;

CREATE PROCEDURE populateTableNPC (@rows INT) AS
	DECLARE @eventName VARCHAR(32)
	SET @eventName = (SELECT TOP 1 name FROM Event)
	WHILE @rows > 0 BEGIN 
		INSERT INTO NPC VALUES('npc_' + CONVERT(VARCHAR(32), @rows), @eventName)
		SET @rows = @rows - 1
	END;

EXEC addToTables 'Event';
EXEC addToTables 'NPC';
EXEC addToViews 'NPCEventView';
EXEC addToTests 'NPCEventTest';
EXEC connectTableToTest 'NPC', 'NPCEventTest', 500, 0;
EXEC connectTableToTest 'Event', 'NPCEventTest', 200, 1;
EXEC connectViewToTest 'NPCEventView', 'NPCEventTest';

EXEC runTest 'NPCEventTest', 'test2'; 

-- test3 -- 

CREATE TABLE Quote 
(
	quote VARCHAR(256) PRIMARY KEY
);

CREATE TABLE MinorCharacter
(
	name VARCHAR(32) PRIMARY KEY
);

CREATE TABLE MinorCharacterQuote
(
	name VARCHAR(256),
	quote VARCHAR(32)
	
	CONSTRAINT PK_minor_character_quote PRIMARY KEY (name, quote)
);

DROP TABLE MinorCharacterQuote
DROP TABLE MinorCharacter
DROP TABLE Quote

CREATE VIEW MinorCharacterQuoteView AS
	SELECT quote.quote, COUNT(*) AS quote_used_count
	FROM MinorCharacter minor_character INNER JOIN MinorCharacterQuote mcq ON minor_character.name = mcq.name INNER JOIN Quote ON quote.quote = mcq.quote
	GROUP BY quote.quote;


CREATE PROCEDURE populateTableMinorCharacterQuote(@rows INT) AS
	DECLARE @minorCharacterRows INT
	DECLARE @quoteRows INT
	SET @minorCharacterRows = SQRT(@rows) + 1
	SET @quoteRows = SQRT(@rows) + 1
	
	WHILE @minorCharacterRows > 0 BEGIN 
		INSERT INTO MinorCharacter VALUES('character_' + CONVERT(VARCHAR(32), @minorCharacterRows))
		SET @minorCharacterRows = @minorCharacterRows - 1
	END;

	WHILE @quoteRows > 0 BEGIN 
		INSERT INTO Quote VALUES('quote_' + CONVERT(VARCHAR(256), @quoteRows))
		SET @quoteRows = @quoteRows - 1
	END;
	
	DECLARE populateCursor CURSOR SCROLL FOR
		SELECT minor_character.name, quote.quote
		FROM MinorCharacter minor_character CROSS JOIN Quote quote
	DECLARE @name VARCHAR(32)
	DECLARE @quote VARCHAR(256)
	
	OPEN populateCursor
	WHILE @rows > 0 BEGIN 
		FETCH FROM populateCursor INTO @name, @quote
		INSERT INTO MinorCharacterQuote VALUES(@name, @quote)
		SET @rows = @rows - 1
	END
	CLOSE populateCursor
	DEALLOCATE populateCursor;
	
EXEC addToTables 'Quote';
EXEC addToTables 'MinorCharacter';
EXEC addToTables 'MinorCharacterQuote';
EXEC addToViews 'MinorCharacterQuoteView';
EXEC addToTests 'MinorCharacterQuoteTest';
EXEC connectTableToTest 'MinorCharacterQuote', 'MinorCharacterQuoteTest', 500, 0;
EXEC connectViewToTest 'MinorCharacterQuoteView', 'MinorCharacterQuoteTest';

EXEC runTest 'MinorCharacterQuoteTest', 'test3';

