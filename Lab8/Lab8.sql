DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS purchases;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS purchaseorders;
DROP TABLE IF EXISTS supplierorders;

--CREATE--

CREATE TABLE orders (
	orderid INT PRIMARY KEY NOT NULL,
	orderDate DATE,
	partList TEXT,
	partQuantity INT,
	comments TEXT
);

CREATE TABLE purchases (
	purchaseid INT PRIMARY KEY NOT NULL,
	description TEXT,
	quantity INT
);

CREATE TABLE suppliers (
	supplierid INT PRIMARY KEY NOT NULL,
	name TEXT,
	address TEXT,
	city TEXT,
	state TEXT,
	postalCode INT,
	contactInfo TEXT,
	paymentTerms TEXT
);

CREATE TABLE purchaseorders (
	orderid INT REFERENCES orders,
	purchaseid INT REFERENCES purchases,
	priceUSD INT,
	CONSTRAINT po_pk PRIMARY KEY (orderid, purchaseid)
);

CREATE TABLE supplierorders (
	orderid INT REFERENCES orders,
	supplierid INT REFERENCES suppliers,
	CONSTRAINT so_pk PRIMARY KEY (orderid, supplierid)
);

--POPULATE--

INSERT INTO suppliers (supplierid, name, address, city, state, postalCode, contactInfo, paymentTerms)
VALUES (0, 'ACME Supply', '123 Supply Rd', 'SupplyVille', 'Kansas', 66075, '(123)123-1234', '1 percent 10 net 30');

INSERT INTO suppliers (supplierid, name, address, city, state, postalCode, contactInfo, paymentTerms)
VALUES (1, 'FutureWare, Inc.', '456 Martian St', 'Marstown', 'California', 10101, '(456)456-4567', '2 percent 10 net 30');

INSERT INTO suppliers (supplierid, name, address, city, state, postalCode, contactInfo, paymentTerms)
VALUES (2, 'S & D', '789 Crown Ln', 'New York', 'New York', 12000, '(789)789-7890', '1 percent 10 net 30');

INSERT INTO purchases (purchaseid, description, quantity)
VALUES (0, 'T-shirts', 10000);

INSERT INTO purchases (purchaseid, description, quantity)
VALUES (1, 'Jeans', 2000);

INSERT INTO purchases (purchaseid, description, quantity)
VALUES (2, 'Polos', 5000);

INSERT INTO purchases (purchaseid, description, quantity)
VALUES (3, 'Underwear', 9001);

INSERT INTO purchases (purchaseid, description, quantity)
VALUES (4, 'Shorts', 3000);

INSERT INTO orders (orderid, orderDate, partList, partQuantity, comments)
VALUES (0, DATE '2011-02-11', 'T-shirts', 4832, 'Black only');

INSERT INTO orders (orderid, orderDate, partList, partQuantity, comments)
VALUES (1, DATE '2012-01-05', 'Underwear', 2351, 'Boxers and briefs');

INSERT INTO orders (orderid, orderDate, partList, partQuantity, comments)
VALUES (2, DATE '2012-06-12', 'Polos', 1091, 'Blue, green and white');

INSERT INTO purchaseorders (orderid, purchaseid, priceUSD)
VALUES (0, 0, 20);

INSERT INTO purchaseorders (orderid, purchaseid, priceUSD)
VALUES (1, 3, 10);

INSERT INTO purchaseorders (orderid, purchaseid, priceUSD)
VALUES (2, 2, 25);

INSERT INTO supplierorders (orderid, supplierid)
VALUES (0, 2);

INSERT INTO supplierorders (orderid, supplierid)
VALUES (1, 0);

INSERT INTO supplierorders (orderid, supplierid)
VALUES (2, 1);

--QUERY--

SELECT (partQuantity + quantity) AS sku
FROM orders o, purchases p
WHERE o.partList = p.description