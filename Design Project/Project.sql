CREATE TABLE IF NOT EXISTS infrastructure (
    ifst_id			SERIAL			NOT NULL UNIQUE,
    type				VARCHAR(25)		NOT NULL,
    description		VARCHAR(50)		NOT NULL,
    PRIMARY KEY (ifst_id)
);

CREATE TABLE IF NOT EXISTS bridges (
    bridge_id		SERIAL			NOT NULL,
    name				VARCHAR(50)		NOT NULL,
    type				VARCHAR(25)		NOT NULL,
    length			VARCHAR(25)		NOT NULL,
    daily_traffic	INTEGER					,
    year_opened		INTEGER			NOT NULL,
    PRIMARY KEY (bridge_id)
);

CREATE TABLE IF NOT EXISTS traffic_lights (
    tlight_id		SERIAL			NOT NULL,
    location			VARCHAR(50)		NOT NULL,
    last_maintained	DATE				NOT NULL,
    PRIMARY KEY (tlight_id)
);

CREATE TABLE IF NOT EXISTS security_cameras (
    cam_id			SERIAL			NOT NULL,
    location			VARCHAR(50)		NOT NULL,
    last_maintained	DATE				NOT NULL,
    PRIMARY KEY (cam_id)
);

CREATE TABLE IF NOT EXISTS transformers (
    transformer_id	SERIAL			NOT NULL,
    location			VARCHAR(50)		NOT NULL,
    last_maintained	DATE				NOT NULL,
    PRIMARY KEY (transformer_id)
);

CREATE TABLE IF NOT EXISTS infrastructure_bridges (
    ifst_id			INTEGER			NOT NULL,
    bridge_id		INTEGER			NOT NULL,
    PRIMARY KEY (ifst_id, bridge_id),
    FOREIGN KEY (ifst_id)	REFERENCES infrastructure(ifst_id),
    FOREIGN KEY (bridge_id)	REFERENCES bridges(bridge_id)
);

CREATE TABLE IF NOT EXISTS infrastructure_traffic_lights (
    ifst_id			INTEGER			NOT NULL,
    tlight_id		INTEGER			NOT NULL,
    PRIMARY KEY (ifst_id, tlight_id),
    FOREIGN KEY (ifst_id)	REFERENCES infrastructure(ifst_id),
    FOREIGN KEY (tlight_id)	REFERENCES traffic_lights(tlight_id)
);

CREATE TABLE IF NOT EXISTS infrastructure_security_cameras (
    ifst_id			INTEGER			NOT NULL,
    cam_id			INTEGER			NOT NULL,
    PRIMARY KEY (ifst_id, cam_id),
    FOREIGN KEY (ifst_id)	REFERENCES infrastructure(ifst_id),
    FOREIGN KEY (cam_id)		REFERENCES security_cameras(cam_id)
);

CREATE TABLE IF NOT EXISTS infrastructure_transformers (
    ifst_id			INTEGER			NOT NULL,
    transformer_id	INTEGER			NOT NULL,
    PRIMARY KEY (ifst_id, transformer_id),
    FOREIGN KEY (ifst_id)		REFERENCES infrastructure(ifst_id),
    FOREIGN KEY (transformer_id)	REFERENCES transformers(transformer_id)
);

CREATE TABLE IF NOT EXISTS transportation (
    transport_id		SERIAL			NOT NULL UNIQUE,
    type				VARCHAR(25)		NOT NULL,
    description		VARCHAR(50),
    PRIMARY KEY (transport_id)
);

CREATE TABLE IF NOT EXISTS subways (
    subway_id		SERIAL			NOT NULL,
    start_station	VARCHAR(50)		NOT NULL,
    end_station		VARCHAR(50)		NOT NULL,
    start_time		TIME				NOT NULL,
    end_time			TIME				NOT NULL,
    frequency		VARCHAR(50)		NOT NULL,		
    PRIMARY KEY (subway_id)
);

