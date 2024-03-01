use dont_starve_together

-- statements



-- insert data – for at least 4 tables
-- at least one statement must violate referential integrity constraints


-- food
INSERT INTO Food (name, health, hunger, sanity, perish_time)
VALUES 	('bacon and eggs', 20, 75, 5, 20), 
		('spicy chili', 20, 37.5, 0, 10), 
		('roasted potato', 20, 25, 0, 6), 
		('banana pop', 20, 12.5, 33, 3),
		('butter muffin', 20, 37.5, 5, 15),
		('surf `n` turf', 60, 37.5, 33, 10),
		('honey nuggets', 20, 37.5, 5, 15),
		('fresh fruit crepes', 60, 150, 15, 10),
		('wobster dinner', 60, 37.5, 50, 15),
		('turkey dinner', 20, 75, 5, 6),
		('ice cream', 0, 25, 50, 3),
		('spicy vegetable stinger', 3, 25, 33, 15),
		('pomegranate', 3, 9.375, 0, 6),
		('sliced pomegranate', 20, 12.5, 0, 3),
		('cooked banana', 3, 12.5, 0, 6),
		('durian', -3, 25, -5, 6),
		('extra smelly durian', 0, 25, -5, 6),
		('trail mix', 30, 12.5, 5, 15),
		('taffy', -3, 25, 15, 15),
		('raw banana', 1, 12.5, 0, 10),
		('berries', 0, 9.375, 0, 6),
		('butter', 40, 25, 0, 40),
		('popcorn', 3, 12.5, 0, 15),
		('deerclops eyeball', 60, 75, -15, null),
		('eye of the tiger shark', 60, 75, -15, null),
		('ice', 0.5, 2.3, 0, 3),
		('koalefant trunk', 30, 37.5, 0, 6),
		('mandrake', 60, 75, 0, null),
		('cooked mandrake', 100, 150, 0, null),
		('monster meat', -20, 18.75, -15, 6),
		('blue cap', 20, 12.5, -15, 10),
		('green cap', 0, 12.5, -50, 10),
		('red cap', -20, 12.5, 0, 10),
		('rot', -1, -10, 0, null);

	
-- player
INSERT INTO Player (name, gender, title, birthday_month, birthday_day, motto, odds_of_survival, health, hunger, sanity)
VALUES 	('wilson', 'm', 'the gentleman scientist', 4, 23, 'i will conquer this world with the power of my mind!', 'slim', 150, 150, 200),
		('willow', 'f', 'the firestarter', 5, 7, 'all will bathe in the prettiest of flames', 'slim', 150, 150, 120),
		('wolfgang', 'm', 'the strongman', 10, 2, 'i am mighty! no one is mightier!', 'grim', 200, 200, 200),
		('wendy', 'f', 'the bereaved', 11, 11, 'abigail? come back! i`m not done playing with you.', 'slim', 150, 150, 200),
		('wx-78', 'r', 'the soulless automaton', 11, 28, 'empathy module not responding', 'grim', 125, 125, 150),
		('wickerbottom', 'f', 'the librarian', 12, 6, 'shhhh! no talking!', 'grim', 125, 150, 250),
		('woodie', 'm', 'the lumberjack', 9, 12, 'that`s a nice lookin` tree, eh? Not for long.', 'slim', 150, 150, 200),
		('wes', 'm', 'the silent', 4, 16, '...', 'none', 75, 75, 75),
		('maxwell', 'm', 'the puppet master', 10, 6, 'freedom suits me.', 'grim', 75, 150, 200),
		('wigfrid', 'f', 'the performance artist', 7, 23, 'all the world`s a stage. for me!', 'slim', 200, 120, 120),
		('webber', 'm', 'the indigestible', 4, 30, 'we`re always together, and never alone!', 'grim', 175, 175, 100),
		('winona', 'f', 'the handywoman', 9, 13, 'anything can be fixed with hard work and elbow grease.', 'slim', 150, 150, 200),
		('warly', 'm', 'the culinarian', 7, 25, 'nothing worthwhile is ever done on an empty stomach!', 'grim', 150, 250, 200),
		('wortox', 'm', 'the soul starved', 3, 28, 'pardon me if i don`t shake your hand.', 'grim', 200, 175, 150),
		('wormwood', 'm', 'the lonesome', 6, 6, 'hello friend?', 'grim', 150, 150, 200),
		('wurt', 'f', 'the half-pint', 10, 17, 'mermfolk known for hos-per-tal-ity, florp.', 'slim', 150, 200, 150),
		('walter', 'm', 'the fearless', 3, 31, 'a pinetree pioneer is always prepared!', 'slim', 130, 110, 200),
		('wanda', 'f', 'the timekeeper', 8, 8, 'time! i just need more time!', 'grim', 80, 175, 200),
		('wonkey', 'm', 'the accursed', null, null, 'ook ook!', 'grim', 125, 175, 100);
		
	
