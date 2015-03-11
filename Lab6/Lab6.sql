-- GROUP BY: Aggregate function to group result set by a column
-- ORDER BY count(x): Count number of fields in x, order by different "types" in x
-- Combined with group by, group by different "types" in x
-- COALESCE: Evaluates arguments in order and returns the first non-NULL expression among its arguments

-- 1. Name and city of customers who live in any city that makes the most different kinds of products

select c.name, c.city
from customers c
where c.city in 
	(select p.city
	 from products p
	 group by p.city
	 order by count(p.city) DESC
	 limit 1)

-- 2. Names of products whose priceUSD is below the average priceUSD, in alphabetical order

select name 
from products
where priceUSD > 
	(select avg(priceUSD)
	from products)
order by name ASC

-- 3. Customer name, pid ordered, and the dollar for all orders, sorted by dollars from high to low

select c.name, o.pid, o.dollars
from customers c, orders o
where c.cid = o.cid
order by o.dollars DESC

-- 4. All customer names (in reverse alphabetical order) and their total ordered, and nothing more

select coalesce(totals.tOrdered, 0) as total, totals.cName
from 
	(select sum(o.dollars) as tOrdered, c.name as cName
	 from customers c full outer join orders o
	 on c.cid = o.cid
	 group by c.cid) totals
order by totals.cName DESC

-- 5. All customer names who bought products from agents based in Tokyo along with the names of the products they ordered, and the names of the agents who sold it to them

select a.name, p.name, c.name
from agents a, products p, customers c, orders o
where p.pid = o.pid
and c.cid = o.cid
and a.aid = o.aid
and a.city = 'Tokyo'

-- 6. Check the accuracy of the dollars column in the Orders table

select o.*
from orders o, products p, customers c
where p.pid = o.pid
and c.cid = o.cid
and (p.priceUSD * o.qty) - c.discount != o.dollars
