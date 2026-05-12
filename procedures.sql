-- Create Order Procedure
DELIMITER &&
CREATE PROCEDURE CreateOrder(
    IN p_client_id INT,
    IN p_order_date DATE,
    IN p_total_amount DECIMAL(10,2)
)
BEGIN
    INSERT INTO orders(
        client_id,
        order_date,
        total_amount
    )
    VALUES (
        p_client_id,
        p_order_date,
        p_total_amount
    );

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