-- season
INSERT INTO Season (name, days)
VALUES 	('spring', 20),
		('summer', 15),
		('autumn', 20),
		('winter', 15);
	
	
-- mob
INSERT INTO Mob (name, mob_type, health, damage, walk_speed, run_speed, season_id)
VALUES 	('abigail', 'n', 600, 40, 5, 5, null),
		('bearger', 'h', 6000, 87, 6, 10, (SELECT id FROM Season WHERE name = 'autumn')),
		('moose', 'h', 6000, 75, 8, 12, (SELECT id FROM Season WHERE name = 'spring')),
		('glommer', 'p', 100, 0, 6, 6, null),
		('mandrake', 'p', 20, 0, 6, 6, null),
		('bird', 'p', 25, 0, null, null, null),
		('deerclops', 'h', 4000, 75, 3, 3, (SELECT id FROM Season WHERE name = 'winter')),
		('mactusk', 'h', 300, 33, 3, 6, (SELECT id FROM Season WHERE name = 'winter')),
		('ancient fuelweaver', 'h', 16000, 100, 4.2, null, null),
		('bernie', 'n', 2000, 50, 4.5, 11, null),
		('spider', 'h', 100, 20, 3, 5, null),
		('woby', 'p', 0, 0, 1.5, 10, null),
		('beefalo', 'n', 1000, 34, 1.5, 7, null),
		('koalefant', 'n', 1000, 50, 1.5, 7, null),
		('winter koalefant', 'n', 1000, 50, 1.5, 7, (SELECT id FROM Season WHERE name = 'winter')),
		('ewecus', 'h', 800, 60, null, null, null),
		('pig', 'n', 250, 33, 3, 5, null),
		('werepig', 'h', 525, 40, 3, 7, null),
		('batilisk', 'h', 50, 20, 6, 6, null);
		

-- item category name
INSERT INTO ItemCategoryName (name)
VALUES 	('tools'),
		('light sources'),
		('weapons'),
		('armour'),
		('clothing'),
		('structures'),
		('cooking'),
		('storage solutions'),
		('prototypes');
	
	
-- item
INSERT INTO Item (name, starting_item_of_player)
VALUES 	('axe', null),
		('pickaxe', null),
		('shovel', null),
		('trap', null),
		('pile o` balloons', (SELECT id FROM Player WHERE name = 'wes')),
		('science machine', null),
		('alchemy engine', null),
		('think tank', null),
		('cartographer`s desk', null),
		('prestihatitator', null),
		('shadow manipulator', null),
		('torch', null),
		('camp fire', null),
		('miner hat', null),
		('alarming clock', null),
		('spear', null),
		('trusty slingshot', (SELECT id FROM Player WHERE name = 'walter')),
		('dark sword', null),
		('pan flute', null),
		('grass suit', null),
		('football helmet', null),
		('backpack', null),
		('trusty tape', (SELECT id FROM Player WHERE name = 'winona')),
		('top hat', null),
		('sisturn', null),
		('crock pot', null),
		('drying rack', null),
		('chest', null),
		('ice box', null);
	
	
-- fertilizer
INSERT INTO Fertilizer (name)
VALUES	('compost'),
		('glommer`s goop'),
		('guano'),
		('manure'),
		('rot'),
		('rotten egg');
	
	
