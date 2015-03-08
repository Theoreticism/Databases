-- 1. Ordno and dollars of all orders
select ordno, dollars
from orders

-- 2. Name and city of agents named Smith
select name, city
from agents
where name = 'Smith'

-- 3. Pid, name, and priceUSD of products with quantity >200,000
select pid, name, priceUSD
from products
where quantity > 200000

-- 4. Names and cities of customers in Dallas
select name, city
from customers
where city = 'Dallas'

-- 5. Names of agents not in New York and not in Tokyo
select name
from agents
where city != 'New York' and city != 'Tokyo'

-- 6. Data for products not in Dallas or Duluth that cost US$1 or more.
select *
from products
where city != 'Dallas' and city != 'Duluth' and priceUSD >= 1

-- 7. Data for orders in January or May
select *
from orders
where mon = 'jan' or mon = 'may'

-- 8. Data for orders in February more than US$500
select *
from orders
where mon = 'feb' and dollars >= 500

-- 9. Orders from the customer whose cid is 005
select *
from orders
where cid = 'c005'