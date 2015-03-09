-- Inner Join: All rows when at least one match in BOTH tables (Intersection)
-- Outer Join: All rows of which both tables match (Union)
-- Left Join: All rows from the left table and matched rows from right table
-- Right Join: All rows from the right table and matched rows from left table
-- Full Join: All rows when a match in ONE of the tables

-- 1. The cities of agents booking an order for a customer whose pid is 'c006', use joins

select city
from agents a
inner join orders o
on o.aid = a.aid and o.cid = 'c006'

-- 2. The pids of products ordered through any agent who makes at least one order from a customer in Kyoto, sorted by pid from highest to lowest, use joins

select distinct p.pid
from orders o
inner join customers c 
on c.cid = o.cid and c.city = 'Kyoto'
inner join orders o2 
on o.aid = o2.aid
inner join products p
on o2.pid = p.pid
order by p.pid

-- 3. Names of customers who have never placed an order, subquery

select name
from customers
where cid not in
	(select distinct cid
	 from orders)

-- 4. Names of customers who have never placed an order, outer join

select c.name
from customers c
left outer join orders o
on o.cid = c.cid
where ordno is null

-- 5. Names of customers who placed at least one order through an agent in their own city, along with those agent(s) names

select c.name, a.name
from customers c
inner join orders o
on o.cid = c.cid
inner join agents a
on a.city = c.city

-- 6. Names of customers and agents living in the same city, along with the name of the sahred cit, regardless of whether or not the customer has ever placed an order with that agent

select c.name, a.name, c.city
from customers c, agents a
where c.city = a.city

-- 7. Name and city of customers who live in the city that makes the fewest different kinds of products (count and group by)

select c.name, c.city
from customers c
where c.city in
	(select p.city
	 from products p
	 group by p.city
	 order by count(p.city) ASC
	 limit 1)