-- player favourite food
INSERT INTO PlayerFavouriteFood (player_id, food_id, health_bonus, hunger_bonus, sanity_bonus)
VALUES 	((SELECT id FROM Player WHERE name = 'wilson'), (SELECT id FROM Food WHERE name = 'bacon and eggs'), 0, 15, 0),
		((SELECT id FROM Player WHERE name = 'willow'), (SELECT id FROM Food WHERE name = 'spicy chili'), 0, 15, 0),
		((SELECT id FROM Player WHERE name = 'wolfgang'), (SELECT id FROM Food WHERE name = 'roasted potato'), 0, 15, 0),
		((SELECT id FROM Player WHERE name = 'wendy'), (SELECT id FROM Food WHERE name = 'banana pop'), 0, 15, 0),
		((SELECT id FROM Player WHERE name = 'wx-78'), (SELECT id FROM Food WHERE name = 'butter muffin'), 0, 15, 0),
		((SELECT id FROM Player WHERE name = 'wickerbottom'), (SELECT id FROM Food WHERE name = 'surf `n` turf'), 0, 15, 0),
		((SELECT id FROM Player WHERE name = 'woodie'), (SELECT id FROM Food WHERE name = 'honey nuggets'), 0, 15, 0),
		((SELECT id FROM Player WHERE name = 'wes'), (SELECT id FROM Food WHERE name = 'fresh fruit crepes'), 0, 15, 0),
		((SELECT id FROM Player WHERE name = 'maxwell'), (SELECT id FROM Food WHERE name = 'wobster dinner'), 0, 15, 0),
		((SELECT id FROM Player WHERE name = 'wigfrid'), (SELECT id FROM Food WHERE name = 'turkey dinner'), 0, 15, 0),
		((SELECT id FROM Player WHERE name = 'webber'), (SELECT id FROM Food WHERE name = 'ice cream'), 0, 15, 0),
		((SELECT id FROM Player WHERE name = 'winona'), (SELECT id FROM Food WHERE name = 'spicy vegetable stinger'), 0, 15, 0),
		((SELECT id FROM Player WHERE name = 'wortox'), (SELECT id FROM Food WHERE name = 'pomegranate'), 0, 1.25, 0),
		((SELECT id FROM Player WHERE name = 'wortox'), (SELECT id FROM Food WHERE name = 'sliced pomegranate'), 0, 2.8125, 0),
		((SELECT id FROM Player WHERE name = 'wormwood'), (SELECT id FROM Food WHERE name = 'cooked banana'), 0, 15, 0),
		((SELECT id FROM Player WHERE name = 'wurt'), (SELECT id FROM Food WHERE name = 'durian'), 3, 23.25, 5),
		((SELECT id FROM Player WHERE name = 'wurt'), (SELECT id FROM Food WHERE name = 'extra smelly durian'), 0, 23.25, 5),
		((SELECT id FROM Player WHERE name = 'walter'), (SELECT id FROM Food WHERE name = 'trail mix'), 0, 15, 0),
		((SELECT id FROM Player WHERE name = 'wanda'), (SELECT id FROM Food WHERE name = 'taffy'), 3, 15, 0),
		((SELECT id FROM Player WHERE name = 'wonkey'), (SELECT id FROM Food WHERE name = 'raw banana'), 0, 0, 10),
		((SELECT id FROM Player WHERE name = 'wonkey'), (SELECT id FROM Food WHERE name = 'cooked banana'), 0, 0, 10);

	
