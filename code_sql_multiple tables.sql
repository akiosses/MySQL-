#select the orders in the orders table but instead of showing the customers id show the full name of each customer.

SELECT * 
FROM orders
JOIN customers 	ON orders.customer_id = customers.customer_id;  #combine the columns from orders table to the columns in the customers table
#if you put 2 tables next to each other , we want to line up the records such that the customer id's are equal.

#select only order id from orders,first_name and last_name
#first_name , last_name belong to the customers table 
SELECT order_id, orders.customer_id ,first_name ,last_name
FROM orders
JOIN customers 	ON orders.customer_id = customers.customer_id;

#after each table we can give an elias
#elias o after order, then wherever we have orders can simply type the letter o instead.
#in the same way give the elias c after customers
SELECT order_id, o.customer_id ,first_name ,last_name
FROM orders o
JOIN customers c	
ON o.customer_id = c.customer_id;

#write a query and join order_items table with the products table so for each order return both the product_id as well its name.
#followed by the quantity and the unit price from the order items table and use an elias to simplify the code. 

SELECT order_id, p.product_id, oi.unit_price, quantity
FROM order_items oi
JOIN products p	
ON oi.product_id  = p.product_id ;

#JOINING Across data bases
#Combine columns accross multiple databases 
#join the order_items table with the products table from sql_inventory data base.
SELECT *
FROM order_items oi
JOIN sql_inventory.products p
ON oi.product_id  = p.product_id;

#WE can type 
USE sql_inventory;

#then the above query must be fixed
SELECT *
FROM sql_store.order_items oi
JOIN products p
ON oi.product_id  = p.product_id;

#SELF JOIN
SELECT * FROM sql_hr.employees;
#column "report_to" is the idea of the manager for this person or employee.
#we don't want to repeat the managers information here, like their phone number, address because this information can change 
#so we only use the id (report_to)  to refer to that manager in this table.
#However the manager is also an employee and its informations contained in the same table.
# For example reports_to=37270 corresponds to the manager with employee_id=37270


USE sql_hr;
SELECT * 
FROM employees e
JOIN employees m
ON e.reports_to  = m.employee_id;

#get only the employee's and manager's name 
SELECT e.employee_id, e.first_name,m.first_name 
FROM employees e
JOIN employees m
ON e.reports_to  = m.employee_id;

SELECT e.employee_id, 
       e.first_name,
	   m.first_name AS manager 
FROM employees e
JOIN employees m
ON e.reports_to  = m.employee_id;

#JOIN more than 2 tables.
#looking the orders table in sql_store data base and the column status whose name is stored in order_statuses table.
#write a query to join the orders table with customers and order_statuses

USE sql_store;

SELECT * 
FROM orders o
JOIN customers c
     ON o.customer_id=c.customer_id
JOIN order_statuses os
	 ON  o.status= os.order_status_id;     
     

SELECT 
      o.order_id,
      o.order_date,
      c.first_name,
      c.last_name,
      os.name AS status 
FROM orders o
JOIN customers c
     ON o.customer_id=c.customer_id
JOIN order_statuses os
	 ON  o.status= os.order_status_id;      

#join payments with clients table from sql_invoicing to see the name of the clients,also join the payments table with the payments method
#produce a report that shows details such as the name of the client and the payment method.
USE sql_invoicing;  

SELECT *
FROM payments p
JOIN clients c
	 ON p.client_id=c.client_id
JOIN payment_methods pm
     ON p.payment_method=pm.payment_method_id;   
     
SELECT 
     p.date,
     p.invoice_id,
     p.amount,
     c.name,
     pm.name AS payment_method
FROM payments p
JOIN clients c
	 ON p.client_id=c.client_id
JOIN payment_methods pm
     ON p.payment_method=pm.payment_method_id;  
     
#Compound Join conditions 

#In the order_items table in data base sql_store there is not a single column to uniquely identify each record. 
#Dublicate values are containes in the columns.    
#we can use the combination of order_id and product_id to uniquely identify each order item.
#when there are 2 primary keys in one table this is called "composite primary key".

#JOIN order_item_notes with order_items table.

SELECT *
FROM order_items oi
JOIN order_item_notes oin 
    ON oi.order_id= oin.order_id
    AND oi.product_id=oin.product_id;


#implicit join syntax

SELECT *
FROM orders o 
JOIN customers c
ON o.customer_id=c.customer_id;

#alternative way to write this query using implicit join syntax
#implicit join syntax

SELECT *
FROM orders o,customers c
WHERE o.customer_id=c.customer_id;

#However, this is not a suggested way due to the explicit syntax using JOIN forces you to write the condition. 

SELECT 
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
JOIN orders o 
    ON c.customer_id=o.customer_id
ORDER BY c.customer_id ;

#in the above query we see on the customers who have an order. 
#If we want to see all the customers whether they have an order or not we use OUTER JOINS

#LEFT JOIN -> all the records from the left table (customers) are returned whether the condition (ON) is true or not.

SELECT 
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
LEFT JOIN orders o 
    ON c.customer_id=o.customer_id
ORDER BY c.customer_id ;

#RIGHT JOIN -> all the records from the right table (customers) are returned whether the condition (ON) is true or not.

SELECT 
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
RIGHT JOIN orders o 
    ON c.customer_id=o.customer_id
ORDER BY c.customer_id ;

#the above query produces the same result as the INNER JOIN due to we asked for all the records from the right table (e.g orders) and not all the customers

#If we use the RIGHT JOIN and we want to return all the records from the customers we just need to swap customers c with orders o
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id
FROM orders o
RIGHT JOIN customers c
    ON c.customer_id=o.customer_id
ORDER BY c.customer_id ;



#write a query that returns product_id ,name and quantity from the order_items table 
#so we have to join the products with order_items table.

SELECT 
	p.product_id,
    p.name,
    oi.quantity
FROM products p
LEFT JOIN order_items oi 
    ON p.product_id=oi.product_id;

#OUTER JOINS between multiple tables 

#some of the records don't have shipper and that is why they are not returned below.

SELECT 
	c.customer_id,
    c.first_name,
    o.order_id
FROM orders o
RIGHT JOIN customers c
    ON c.customer_id=o.customer_id
JOIN shippers sh
    ON o.shipper_id=sh.shipper_id    
ORDER BY c.customer_id ;

#to solve this issue we can use a left join, to make sure that all orders are returned whether they have a shipper or not.

#returned all the customers whether they have an order or not, 
#and for those who do have an order we get all the order whether they have a shipper or not.
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id,
    sh.name AS shipper
FROM orders o
RIGHT JOIN customers c
    ON c.customer_id=o.customer_id
LEFT JOIN shippers sh
    ON o.shipper_id=sh.shipper_id    
ORDER BY c.customer_id ;

