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

    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    product_type VARCHAR(12) NOT NULL,

    category_id INT NOT NULL,
    brand_id INT NOT NULL,

    INDEX (name),

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