-- item category
INSERT INTO ItemCategory (item_id, category_id)
VALUES 	((SELECT id FROM Item WHERE name = 'axe'), (SELECT id FROM ItemCategoryName WHERE name = 'tools')),
		((SELECT id FROM Item WHERE name = 'pickaxe'), (SELECT id FROM ItemCategoryName WHERE name = 'tools')),
		((SELECT id FROM Item WHERE name = 'shovel'), (SELECT id FROM ItemCategoryName WHERE name = 'tools')),
		((SELECT id FROM Item WHERE name = 'trap'), (SELECT id FROM ItemCategoryName WHERE name = 'tools')),
		((SELECT id FROM Item WHERE name = 'pile o` balloons'), (SELECT id FROM ItemCategoryName WHERE name = 'tools')),
		((SELECT id FROM Item WHERE name = 'torch'), (SELECT id FROM ItemCategoryName WHERE name = 'light sources')),
		((SELECT id FROM Item WHERE name = 'camp fire'), (SELECT id FROM ItemCategoryName WHERE name = 'light sources')),
		((SELECT id FROM Item WHERE name = 'miner hat'), (SELECT id FROM ItemCategoryName WHERE name = 'light sources')),
		((SELECT id FROM Item WHERE name = 'alarming clock'), (SELECT id FROM ItemCategoryName WHERE name = 'weapons')),
		((SELECT id FROM Item WHERE name = 'spear'), (SELECT id FROM ItemCategoryName WHERE name = 'weapons')),
		((SELECT id FROM Item WHERE name = 'trusty slingshot'), (SELECT id FROM ItemCategoryName WHERE name = 'weapons')),
		((SELECT id FROM Item WHERE name = 'dark sword'), (SELECT id FROM ItemCategoryName WHERE name = 'weapons')),
		((SELECT id FROM Item WHERE name = 'pan flute'), (SELECT id FROM ItemCategoryName WHERE name = 'weapons')),
		((SELECT id FROM Item WHERE name = 'grass suit'), (SELECT id FROM ItemCategoryName WHERE name = 'armour')),
		((SELECT id FROM Item WHERE name = 'football helmet'), (SELECT id FROM ItemCategoryName WHERE name = 'armour')),
		((SELECT id FROM Item WHERE name = 'backpack'), (SELECT id FROM ItemCategoryName WHERE name = 'clothing')),
		((SELECT id FROM Item WHERE name = 'trusty tape'), (SELECT id FROM ItemCategoryName WHERE name = 'clothing')),
		((SELECT id FROM Item WHERE name = 'top hat'), (SELECT id FROM ItemCategoryName WHERE name = 'clothing')),
		((SELECT id FROM Item WHERE name = 'crock pot'), (SELECT id FROM ItemCategoryName WHERE name = 'structures')),
		((SELECT id FROM Item WHERE name = 'drying rack'), (SELECT id FROM ItemCategoryName WHERE name = 'structures')),
		((SELECT id FROM Item WHERE name = 'sisturn'), (SELECT id FROM ItemCategoryName WHERE name = 'structures')),
		((SELECT id FROM Item WHERE name = 'science machine'), (SELECT id FROM ItemCategoryName WHERE name = 'structures')),
		((SELECT id FROM Item WHERE name = 'alchemy engine'), (SELECT id FROM ItemCategoryName WHERE name = 'structures')),
		((SELECT id FROM Item WHERE name = 'think tank'), (SELECT id FROM ItemCategoryName WHERE name = 'structures')),
		((SELECT id FROM Item WHERE name = 'cartographer`s desk'), (SELECT id FROM ItemCategoryName WHERE name = 'structures')),
		((SELECT id FROM Item WHERE name = 'prestihatitator'), (SELECT id FROM ItemCategoryName WHERE name = 'structures')),
		((SELECT id FROM Item WHERE name = 'shadow manipulator'), (SELECT id FROM ItemCategoryName WHERE name = 'structures')),
		((SELECT id FROM Item WHERE name = 'crock pot'), (SELECT id FROM ItemCategoryName WHERE name = 'cooking')),
		((SELECT id FROM Item WHERE name = 'drying rack'), (SELECT id FROM ItemCategoryName WHERE name = 'cooking')),
		((SELECT id FROM Item WHERE name = 'ice box'), (SELECT id FROM ItemCategoryName WHERE name = 'cooking')),
		((SELECT id FROM Item WHERE name = 'camp fire'), (SELECT id FROM ItemCategoryName WHERE name = 'cooking')),
		((SELECT id FROM Item WHERE name = 'chest'), (SELECT id FROM ItemCategoryName WHERE name = 'storage solutions')),
		((SELECT id FROM Item WHERE name = 'ice box'), (SELECT id FROM ItemCategoryName WHERE name = 'storage solutions')),
		((SELECT id FROM Item WHERE name = 'backpack'), (SELECT id FROM ItemCategoryName WHERE name = 'storage solutions')),
		((SELECT id FROM Item WHERE name = 'science machine'), (SELECT id FROM ItemCategoryName WHERE name = 'prototypes')),
		((SELECT id FROM Item WHERE name = 'alchemy engine'), (SELECT id FROM ItemCategoryName WHERE name = 'prototypes')),
		((SELECT id FROM Item WHERE name = 'think tank'), (SELECT id FROM ItemCategoryName WHERE name = 'prototypes')),
		((SELECT id FROM Item WHERE name = 'cartographer`s desk'), (SELECT id FROM ItemCategoryName WHERE name = 'prototypes')),
		((SELECT id FROM Item WHERE name = 'prestihatitator'), (SELECT id FROM ItemCategoryName WHERE name = 'prototypes')),
		((SELECT id FROM Item WHERE name = 'shadow manipulator'), (SELECT id FROM ItemCategoryName WHERE name = 'prototypes'));

	
