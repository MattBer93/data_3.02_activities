-- Activity 1
use bank;

-- 1. Use the below query and list district_name (A2), client_id and account_id for those clients who are owner of the account. 
-- Order the results by district_name:
select disp_id, c.client_id, account_id, type, A2 from bank.disp d
join bank.client c
on d.client_id = c.client_id
join bank.district da
on da.A1 = c.district_id;

select A2, client_id as client2, account_id
from (
	select disp_id, c.client_id, account_id, type, A2 from bank.disp d
	join bank.client c
	on d.client_id = c.client_id
	join bank.district da
	on da.A1 = c.district_id
) sub1
where type='OWNER'
order by A2;

-- Activity 2
-- List districts together with total amount borrowed and average loan amount.
select A2, sum(amount), avg(amount)
from district d
join account a on d.A1 = a.district_id
join loan l
using(account_id)
group by A2;

-- Activity 3
-- Create a temporary table district_overview in the bank database 
-- which lists districts together with total amount borrowed and average loan amount.
create temporary table if not exists district_overview
select A2, sum(amount), avg(amount)
from district d
join account a on d.A1 = a.district_id
join loan l
using(account_id)
group by A2;



-- Activity 4
-- Still working in the bank database, list the clients with no credit card.
create temporary table if not exists no_card
select d.client_id, c.disp_id
from disp d
left join card c using(disp_id);

select client_id, disp_id as card from no_card
where disp_id is null;
