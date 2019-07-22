drop table if exists exchange_rates;
create table exchange_rates(
ts datetime,
from_currency varchar(3),
to_currency varchar(3),
rate NUMERIC (4,2)
);


truncate table exchange_rates;
insert into exchange_rates
values
('2018-04-01 00:00:00', 'USD', 'GBP', '0.71'),
('2018-04-01 00:00:05', 'USD', 'GBP', '0.82'),
('2018-04-01 00:01:00', 'USD', 'GBP', '0.92'),
('2018-04-01 01:02:00', 'USD', 'GBP', '0.62'),

('2018-04-01 02:00:00', 'USD', 'GBP', '0.71'),
('2018-04-01 03:00:05', 'USD', 'GBP', '0.82'),
('2018-04-01 04:01:00', 'USD', 'GBP', '0.92'),
('2018-04-01 04:22:00', 'USD', 'GBP', '0.62'),

('2018-04-01 00:00:00', 'EUR', 'GBP', '1.71'),
('2018-04-01 01:00:05', 'EUR', 'GBP', '1.82'),
('2018-04-01 01:01:00', 'EUR', 'GBP', '1.92'),
('2018-04-01 01:02:00', 'EUR', 'GBP', '1.62'),

('2018-04-01 02:00:00', 'EUR', 'GBP', '1.71'),
('2018-04-01 03:00:05', 'EUR', 'GBP', '1.82'),
('2018-04-01 04:01:00', 'EUR', 'GBP', '1.92'),
('2018-04-01 05:22:00', 'EUR', 'GBP', '1.62'),

('2018-04-01 05:22:00', 'EUR', 'HUF', '0.062')
;


-- Transactions

drop table if exists transactions;
create table transactions (
ts datetime,
user_id int,
currency varchar(3),
amount numeric
);

truncate table transactions;
insert into transactions
values
('2018-04-01 00:00:00', 1, 'EUR', 2.45),
('2018-04-01 01:00:00', 1, 'EUR', 8.45),
('2018-04-01 01:30:00', 1, 'USD', 3.5),
('2018-04-01 20:00:00', 1, 'EUR', 2.45),

('2018-04-01 00:30:00', 2, 'USD', 2.45),
('2018-04-01 01:20:00', 2, 'USD', 0.45),
('2018-04-01 01:40:00', 2, 'USD', 33.5),
('2018-04-01 18:00:00', 2, 'EUR', 12.45),

('2018-04-01 18:01:00', 3, 'GBP', 2),

('2018-04-01 00:01:00', 4, 'USD', 2),
('2018-04-01 00:01:00', 4, 'GBP', 2)
;

-----------querry 1

select sum(TR1.amount*ISNULL(A.highest_rate,1)) as Total_sum_GBP,
       user_id 
	   from
		(select  ER1.rate as highest_rate,
			 ER1.from_currency 
				from 
			        exchange_rates ER1
				where ER1.to_currency='GBP'
				and ER1.ts in (select max(ER2.ts) 
								from 
								exchange_rates ER2
								where ER2.to_currency='GBP'
								group by 
					                        ER2.from_currency)) as A
right join transactions TR1 on TR1.currency=A.from_currency
	group by 
		TR1.user_id
	order by
	        TR1.user_id





-----------Querry 2

select A.user_id,sum(A.[GBP SPEND]) as 'Tot sum in GBP' from
(select  TR1.user_id,(ISNULL((select top 1 ER1.rate 
						from 
						exchange_rates ER1
						where TR1.ts >=  ER1.ts
						and TR1.currency=ER1.from_currency
						order by ts desc),1))*TR1.amount as [GBP SPEND]
				from transactions TR1 ) as A
group by A.[user_id]
order by A.[user_id]













		
			 




























