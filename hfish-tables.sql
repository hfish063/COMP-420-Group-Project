CREATE TABLE IF NOT EXISTS brands (
	brand_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    domain VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS categories (
    category_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,

    name VARCHAR(255) INDEX NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    product_type VARCHAR(12) NOT NULL,

    category_id INT NOT NULL,
    brand_id INT NOT NULL,

    FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (brand_id)
        REFERENCES brands(brand_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

create table vendors(
    vendor_id int primary key,
    name varchar(64),
    email varchar(64)
);

create table warehouses(
    warehouse_id int primary key,
    name varchar(64),
    address varchar(128),
    vendor_id int,

    foreign key(vendor_id) references vendors(vendor_id)
);

create table stores(
    store_id int primary key,
    name varchar(64),
    address varchar(128),
    warehouse_id int,

    foreign key(warehouse_id) references warehouses(warehouse_id)
);

CREATE TABLE IF NOT EXISTS inventory (
	inventory_id INT PRIMARY KEY,
	store_id INT NOT NULL,
	product_id INT NOT NULL,
	quantity INT DEFAULT 0,
	
	FOREIGN KEY (store_id)
		REFERENCES stores(store_id)
		ON DELETE CASCADE 
		ON UPDATE CASCADE,
	
	FOREIGN KEY (product_id) 
		REFERENCES products(product_ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE clients (
    client_id INT PRIMARY KEY,
    f_name VARCHAR(50) NOT NULL,
    l_name VARCHAR(50) NOT NULL,
    email VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    store_id INT NOT NULL,
    status VARCHAR(50),
    order_date DATE NOT NULL,
    CONSTRAINT fk_orders_store
        FOREIGN KEY (store_id) 
        REFERENCES stores(store_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    f_name VARCHAR(50),
    l_name VARCHAR(50),
    email VARCHAR(255),
    address VARCHAR(255),
    department VARCHAR(64),
    hire_date DATETIME,
    store_id INT NOT NULL,
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

create table jobs(
    job_id int primary key,
    assigned_employee_id int,
    client_id int,
    price decimal(10,2),
    ongoing boolean,
    start_date date,
    completion_date date,

    foreign key(assigned_employee_id) references employees(employee_id),
    foreign key(client_id) references clients(client_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_item_type VARCHAR(50) NOT NULL,
    job_id INT NULL,
    order_id INT NOT NULL,
    product_id INT NULL,
    CONSTRAINT fk_order_items_job
        FOREIGN KEY (job_id) 
        REFERENCES jobs(job_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id) 
        REFERENCES orders(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id) 
        REFERENCES products(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE job_details (
    job_details_id INT PRIMARY KEY,
    description TEXT,
    repair_type VARCHAR(100),
    job_id INT NOT NULL,
    CONSTRAINT fk_job_details_job
        FOREIGN KEY (job_id) 
        REFERENCES jobs(job_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    transaction_date DATETIME DEFAULT NOW(),
    amount  DECIMAL(10,2) ,
    payment_method ENUM('cash','credit','debit','online'),
    order_id INT NOT NULL,
    employee_id INT NOT NULL,
   FOREIGN KEY (order_id) REFERENCES orders(order_id),
   FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);