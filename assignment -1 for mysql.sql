create database techshop;
use techshop;
create table customers
( customerid int primary key auto_increment,
  firstname varchar(45),
  lastname varchar(45),
  email varchar(50),
  phone varchar(20),
  address varchar(225)
  );
  create table products 
  (
  productid int primary key auto_increment,
  productname varchar(100),
  productdescription varchar(225),
  price decimal (10,2)
  );
  create table orders
  (
  orderid int primary key auto_increment,
  customerid int,
  orderdate date,
  totalamount decimal (10,2),
  foreign key (customerid) references customers(customerid) on delete cascade
  );
  create table orderdetails
  (
  orderdetailid int primary key auto_increment,
  orderid int,
  productid int,
  quantity int not null,
  foreign key (orderid) references orders(orderid) on delete cascade,
  foreign key (productid) references products(productid) on delete cascade
  );
  create table inventory
  (
  inventoryid int primary key auto_increment,
  productid int,
  quantityinstock int not null,
  laststockupdate date,
  foreign key (productid) references products(productid) on delete cascade
  );
  
  
insert into customers(firstname,lastname,email,phone,address)
  values
  ('Preeti','Sharma','preeti@gmail.com','123456789','Delhi'),
  ('Rohit','Sharma','rohit@gamil.com','234567891','Nagpur'),
  ('Shubhan','Gill','gill@gmail.com','3456789012','Gujarat'),
  ('Sanju','Samson','sanju@gmail.com','4567890123','Rajasthan'),
  ('Hardhik','Pandaya','hardhik@gmail.com','567891234','Mumbai');
  select * from customers;
  insert into products (productname, productdescription, price) 
  values
  ('Smartphone', 'Latest 5G smartphone', 699.99),
  ('Laptop', 'High-performance laptop', 1299.99),
  ('Smartwatch', 'Fitness smartwatch', 199.99),
  ('Bluetooth Speaker', 'Portable speaker', 89.99),
  ('Tablet', '10-inch tablet', 399.99),
  ('Headphones', 'Noise-cancelling headphones', 149.99),
  ('Camera', 'DSLR camera', 899.99),
  ('Gaming Console', 'Next-gen console', 499.99),
  ('Wireless Mouse', 'Ergonomic design', 29.99),
  ('Keyboard', 'Mechanical keyboard', 59.99);
select * from products;
insert into orders (customeriD, orderdate, totalamount) 
values
(1, '2025-04-01', 899.98),
(2, '2025-04-02', 1299.99),
(3, '2025-04-03', 229.98),
(4, '2025-04-04', 499.99),
(5, '2025-04-05', 1199.98);
select * from orders;
insert into orderdetails(orderid,productid,quantity) 
values
(1, 1, 1),
(1, 3, 1),
(2, 2, 1),
(3, 4, 2),
(4, 8, 1),
(5, 2, 1),
(5, 6, 2);
select * from orderdetails;
insert into inventory (productid, quantityinstock, laststockupdate) 
values
(1, 100, '2025-04-01'),
(2, 50, '2025-04-02'),
(3, 150, '2025-04-03'),
(4, 200, '2025-04-04'),
(5, 80, '2025-04-05'),
(6, 120, '2025-04-06'),
(7, 40, '2025-04-07'),
(8, 60, '2025-04-08'),
(9, 300, '2025-04-09'),
(10, 250, '2025-04-10');
select * from inventory;
select firstname,lastname, email
from customers;
select 
orders.orderid,
orders.orderdate,
customers.firstname,
customers.lastname
from orders join customers on orders.customerid=customers.customerid;
insert into customers(firstname,lastname,email,phone,address)
values ('Chris','Gayle','chris@gmail.com','5678901234','WestIndies');
select *from customers;
set sql_safe_updates=0;
update products
set price=price*1.10;
select*from products;
delete from orders where orderid=2;
select * from orderdetails;
insert into orders(customerid,orderdate,totalamount)
values (2, '2025-04-02', 1299.99);
select * from orders;
insert into orderdetails(orderid,productid,quantity)
values (6,2,1);
select * from orderdetails;
update customers
set email='sharma@gmail.com',
    address='Haryana'