CREATE TABLE IF NOT EXISTS buses (
    bus_id			SERIAL			NOT NULL,
    start_station	VARCHAR(50)		NOT NULL,
    end_station		VARCHAR(50)		NOT NULL,
    start_time		TIME				NOT NULL,
    end_time			TIME				NOT NULL,		
    frequency		VARCHAR(50)		NOT NULL,
    day				VARCHAR(25)		NOT NULL,
    PRIMARY KEY (bus_id)
);

CREATE TABLE IF NOT EXISTS ferries (
    ferry_id			SERIAL			NOT NULL,
    start_station	VARCHAR(50)		NOT NULL,
    end_station		VARCHAR(50)		NOT NULL,
    frequency		VARCHAR(50)		NOT NULL,
    PRIMARY KEY (ferry_id)
);

CREATE TABLE IF NOT EXISTS transport_subways (
    transport_id		INTEGER			NOT NULL,
    subway_id		INTEGER			NOT NULL,
    PRIMARY KEY (transport_id, subway_id),
    FOREIGN KEY (transport_id)	REFERENCES transportation(transport_id),
    FOREIGN KEY (subway_id)		REFERENCES subways(subway_id)
);

CREATE TABLE IF NOT EXISTS transport_buses (
    transport_id		INTEGER			NOT NULL,
    bus_id			INTEGER			NOT NULL,
    PRIMARY KEY (transport_id, bus_id),
    FOREIGN KEY (transport_id)	REFERENCES transportation(transport_id),
    FOREIGN KEY (bus_id)			REFERENCES buses(bus_id)
);

CREATE TABLE IF NOT EXISTS transport_ferries (
    transport_id		INTEGER			NOT NULL,
    ferry_id			INTEGER			NOT NULL,
    PRIMARY KEY (transport_id, ferry_id),
    FOREIGN KEY (transport_id)	REFERENCES transportation(transport_id),
    FOREIGN KEY (ferry_id)		REFERENCES ferries(ferry_id)
);

CREATE TABLE IF NOT EXISTS profiler (
    person_id		SERIAL			NOT NULL,
    first_name		VARCHAR(50)		NOT NULL,
    middle_name		VARCHAR(50),
    last_name		VARCHAR(50)		NOT NULL,
    birth_date		DATE				NOT NULL,
    gender			CHAR(1)			NOT NULL,
    address			VARCHAR(50)		NOT NULL,
    phone_number		CHAR(15)			NOT NULL,
    email			CHAR(256)		NOT NULL,
    eye_color		VARCHAR(25)		NOT NULL,
    hair_color		VARCHAR(25)		NOT NULL,
    is_employee		BOOLEAN			NOT NULL,
    is_affiliate		BOOLEAN			NOT NULL,
    CONSTRAINT valid_gender		CHECK (gender = 'M' OR gender = 'F'),
    PRIMARY KEY (person_id)
);

CREATE TABLE IF NOT EXISTS employees (
    person_id		INTEGER			NOT NULL,
    hire_date		DATE				NOT NULL DEFAULT CURRENT_TIMESTAMP,
    year_wages_usd	MONEY			NOT NULL,
    PRIMARY KEY (person_id),
    FOREIGN KEY (person_id) REFERENCES Profiler(person_id)
);

CREATE TABLE IF NOT EXISTS affiliates (
    person_id		INTEGER			NOT NULL,
    hire_date		DATE				NOT NULL DEFAULT CURRENT_TIMESTAMP,
    contract_length	VARCHAR(25)		NOT NULL,
    pay				MONEY			NOT NULL,
    PRIMARY KEY (person_id),
    FOREIGN KEY (person_id) REFERENCES Profiler(person_id)
);

CREATE TABLE IF NOT EXISTS central_os (
    ifst_id			INTEGER			NOT NULL,
    person_id		INTEGER			NOT NULL,
    transport_id		INTEGER			NOT NULL,
    PRIMARY KEY (ifst_id, person_id, transport_id),
    FOREIGN KEY (ifst_id)		REFERENCES infrastructure(ifst_id),
    FOREIGN KEY (person_id)		REFERENCES profiler(person_id),
    FOREIGN KEY (transport_id)	REFERENCES transportation(transport_id)
);