-- player mob relationship
INSERT INTO PlayerMobRelationship (player_id, mob_id, type_of_relationship)
VALUES 	((SELECT id FROM Player WHERE name = 'willow'), (SELECT id FROM Mob WHERE name = 'bernie'), 'best friends'),
		((SELECT id FROM Player WHERE name = 'wendy'), (SELECT id FROM Mob WHERE name = 'abigail'), 'twin sisters'),
		((SELECT id FROM Player WHERE name = 'webber'), (SELECT id FROM Mob WHERE name = 'spider'), 'spiders'),
		((SELECT id FROM Player WHERE name = 'walter'), (SELECT id FROM Mob WHERE name = 'woby'), 'best friends');

	
-- dropped by
INSERT INTO DroppedBy (fertilizer_id, mob_id, method_of_generation)
VALUES 	((SELECT id FROM Fertilizer WHERE name = 'manure'), (SELECT id FROM Mob WHERE name = 'beefalo'), 'periodically'),
		((SELECT id FROM Fertilizer WHERE name = 'manure'), (SELECT id FROM Mob WHERE name = 'koalefant'), 'periodically'),
		((SELECT id FROM Fertilizer WHERE name = 'manure'), (SELECT id FROM Mob WHERE name = 'winter koalefant'), 'periodically'),
		((SELECT id FROM Fertilizer WHERE name = 'manure'), (SELECT id FROM Mob WHERE name = 'ewecus'), 'periodically'),
		((SELECT id FROM Fertilizer WHERE name = 'manure'), (SELECT id FROM Mob WHERE name = 'pig'), 'when fed'),
		((SELECT id FROM Fertilizer WHERE name = 'manure'), (SELECT id FROM Mob WHERE name = 'werepig'), 'when fed'),
		((SELECT id FROM Fertilizer WHERE name = 'glommer`s goop'), (SELECT id FROM Mob WHERE name = 'glommer'), 'periodically'),
		((SELECT id FROM Fertilizer WHERE name = 'guano'), (SELECT id FROM Mob WHERE name = 'bird'), 'periodically'),
		((SELECT id FROM Fertilizer WHERE name = 'guano'), (SELECT id FROM Mob WHERE name = 'batilisk'), 'periodically');
	
	
-- violating the referential integrity constraints
INSERT INTO PlayerMobRelationship (player_id, mob_id, type_of_relationship)
VALUES (1000, 1000, 'inexistent relationship');
INSERT INTO ItemCategory (item_id, category_id)
VALUES (0, 0);



-- update data – for at least 3 tables


-- using '='
-- updating a specific type of relationship into 'same species'
UPDATE PlayerMobRelationship 
SET type_of_relationship = 'same species'
WHERE type_of_relationship = 'spiders';


-- using 'LIKE'
-- updating the item records such that the player 'wilson' will have as starting items
-- those that contain 'axe' in their name (here, 'axe' and 'pickaxe')
UPDATE Item 
SET starting_item_of_player = (SELECT id FROM Player WHERE name = 'wilson')
WHERE name LIKE '%axe%';


-- using '='
-- updating the number of days of the seasons that have the minimum number of days 
-- of them all (here, summer and winter will get from 15 to 25 days)
UPDATE Season 
SET days = days + 10
WHERE days = (SELECT MIN(days)
			  FROM Season);
		
			 
-- using 'IS NULL'
-- changing the null state of walking speed into 0 only if it is null 
-- (here, 'bird' and 'ewecus' will get affected)
UPDATE Mob 
SET walk_speed = 0
WHERE walk_speed IS NULL;
			 
			 

-- delete data – for at least 2 tables


-- using 'IN' and '>='
-- deleting the dropped by records of mobs that do over 50 damage
-- because we're no longer interested in fertilizers dropped by mobs that do much damage
-- (they are too risky to kill, thus the effort is unjustified)
-- (here, the dropped by data reffering to 'koalefant', 'winter koalefant' and 'ewecus' will be deleted)
DELETE FROM DroppedBy  
WHERE mob_id IN (SELECT id FROM Mob WHERE damage >= 50);