where customerid=1;
select * from customers;
insert into products(productname,productdescription,price)
values ('Airpods','wireless connection','1000.99');
select* from products;
alter table orders
add productstatus varchar(30);
select * from orders;
update orders
set productstatus='pending'
where orderid=5;
select * from orders;
insert into orders(customerid,orderdate,totalamount,productstatus)
values ('6','2025-05-02','89.99','pending');
select * from orders;
update orders
set productstatus='shipped'
where customerid=3;
alter table customers
add numoforders int not null;
select * from orders;
drop table customerorder;
create temporary table customerorder as
select customerid,count(*) as ordercount
from orders group by customerid;
select* from customerorder;
update customers
join customerorder on customers.customerid=customerorder.customerid
set customers.numoforders=customerorder.ordercount;
alter table customers
add fullname varchar(100) generated always as (concat(firstname,' ',lastname));
select* from customers;
use techshop;
select c.customerid,c.fullname,c.email,c.phone,c.address,
	   o.orderid,o.orderdate,o.totalamount,o.productstatus
       from customers c join orders o on c.customerid=o.customerid;
select p.productname,sum(od.quantity*p.price) as totalrevenue
from orderdetails od join products p on od.productid=p.productid 
group by p.productid,p.productname;
select 
    c.customerid,
    c.firstname,
    c.lastname,
    c.email,
    c.phone,
    count(o.orderid) as totalorders
from customers c
join orders o on c.customerid = o.customerid
group by c.customerid, c.firstname, c.lastname, c.email, c.phone
having count(o.orderid) >= 1
order by totalorders desc;
select 
    p.productname,
    sum(od.quantity) as totalquantityordered
from orderdetails od
join products p on od.productid = p.productid
group by p.productid, p.productname
order by totalquantityordered desc
limit 1;
select 
    c.firstname,
    c.lastname,
    avg(o.totalamount) as averageordervalue
from orders o
join customers c on o.customerid = c.customerid
group by c.customerid, c.firstname, c.lastname;
select 
    o.orderid,
    c.firstname,
    c.lastname,
    o.totalamount as totalrevenue
from orders o
join customers c on o.customerid = c.customerid
order by o.totalamount desc
limit 1;
select 
    p.productname,
    count(od.orderdetailid) as timesordered
from orderdetails od
join products p on od.productid = p.productid
group by p.productid, p.productname;
select distinct 
    c.firstname,
    c.lastname,
    c.email
from customers c
join orders o on c.customerid = o.customerid
join orderdetails od on o.orderid = od.orderid
join products p on od.productid = p.productid
where p.productname = 'laptop';
select 
    sum(o.totalamount) as totalrevenue
from orders o
where o.orderdate between '2025-04-05' and '2025-05-01';
select *from products;
select 
    avg(od.quantity) as avg_quantity_ordered
from orderdetails od
join products p on od.productid = p.productid
where p.productname = 'smartphone';
select 
    sum(od.quantity * p.price) as customer_revenue
from orders o
join orderdetails od on o.orderid = od.orderid
join products p on od.productid = p.productid
where o.customerid = 2;
select 
    c.firstname, 
    c.lastname, 
    count(o.orderid) as total_orders
from customers c
join orders o on c.customerid = o.customerid
group by c.customerid, c.firstname, c.lastname
order by total_orders desc
limit 1;
select 
    c.fullname,
    sum(od.quantity * p.price) as total_spent
from customers c
join orders o on c.customerid = o.customerid
join orderdetails od on o.orderid = od.orderid
join products p on od.productid = p.productid
group by c.customerid, c.fullname
order by total_spent desc
limit 1;
select 
    avg(order_value) as avg_order_value
from (
    select 
        o.orderid, 
        sum(od.quantity * p.price) as order_value
    from orders o
    join orderdetails od on o.orderid = od.orderid
    join products p on od.productid = p.productid
    group by o.orderid
) as order_totals;
select 
    c.firstname, 
    c.lastname, 
    count(o.orderid) as order_count
from customers c
join orders o on c.customerid = o.customerid
group by c.customerid, c.firstname, c.lastname
order by order_count desc;

