--recyclable-and-low-fat-products
Select product_id 
from Products
where low_fats like "Y" and recyclable like "Y";

--big-countries
Select name , population , area 
from World
where area >= 3000000 or population >= 25000000;

-- find-customer-referee
select name 
from Customer 
where referee_id != 2 or referee_id is null;