-- using 'BETWEEN', 'NOT IN' and 'AND'
-- deleting the food records where the sum between the health, hunger and sanity 
-- are between -15 and 15 (which means that food doesn't have a great impact on the game)
-- also taking care that that specific food is not the favourite food of a player
-- (here, 'berries', 'ice', 'red cap' and 'rot' are deleted)
--- DISTINCT, for eficiency :)
DELETE FROM Food 
WHERE health + hunger + sanity BETWEEN -15 AND 15 AND id NOT IN (SELECT DISTINCT food_id FROM PlayerFavouriteFood);




-- queries



-- 2 queries with the union operation; use UNION [ALL] and OR;


-- selecting only the 'good' players (those who start with 'w' because 'maxwell' is the bad guy)
-- and the 'good' mobs (those that are 'passive' or 'neutral')
SELECT name FROM Player WHERE name LIKE 'w%'
UNION 
SELECT name FROM Mob WHERE mob_type = 'p' OR mob_type = 'n'


-- selecting the players and mob that have the health <= 150
SELECT name, health FROM Player WHERE health <= 150
UNION 
SELECT name, health FROM Mob WHERE health <= 150



-- 2 queries with the intersection operation; use INTERSECT and IN;


-- selecting the items that are in the 'structures' and 'cooking' categories at the same time
SELECT name FROM Item WHERE id IN (SELECT item_id FROM ItemCategory WHERE category_id IN (SELECT id FROM ItemCategoryName WHERE name = 'structures'))
INTERSECT
SELECT name FROM Item WHERE id IN (SELECT item_id FROM ItemCategory WHERE category_id IN (SELECT id FROM ItemCategoryName WHERE name = 'cooking'))


-- selecting the female characters that have relationships with other mobs
SELECT name FROM Player WHERE gender = 'f'
INTERSECT
SELECT name FROM Player WHERE id IN (SELECT player_id FROM PlayerMobRelationship)



-- 2 queries with the difference operation; use EXCEPT and NOT IN;


-- selecting the items that are in the 'storage solutions' and 'cooking' categories at the same time
SELECT name FROM Item WHERE id IN (SELECT item_id FROM ItemCategory WHERE category_id IN (SELECT id FROM ItemCategoryName WHERE name = 'storage solutions'))
EXCEPT
SELECT name FROM Item WHERE id NOT IN (SELECT item_id FROM ItemCategory WHERE category_id IN (SELECT id FROM ItemCategoryName WHERE name = 'cooking'))


-- selecting the male characters that have relationships with other mobs
SELECT name FROM Player WHERE gender = 'm'
EXCEPT 
SELECT name FROM Player WHERE id NOT IN (SELECT player_id FROM PlayerMobRelationship)



-- 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN (one query per operator);
-- one query will join at least 3 tables, while another one will join at least two many-to-many relationships;


-- selecting the relationships between a player and a mob in which the mob is passive
-- using INNER JOIN
-- joining 3 tables
SELECT P.name as player_name, M.name as mob_name
FROM PlayerMobRelationship PMR 
INNER JOIN Player P ON P.id = PMR.player_id 
INNER JOIN Mob M ON PMR.mob_id = M.id
WHERE M.mob_type = 'p'


-- selecting the mobs that have relationships with players that like spicy foods
-- using INNER JOIN
-- joining 5 tables
-- joining 2 many-to-many relationship tables (PlayerMobRelationship and PlayerFavouriteFood)
SELECT M.name as mob_name, P.name as player_name, F.name as food_name
FROM Mob M
INNER JOIN PlayerMobRelationship PMR ON M.id = PMR.mob_id
INNER JOIN Player P ON PMR.player_id = P.id 
INNER JOIN PlayerFavouriteFood PFF ON P.id = PFF.player_id
INNER JOIN Food F ON PFF.food_id = F.id 
WHERE F.name LIKE '%spicy%'


-- selecting all the players and their favourite foods
-- using LEFT OUTER JOIN
-- joining 3 tables
SELECT P.name as player_name, F.name as food_name
FROM Player P
LEFT OUTER JOIN PlayerFavouriteFood PFF ON P.id = PFF.player_id
LEFT OUTER JOIN Food F ON PFF.food_id = F.id


