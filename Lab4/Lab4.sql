-- 1. Cities of agents booking an order for a customer whose cid is 'c006'

select city
from agents
where aid in 
	(select aid
	 from orders
	 where cid = 'c006')

-- 2. Pids of products ordered through any agent who takes at least one order from a customer in Kyoto, sorted by pid from highest to lowest

select pid
from orders
where aid in
	(select aid 
	 from orders
	 where cid in
		(select cid
		 from customers
		 where city = 'Kyoto'))
order by pid desc

-- 3. Cids and names of customers who did not place an order through agent a03

select cid, name
from customers
where cid in
	(select cid
	 from orders
	 where aid != 'a03')

-- 4. Cids of customers who ordered both product p01 and p07

select cid
from customers
where cid in
	(select cid
	 from orders
	 where pid = 'p01' or pid = 'p07')

-- 5. Pids of products not ordered by any customer who placed any order through agent a05

select pid
from orders
where cid not in 
	(select cid
	 from orders
	 where aid = 'a05')

-- 6. Name, discounts, and city for all customers who placed orders through agents in Dallas or New York

select name, discount, city
from customers
where cid in
	(select cid
	 from orders
	 where aid in
		(select aid
		 from agents
		 where city = 'Dallas' or city = 'New York'))

-- 7. All customers who have the same discount as that of any customers in Dallas or London

select *
from customers
where not city = 'Dallas' and not city = 'London' and discount in
	(select discount 
	 from customers
	 where city = 'Dallas' or city = 'London')