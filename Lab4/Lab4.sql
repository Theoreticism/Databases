!-- 1. Cities of agents booking an order for a customer whose cid is 'c006'

select city
from agents
where aid in 
	(select aid
	 from orders
	 where cid = 'c006')

!-- 2. Pids of products ordered through any agent who takes at least one order from a customer in Kyoto, sorted by pid from highest to lowest

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