-- selecting all the foods and the player that have that food as their favourite one
-- using RIGHT OUTER JOIN
-- joining 3 tables 
SELECT F.name as food_name, P.name as player_name
FROM Player P
RIGHT OUTER JOIN PlayerFavouriteFood PFF ON P.id = PFF.player_id
RIGHT OUTER JOIN Food F ON PFF.food_id = F.id


-- selecting all the relationships possible
-- using FULL OUTER JOIN
-- joining 3 tables
SELECT P.name as player_name, M.name as mob_name
FROM PlayerMobRelationship PMR
FULL OUTER JOIN Player P ON PMR.player_id = P.id 
FULL OUTER JOIN Mob M ON PMR.mob_id = M.id



-- 2 queries with the IN operator and a subquery in the WHERE clause; 
-- in at least one case, the subquery must include a subquery in its own WHERE clause;


-- selecting the mobs that spawn only in spring or autumn
SELECT name
FROM Mob
WHERE season_id IN 
	(SELECT id 
	FROM Season 
	WHERE name IN ('spring', 'autumn'))

	
-- selecting the players whose favourite food will have no or negative impact on others` health
SELECT name
FROM Player
WHERE id IN 
	(SELECT player_id 
	FROM PlayerFavouriteFood 
	WHERE food_id IN 
		(SELECT id 
		FROM Food 
		WHERE health <= 0))
		
		
		
-- 2 queries with the EXISTS operator and a subquery in the WHERE clause;
		
		
-- selecting all the feritilizers that can be dropped by mobs
SELECT F.name
FROM Fertilizer F
WHERE EXISTS (SELECT DB.fertilizer_id FROM DroppedBy DB WHERE DB.fertilizer_id = F.id)


-- selecting all the players that have starting items
SELECT P.name
FROM Player P
WHERE EXISTS (SELECT I.id FROM Item I WHERE I.starting_item_of_player = P.id)



-- 2 queries with a subquery in the FROM clause;


-- selecting the first 3 healthiest female players (having health >= 150) 
--- using TOP
--- using ORDER BY
--- using arithmetic expressions in the SELECT clause
SELECT TOP 3 FP.name, FP.health - 150
FROM (SELECT * FROM Player WHERE gender = 'f') AS FP
WHERE FP.health >= 150
ORDER BY FP.health DESC


-- selecting the top 3 healthiest non expiring foods
--- using TOP
--- using ORDER BY
SELECT TOP 3 NEF.name, NEF.health, NEF.hunger, NEF.sanity
FROM (SELECT * FROM Food WHERE perish_time IS NULL) AS NEF
ORDER BY NEF.health DESC



-- 4 queries with the GROUP BY clause, 
-- 3 of which also contain the HAVING clause; 
-- 2 of the latter will also have a subquery in the HAVING clause; 
-- use the aggregation operators: COUNT, SUM, AVG, MIN, MAX;


-- selecting the number of players with a specific odd of survival, their average health, average hunger and average sanity
-- using COUNT and AVG
SELECT odds_of_survival, COUNT(*) AS number_of_players, AVG(health) AS average_health, AVG(hunger) AS average_hunger, AVG(sanity) AS average_sanity
FROM Player 
GROUP BY odds_of_survival


-- selecting the difference between the maximum and minimum walking speed and average walking speed of the passive and neutral mobs
-- using MIN, MAX and AVG
-- using the HAVING clause
--- arithmetic expression in the SELECT clause
SELECT mob_type, MAX(walk_speed) - MIN(walk_speed) AS difference_walking_speed, AVG(walk_speed) AS average_walking_speed
FROM Mob
GROUP BY mob_type
HAVING mob_type IN ('p', 'n')


-- selecting the types of mobs that have the minimum health bigger than any health of a player
-- using MIN
-- using a subquery in the HAVING clause
SELECT mob_type, MIN(health) AS minimum_health
FROM Mob
GROUP BY mob_type
HAVING MIN(health) >= ALL (SELECT health FROM Player)


-- selecting the types of mobs that cannot kill any player from one hit
-- using MAX
-- using a subquery in the HAVING clause
SELECT mob_type, MAX(damage) AS maximum_damage
FROM Mob
GROUP BY mob_type
HAVING MAX(damage) <= ALL (SELECT health FROM Player)


-- selecting the names of the characters that would get a lower hunger bonus if they were to eat their favourite food rather than any other food that is not favourite to any other character
-- using SUM
-- using a subquery in the HAVING clause
SELECT PPFF.name, SUM(PPFF.health_bonus), SUM(PPFF.hunger_bonus), SUM(PPFF.sanity_bonus)
FROM (SELECT P.name, PFF.health_bonus, PFF.hunger_bonus, PFF.sanity_bonus FROM PlayerFavouriteFood PFF INNER JOIN Player P ON P.id = PFF.player_id) PPFF
GROUP BY PPFF.name
HAVING SUM(PPFF.hunger_bonus) <= ALL (SELECT Food.hunger FROM Food WHERE Food.id NOT IN (SELECT PlayerFavouriteFood.food_id FROM PlayerFavouriteFood))



-- 4 queries using ANY and ALL to introduce a subquery in the WHERE clause (2 queries per operator); 
-- rewrite 2 of them with aggregation operators, and the other 2 with IN / [NOT] IN.


-- selecting the names of the mobs that would kill any player from 5 hits or wouldn't kill even the unhealthiest player and the damage dealt by those hits
-- using ALL
--- arithmetic expression in SELECT
--- using ORDER BY
--- OR and paranthesis in the WHERE clause
SELECT 	name AS mob_name, 
		5 * damage AS damage_dealt
FROM Mob
WHERE 5 * damage >= ALL (SELECT health FROM Player) OR 5 * damage < ALL (SELECT health FROM Player)
ORDER BY 5 * damage DESC

-- using aggregation operators (MAX)
--- arithmetic expression in SELECT
--- using ORDER BY
--- OR and paranthesis in the WHERE clause
SELECT 	M.name AS mob_name, 
		5 * M.damage AS damage_dealt
FROM Mob M, Player P
GROUP BY M.name, M.damage
HAVING 5 * M.damage >= MAX(P.health) OR 5 * M.damage < MIN(P.health)
ORDER BY 5 * damage DESC


-- selecting the names of the foods that give you more health than any other food that is favourite to at least one player
-- using ALL
-- LEFT OUTER JOIN can be replaced by INNER JOIN
SELECT 	name AS food_name,
		health AS food_health
FROM Food
WHERE health > ALL (SELECT health FROM PlayerFavouriteFood PFF LEFT OUTER JOIN Food F ON PFF.food_id = F.id)

-- using aggregation operators (MAX)
SELECT 	F.name AS food_name, 
		F.health AS food_health
FROM Food F, (SELECT health FROM Food f INNER JOIN PlayerFavouriteFood PFF ON f.id = PFF.food_id) PPFF
GROUP BY F.name, F.health
HAVING F.health > MAX(PPFF.health)


-- selecting the mobs' name and damage that could kill at least one player with one hit
-- using ANY
SELECT 	name AS mob_name, 
		damage AS one_hit
FROM Mob
WHERE damage >= ANY (SELECT health FROM Player)

-- using IN
SELECT 	name AS mob_name,
		damage AS one_hit
FROM Mob
WHERE damage IN (SELECT M.damage from Player P INNER JOIN Mob M ON M.damage >= P.health)


-- selecting the male players' name and health that are more healthier than at least one female player
-- using ANY
--- AND condition in WHERE clause
SELECT 	name AS male_player_name, 
		health AS male_player_health
FROM Player
WHERE gender = 'm' AND health >= ANY (SELECT health FROM Player WHERE gender = 'f')

-- using IN
--- AND condition in WHERE clause
SELECT 	name AS male_player_name, 
		health AS male_player_health
FROM Player
WHERE gender = 'm' AND health IN 
	(
	SELECT MP.health 
	FROM (SELECT health FROM Player WHERE gender = 'm') MP INNER JOIN (SELECT health FROM Player WHERE gender = 'f') FP 
	ON MP.health >= FP.health
	)
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
--- bonus queries in order to use DISTINCT
--- i'm sorry, but i couldn't integrate DISTINCT anywhere
	
-- selecting the types of genders a player can have
SELECT DISTINCT gender
FROM Player

-- selecting the birthday months in which players have been born
SELECT DISTINCT birthday_month
FROM Player
WHERE birthday_month IS NOT NULL

-- selecting the types of a mob
SELECT DISTINCT mob_type
FROM Mob






		