INSERT INTO infrastructure (ifst_id, type, description) VALUES 
(1, 'Bridge', 'Washington Bridge'),
(2, 'Traffic Light', 'Brown St and Park Ave'),
(3, 'Transformer', '152 Pensacola St'),
(4, 'Security Camera', '29 Myers Rd'),
(5, 'Traffic Light', 'Atkins St and Bay Ave'),
(6, 'Bridge', 'Bayview Bridge'),
(7, 'Transformer', '2 Blake Ct');

INSERT INTO bridges (bridge_id, name, type, length, daily_traffic, year_opened) VALUES
(1, 'Michigan Avenue Bridge', 'bascule', '339 ft', 49600, 1920),
(2, 'La Salle Street Bridge', 'bascule', '242 ft', 12050, 1928),
(3, 'Nichols Bridgeway', 'pedestrian', '620 ft', 8200, 2009),
(4, 'Clark Street Bridge', 'bascule', '346 ft', 72830, 1929),
(5, 'BP Pedestrian Bridge', 'pedestrian', '935 ft', 17890, 2004),
(6, 'Outer Drive Bridge', 'bascule', '480 ft', 40000, 1937),
(7, 'Sky Ride', 'ferry', '3200 ft', 65000, 1933),
(8, 'Kinzie Street Bridge', 'bascule', '196 ft', 0, 1908);


INSERT INTO traffic_lights (tlight_id, location, last_maintained) VALUES
(1, 'Brown St and Park Ave', '20070427'),
(2, 'N Kennedy St and Fairbanks Ct', '20090616'),
(3, 'Meyer Ave and Damien Ave', '20100702'),
(4, 'Atkins St and Bay Ave', '20080209'),
(5, 'W 38 St and Kemper Pl', '20130518'),
(6, 'N Emmett St and Felton Ave', '20150501'),
(7, 'S Independence Blvd and 29 St', '20141212');

INSERT INTO security_cameras (cam_id, location, last_maintained) VALUES
(1, 'S Ingleside Ave and Raven Rd', '20140317'),
(2, '492 Bandle Pl', '20070511'),
(3, 'Lawndale Ave and Princeton Ave', '20100702'),
(4, 'Quinn St and S Prospect Ave', '20090102'),
(5, 'Atkins St and Bay Ave', '20110516'),
(6, '12 W 89th St', '20081101'),
(7, 'N Kennedy St and Fairbanks Ct', '20131012');

INSERT INTO transformers (transformer_id, location, last_maintained) VALUES
(1, '42 Riverside Rd', '20150214'),
(2, '132 Park Ave', '20131203'),
(3, '4 N Kennedy St', '20080912'),
(4, '92 Emmett St', '20101010'),
(5, '1439 Atkins St', '20110420'),
(6, '2 W 89th St', '20090911'),
(7, '50 Fairbanks Ct', '20120501');

INSERT INTO infrastructure_bridges (ifst_id, bridge_id) VALUES
(1, 1),
(6, 2);

INSERT INTO infrastructure_traffic_lights (ifst_id, tlight_id) VALUES
(2, 1),
(5, 2);

INSERT INTO infrastructure_security_cameras (ifst_id, cam_id) VALUES
(4, 1);

INSERT INTO infrastructure_transformers (ifst_id, transformer_id) VALUES
(3, 1),
(7, 2);

INSERT INTO transportation (transport_id, type, description) VALUES
(1, 'Bus', NULL),
(2, 'Subway', 'Irving Park - Belmont'),
(3, 'Ferry', NULL),
(4, 'Bus', NULL),
(5, 'Bus', NULL),
(6, 'Subway', 'Racine - Forest Park');

