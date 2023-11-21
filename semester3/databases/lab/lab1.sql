use dont_starve_together

CREATE TABLE Food 
(
	id INT IDENTITY(1, 1) PRIMARY KEY,
	name VARCHAR(32) NOT NULL UNIQUE,
	health FLOAT NOT NULL,
	hunger FLOAT NOT NULL,
	sanity FLOAT NOT NULL,
	perish_time INT
);

CREATE TABLE Player 
(
	id INT IDENTITY(1, 1) PRIMARY KEY,
	name VARCHAR(16) NOT NULL UNIQUE check (substring(name, 1, 1) = 'w' or name = 'maxwell'),
	gender CHAR NOT NULL check (gender IN ('m', 'f', 'r')),
	title VARCHAR(32) NOT NULL UNIQUE,
	birthday_month INT check (birthday_month >= 1 and birthday_month <= 12),
	birthday_day INT check (birthday_day >= 1 and birthday_day <= 31),
	motto VARCHAR(128) NOT NULL,
	odds_of_survival VARCHAR(4) NOT NULL check (odds_of_survival IN ('slim', 'grim', 'none')),
	health INT NOT NULL check (health >= 0),
	hunger INT NOT NULL check (hunger >= 0),
	sanity INT NOT NULL check (sanity >= 0),
);

CREATE TABLE Season 
(
	id INT IDENTITY(1, 1) PRIMARY KEY,
	name VARCHAR(8) NOT NULL UNIQUE check (name IN ('spring', 'summer', 'autumn', 'winter')),
	days INT NOT NULL check (days > 0)
);

-- 1:n relationship
--
-- a mob can only spawn in (zero or one) season.
-- in a season (many) mobs can be spawn
CREATE TABLE Mob 
(
	id INT IDENTITY(1, 1) PRIMARY KEY,
	name VARCHAR(32) NOT NULL UNIQUE,
	mob_type CHAR NOT NULL check (mob_type IN ('h', 'n', 'p')), -- h - hostile, n - neutral, p - passive
	health INT NOT NULL,
	damage INT,
	walk_speed FLOAT,
	run_speed FLOAT,
	season_id INT FOREIGN KEY references Season(id)
);

CREATE TABLE ItemCategoryName
(
	id INT IDENTITY(1, 1) PRIMARY KEY,
	name VARCHAR(32) NOT NULL UNIQUE
);

-- 1:n relationship
--
-- an item can only be in the starting inventory of (zero or one) player
-- one player can have (zero, one or multiple) starting items
CREATE TABLE Item 
(
	id INT IDENTITY(1, 1) PRIMARY KEY,
	name VARCHAR(32) NOT NULL UNIQUE,
	starting_item_of_player INT FOREIGN KEY references Player(id)
);

CREATE TABLE Fertilizer 
(
	id INT IDENTITY(1, 1) PRIMARY KEY,
	name VARCHAR(32) NOT NULL UNIQUE
);

-- n:m relationship
--
-- a player can have (zero, one or multiple) favourite foods
-- a food can be favourite to (zero, one or multiple) players
CREATE TABLE PlayerFavouriteFood 
(
	player_id INT NOT NULL FOREIGN KEY references Player(id),
	food_id INT NOT NULL FOREIGN KEY references Food(id),
	health_bonus FLOAT NOT NULL check (health_bonus >= 0),
	hunger_bonus FLOAT NOT NULL check (hunger_bonus >= 0),
	sanity_bonus FLOAT NOT NULL check (sanity_bonus >= 0)
);

-- n:m relationship
--
-- an item can belong to (one or many) categories 
-- a category has (multiple) items
CREATE TABLE ItemCategory
(
	item_id INT NOT NULL FOREIGN KEY references Item(id),
	category_id INT NOT NULL FOREIGN KEY references ItemCategoryName(id),
	
	UNIQUE (item_id, category_id)
);

-- n:m relationship
--
-- a player can have relationships with (zero, one or many) mobs
-- a mob can have relationships with (zero, one or many) players.
CREATE TABLE PlayerMobRelationship 
(
	player_id INT NOT NULL FOREIGN KEY references Player(id),
	mob_id INT NOT NULL FOREIGN KEY references Mob(id),
	type_of_relationship VARCHAR(32)
	
	UNIQUE (player_id, mob_id)
);

-- 1:n relationship
--
-- a mob can drop (zero or one) type of fertilizer.
-- a type of fertilizer can be dropped by (zero, one or many) mobs
CREATE TABLE DroppedBy 
(
	fertilizer_id INT NOT NULL FOREIGN KEY references Fertilizer(id),
	mob_id INT NOT NULL UNIQUE FOREIGN KEY references Mob(id),
	method_of_generation VARCHAR(16),
);
