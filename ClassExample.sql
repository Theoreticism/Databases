-- drop table cars;
create table cars (
   kind      text,
   make      text,
   model     text,
   priceUSD  numeric
);


insert into cars(priceUSD,   kind,          make,     model)
         values (98600.42, 'sports coup', 'Porche', '911 Carrera');
insert into cars(priceUSD,   kind,    make,  model)
         values (120007.42, 'sedan', 'BMW', '740il');
insert into cars(priceUSD,   kind,          make,  model)
         values (121007.42, 'sports coup', 'BMW', 'z7');
insert into cars(priceUSD, kind,                     make,    model)
         values (87007.42, 'sports coup/submarine', 'Lotus', 'Esprit');

SELECT make, priceUSD
FROM cars
WHERE priceUSD >= 100000
  or model = 'Esprit'

delete from cars
where kind = 'sedan'

update cars
set priceUSD = priceUSD * 5
where make = 'Lotus'