INSERT INTO subways (subway_id, start_station, end_station, start_time, end_time, frequency) VALUES
(1, 'O`Hare', 'Logan Square', '8:00:00 AM', '10:00:00 AM', '15 min'),
(2, 'Irving Park', 'Belmont', '9:00:00 AM', '10:00:00 AM', '12 min'),
(3, 'Montrose', 'Jackson', '7:00:00 AM', '11:00:00 AM', '18 min'),
(4, 'Logan Square', 'Racine', '11:00:00 AM', '2:00:00 PM', '13 min'),
(5, 'Jackson', 'Harlem', '12:30:00 PM', '3:00:00 PM', '16 min'),
(6, 'Racine', 'Forest Park', '4:00:00 PM', '7:00:00 PM', '17 min');

INSERT INTO buses (bus_id, start_station, end_station, start_time, end_time, frequency, day) VALUES
(1, 'Indiana/35th', 'Union Station', '5:40:00 AM', '9:00:00 PM', '27 min', 'Weekdays'),
(2, 'St. Lawrence', 'Fairbanks', '4:45:00 AM', '11:05:00 PM', '15 min', 'Weekdays'),
(3, 'South Shore', 'Wacker', '4:00:00 AM', '11:45:00 PM', '20 min', 'Weekdays'),
(4, 'South Shore', 'Wacker', '4:45:00 AM', '12:05:00 AM', '22 min', 'Saturday'),
(5, 'Harrison', 'Michigan', '6:10:00 AM', '10:05:00 PM', '10 min', 'Weekdays'),
(6, 'Halstead', 'Broadway', '4:05:00 AM', '12:30:00 AM', '12 min', 'Sunday');

INSERT INTO ferries (ferry_id, start_station, end_station, frequency) VALUES
(1, 'Belfast', 'Harlem', '20 min'),
(2, 'Boruch', 'Radon', '30 min'),
(3, 'Harlem', 'Belfast', '35 min'),
(4, 'East Side', 'Grant', '25 min'),
(5, 'East Side', 'West Side', '27 min'),
(6, 'Radon', 'Boruch', '32 min');

INSERT INTO transport_subways (transport_id, subway_id) VALUES
(2, 1),
(6, 2);

INSERT INTO transport_buses (transport_id, bus_id) VALUES
(1, 1),
(4, 2),
(5, 3);

INSERT INTO transport_ferries (transport_id, ferry_id) VALUES
(3, 1);

INSERT INTO profiler (person_id, first_name, middle_name, last_name, birth_date, gender, address, phone_number, email, eye_color, hair_color, is_employee, is_affiliate) VALUES
(1, 'Bob', 'Randal', 'Tarly', '19890420', 'M', '123 Kenny Ln', '312-483-2035', 'bob_tarly@icloud.com', 'Blue', 'Blonde', TRUE, FALSE),
(2, 'Frank', NULL, 'Underwood', '19560825', 'M', '426 Rook St', '312-928-3058', 'funderwood@gmail.com', 'Black', 'Brown', FALSE, TRUE),
(3, 'Jaime', NULL, 'Lannister', '19670911', 'M', '1 Casterly Rock Rd', '312-312-3120', 'kingslayer@hotmail.com', 'Green', 'Blonde', FALSE, FALSE),
(4, 'Grace', 'Rose', 'Kelly', '19900716', 'F', '92 Flower Ln', '312-213-9999', 'grace_kelly@gmail.com', 'Gray', 'White', FALSE, FALSE),
(5, 'Eileen', 'Calvin', 'Hobbes', '19700101', 'F', '172 Brooks Rd', '312-183-5720', 'calvin_hobbes@gmail.com', 'Black', 'Black', TRUE, FALSE),
(6, 'Rhodes', NULL, 'Rodney', '19300215', 'M', '304 56th St', '572-381-3957', 'rrodney12@hotmail.com', 'Brown', 'Brown', FALSE, TRUE),
(7, 'Susan', 'Dumont', 'Morgan', '19480310', 'F', '95 Flower Ln', '572-395-2934', 'susan_morgan@gmail.com', 'Pale', 'Red', TRUE, FALSE),
(8, 'Cercei', NULL, 'Baratheon', '19751225', 'F', '1 Kings Landing Rd', '312-304-2950', 'stupid_queen@gmail.com', 'Green', 'Blonde', FALSE, FALSE),
(9, 'Jon', NULL, 'Snow', '19820909', 'M', '1 Knows Nothing Rd', '312-304-5820', 'clueless@hotmail.com', 'Black', 'Black', FALSE, TRUE);

