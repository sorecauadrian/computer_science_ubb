-- create a database for tracking operations within a bank
-- you will manage customers, bank accounts, cards, ATMs and transactions.
-- each customer has a name, the date of birth, and may have multiple bank accounts.
-- for each bank account consider the following: the IBAN code, the current balance, the holder and the cards associated with that bank account.
-- each card has a number, a CVV code (last 3 digits of the card number) and is associated with a bank account. an ATM has an address.
-- a transaction involves withdrawing, from an ATM, a sum of money using a card at a certain time (consider both date and time).
-- of course, a card can be used in several transactions at the same ATM or at different ATMs and at an ATM multiple transactions can be done with multiple cards.

-- requirements:
-- 1. write an SQL script that creates the corresponding relational data model. (4p)
-- 2. implement a stored procedure that receives a card and deletes all the transactions related to that card. (1p)
-- 3. create a view that shows the card numbers which were used in transactions at all ATMs. (2p)
-- 4. implement a function that lists the cards (number and CVV code) that have the total transactions sum greater than 2000 lei. (2p)

use bank

-- 1

create table customers
(
	id int primary key identity(1, 1),
	name varchar(32) not null,
	date_of_birth date not null
);

create table bank_accounts
(
	id int primary key identity(1, 1),
	iban varchar(34) not null,
	balance decimal(16, 2) not null,
	customer_id int foreign key references customers(id)
);

create table cards
(
	id int primary key identity(1, 1),
	number varchar(16) not null,
	cvv varchar(3) not null,
	bank_account_id int foreign key references bank_accounts(id)
);

create table atms
(
	id int primary key identity(1, 1),
	address varchar(256) not null
);

create table transactions
(
	id int primary key identity(1, 1),
	amount decimal(16, 2) not null,
	transaction_time datetime not null,
	atm_id int foreign key references atms(id),
	card_id int foreign key references cards(id)
);

insert into customers(name, date_of_birth) values ('adi', '2003-04-14');
insert into bank_accounts(iban, balance, customer_id) values ('RO01234567890123456789012345678901', 3000.00, 1);
insert into cards(number, cvv, bank_account_id) values ('1234123412341234', '123', 1);
insert into atms(address) values ('strada republicii, 14');
insert into transactions(amount, transaction_time, atm_id, card_id) values (100.00, '2024-01-01 12:00:00', 1, 1);

-- 2

create or alter procedure DeleteTransactionsByCardId @card_id int
as
begin
	set nocount on; -- the number of rows affected is not returned as part of the result
	
	delete from transactions
	where card_id = @card_id;

	print 'transactions deleted successfully.';
end

declare @card_id_to_delete int;
set @card_id_to_delete = 1;
exec DeleteTransactionsByCardId @card_id_to_delete;

-- 3

create view CardsUsedAtAllATMs as
	select distinct card.number
	from cards card
	where not exists 
	(
		select atm.id
		from atms atm
		where not exists 
		(
			select transaction_.id
			from transactions transaction_
			where transaction_.card_id = card.id and transaction_.atm_id = atm.id
		)
	);

select * from CardsUsedAtAllATMs;

-- 4

create function GetCardsWithTotalSumGreaterThan2000 (@total_sum_threshold decimal(16, 2))
returns table
as
return
(
	select card.number, card.cvv
	from cards card
	where exists
	(
		select transaction_.card_id
		from transactions transaction_
		where transaction_.card_id = card.id
		group by transaction_.card_id
		having sum(transaction_.amount) > @total_sum_threshold
	)
);

declare @threshold decimal(16, 2);
set @threshold = 20.00;
select * from GetCardsWithTotalSumGreaterThan2000(@threshold);







