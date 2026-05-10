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

CREATE TABLE IF NOT EXISTS vendors (
    vendor_id INT PRIMARY KEY,
    name VARCHAR(64),
    email VARCHAR(64)
);

CREATE TABLE IF NOT EXISTS warehouses (
    warehouse_id INT PRIMARY KEY,
    name VARCHAR(64),
    address VARCHAR(128),
    vendor_id INT,

    FOREIGN KEY (vendor_id)
        REFERENCES vendors(vendor_id)
);

CREATE TABLE IF NOT EXISTS stores (
    store_id INT PRIMARY KEY,
    name VARCHAR(64),
    address VARCHAR(128),
    warehouse_id INT,

    FOREIGN KEY (warehouse_id)
        REFERENCES warehouses(warehouse_id)
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
        REFERENCES products(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS clients (
    client_id INT PRIMARY KEY,
    f_name VARCHAR(50) NOT NULL,
    l_name VARCHAR(50) NOT NULL,
    email VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    store_id INT NOT NULL,
    status VARCHAR(50),
    order_date DATE NOT NULL,

    FOREIGN KEY (store_id)
        REFERENCES stores(store_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY,
    f_name VARCHAR(50),
    l_name VARCHAR(50),
    email VARCHAR(255),
    address VARCHAR(255),
    department VARCHAR(64),
    hire_date DATETIME,
    store_id INT NOT NULL,

    FOREIGN KEY (store_id)
        REFERENCES stores(store_id)
);

CREATE TABLE IF NOT EXISTS jobs (
    job_id INT PRIMARY KEY,
    assigned_employee_id INT,
    client_id INT,
    price DECIMAL(10,2),
    ongoing BOOLEAN,
    start_date DATE,
    completion_date DATE,

    FOREIGN KEY (assigned_employee_id)
        REFERENCES employees(employee_id),

    FOREIGN KEY (client_id)
        REFERENCES clients(client_id)
);

CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT PRIMARY KEY,
    order_item_type VARCHAR(50) NOT NULL,
    job_id INT NULL,
    order_id INT NOT NULL,
    product_id INT NULL,

    FOREIGN KEY (job_id)
        REFERENCES jobs(job_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS job_details (
    job_details_id INT PRIMARY KEY,
    description TEXT,
    repair_type VARCHAR(100),
    job_id INT NOT NULL,

    FOREIGN KEY (job_id)
        REFERENCES jobs(job_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS transactions (
    transaction_id INT PRIMARY KEY,
    transaction_date DATETIME DEFAULT NOW(),
    amount DECIMAL(10,2),
    payment_method ENUM('cash', 'credit', 'debit'),
    order_id INT NOT NULL,
    employee_id INT NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);
