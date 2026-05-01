CREATE DATABASE RetailDB;
USE RetailDB;
CREATE TABLE Customers
(
customer_id INT PRIMARY KEY UNIQUE NOT NULL,
customer_name VARCHAR(20) NOT NULL,
email VARCHAR(30) UNIQUE NOT NULL,
city VARCHAR(20) ,
gender CHAR(1) CHECK (gender IN ('M','F')),
registration_date DATE NOT NULL DEFAULT(CURDATE())
);
CREATE TABLE Products
(
product_id INT PRIMARY KEY UNIQUE NOT NULL,
product_name VARCHAR(20) NOT NULL,
category VARCHAR(20) NOT NULL,
price FLOAT NOT NULL CHECK(price>=0),
stock_quantity INT NOT NULL DEFAULT 0 CHECK(stock_quantity>=0),
is_active BOOLEAN NOT NULL DEFAULT 1,
supplier_id INT NOT NULL,
FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
 );
 CREATE TABLE Sales
 (
 sale_id INT PRIMARY KEY NOT NULL,
 customer_id INT NOT NULL,
 product_id INT NOT NULL,
 quantity INT NOT NULL CHECK(quantity>=0),
 sale_date DATE NOT NULL DEFAULT(CURDATE()),
 FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
 FOREIGN KEY (product_id) REFERENCES Products(product_id)
 );
 CREATE TABLE Suppliers
 (
 supplier_id INT PRIMARY KEY NOT NULL UNIQUE,
 supplier_name VARCHAR(20) NOT NULL,
 contact_email VARCHAR(20) UNIQUE,
 city VARCHAR(10),
 phone_number VARCHAR(15),
 registration_date DATE NOT NULL DEFAULT(CURDATE())
 );
 INSERT INTO Customers (customer_id, customer_name, email, city, gender, registration_date) VALUES
 (1,'Amara Khan', 'amarakhan@gmail.com', 'Bahawalpur', 'F', '2024-01-14'),
 (2,'Muhammad Anas', 'manas@gmail.com', 'Lodhran','M', '2023-02-10'),
 (3,'Amna Shehbaz', 'amnas@gmail.com', 'Sheikhupura', 'F', '2024-03-05'),
 (4, 'Ayesha Siddiue', 'ayeshaas@gmail.com', 'Lahore', 'F','2024-04-20'),
 (5, 'Muhammad Orhan', 'morhan@gmail.com', 'Lahore','M','2023-01-25'),
 (6,'Eman Fatime', 'emanfatima@gmail.com', 'Multan','F','2024-06-13'),
 (7,'Wali Ahmed','waliahmed@gmail.com','Islamabad','M','2023-08-22'),
 (8,'Fatima Khan','fatimak@gmail.com','Lodhran','F','2024-12-26'),
 (9,'Huda Fatima','hudafatima@gmail.com','Bahawalpur','F','2023-12-12'),
 (10,'Zia Sial','ziasial@gmail.com','Bahawalpur','M','2024-12-12'),
 (11,'Hareem Noor','hareemnoor@gmail.com','Lodhran','F','2023-01-19'),
 (12,'Sami Sial','samisial@gmail.com','Islamabad','M','2023-12-30'),
 (13,'Sana Malik','sanamalik@gmail.com','Islamabad','F','2024-12-25'),
 (14,'Syyeda Rabbia','arabbia@gmail.com','Lahore','F','2024-02-15'),
 (15,'Irha Khan','irhakhan@gmail.com','Multan','F','2025-02-10'),
 (16,'Sara Khan','sarakhan@gmail.com','Sheikhupura','F','2025-01-30');
 INSERT INTO Suppliers(supplier_id,supplier_name,contact_email,city,phone_number,registration_date)VALUES
 (1,'Nishat Linen','nishat@supply.com','Lahore','0321-1234567','2025-05-19'),
 (2,'AquaProducts LTd','aquapro@supply.com','Karachi','0300-3421342','2024-01-10'),
 (3,'GreenGrocers Ltd','greengro@supply.com','Karachi','0308-8811002','2024-02-20'),
 (4,'TetraPack Ltd','tetrapack@supply.com','Lahore','0306-1972345','2025-02-10'),
 (5,'Orient Services','orient@supply.com','Lahore','0302-1928543','2024-01-21'),
 (6,'Econocs Pvt Ltd','econocs@supply.com','Lahore','0322-2543167','2024-10-18'),
 (7,'Haleeb Foods','haleebf@supply.com','Lahore','0301-1092837','2025-12-12'),
 (8,'Duo Interiors','duoint@supply.com','Karachi','0311-0192837','2024-01-18'),
 (9,'Rafhan Foods','rafhan@supply.com','Islamabad','0344-4110384','2025-08-02'),
 (10,'Cadbury UK','cadburyx@supply.com','Karachi','0333-9988776','2025-04-10'),
 (11,'Cosmo International','cosmoint@supply.com','Lahore','0356-9822334','2024-07-31'),
 (12,'Shan Foods','shanfoods@supply.com','Multan','0309-9984451','2024-10-16'),
 (13,'Sapphire Clothing','sapphirex@supply.com','Lahore','0320-7623456','2024-11-25'),
 (14,'Peak Freans','pfreans@supply.com','Multan','0333-3760339','2025-02-11'),
 (15,'Delisoga Glass','delisoga@supply.com','Karachi','0312-0002345','2025-02-15'),
 (16,'Kenwood Ltd','kenwoood@supply.com','Islamabad','0346-2819375','2024-12-23');
 INSERT INTO Products(product_id,product_name,category,price,stock_quantity,is_active,supplier_id)VALUES
 (1,'iPhone','Electronics',85000.00,2,1,1),
 (2,'Samsung','Electronics',12000.00,4,1,5),
 (3,'Canon','Electronics',82000.00,3,1,6),
 (4,'Dawlance','Electronics',18000.00,6,1,10),
 (5,'Eva Oil ltr','Grocery',92000.00,12,1,15),
 (6,'Nike','Clothing',100000.00,11,1,16),
 (7,'Adidas','Clothing',53000.00,9,1,9),
 (8,'Polo','Clothing',62000.00,6,1,1),
 (9,'Nestle Corn kg','Grocery',60500.00,2,1,8),
 (10,'Panasonic','Kitchen',49800.00,1,1,12),
 (11,'National','Kitchen',99000.00,8,1,14),
 (12,'Black & Decker','Kitchen',72000.00,14,1,4),
 (13,'Green Tea Bags','Kitchen',8500.00,28,1,13),
 (14,'Notebook','Stationary',4800.00,7,1,4),
 (15,'Gel Pen','Stationary',2350.00,12,1,2),
 (16,'Lentils kg','Grocery',4000.00,6,1,14);
 INSERT INTO Sales(sale_id,customer_id,product_id,quantity,sale_date)VALUES
 (1,1,9,1,'2025-01-06'),
 (2,2,1,3,'2025-01-07'),
 (3,3,8,5,'2024-01-13'),
 (4,4,2,6,'2024-02-06'),
 (5,5,1,4,'2025-10-07'),
 (6,6,3,2,'2024-11-12'),
 (7,7,7,1,'2024-02-28'),
 (8,8,4,6,'2025-10-18'),
 (9,9,1,2,'2025-06-27'),
 (10,10,6,3,'2024-12-26'),
 (11,11,10,4,'2025-04-17'),
 (12,12,7,1,'2024-08-22'),
 (13,13,8,1,'2024-01-26'),
 (14,14,5,5,'2025-09-19'),
 (15,15,2,6,'2025-11-25'),
 (16,16,5,2,'2025-07-29'),
 (17,1,4,3,'2024-10-13'),
 (18,2,9,3,'2024-12-15'),
 (19,3,10,5,'2024-02-08'),
 (20,4,2,4,'2025-03-02');
 
 -- 1.distinct customer cities
 SELECT DISTINCT city,gender
 FROM Customers
 ORDER BY city ASC, gender ASC;
  SELECT DISTINCT city,gender
 FROM Customers
 ORDER BY city DESC, gender DESC;
 
 -- 2.product price with discount
 SELECT product_name, price AS original_price,
 price*0.90 AS discounted_price
 FROM Products
 WHERE is_active=1 AND price>1000
 ORDER BY discounted_price DESC;
 
 -- 3.conditional sales record
 SELECT * FROM Sales
 WHERE quantity>1 AND DAYNAME(sale_date) IN ('Monday','Tuesday','Wednesday')
 ORDER BY sale_date DESC, quantity ASC;
 
 -- 4.total products per category
 SELECT category,
 COUNT(*) AS total_products,
 SUM(stock_quantity) AS total_stock
 FROM Products
 GROUP BY category
 HAVING COUNT(*)>2
 ORDER BY total_products DESC;
 
 -- 5.average product price filtering
 SELECT category,
 AVG(price) AS average_price,
 MAX(price) AS max_price
 FROM Products
 GROUP BY category
 HAVING (average_price)>1000
 ORDER BY average_price DESC;
 
 -- 6.total quantity per customer
 SELECT customer_id,
 SUM(quantity) AS total_quantity,
 COUNT(*) AS number_of_orders
 FROM Sales
 WHERE quantity>0
 GROUP BY customer_id
 ORDER BY total_quantity DESC;
 
 -- 7.min/max price per category
 SELECT category,
 MIN(price) AS min_price,
 MAX(price) AS max_price,
 AVG(price) AS average_price
 FROM Products
 GROUP BY category
 HAVING MIN(price)<5000
 ORDER BY average_price DESC;
 
 -- 8.high selling products
 SELECT product_id,
 SUM(quantity) AS total_quantity,
 COUNT(DISTINCT customer_id) AS distinct_customers
 FROM Sales
 GROUP BY product_id
 HAVING total_quantity>2
 ORDER BY total_quantity DESC;
 
 -- 9.quantity per product
 SELECT product_id,
 SUM(quantity) AS total_units_sold,
 AVG(quantity) AS average_quantity
 FROM Sales
 GROUP BY product_id
 HAVING total_units_sold>1
 ORDER BY total_units_sold DESC, average_quantity ASC;
 
 -- 10.multiple filters & date
 SELECT * FROM Sales
 WHERE quantity>1 AND sale_date BETWEEN '2025-01-01' AND '2025-03-01' AND sale_id%2=0
 ORDER BY sale_date DESC,quantity ASC;
 
 -- 11.categories with stock
 SELECT category,
 SUM(stock_quantity) AS total_stock,
 COUNT(*) AS total_products
 FROM Products
 GROUP BY category
 HAVING SUM(stock_quantity)>20
 ORDER BY total_stock DESC;
 
 -- 12.formatted customer names and registration month-year
 SELECT customer_name, registration_date,
 CONCAT(UPPER(SUBSTRING(customer_name,1,1)), LOWER(SUBSTRING(customer_name,2))) AS formatted_name,
 DATE_FORMAT(registration_date, '%M-%Y') AS reg_date
 FROM Customers
 WHERE registration_date<CURDATE()
 ORDER BY registration_date DESC;