INSERT INTO employees (person_id, hire_date, year_wages_usd) VALUES
(3, '20020205', 42000),
(7, '20090420', 92000),
(9, '20000117', 50000);

INSERT INTO affiliates (person_id, hire_date, contract_length, pay) VALUES
(1, '20010708', '16 months', 42000),
(3, '20080216', '18 months', 50000),
(8, '20101001', '6 months', 20000);

INSERT INTO central_os (ifst_id, person_id, transport_id) VALUES
(1, 1, 1),
(2, 2, 2);

CREATE OR REPLACE VIEW employeeInformation AS
    SELECT p.first_name,
           p.middle_name,
           p.last_name,
           p.phone_number,
           p.email,
           e.hire_date,
           e.year_wages_usd
    FROM   profiler p,
           employees e
    WHERE  p.person_id = e.person_id
    ORDER BY p.last_name DESC;

CREATE OR REPLACE VIEW affiliateInformation AS
    SELECT p.person_id AS EmployeeID,
           p.first_name,
           p.middle_name,
           p.last_name,
           p.phone_number,
           p.email,
           a.hire_date,
           a.contract_length,
           a.pay
    FROM   profiler p,
           affiliates a
    WHERE  p.person_id = a.person_id
    ORDER BY p.last_name DESC;

CREATE OR REPLACE VIEW tlight_maintain AS
    SELECT t.tlight_id,
           t.location,
           t.last_maintained
    FROM   traffic_lights t
    ORDER BY last_maintained ASC;

CREATE OR REPLACE VIEW transformer_maintain AS
    SELECT t.transformer_id,
           t.location,
           t.last_maintained
    FROM   transformers t
    ORDER BY t.last_maintained ASC;

CREATE OR REPLACE VIEW cam_maintain AS
    SELECT s.cam_id,
           s.location,
           s.last_maintained
    FROM   security_cameras s
    ORDER BY s.last_maintained ASC;

SELECT b.bridge_id AS BridgeID,
       b.name AS Name,
       avg(b.daily_traffic) AS Avg_Daily_Traffic
FROM   bridges b
WHERE  b.daily_traffic IS NOT NULL
GROUP BY b.bridge_id;

SELECT TRUNC (
          CAST (
                 (SELECT COUNT(person_id) as count
                   FROM Profiler
                   WHERE date_part('year', age( Profiler.birth_date )) < 21
                 ) as decimal(5, 2)
               ) / (SELECT COUNT(person_id) as total
                     FROM Profiler
                   ) * 100
             ) as Underage

CREATE OR REPLACE FUNCTION potential_crime(eye_color text, hair_color text, gender CHAR(1))
RETURNS TABLE(First_Name text, Middle_Name text, Last_Name text) AS 
$BODY$
BEGIN
    SELECT DISTINCT p.first_name, p.middle_name, p.last_name
    FROM Profiler p
    WHERE eye_color = p.eye_color
          AND hair_color = p.hair_color
          AND gender = p.gender
END;
$BODY$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION new_employee()
RETURNS trigger AS $$
BEGIN
    IF NEW.is_employee = true THEN
        INSERT INTO Employees VALUES(NEW.person_id, NEW.hire_date,              									NEW.year_wages_usd);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql

CREATE OR REPLACE FUNCTION new_affiliate()
RETURNS trigger AS $$
BEGIN
    IF NEW.is_affilaite = true THEN 
        INSERT INTO Affiliates VALUES(NEW.person_id, NEW.hire_date, 												 NEW.contract_length, NEW.pay);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql

CREATE TRIGGER add_employee
AFTER INSERT OR UPDATE ON Profiler
FOR EACH ROW
EXECUTE PROCEDURE new_employee();

CREATE TRIGGER add_affiliate
AFTER INSERT OR UPDATE ON Profiler
FOR EACH ROW
EXECUTE PROCEDURE new_affiliate();