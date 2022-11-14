SELECT *
from customers
where customer_id=1
order by first_name;

SELECT first_name,last_name,
points+10 as 'discount factor'
from customers
where customer_id=1
order by first_name;

SELECT *
from customers
where customer_id=1
order by first_name;

SELECT *
from Customers
where state='VA';

SELECT *
from Customers
where birth_date>'1990-01-01';



#Get the orders placed this year ;
SELECT *
from orders
where order_date>='2019-01-01';

#AND, OR, NOT   OPERATOR
#get all the customers born after january 1st,1990, having also more than 1000 points
SELECT *
from Customers
where birth_date>'1990-01-01' AND points >1000;

#get all the customers born after january 1st,1990 or having more than 1000 points
SELECT *
from Customers
where birth_date>'1990-01-01' OR points >1000;

#get all the customers EITHER born after january 1st,1990 OR having more than 1000 points AND live in VA
SELECT *
from Customers
where birth_date>'1990-01-01' OR
(points >1000 AND state='VA');

SELECT *
from Customers
where NOT (birth_date>'1990-01-01' OR points >1000);
#where (birth_date<='1990-01-01' AND points <=1000);

##From order items table get the items for order 6 where the total price is <30
SELECT *
from order_items
where order_id=6 AND unit_price*quantity >30;

#IN OPERATOR
SELECT *
from Customers
where state='VA' OR state='GA' OR state='FL';

SELECT *
from Customers
where state IN ('VA','GA','FL');

SELECT *
from Customers
where state NOT IN ('VA','GA','FL');

##Return products with quantity in stocs equal to 49,38,72
SELECT *
from products
where quantity_in_stock IN (49,38,72);

##Between operator
SELECT *
from customers
where points>=1000 AND points<=3000;

SELECT *
from customers
where points BETWEEN 1000 AND 3000;

##Return customers born between 1/1/1990 and 1/1/2000

SELECT *
from customers
where birth_date BETWEEN '1990-01-01' AND '2000-01-01';

##LIKE operator
#get customers whose last name start with b

SELECT *
from customers 
WHERE last_name LIKE 'b%';

#get customers whose last name start with brush

SELECT *
from customers 
WHERE last_name LIKE 'brush%';

#get customers whose last name contains the letter b

SELECT *
from customers 
WHERE last_name LIKE '%b%';

#get customers whose last name contains the sixth character y

SELECT *
from customers 
WHERE last_name LIKE '_____y';

#get customers whose last name starts with b and the sixth character y

SELECT *
from customers 
WHERE last_name LIKE 'b____y';

## Therefore the % is used to represent any number of characters
## and _ to represent a single character 

## Get the customers whose addresses contain trail or Avenue phone numbers 
SELECT *
from customers 
WHERE address LIKE '%trail%' OR
	  address LIKE '%avenue%' ;

#end with 9
SELECT *
from customers 
WHERE phone LIKE '%9';

#don't end with 9
SELECT *
from customers 
WHERE phone NOT LIKE '%9';

##Regexp
#search for the customers who have the word field in their last name 

SELECT *
from customers 
WHERE last_name LIKE '%field%';

#EQUIVALENT TO THE ABOVE 

SELECT *
from customers 
WHERE last_name REGEXP 'field';

##ABOUT REGEXP
## ^ used to indicate the begining of a string , hence ^field means that last name must start with 'field'
##  ^ used to represent the end of a string e.g 'field$'

##we want the customer who have the either mac or field or rose in the last name 
SELECT *
from customers 
WHERE last_name REGEXP 'field|mac|rose';

##we want the customer either start with the word mac or field or rose in the last name 
SELECT *
from customers 
WHERE last_name REGEXP '^field|mac|rose';

##we want the customer who have the letter e in the last name 
SELECT *
from customers 
WHERE last_name REGEXP 'e';

##we want the customer who have ge or ie or me in the last name 
SELECT *
from customers 
WHERE last_name REGEXP '[gim]e';

##we want the customer who have eg or ei or em in the last name 
SELECT *
from customers 
WHERE last_name REGEXP 'e[gim]';

#supply a range of characters instead of writing all the letters between a and h
SELECT *
from customers 
WHERE last_name REGEXP '[a-h]e';

#summary
# use ^ to represent the beginning of the string 
#use $ to represent the end of the string 

#use | to represent logical or 
#use [abcd] to match any single character listed in the brackets
#use [-] to represent a range , example [a-z] any character from a to z

#Get the customers whose 
##   first names are elka or ambur 

SELECT *
from customers 
WHERE first_name REGEXP 'elka|ambur';

###    last names end with EY or ON
SELECT *
from customers 
WHERE last_name REGEXP 'EY$|ON$';

####   last names start with MY or contains SE
SELECT *
from customers 
WHERE last_name REGEXP '^my|se';
 
#####    last names contain B followed by R or U 

SELECT *
from customers 
WHERE last_name REGEXP 'b[ru]';

#alternatively
SELECT *
from customers 
WHERE last_name REGEXP 'br|bu';

#NULL Operator
SELECT *
from customers 
WHERE phone IS NULL;

#customers who does have a phone number 
SELECT *
from customers 
WHERE phone IS NOT NULL;

#Get the orders that are not shipped yet
SELECT *
from orders
WHERE shipped_date IS NULL;

#ORDER BY 
SELECT *
from customers 
ORDER BY first_name;

SELECT *
from customers 
ORDER BY first_name DESC;

#order by state and when it is equal order by first_name
SELECT *
from customers 
ORDER BY state,first_name ;

SELECT *
from customers 
ORDER BY state DESC,first_name DESC;

#we can sort data by a column whether it is in the select class or not 
SELECT first_name, last_name 
from customers 
ORDER BY birth_date;

#sort column by an alias 
SELECT first_name, last_name, 10 AS points
from customers 
ORDER BY points, first_name;

#select order_items with id =2 and sort in descending order by quantity*unit_price
#we see that the order by class can have an arithmetic expression 
SELECT  *, quantity*unit_price as total_price
from order_items
where order_id =2 
ORDER BY total_price DESC;

#select the first 3 samples
SELECT *
from customers 
LIMIT 3;

#skip the first 6 and select the next 3 
SELECT *
from customers 
LIMIT 6,3;







