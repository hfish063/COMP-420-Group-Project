-- Create Order Procedure
DELIMITER &&
CREATE PROCEDURE create_order(
    IN p_store_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    IN p_order_item_type VARCHAR(50),
    IN p_status VARCHAR(50),
    IN p_order_date DATE
)
BEGIN
    DECLARE v_order_id INT;

    -- Create order
    INSERT INTO orders (store_id, status, order_date)
    VALUES (p_store_id, p_status, p_order_date);
    SET v_order_id = LAST_INSERT_ID();

    -- Link product to order
    INSERT INTO order_items (
		order_item_type,
		order_id,
        product_id
    )
    VALUES (
		p_order_item_type,
        v_order_id,
        p_product_id
    );
    
    -- Link inventory to product
    UPDATE inventory
    SET quantity = quantity - p_quantity
    WHERE store_id = p_store_id
      AND product_id = p_product_id
      AND quantity >= p_quantity;
END &&
DELIMITER ;

-- Restock Product
DELIMITER &&
CREATE PROCEDURE restock_product(
    IN p_store_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    UPDATE inventory
    SET quantity = quantity + p_quantity
    WHERE store_id = p_store_id
      AND product_id = p_product_id;
END &&
DELIMITER ;

-- Update Inventory
DELIMITER &&
CREATE PROCEDURE update_inventory (
    IN p_inventory_id INT,
    IN p_quantity INT
)
BEGIN
    UPDATE inventory
    SET quantity = p_quantity
    WHERE inventory_id = p_inventory_id;
END &&
DELIMITER ;

-- Restock Product Procedure
DELIMITER &&
CREATE PROCEDURE RestockProduct(
    IN p_product_id INT,
    IN p_store_id INT,
    IN p_quantity INT
)
BEGIN 
    UPDATE inventory
    SET quantity = quantity + p_quantity
    WHERE product_id = p_product_id
        AND store_id = P_store_id;

END &&
DELIMITER ;

-- Update Inventory Procedure
DELIMITER &&

CREATE PROCEDURE UpdateInventory (
    IN p_inventory_id INT,
    IN p_new_quantity
)

BEGIN
    UPDATE inventory
    SET quantity = p_new_quantity
    WHERE inventory_id = p_inventory_id;

END &&
DELIMITER ;

-- Adding a new store
DELIMITER $$

CREATE PROCEDURE add_new_store (
    IN p_store_id INT,
    IN p_store_name VARCHAR(100),
    IN p_address VARCHAR(255)
)
BEGIN
    INSERT INTO stores (store_id, store_name, address)
    VALUES (p_store_id, p_store_name, p_address);
END$$

DELIMITER ;


-- Deleting a product
DELIMITER $$

CREATE PROCEDURE delete_product (
    IN p_product_id INT
)
BEGIN
    DELETE FROM products
    WHERE product_id = p_product_id;
END$$

DELIMITER ;


-- Deleting an employee
DELIMITER $$

CREATE PROCEDURE delete_employee (
    IN p_employee_id INT
)
BEGIN
    DELETE FROM employees
    WHERE employee_id = p_employee_id;
END$$

DELIMITER ;

-- Create repair job
DELIMITER &&

CREATE PROCEDURE create_repair_job(
	IN p_job_id INT,
	IN p_assigned_emp_id INT,
	IN p_client_id INT,
	IN p_price DECIMAL(10,2),
	IN p_ongoing BOOL,
	IN p_start_date DATE,
	IN p_completion_date DATE,
	IN p_job_details_id INT, 
	IN p_description TEXT,
	IN p_repair_type VARCHAR(100)
)
BEGIN
	INSERT INTO jobs (
		job_id,
		assigned_employee_id,
		client_id,
		price, 
		ongoing, 
		start_date, 
		completion_date 
	) VALUES (
		p_job_id, 
		p_assigned_emp_id, 
		p_client_id, 
		p_price, 
		p_ongoing, 
		p_start_date, 
		p_completion_date
	);
	
	INSERT INTO job_details (
		job_details_id, 
		description, 
		repair_type, 
		job_id
	) VALUES (
		p_job_details_id,
		p_description,
		p_repair_type,
		p_job_id
	);
END &&
DELIMITER ;

-- Complete repair job
DELIMITER &&

CREATE PROCEDURE complete_repair_job(
	IN p_job_id INT,
	IN p_completion_date DATE
)
BEGIN 
	UPDATE jobs
	SET 
		ongoing = 0,
		completion_date = p_completion_date
	WHERE
		job_id = p_job_id;
END &&
DELIMITER ;

delimiter //

-- Add employee procedure
create procedure add_employee(
    in p_employee_id int,
    in p_f_name varchar(32),
    in p_l_name varchar(32),
    in p_email varchar(64),
    in p_address varchar(128),
    in p_department varchar(32),
    in p_hire_date date,
    in p_store_id int
)
begin


    insert into employees(
        employee_id,
        f_name,
        l_name,
        email,
        address,
        department,
        hire_date,
        store_id
    )
    values(
        p_employee_id,
        p_f_name,
        p_l_name,
        p_email,
        p_address,
        p_department,
        p_hire_date,
        p_store_id
    );


end //


delimiter ;

-- Add new product procedure
delimiter //

create procedure add_product(
    in p_product_id int,
    in p_name varchar(64),
    in p_price decimal(10,2),
    in p_category_id int,
    in p_brand_id int
)
begin


    insert into products(
        product_id,
        name,
        price,
        category_id,
        brand_id
    )
    values(
        p_product_id,
        p_name,
        p_price,
        p_category_id,
        p_brand_id
    );


end //


delimiter ;


-- Get order info procedure
delimiter //


create procedure get_order_information(
    in p_order_id int
)
begin


    select
        o.order_id,
        o.order_date,
        o.status,


        s.name as store_name,


        oi.order_item_id,
        oi.order_item_type,


        p.name as product_name,
        p.price,


        t.transaction_id,
        t.total,
        t.payment_method,
        t.transaction_date


    from orders o


    left join stores s
        on o.store_id = s.store_id


    left join order_items oi
        on o.order_id = oi.order_id


    left join products p
        on oi.product_id = p.product_id


    left join transactions t
        on o.order_id = t.order_id


    where o.order_id = p_order_id;


end //


delimiter ;


